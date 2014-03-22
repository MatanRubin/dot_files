# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
if [[ $OSTYPE == 'darwin13' ]]; then
	platform='mac'
elif [[ $OSTYPE == 'linux-gnu' ]]; then
	platform='linux'
fi

alias l=less
alias ll='ls -ltrh -G'
alias sumcol='paste -sd+ | bc'

export PROMPT_DIRTRIM=3
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	. /usr/share/git-core/contrib/completion/git-prompt.sh
fi
if [ -f /usr/local/git/contrib/completion/git-prompt.sh ]; then
	. /usr/local/git/contrib/completion/git-prompt.sh
fi
export PS1='[\u@\h \[\033[1;35m\]\w\[\033[m\]\[\033[m\]]\[\033[1;33m\]$(__git_ps1)\[\033[m\]$ \[\033[0;37;00m\]'

gll()
{
	git log -n25 --pretty=tformat:"^%Cgreen%h%Creset^%C(yellow)%aN%Creset^%ai^%Cred|%Creset^%d^%s" $@ |
	TERM_COLUMNS=$COLUMNS perl -F'\^' -lane '
	sub min ($$) { $_[$_[0] > $_[1]] }
	my $FREEW = $ENV{TERM_COLUMNS} - 45 - length($F[0]);
	my $REF = $F[5];
	my $REFW = length($REF);
	my $MSG = join("^", @F[6..$#F]);
	my $MSGW = length($MSG);
	if ($MSGW + $REFW > $FREEW)
		{
			$REFW = min($REFW, int($FREEW*0.8));
			$REF = substr($REF, 0, $REFW - 4) . "...)" if ($REFW < length($REF));
			$MSGW = $FREEW - $REFW;
		}
		printf("$F[1] %-25s %.16s %s %-.${MSGW}s\033[0;31m%.${REFW}s\033[0m\n",
		$F[2], $F[3], $F[4], $MSG, $REF);
		'
}


# Git aliases
alias gst='git status'
alias gco='git checkout'
alias gds='git diff --cached'   # gds == "git diff, STAGED changes" 
alias gdu='git diff'            # gdu == "git diff, UNSTAGED changes" 
alias gda='git diff HEAD'       # gda == "git diff, ALL changes, stages & unstaged"
alias gad='git add'

# Colored man pages
#man() {
#	env \
#		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
#		LESS_TERMCAP_md=$(printf "\e[1;31m") \
#		LESS_TERMCAP_me=$(printf "\e[0m") \
#		LESS_TERMCAP_se=$(printf "\e[0m") \
#		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
#		LESS_TERMCAP_ue=$(printf "\e[0m") \
#		LESS_TERMCAP_us=$(printf "\e[1;32m") \
#		man "$@"
#}

man() {
	env LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[38;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
		man "$@"
}

# GDB Text UI
alias gdb='gdb -tui'

# ls colors
if [[ $platform == 'linux' ]]; then
	# Auto download dircolors
	if [ ! -d ~/dircolors-solarized/ ]; then
		mkdir ~/dircolors-solarized
		git clone https://github.com/seebi/dircolors-solarized.git \
			~/dircolors-solarized
	fi
	# set ls colors to ansi-light
	eval `dircolors ~/dircolors-solarized/dircolors.ansi-light`
fi

if [[ $platform == 'mac' ]]; then
	alias gvim=mvim
fi

# Simpler job control
alias j='jobs ; read -p "Activate process number: " job ; fg $job'
