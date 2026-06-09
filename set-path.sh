# Make utilities available

PATH="$DOTFILES_DIR/bin:$PATH"

# Start with system path
# Retrieve it from getconf, otherwise it's just current $PATH

PATH=$($(command -v getconf) PATH)

prepend-path() {
  [ -d $1 ] && PATH="$1:$PATH"
}

# Prepend new items to path (if directory exists)

prepend-path "/bin"
prepend-path "/sbin"
prepend-path "/usr/bin"
prepend-path "/usr/sbin"
prepend-path "/usr/local/bin"
prepend-path "/bin"
prepend-path "/opt/homebrew/bin"
prepend-path "/opt/homebrew/sbin"
prepend-path "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
prepend-path "/opt/homebrew/opt/grep/libexec/gnubin"

# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755

PATH=$(echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')

# Wrap up

export PATH
