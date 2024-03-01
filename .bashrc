## 2023-04-23
# Add VS Code prompts
# More & better aliases
## 2023-07-07
# Add mount.nic
## 2023-07-22
# Disable (.venv) in PSX (VIRTUAL_ENV_DISABLE_PROMPT=1)
## 2023-08-07
# PCX/PSX refactor & prompt tagging
## 2023-08-21
# Better day counting for passtime (over years)
# Disable history for UID 0
## 2023-08-25
# Root doesn't append new history instead of disabling it
## 2023-09-17
# Use ~ for VS Code .bash_history path resolution
# fzf --reverse
## 2023-09-27
# Change cooper/cherrypie/earl behavior (systemd agent)
## 2023-10-23
# wl-clipboard aliases
## 2023-10-25
# reorder system time
## 2023-12-12
# python -m json.tool alias
## 2024-01-01
# alias df/du -h; compopt -o nospace
## 2024-01-22
# aliases to file
# nnn boilerplate
## 2024-01-23
# SSH_AUTH_SOCK


# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# include extended completion if available
[ -r /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# cd on path
shopt -s autocd

# refresh terminal size if changed
shopt -s checkwinsize

# interpret **
shopt -s globstar

# don't overwrite without >|
set -o noclobber

# exit status of pipeline is leftmost non-zero, else zero
set -o pipefail

# don't add space after completions at end of line for ls
#compopt -o nospace ls



# append new memory history to the history file on close; don't rewrite all (multi-terminal support)
shopt -s histappend

# load and keep all lines of history (go fzf!)
HISTSIZE=-1
HISTFILESIZE=-1

# ignore space or adjacent identical lines
HISTCONTROL=ignoreboth

# if we're root, don't tell anyone
[[ $EUID -eq 0 ]] && HISTFILE=/dev/null


# prevent locale-depending things from blowing up under KDE's non-existent LC_TIME="en_SE.UTF-8"
#export LC_TIME='en_US.UTF-8'

# nano masterrace
export EDITOR='nano'

# if available, alias sunshine WOL utility to sunshine and pass arguments
#[ -r ~/.bash_sunshine.sh ] && alias sunshine='~/.bash_sunshine.sh '

# if git-prompt is unavailable, give no git output (this no-output function will be used by PS1 instead)
__git_ps1() {
    echo ''
}
# if git-prompt is available, source and configure it
if [ -r ~/.bash_git-prompt.sh ]; then
    source ~/.bash_git-prompt.sh
    GIT_PS1_COMPRESSSPARSESTATE=1
    GIT_PS1_DESCRIBE_STYLE='default'
    GIT_PS1_SHOWCONFLICTSTATE=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM='auto verbose'
    GIT_PS1_STATESEPARATOR=':'
fi

# if available, source fzf keybindings and configure it
if command -v fzf $> /dev/null; then
    source /usr/share/fzf/completion.bash
    source /usr/share/fzf/key-bindings.bash
    export FZF_DEFAULT_OPTS='--reverse --bind alt-j:preview-down,alt-k:preview-up'
    # if available, use bat to enable fzf's explorer preview for first 99 lines
    if command -v bat &> /dev/null; then
        export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --line-range :99 --color=always {}"'
    fi
fi

# if available, configure nnn
if command -v nnn $> /dev/null; then
    # https://raw.githubusercontent.com/jarun/nnn/master/misc/quitcd/quitcd.bash_sh_zsh
    n ()
    {
        # Block nesting of nnn in subshells
        [ "${NNNLVL:-0}" -eq 0 ] || {
            echo "nnn is already running"
            return
        }

        # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
        # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
        # see. To cd on quit only on ^G, remove the "export" and make sure not to
        # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
        #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
        export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

        # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
        # stty start undef
        # stty stop undef
        # stty lwrap undef
        # stty lnext undef

        # The command builtin allows one to alias nnn to n, if desired, without
        # making an infinitely recursive alias
        command nnn "$@"

        [ ! -f "$NNN_TMPFILE" ] || {
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
        }
    }
fi

export NNN_BMS="s:$HOME/School/SP24"
export NNN_FIFO='/tmp/nnn.fifo'
# don't auto-enter on single filter match; don't auto-advance; open only on enter
export NNN_OPTS='AJo'
export NNN_PLUG='p:preview-tui'
# trash-cli
export NNN_TRASH='1'


PCX_TAG='${CONSOLE_TAG:+(${CONSOLE_TAG}) }'
PCX_USERHOST='${USER}@${HOSTNAME%%.*}'
PCX_WD='$(WD=${PWD##*/}; echo ${WD:-/})'

# set the xterm shell title to the interior of PSL's [SYSTEM]
PCL="__GIT_PS1=\$(__git_ps1 "%s"); echo -ne \"\033]0;${PCX_TAG}${PCX_USERHOST}:${PCX_WD}\a\""
# or just dirname if we're hushed, as described below
PCS="__GIT_PS1=\$(__git_ps1 "%s"); echo -ne \"\033]0;${PCX_TAG}${PCX_WD}\a\""
PROMPT_COMMAND=$PCL

C_BLU='\[\e[0;34m\]'
C_CYN='\[\e[0;36m\]'
C_GRN='\[\e[0;32m\]'
C_GRNB='\[\e[1;32m\]'
C_GRYB='\[\e[1;90m\]'
C_NON='\[\e[0m\]'
C_PPL='\[\e[0;35m\]'
C_RED='\[\e[0;31m\]'
C_YEL='\[\e[0;33m\]'

PSL_GIT="\${__GIT_PS1:+${C_GRYB}{${C_YEL}\${__GIT_PS1}${C_GRYB}\}}"
PSS_GIT="\${__GIT_PS1:+${C_YEL}\${__GIT_PS1} }"
PSL_JOBS="\$(JOBS=\j; JOBS=\${JOBS##0}; echo \${JOBS:+${C_GRYB}|${C_PPL}\${JOBS}${C_GRYB}|})"
PSS_JOBS="\$(JOBS=\j; JOBS=\${JOBS##0}; echo \${JOBS:+${C_PPL}\${JOBS}\ })"
PSL_PROMPT="${C_NON}\\$ "
PSS_PROMPT="${C_GRNB}\\$ ${C_NON}"
PSL_RETURN="\$(RETURN=\${?##0}; echo \${RETURN:+${C_GRYB}(${C_RED}\${RETURN}${C_GRYB})})"
PSS_RETURN="\$(RETURN=\${?##0}; echo \${RETURN:+${C_RED}\${RETURN}\ })"
PSX_USERHOST="${C_GRN}\u${C_GRYB}@${C_CYN}\h"
# leading / on dirname only for root dir
PSX_WD="${C_BLU}\$(WD=\${PWD##*/}; echo \${WD:-/})"

PSL="\
${PSL_RETURN}\
${PSL_JOBS}\
${C_GRYB}[${C_GRN}\${CONSOLE_TAG:-${PSX_USERHOST}}${C_GRYB}:${C_BLU}${PSX_WD}${C_GRYB}]\
${PSL_GIT}\
${PSL_PROMPT}\
"
PSS="\
${PSS_RETURN}\
${PSS_JOBS}\
${PSS_GIT}\
\${CONSOLE_TAG:+${C_GRN}\${CONSOLE_TAG} }\
${PSS_PROMPT}\
"

export PS1=$PSL
# what to go to PSL; hush to go to PSS (also switch PCL and PCS respectively)
alias what='export PS1=$PSL; PROMPT_COMMAND=$PCL'
alias hush='export PS1=$PSS; PROMPT_COMMAND=$PCS'

# if running in kitty...
#if [[ $PILCHD_TERMINAL == 'kitty' ]]; then
    # ...add Konsole's semantic-hinting helper characters to all PSs, if not already
    ##if [[ ! $PS1 =~ 133 ]]; then
    #    PS0='\[\e]133;C\a\]'
    #    PSL='\[\e]133;L\a\]\[\e]133;D;$?\]\[\e]133;A\a\]'$PSL'\[\e]133;B\a\]'
    #    PSS='\[\e]133;L\a\]\[\e]133;D;$?\]\[\e]133;A\a\]'$PSS'\[\e]133;B\a\]'
    #    PS2='\[\e]133;A\a\]'$PS2'\[\e]133;B\a\]'
    #fi
    ## then re-set the new PSL as the default.
    #export PS1=$PSL
#fi

# if running in VS Code: start hushed, use PCS, custom prompts, and a separate history file
if [[ $PILCHD_TERMINAL == 'vscode' ]]; then
    PSLV="${PSS_JOBS}${PSS_GIT}${PSS_PROMPT}"
    PSSV="${PSS_JOBS}${PSS_PROMPT}"
    alias what='export PS1=$PSLV'
    alias hush='export PS1=$PSSV'
    PROMPT_COMMAND=$PCS
    export PS1=$PSSV
    export HISTFILE=~/.config/Code/User/bash_history
fi

# don't add '(.venv)' to PS1 when using Python venv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# ~/.config/environment.d/ssh_auth_sock.conf
systemctl --user is-active ssh-agent &> /dev/null && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"


# change the color of other writable and sticky other writable used by ls
# to their text colors (blue and yellow) underlined instead of highlighted
LS_COLORS=$LS_COLORS:'ow=1;4;34:tw=1;4;33:'; export LS_COLORS

# use Ubuntu's colorful GCC output
export GCC_COLORS='error=1;31:warning=1;35:note=1;36:caret=1;32:locus=1:quote=1'


[ -r ~/.bash_aliases ] && source ~/.bash_aliases


# style-points gang (but only in kitty)
if [[ $PILCHD_TERMINAL == 'kitty' ]]; then

    # let kitty settle
    sleep .05

    SPACE_TIME=' '
    # if available, parse the passtime file...
    if [ -r ~/.bash_passtime.txt ]; then
        # get the date and the passtime...
        DATE_PASTIME=($(grep -v '^#' ~/.bash_passtime.txt))
        DATE=${DATE_PASTIME[0]}
        PASTIME=${DATE_PASTIME[1]}
        # get the days to it...
        # https://stackoverflow.com/a/29019048
        DAYS=$(( ($(date -d "$DATE UTC" +%s) - $(date -d "$(date -I) UTC" +%s)) / (60 * 60 * 24) ))
        # zero it out as appropriate...
        if [[ $DAYS -le 0 ]]; then
            DAYS='zero! :)'
        fi
        # and pad the spacing before the time display to match it.
        for ((char=0; char<${#PASTIME}; char++)); do
            SPACE_TIME+=' '
        done
    fi

    # if available, allow one rip upon the hallowed fortune | cowsay
    command -v fortune $> /dev/null && command -v cowsay $> /dev/null && fortune | cowsay

    # display the time
    echo -e "\e[90mSystem time is $SPACE_TIME\e[32m$(date "+%m-%d %a %H:%M")\e[0m"

    # display the next pastime, if it was available
    [ -r ~/.bash_passtime.txt ] && echo -e "\e[90mDays until $PASTIME are \e[31m$DAYS\e[0m"

    # finish with a newline
    echo
fi
