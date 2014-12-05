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

export EDITOR=vim

alias gs='git status'
alias gl='git log'
alias gb='git branch'
alias gc='git checkout'
alias gau='git add -u'
source /opt/boxen/env.sh

alias tnote="terminal-notifier -message"

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
