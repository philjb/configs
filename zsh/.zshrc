export LSCOLORS=GxFxCxDxBxegedabagaced

HISTFILE=~/.histfile
export HISTSIZE=5000
export SAVEHIST=5000
setopt appendhistory autocd
export HISTORY_IGNORE="(ls|cat|SECRET)"
#setopt inc_append_history # don't need this setting and share_history
setopt share_history hist_ignore_dups hist_expire_dups_first hist_ignore_all_dups hist_ignore_space
setopt hist_reduce_blanks hist_verify

#setopt SH_WORD_SPLIT #see http://zsh.sourceforge.net/FAQ/zshfaq03.html#31
bindkey -e # emacs keybindings

source .secretsrc
# this removes / from the default
# this is the list of chars that are considered parts of words
# remove some to make cmdline nav "better"
WORDCHARS=$WORDCHARS:s:/:
WORDCHARS="$WORDCHARS:s/&/"
WORDCHARS=$WORDCHARS:s/=/

export PATH=$PATH:~/bin
export EDITOR=vi
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# for gpg2, note the backticks
export GPG_TTY=`tty`

ulimit -n 2048 #maximum (soft) limit on the number of file descriptors for the shell

man() {
    env \
	LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        java -version
 }

#--------------------------------------
alias mc='mvn clean'
alias m='mvn -Dcheckstyle.skip=true -Dmaven.javadoc.skip=true -Denforcer.skip=true -Dmdep.analyze.skip=true -DskipTests -Dmaven.test.skip=true -Dmaven.source.skip=true'
alias mi='m install'
alias mci='m clean install'
alias jcurl='curl -H"Content-Type: application/json"'
alias jxcurl='curl -H"Content-Type: application/x-json-stream"'
alias jwtcurl='curl -H"$(jwtheader)" -H"Content-Type:application/json"'
alias cprb='git co -b $(git rev-parse --abbrev-ref HEAD)-pjb'

alias jpaste='pbpaste | jq . -C | lesc'
#--------------------------------------

alias la='ls -la'
alias c='clear'
alias cp='cp -i'
alias ctags='/usr/bin/ctags'
alias df='df -h'
alias di='dirs -v'
alias dir='ls -G -C'
alias du='du -h'
alias grep='grep --color'
alias l.='command ls -d -F -G .*'
alias ll='command ls -l -F -h -G'
alias ll.='command ls -l -d -F -h -G .*'
alias ls='command ls -F -G'
alias mv='mv -i'
alias po='popd'
alias pu='pushd'
alias vdir='ls -G --format=long'
alias vi='vim'
alias whence='type -a'
alias d='dirs -v'
alias rm='rm -i'
alias del='rmtrash'
alias trash='rmtrash'
alias urle='python -c "import urllib, sys; print urllib.quote(sys.argv[1])"'
alias urld='python -c "import urllib, sys; print urllib.unquote(sys.argv[1])"'
alias v='vim'
alias lesc='less -R'
alias e='emacs'

#--------------------------------------
bindkey  "^[[B"  history-beginning-search-forward
bindkey  "^[[A"  history-beginning-search-backward
#bindkey  "^[[B"  history-search-forward
#bindkey  "^[[A"  history-search-backward
bindkey  "^[[3~" delete-char
#--------------------------------------

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# an attempt to have zsh read bash completion files but it doesn't emulate enough bash function
#autoload -U bashcompinit
#bashcompinit
#source ~/.zsh/_mvn
# End of lines added by compinstall

#--------------------------------------
parse_git_branch() {
    local s="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
    printf "%s%s" "%{${fg[cyan]}%}" $s
}

# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Initialize colors.
autoload -U colors
colors

precmd() { print -rP $'%w %T \e[1;32m[%d]\e[0m' }
PROMPT=$'$(parse_git_branch)%{${fg[default]}%}> '

autoload -U promptinit
promptinit
#prompt bart
#prompt suse

#--------------------------------------

#--------------------------------------
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
#if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
#  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
#  [[ -d $dirstack[1] ]] && cd $dirstack[1]
#fi
##chpwd() {
#  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
#}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus
#--------------------------------------

#--------------------------------------
fpath=(~/.zsh $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)
#--------------------------------------

alias j2y="python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)'"

export PYTHONSTARTUP=~/.pystartup

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
