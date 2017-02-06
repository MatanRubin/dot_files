# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
if [[ $OSTYPE == "darwin"* ]]; then
	platform='mac'
elif [[ $OSTYPE == 'linux-gnu' ]]; then
	platform='linux'
elif [[ $OSTYPE == 'msys' ]]; then
	platform='windows'
fi

##################### Aliases ########################
alias l=less
alias ll='ls -ltrh -G'
alias sumcol='paste -sd+ | bc'
alias dirs='dirs -p -v'
alias grep='grep --color=auto'
alias cll='tail -n 1 | pbcopy'
# Simpler job control
alias j='jobs ; read -p "Activate process number: " job ; fg $job'
alias "c=xclip"
alias "v=xclip -o"
alias "info=info --vi-keys"
if [[ $platform == 'mac' ]]; then
	alias gvim=mvim
	alias ctags='ctags -R --fields=+l'
elif [[ $platform == 'windows' ]]; then
	# vim aliases
	alias vim='/c/Program\ Files/Vim/vim74/vim.exe'
	alias view='/c/Program\ Files/Vim/vim74/vim.exe -R'
	alias vimdiff='/c/Program\ Files/Vim/vim74/vim.exe -d'
	alias gvim='start gvim'
	alias gvimdiff='gvim -d'

	# general aliases
	alias tree='cmd //c tree'
fi

alias mci='mvn clean install'
alias mcc='mvn clean compile'



###################### Git ###########################
# Bash version on Mac does not support Bash's PROMT_DIRTRIM feature, so we
# emulate it using this dirtrim function
function dirtrim {
	pwd | sed s_${HOME}_~_ | rev | awk -F / '{print $1,$2}' | rev | sed s_\ _/_ | sed s_/~_~_
}

export PROMPT_DIRTRIM=3
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# git bash completion
if [[ $platform == 'mac' ]]; then
	#. /usr/local/git/contrib/completion/git-prompt.sh
	#. /usr/local/Cellar/bash-git-prompt/2.4.1/share/gitprompt.sh
	true
elif [[ $platform == 'linux' ]]; then
	. /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# nice git info on command prompt
if [[ $platform == 'mac' ]]; then
	alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"
	export PS1='[\u@\h \[\033[1;35m\]$(dirtrim)\[\033[m\]\[\033[m\]]\[\033[1;33m\]$(__git_ps1)\[\033[m\]$ \[\033[0;37;00m\]'
elif [[ $platform == 'linux' ]]; then
	export PS1='[\u@\h \[\033[1;35m\]\w\[\033[m\]\[\033[m\]]\[\033[1;33m\]$(__git_ps1)\[\033[m\]$ \[\033[0;37;00m\]'
fi

# nice git log for current branch
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

######################################################

# Colored man pages
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
elif [[ $platform == 'mac' ]]; then
	export LSCOLORS=gxfxcxdxbxegedabagacad
fi


# Fix locale issue when SSHing from Mac to Linux
if [[ $platform == 'mac' ]]; then
	export LC_ALL="en_US.UTF-8"
fi

# Find function
f() {
	find . -name "*${1}*"
}

# Python Virtual Envs
export WORKON_HOME=~/.virtualenvs
if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
	source /usr/local/bin/virtualenvwrapper.sh
fi

# additional man pages
if [[ $platform == 'mac' ]]; then
	export MANPATH=$MANPATH:/Users/maloni/Documents/DashDocsets/FC19/usr/local/share/man
	export MANPATH=$MANPATH:/Users/maloni/Documents/DashDocsets/FC19/usr/share/man/en
	export MANPATH=$MANPATH:/Users/maloni/Documents/DashDocsets/FC19/usr/share/man
	export PATH=/usr/local/sbin:$PATH
elif [[ $platform == 'windows' ]]; then
	export PATH=/c/Program\ Files/Vim/vim74:${PATH}
fi

# AsciiDoc
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

# Java
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home/

# open zipped files with less, color code source files
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN

# brew bash-completion
if [[ $platform == 'mac' ]]; then
	source $(brew --prefix)/etc/bash_completion
fi

export EDITOR=vim

# maven bash completion
. ~/.maven_bash_completion.bash

# direnv configuration
# to use direnv, create a .envrc file in your directory, and then
# issue `direnv allow .`
if [[ $platform == 'windows' ]]; then
	_direnv_hook() {
		eval "$(direnv export bash)";
	};
	if ! [[ "$PROMPT_COMMAND" =~ _direnv_hook ]]; then
		PROMPT_COMMAND="_direnv_hook;$PROMPT_COMMAND";
	fi
elif [[ $platform == 'mac' ]]; then
	eval "$(direnv hook bash)"
fi

# Powerline
if [[ $platform == 'mac' ]]; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi

# Golang setup
export GOPATH="c:/Users/rubinm3/gocode/"
