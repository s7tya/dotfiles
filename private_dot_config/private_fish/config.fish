if status is-interactive
    # cargo
    export PATH="$HOME/.cargo/bin:$PATH"

    # brew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # fnm
    fnm env --use-on-cd | source

    # starship
    starship init fish | source

    alias vim="nvim"
    alias vi="nvim"
    alias cat="bat"
    alias ls="eza --icons --group-directories-first --color=automatic"

end
