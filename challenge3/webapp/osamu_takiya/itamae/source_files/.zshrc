export LANG="ja_JP.UTF-8"
export LC_ALL="ja_JP.UTF-8"
export LANGUAGE="ja_JP.UTF-8"

umask 0022

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

autoload -Uz compinit
compinit

bindkey -e

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats ' [%b]'
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}

autoload -Uz colors
colors
PROMPT="%{${fg[green]}%}%n@%m@%*%{${reset_color}%}%F{yellow}%1v %F{blue}%(5~,%-2~/.../%1~,%~) $ %f"

setopt hist_ignore_dups # 重複を記録しない
setopt EXTENDED_HISTORY # 開始と終了を記録
setopt share_history # historyを共有
setopt hist_ignore_all_dups # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_space # スペースで始まるコマンド行はヒストリリストから削除
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_reduce_blanks # 余分な空白は詰めて記録
setopt hist_save_no_dups # 古いコマンドと同じものは無視
setopt hist_no_store # historyコマンドは履歴に登録しない
setopt hist_expand # 補完時にヒストリを自動的に展開
setopt inc_append_history # 履歴をインクリメンタルに追加

# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# diffに色を付ける
alias diff='colordiff --unified'

# lsに色をつける
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# macOS と Linux で色の付け方が異なる
case "${OSTYPE}" in
darwin*)
  alias ls="ls -G"
  alias ll="ls -alFG"
  alias la="ls -AG"
  alias l="ls -CFG"
  ;;
linux*)
  alias ls='ls --color=auto'
  alias ll='ls -alF --color=auto'
  alias la='ls -A --color=auto'
  alias l='ls -CF --color=auto'
  ;;
esac

# apt-get の親切機能（Debian だけの機能らしいので注意）
RELEASE_FILE=/etc/os-release
if [[ "${OSTYPE}" =~ .*darwin.* ]]; then
  # 何もしない
elif grep -e '^NAME="Ubuntu' $RELEASE_FILE >/dev/null; then
  source /etc/zsh_command_not_found
elif grep -e '^NAME="Linux Mint' $RELEASE_FILE >/dev/null; then
  source /etc/zsh_command_not_found
else
  # その他の場合の処理（CentOS とかも差し当たりここ）
fi

export LESSCHARSET=utf-8

# 一箇所だけだからいいが、以下の判定部分が増えると DRY でなくなるだろう
RELEASE_FILE=/etc/os-release
if [[ "${OSTYPE}" =~ .*darwin.* ]]; then
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
elif grep -e '^NAME="CentOS' $RELEASE_FILE >/dev/null; then
  export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
elif grep -e '^NAME="Amazon' $RELEASE_FILE >/dev/null; then
  # Amazon Linuxの場合はここに書く
elif grep -e '^NAME="Ubuntu' $RELEASE_FILE >/dev/null; then
  export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
elif grep -e '^NAME="Linux Mint' $RELEASE_FILE >/dev/null; then
  export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
else
 # その他のディストリビューションの場合はここに書く
fi

export EDITOR="vim"

export PATH="$HOME/.embulk/bin:$PATH"
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
