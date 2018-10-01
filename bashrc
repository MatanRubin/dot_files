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

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	session_type=ssh
else
	case $(ps -o comm= -p $PPID) in
		sshd|*/sshd) session_type=ssh;;
		*) session_type=local
	esac
fi

##################### Aliases ########################
alias l=bat
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
alias mci='mvn clean install -T 1C'
alias mcc='mvn clean compile -T 1C'
alias pgadmin='docker run --rm -p 5050:5050 thajeztah/pgadmin4'
alias path='readlink -f'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias p="preview"
alias code='cd ~/Code/SolarEdge/'

################### Platform specific aliases ###################
if [[ $platform == 'mac' ]]; then
	alias gvim=mvim
	alias ctags='ctags -R --fields=+l'
	alias ping='prettyping --nolegend'
	alias cat='bat'
	alias du="ncdu --color dark -rr -x --exclude .git"
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

###################### Platform Specific Configurations ########################
if [[ $platform == 'mac' ]]; then
	# brew bash-completion
	source $(brew --prefix)/etc/bash_completion
	# Fix locale issue when SSHing from Mac to Linux
	export LC_ALL="en_US.UTF-8"
elif [[ $platform == 'linux' ]]; then
	# Colored terminal
	export TERM=xterm-256color
elif [[ $platform == 'windows' ]]; then
	export PATH=/c/Program\ Files/Vim/vim74:${PATH}
fi

###################### Git ###########################
# Bash version on Mac does not support Bash's PROMT_DIRTRIM feature, so we
# emulate it using this dirtrim function
function dirtrim {
	pwd | sed s_${HOME}_~_ | rev | awk -F / '{print $1}' | rev | sed s_\ _/_ | sed s_/~_~_
}

export PROMPT_DIRTRIM=3
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# git bash completion
if [[ $platform == 'mac' ]]; then
	source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
elif [[ $platform == 'linux' ]]; then
	source /etc/bash_completion
	source /etc/bash_completion.d/git-prompt
fi

# nice git info on command prompt
if [[ $platform == 'mac' ]]; then
	alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"
	if [[ $session_type == 'ssh' ]]; then
		# Color hostname in different color when in remote SSH
		export PS1='\u@\h \[\033[1;35m\]$(dirtrim)\[\033[m\]\[\033[m\] \[\033[1;33m\]$(__git_ps1)\[\033[m\]$ \[\033[0;37;00m\]'
	else
		export PS1='\[\033[1;35m\]$(dirtrim)\[\033[m\]\[\033[m\] \[\033[1;33m\]$(__git_ps1)\[\033[m\]$ \[\033[0;37;00m\]'
	fi
elif [[ $platform == 'linux' ]]; then
	export PS1='[\u@\h \[\033[1;35m\]\w\[\033[m\]\[\033[m\]]\[\033[1;33m\]$(__git_ps1)\[\033[m\]$ \[\033[0;37;00m\]'
fi

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

# Find function
f() {
	find . -name "*${1}*"
}

# Python Virtual Envs
export WORKON_HOME=~/.virtualenvs
if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
	source /usr/local/bin/virtualenvwrapper.sh
fi

# open zipped files with less, color code source files
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN

# Use vim as default editor
export EDITOR=vim

# maven bash completion
[ -f ~/.maven_bash_completion.bash ] && source ~/.maven_bash_completion.bash

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
#if [[ $platform == 'mac' ]]; then
	#powerline-daemon -q
	#POWERLINE_BASH_CONTINUATION=1
	#POWERLINE_BASH_SELECT=1
	#. /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
#fi
#precmd_functions+=(_powerline_set_prompt)

###### Fuzzy file search ######
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Use Ctrl+O to open a file in vim from FZF
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})+abort'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'

# remove duplicates from history. Makes using fzf C-R much better
export HISTCONTROL=ignoreboth:erasedups

# unified history across multiple terminals
#shopt -s histappend
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# SolarEdge Specific
export DOCKER_REGISTRY_USER=admin
export DOCKER_REGISTRY_PASSWORD=password

# Pipenv
# This was slow, so I just put the output of pipenv --completion into ~/.local/share/bash/completion/completions/pipenv
#eval "$(pipenv --completion)"
