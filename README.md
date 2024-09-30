<h1 align="center">yvesh/dotfiles</h1>

Personal Linux / Unix dot files 2024. Recently cleaned them up and using a barebone approach for managing them. The old ones can be still found in the [dotfiles-old](https://github.com/yvesh/dotfiles-old) repo.

### Overview

| | |
| - | - |
| **Distro:** | Secureblue Bluefin with Sway, Gentoo, NixOS, Arch .. |
| **Terminal:** | kitty, alacritty, urxvt, st |
| **Shell:** | fish, zsh + zinit + bullet-train |
| **Editor:** | neovim, doom emacs, vim |
| **DM:** | sddm, none |
| **WM:** | sway, hyprland, xmonad, qtile, bspwm, i3 |
| **Launcher:** | rofi, wofi |
| **Browser:** | firefox, chromium, vivalidi |

------

### Distributions

* Gentoo -- Main distro for ages, see [gentoo-config](https://github.com/yvesh/gentoo-config)
* Bluefin -- Secondary distro for 2024 with sway and some secure blue tweaks (Not using VSCode, but neovim, but still like the spirit)
* NixOS -- Secondary distro, see [nixos-config](https://github.com/yvesh/nixos-config)
* Arch Linux -- Some older notebooks, podman / kubernetes / docker hosts
* Proxmox -- Home servers
* FreeBSD -- Home servers

### Shells and terminals

* kitty, alacritty, urxvt and st -- In this order
* fish -- Slowly replacing zsh, still tweaking
* zsh -- After the end of zshinit, I'm slowly moving to fish
* zinit -- Fast plugin manager for zsh
* bullet-train -- My zsh theme

### Windowmanagers / Display Manager

* sway(fx) - Switched back 2024, my main WM 2024 - manual tiling for me
* hyprland -- Playground WM, still missing scratchpads like sway
* xmonad -- 2nd most used WM, when the hype is over and i move back to X11
* qtile -- Still in love
* bspwm -- Before xmonad
* i3-gaps -- Before bspwm
* sddm -- display manager (Rarely use one nowadays, usually start sway from tty)

### Bars

* bumblebee status -- Bar on i3 / sway 
* hyprbar -- Bar for Hyprland / sway - playing around with it 2024
* waybar -- Bar for Hyprland / sway
* xmobar -- Bar for xmonad
* polybar -- Bar for bspwm

### IDE

* neovim -- My daily driver since 2022
* Visual Studio Code -- haven't started it for a long time
* Jetbrains IDEs (PyCharm, IntelliJ IDEA, PhpStorm, WebStorm..) -- Still prefering them for certain projects and languages over VS Code and neovim (Intellij Code)
* Doom Emacs -- Main IDE back in the 2010s

### Notifications

* mako -- Default bar for Hyprland and sway
* dunst -- Still my favorite, test it with notify-send

### Lockscreen

* swaylock / swaylock-effects -- wayland
* i3lock-fancy-rapid -- Very fast rewrite of i3lock-fancy in C++

### Fonts

* Hack Nerd Font
* DejavuSansMono
* Font Awesome

### Other tools

* maim -- Screenshots
* grim + slurp -- Wayland Screenshots
* wayland-ocr -- Helper script for OCR from content
* rofi / wofi -- My default launcher

### People

These are the people whom I've taken inspiration from while writing these
configs. There surely are more but I tend to forget. Regardless, I am thankful
to all of them.

hlissner - fufexan - distrotube - alexays - zeroruka ...

