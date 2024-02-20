export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# collect history from all of the panes
setopt inc_append_history
alias py='python3'
alias ipy='ipython'
export PYTHONBREAKPOINT=ipdb.set_trace
setopt magic_equal_subst
# source ~/my_dot/nnn.zshrc

export EDITOR=nvim
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH


conda config --set changeps1 False #disable virtual envir prefix (cause bug in auto-complete)
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end


#
rsync_directory() {
  local_directory=$1
  shift
  for remote_machine in "$@"
  do
    remote_directory="${remote_machine}:~/"
    rsync -zarvp --no-perms --prune-empty-dirs  --copy-links --include="*/" --include={"*.zip","*.yaml","*.wav","*.flac","Dockerfile*","*.json",".dockerignore","*.py","*.pyx","*.sh","*.txt","*.tsv","*.yml","*.vim","*.conf","*.toml"} --exclude="*" \
     "$local_directory" "$remote_directory"
  done
}

rsync_directory_backward() {
  local_directory=$1
  shift
  for remote_machine in "$@"
  do
    remote_directory="${remote_machine}"
    rsync  -zarvp  --no-perms --prune-empty-dirs  --copy-links --include="*/" --include={"*.wav"} \
     "$remote_directory" "$local_directory" 
  done
}

alias se='rsync_directory  /Users/ericlin/Documents/my_project/   my'
alias sj='rsync_directory /Users/ericlin/Documents/MyCodes/myvc/my_project   a100 '
alias st='rsync_directory /Users/ericlin/Documents/gitrepo/fast-tts/models/en/1/tts_vc/deploy a100'
alias ss='rsync_directory /Users/ericlin/Documents/MyCodes/starman my'
alias si='rsync_directory_backward  /Users/ericlin/Documents/syncbox/  my:~/syncbox/ '
alias sb='rsync -zarvp --no-perms --prune-empty-dirs  --exclude="aim/" a100:~/syncbox/ /Users/ericlin/Documents/syncbox/'
export PYTHONBREAKPOINT=ipdb.set_trace


# export NNN_BMS="d:$HOME/Documents;D:$HOME/Downloads/"

export LC_CTYPE=en_US.UTF-8
# eval "$(zoxide init zsh)"

__conda_setup="$('/Users/ericlin/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ericlin/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ericlin/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ericlin/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# export NNN_PLUG="c:fzcd;z:autojump;p:preview-tui;s:x2sel;m:cmusq"


n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    nnn "$@" -A -T t

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
export sel=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection
export NNN_PLUG="c:fzcd;j:z;p:preview-tui;"
export NNN_FIFO="/tmp/nnn.fifo"
export TERMINAL=tmux
export NNN_BMS="h:~;d:~/Downloads/;D:~/Documents/;c:~/.config/;"
alias vim=nvim
export EDITOR=~/nvim.appimage
alias tmux='tmux -a ~/.config/tmux/tmux.conf'
