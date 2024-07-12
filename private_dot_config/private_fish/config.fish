if status is-interactive
    # cargo
    # export PATH="$HOME/.cargo/bin:$PATH"
    export EDITOR="/opt/homebrew/bin/nvim"

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

    alias ghqcd='cd $(ghq list -p | fzf)'

    alias lualatex="docker run --rm -v $(pwd):/document latex-compiler lualatex"
    alias latexmk="docker run --rm -v $(pwd):/document latex-compiler latexmk"

end
