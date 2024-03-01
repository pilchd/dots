# always run colorful versions of utils
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ls='ls --color=auto'

alias acli='arduino-cli'

alias b='bat'

alias c='cp'

alias copy='wl-copy'
alias paste='wl-paste'

alias d='lsblk'

alias ddc-bl='ddcutil setvcp 10'
alias ddc-ct='ddcutil setvcp 12'

alias df='df -h'
alias du='du -h'

alias e='nano'

alias ex='export'
alias de='unset'

alias ff='pushd'
alias jj='popd'

alias g='git'

alias insomnia='systemd-inhibit --what=handle-suspend-key:handle-hibernate-key:handle-lid-switch:sleep:shutdown --why="Keeping the nose to the grindstone" '

alias json='python -m json.tool'

alias l='ls'
alias la='ls -a'
alias laf='ls -AF'
alias lal='ls -alh'
alias lalf='ls -AlhF'
alias lf='ls -F'
alias ll='ls -lh'
alias llf='ls -lhF'

alias m='mv'

alias md='mkdir'
mdg() {
    mkdir "$1"
    cd "$1"
}
alias rd=rmdir

alias mount.nic='mount -o dmask=0022,fmask=0133,uid=nic,gid=nic'
alias mount.nic-ro='mount -o dmask=0022,fmask=0133,uid=nic,gid=nic,ro'

alias p='cat'

alias paintrain='sl'

alias q='touch'

alias qr='qrencode -m 1 -t ASCII'

alias r='rm -I'
alias rr='rm -rI'

alias rsync='rsync -vh --info=progress2'

alias t='trash'

tag() {
    CONSOLE_TAG="$1"
}
#alias tag=tag
alias untag='unset CONSOLE_TAG'

alias cooper='eval `ssh-agent`'
alias cherrypie='ssh-add ~/.ssh/id_ed25519'
alias earl='eval `ssh-agent -k`'

# Space allows another (immediate) alias substitution (like mount.nic)
alias s='sudo -v; sudo '
alias sudo='sudo -v; sudo '
alias sulk='sudo -K'

alias vv='watch '
