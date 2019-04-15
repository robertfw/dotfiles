export PYENV_VIRTUALENV_DISABLE_PROMPT=1

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export GITAWAREPROMPT=~/code/dotfiles/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

function prompt_command() {
    LAST_STATUS=$?
    PROMPT="\[$bldwht\]\w\[$txtrst\]"

    find_git_branch
    find_git_dirty
    git_stash_dirty
    last_commit_is_wip

    if [[ "$git_branch" != "" ]]; then
        PROMPT+=" \[$txtblu\]レ\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]"
    fi

    if [[ "$wip_status" != "" ]]; then
        PROMPT+=" \[$txtred\] ⚠ \$wip_status ⚠"
    fi

    if [[ "$git_stash_dirty" != "" ]]; then
        PROMPT+=" \[$txtred\] ⚠ \$git_stash_dirty ⚠"
    fi

    if [[ $LAST_STATUS -eq 0 ]]; then
        PROMPT+="\n\[$txtgrn\]ಊ  "
    else
        PROMPT+="\n\[$txtred\]ಊ  "
    fi

    export PS1="$PROMPT\[$txtrst\]"
}

eval $(thefuck --alias)

export PROMPT_COMMAND=prompt_command
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

alias ls='gls -oNhFA --color=auto --group-directories-first'
alias gs='git status'
alias gb='git branch'
alias gc='git commit -m'
alias vss='vagrant ssh'

function flush_dns() {
    echo Killing mDNSResponder...
    sudo killall -HUP mDNSResponder && echo Killed!
    echo Killing mDNSResponderHelper
    sudo killall mDNSResponderHelper && echo Killed!
    echo Flushing cache...
    sudo dscacheutil -flushcache && echo Flushed!
}

