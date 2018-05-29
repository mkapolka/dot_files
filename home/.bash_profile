alias rword='gshuf /usr/share/dict/words | head -n 1'

unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color'
fi
export PATH=$PATH:~/bin:
export PATH=/usr/local/bin:$PATH:~/bin

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

alias gs='git status'
alias gl='git log'
alias gb='git branch'
alias gc='git checkout'
alias gau='git add -u :/'

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
