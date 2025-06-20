if status is-interactive
    fish_vi_key_bindings

    # brew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Go
    set PATH "$PATH:$GOPATH/bin"

    # fnm
    fnm env --use-on-cd | source

    # starship
    starship init fish | source

    set EDITOR "/opt/homebrew/bin/nvim"
    set PATH "/usr/local/bin:$PATH"

    alias vim="nvim"
    alias vi="nvim"
    alias cat="bat"
    alias ls="eza --icons --group-directories-first --color=automatic"
    alias aws-forward="aws ssm start-session \
      --region "ap-northeast-1" \
      --profile AdministratorAccess-197953508117 \
      --target i-09b6af268616b5107 \
      --document-name AWS-StartPortForwardingSession \
      --parameters '{\"portNumber\":[\"3000\"],\"localPortNumber\":[\"3000\", \"25575\"]}'"

    alias ghqcd='cd $(ghq list -p | fzf)'
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
