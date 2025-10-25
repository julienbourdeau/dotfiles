#!/usr/bin/env fish

if not command -sq brew
    echo "Error: Homebrew is not installed. Please install Homebrew first."
    exit 1
end

brew update fish
brew install fisher
brew install terminal-notifier

fisher install IlanCosman/tide@v6
fisher install franciscolourenco/done
fisher install jethrokuan/z

tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Many icons' --transient=Yes

# if docker
#docker completion fish > ~/.config/fish/completions/docker.fish
