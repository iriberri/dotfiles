export TMP=$TMPDIR

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

# ----------------------------------------------------------------------
# LS AND DIRCOLORS
# ----------------------------------------------------------------------

# we always pass these to ls(1)
LS_COMMON="-hBG"

# setup the main ls alias if we've established common args
test -n "$LS_COMMON" &&
	alias ls="command ls $LS_COMMON"

# these use the ls aliases above
alias ll="ls -l"
alias l.="ls -d .*"

# --------------------------------------------------------------------
# MISC COMMANDS
# --------------------------------------------------------------------

alias make='make -j4'
