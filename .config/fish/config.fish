if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Using starship for prompt
starship init fish | source

# Start ssh-agent
fish_ssh_agent

## Fzf
fzf_configure_bindings

## Path
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.bun/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.config/yarn/global/node_modules/.bin
fish_add_path /var/lib/snapd/snap/bin
