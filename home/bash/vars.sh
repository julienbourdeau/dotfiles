# Make vim the default editor.
export EDITOR='vim'
export VISUAL='subl'

# Ensure ruby always load my personal config
if [ -f "$HOME/.ruby/boot.rb" ]; then
	export RUBYOPT="-I$HOME/.ruby/ -r boot"
fi



# Remove macos message about zsh being new default
export BASH_SILENCE_DEPRECATION_WARNING=1

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}"

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'

# Golang
export GO111MODULE=on
export GOPROXY="https://proxy.golang.org,direct"
export GOPRIVATE=github.com/algolia

# Set up bat config: https://github.com/sharkdp/bat#configuration-file
export BAT_THEME=GitHub

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export SSH_AUTH_SOCK=~/.1password/agent.sock
