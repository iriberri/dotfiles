function setps1 {
  # Some shorthands for setting colours
  local bl='\[\033[30m\]'
  local r='\[\033[31m\]'
  local g='\[\033[32m\]'
  local y='\[\033[33m\]'
  local b='\[\033[34m\]'
  local m='\[\033[35m\]'
  local c='\[\033[36m\]'
  local w='\[\033[37m\]'

  local N='\[\033[0m\]'
  local B='\[\033[1m\]'

  local remote=""

  # Are we SSHed into this machine?
  if [ ! "x$SSH_TTY" == "x" ]; then
      remote="${green}\h "
  fi

  # Show:
  #   Remote machine (in green)
  #   Current directory (in maroon.  Use \w for the full path)
  #   Current git branch (in green, if any)
  #   The last return code if nonzero (in red)
  #   A symbol representing the git status (in white)
  #   $ or # (in yellow)
  export PS1="\
$N$B$remote$m\w$N \$(get_git_branch '$g%s$N ')\
$B$r\${?/0/}$N$w\$(get_git_status)$y\$ $N\
"
}
setps1

# Return a symbol representing the status of the git repository, if any.  Preserve the status of the previously executed command.
function get_git_status {
    s=$?

    # I use unicode circles here, but pastebin will not show them
    if git_status=$(git status 2>/dev/null | grep 'added to commit' 2>/dev/null); then
	echo ".";
    elif git_status=$(git status 2>/dev/null | grep 'Changes to be committed' 2>/dev/null); then
	echo ":";
    fi;
    return $s
}

# Return the current branch of the current git repository, if any
function get_git_branch {
    s=$?
    #The following gives nice names, like "master~1", if you are not on a branch.  I think it is somehow broken, which is why it is commented out.
    #r=`git name-rev HEAD 2>/dev/null | cut '-d ' -f 2`
    r=`git branch 2>/dev/null | grep '^*' | cut '-d ' -f 2-`
    [ "x$1" == "x" ] && f="(%s)" || f=$1
    [ "x$r" != "x" ] && printf "$f" $r
    return $s
}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# load our environment
source $HOME/.dotfiles/env.sh

# added by travis gem
[ -f /Users/iriberri/.travis/travis.sh ] && source /Users/iriberri/.travis/travis.sh
