###############################################################################
# DRY  -Don'T REPET YOURSELF
# KISS -KEEP IT SIMPLE STUPID
# POG  -PROGRAMCAO ORIENTADA A GAMBIARRA
# XGH  -extreme go Horse
# soft skills hard skills
# !false its funny because it's true
###############################################################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# HISTFILE=~/.zhistory

# shopt -s expand_aliases
# append to the history file, don't overwrite it
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export EDITOR="nvim"
export BROWSER="chromium"
export MANPAGER="less"
export LESSHISFILE="-"
export HISTCONTROL=ignoredups:erasedus

# LESS colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# FZF colors
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#e5e9f0,bg:#1A212E,hl:#81a1c1
--color=fg+:#e5e9f0,bg+:#1A212E,hl+:#81a1c1
--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

## FUNCTION'S

function clangc {
    if [ -f $1 ]; then
        case $1 in
            *.c) clang $1 -o /tmp/c.out && /tmp/c.out;;
            *) printf "wtf";;
        esac
    else
        echo "whats it '$1'"
    fi
}

function ex {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function rg {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
            cd -- "$(cat "$tempfile")"
        fi
        rm -f -- "$tempfile"
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi
## ALISA'S

#cat cod
alias bat="bat --theme=Dracula --style=numbers"
#kdeconnect
alias kdeshare='kdeconnect-cli --share  -d $(qarma --file-selection) -n SM-J730F'
#nvim
alias nsu='sudo nvim'
alias v='nvim'
alias neovim='nvim ~/.config/nvim/init.lua'
alias nzsh='nvim ~/.zshrc'
alias nwm='cd ~/.config/dwm/ && nvim config.def.h'
alias nbar='cd ~/.config/dwm/dwmblocks/ && nvim blocks.def.h'
alias pconf='sudo nvim /etc/pacman.conf'
alias mkpkg='sudo nvim /etc/makepkg.conf'
alias ngrub='sudo nvim /etc/default/grub'
alias smbconf='sudo nvim /etc/samba/smb.conf'
alias nmirrorlist='sudo nvim /etc/pacman.d/mirrorlist'

# pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"

# get fastest mirrors in your neighborhood
alias upmirros='sudo pacman-mirrors --country all --api --protocols all --set-branch stable && sudo pacman -Syyu'

##Pacman for software managment
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias search='sudo pacman -Qs'
alias update='sudo pacman -Syy'
alias upgate='sudo pacman -Syu'
alias update='sudo pacman -Syyu'
alias remove='sudo pacman -Rsn'
alias autoremove='sudo pacman -R'
alias list='pacman -Qe'

alias clrcache='sudo pacman -Scc'
alias orphans='remove $(pacman -Qtdq)'
alias downgrade='cd /var/cache/pacman/pkg/'
alias linstall='sudo pacman -U'

#paru
alias aur='paru -S'

#Flatpak Update
# alias fpup='flatpak update'

#Snap Update
# alias sup='sudo snap refresh'

#grub update
alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

# Replace ls with exa
alias ls='exa -ah --color=always --group-directories-first --icons'  # preferred listing
alias l='exa -h --color=always --group-directories-first --icons'   # all files and dirs
alias lh='exa -lh --color=always --group-directories-first --icons'  # long format
alias lt='exa -aTh --color=always --group-directories-first --icons' # tree listing
alias la='exa -lah --color=always --group-directories-first --icons'  # tree listing

#Bash aliases
alias hfetch='$HOME/.config/bin/hfetch'
alias sysinfo='$HOME/.config/bin/sysinfo'
alias ip='ip -c'
alias mkfile='touch'
alias jctl='journalctl -p 3 -xb'
alias ssaver='xscreensaver-demo'
alias reload='cd ~ && source ~/.bashrc'
alias pingme='ping -c64 github.com'
alias traceme='traceroute github.com'
alias speednetwork='speedtest-cli'

#advcp Copy
alias cp='advcp -i -g'
alias cpd='advcp -gR'
alias scp='sudo advcp -i -g'
alias scpd='sudo advcp -gR'
#advmv Muve
alias mv='advmv -i -g'
alias smv='sudo advmv -i -g'
#Remove files/dirs
alias rmd='rm -rf'
alias srm='sudo rm'
alias srmd='sudo rm -rf'

#cd/
alias etc='cd /etc/ && ls'
alias music='cd ~/Music && ls'
alias vids='cd ~/Videos && ls'
alias conf='cd ~/.config && ls'
alias pics='cd ~/Pictures && ls'
alias dow='cd ~/Downloads && ls'
alias docs='cd ~/Documents && ls'
alias sapps='cd /usr/share/applications && ls'
alias lapps='cd ~/.local/share/applications && ls'
# alias phone='cd /run/user/1000/gvfs/ && ls' #caminho do diretorio do celular
alias wallpaper="pwd > /tmp/pwd.txt && ~/Pictures/.wallpapers/ && ranger && cd $(cat /tmp/pwd.txt)"
alias screen="pwd > /tmp/pwd.txt && ~/Pictures/screenshots/ && ranger && cd $(cat /tmp/pwd.txt)"
alias etcher="sudo /home/kairo/.config/bin/balenaEtcher-1.7.7-x64.AppImage"

#Tmux
alias tls='tmux ls'
alias tn='tmux new -s'
alias ta='tmux a -t'
alias tfish='~/.config/i3/tfish.sh'
alias tk='tmux kill-session -t'

#mocp
alias mp='mocp'
alias mpr='mp -r'
alias mpf='mp -f'
alias mpg='mp -g'
alias mpx='mp -x'
alias mpl='mp -l'

#pd = pendraive bootavel
alias pbootavel='sudo dcfldd if=(qarma --file-selection) of=/dev/sdb bs=8192; sync'
alias dd='dcfldd'

#vm = virtual machine
alias kvm='~/.config/bin/vm.sh'

alias showcolor="printf '\e]4;1;%s\a\e[0;41m  \e[m' \"$1\""

alias githelp="glow ~/Documents/Templats/github.md"
alias vimhelp="glow ~/.config/nvim/vim.md"
alias vimgit="glow ~/.config/nvim/pack/packages/start/vim-fugitive/README.markdown"

#hardware info --short
alias hw="hwinfo --short"

#Token do meu github
alias Gittoken='cat $HOME/.config/bin/.tokenGit | xclip -sel clip'
#GiT  command
alias gc='git clone '
alias gs='git status '
alias g='git '

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#available free memory
alias free="free -mt"

#continue download
alias wget="wget -c"

#readable output
alias df='df -h'

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#torrent
alias torrent='aria2c'
alias torrents='aria2c -i'

#download
alias download='youtube-dl'

#systeminfo
alias probe="sudo -E hw-probe -all -upload"
