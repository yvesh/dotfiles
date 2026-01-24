<h1 align="center">yvesh/dotfiles</h1>

Personal Linux / Unix dot files 2026. Recently cleaned them up and using a barebone approach for managing them. The old ones can be still found in the [dotfiles-old](https://github.com/yvesh/dotfiles-old) repo.

### Overview

| | |
| - | - |
| **Distro:** | NixOS, Gentoo, Arch .. |
| **Terminal:** | kitty, alacritty, urxvt, st |
| **Shell:** | zsh + sheldon, fish
| **Editor:** | neovim |
| **DM:** | sddm, none |
| **WM:** | sway, hyprland, xmonad, qtile, bspwm, i3 |
| **Launcher:** | rofi, wofi |
| **Browser:** | firefox, chromium, vivalidi |

------

### Distributions

* NixOS -- Main distro 2026, see [nixos-config](https://github.com/yvesh/nixos-config)
* Gentoo -- Secondary Main distro for ages, see [gentoo-config](https://github.com/yvesh/gentoo-config)
* Bluefin -- Secondary distro for 2025 with sway and some secure blue tweaks (Not using VSCode, but neovim, but still like the spirit)
* Arch Linux -- Some older notebooks, podman / kubernetes / docker hosts
* Proxmox -- Home servers
* FreeBSD -- Home servers

### Shells and terminals

* kitty, alacritty, urxvt and st -- In this order
* zsh -- Moving back to it 2026 with sheldon and co after using fish for the last years
* fish -- Slowly moving away from it 2026
* zinit -- Fast plugin manager for zsh
* bullet-train -- My zsh theme

### Windowmanagers / Display Manager

* sway(fx) - My main WM 2026 - manual tiling it is for me (maybe at some point hyprland again?)
* hyprland -- Mostly my main WM for 2025, miss straigtforward tiling sometimes
* xmonad -- Used it for years, still my favorite X11 tiling WM
* qtile -- Love it in so many ways, but never fully switched to it
* bspwm -- Before xmonad
* i3-gaps -- Before bspwm
* sddm -- display manager (Rarely use one nowadays, usually start sway from tty)

### Bars

* bumblebee status -- Bar on i3 / sway - love the simplicity
* hyprbar -- Bar for Hyprland etc
* waybar -- Bar for Hyprland
* xmobar -- Bar for xmonad
* polybar -- Bar for bspwm

### IDE

* neovim -- My daily driver since 2022
* Zed -- playing around with it 2026, nice performance and native vim mode
* Visual Studio Code -- haven't started it for a long time
* Jetbrains IDEs (PyCharm, IntelliJ IDEA, PhpStorm, WebStorm..) -- Still prefering them for certain projects and languages over VS Code and neovim (Intellij Code)
* Doom Emacs -- Main IDE back in the 2010s

### AI stuff 2026

* opencode - The goto client
* llama.cpp and lm studio - Local LLMs
* claude - Mostly when i use proprietary solutions
* codex - Opus 4.5 is better at the moment, but codex is way cheaper
* anti gravity - not yet there
* cursor - mhm, so slow..

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

