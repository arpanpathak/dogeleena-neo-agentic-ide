# Fonts

Requires a Nerd Font for icons.

## Install

macOS:
```bash
brew install --cask font-jetbrains-mono-nerd-font
```

Linux:
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv
```

Then set the font in your terminal to "JetBrainsMono Nerd Font".
