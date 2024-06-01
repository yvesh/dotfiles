function config --wraps git --description 'git for dotfiles'
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end
