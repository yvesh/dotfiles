if status is-interactive
    # Commands to run in interactive sessions can go here
    # Add Atuin (history tracking and sync)
    atuin init fish | source
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
fish_add_path $HOME/.npm-global/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.bun/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.config/yarn/global/node_modules/.bin
fish_add_path /var/lib/snapd/snap/bin
# fish_add_path /home/linuxbrew/.linuxbrew/bin/nmap
fish_add_path /var/lib/flatpak/exports/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/bytee/.lmstudio/bin
# End of LM Studio CLI section

