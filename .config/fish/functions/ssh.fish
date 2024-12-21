  function ssh --wraps ssh
    if test $TERM = xterm-kitty
      set --function --export TERM xterm-256color
    end
    command ssh $argv
  end
