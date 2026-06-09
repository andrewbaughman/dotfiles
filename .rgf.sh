# Define a function 'rgf' for ripgrep-fzf search
rgf() {
    # Check if bat is installed for enhanced previews, otherwise fall back to cat
    local PREVIEW_CMD="cat"
    if command -v bat &> /dev/null; then
        PREVIEW_CMD="bat --style=numbers --color=always"
    else
        echo "Warning: 'bat' not found. Install it for better previews (e.g., 'brew install bat')." >&2
    fi

    # Ensure fzf-tmux is preferred for a floating window if tmux is running
    local FZF_BIN="fzf"
    if command -v fzf-tmux &> /dev/null && [ -n "$TMUX" ]; then
        FZF_BIN="fzf-tmux -p" # -p for popup window
    fi

    # The core fzf + ripgrep command
    # - --bind 'change:reload(...)': As you type (query changes), ripgrep is re-run
    #   - `rg --column --line-number --no-heading --color=always --smart-case --fixed-strings {q} || true`
    #     - `--column`: Include column number in output (useful but not used in this specific vim binding for simplicity).
    #     - `--line-number`: Include line number. Essential for opening files at specific lines.
    #     - `--no-heading`: Don't print filename headers (fzf handles this better in preview).
    #     - `--color=always`: Force color output, which fzf's `--ansi` option then interprets.
    #     - `--smart-case`: Search case-insensitively unless the pattern contains uppercase letters.
    #     - `--fixed-strings`: Treat pattern as a literal string, not a regex. Remove for regex search.
    #     - `{q}`: This is fzf's placeholder for the current query string you are typing.
    #     - `|| true`: Prevents fzf from erroring out if ripgrep finds no matches (ripgrep exits with 1).
    # - --ansi: Tells fzf to interpret ANSI color codes from ripgrep.
    # - --preview "$PREVIEW_CMD {1} --highlight-line {2}": Shows content of the selected file.
    #   - `{1}`: The first field extracted by `--delimiter :` (which is the filename).
    #   - `{2}`: The second field (line number).
    #   - `--highlight-line {2}`: `bat` specific, highlights the matching line.
    # - --delimiter : --nth 3..: Parses ripgrep's output.
    #   - ripgrep output format: `filename:line_number:column_number:content` (with `--column`)
    #   - `--delimiter :`: Splits each line by colon.
    #   - `--nth 3..`: Displays only the content starting from the 3rd field. This hides filename and line number in the main fzf window, keeping it clean.
    # - --bind 'enter:execute(vim +{2} {1})': When you press Enter, execute this command.
    #   - `vim +{2} {1}`: Opens the file (`{1}`) in Vim at the specified line number (`{2}`).
    #     Adjust `vim` to your preferred editor (e.g., `nvim`, `code --goto`).
    # - --header: Provides helpful text at the top of the fzf window.
    $FZF_BIN \
        --bind "change:reload(rg --column --line-number --no-heading --color=always --smart-case --fixed-strings {q} || true)" \
        --ansi \
        --preview-window 'down,50%' \
        --preview "$PREVIEW_CMD {1} --highlight-line {2}" \
        --delimiter : \
        --nth 3.. \
        --bind 'enter:execute(vim +{2} {1})' \
        --header "Type to search with ripgrep. Enter to open in vim. (C-d to cancel)"
}