# Neovim config

Personal Neovim config based on [LazyVim](https://github.com/LazyVim/LazyVim).

## Install

```bash
# back up an existing config first
mv ~/.config/nvim ~/.config/nvim.bak

git clone https://github.com/ke-an/.nvim.git ~/.config/nvim
nvim
```

On first start lazy.nvim installs all plugins (versions pinned in `lazy-lock.json`),
Mason installs LSP servers/tools and Treesitter compiles parsers.

## Requirements

- Neovim >= 0.11
- git, gcc/make (Treesitter parsers)
- [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) (search/pickers)
- node/npm, php, composer (some Mason LSPs/linters)
- a [Nerd Font](https://www.nerdfonts.com/) in the terminal

Ubuntu/Debian:

```bash
sudo apt install git gcc make ripgrep fd-find nodejs npm php-cli composer
```

The `neovim` package in Ubuntu's apt repos is usually older than 0.11, so install a newer one,
either from the unstable PPA:

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update && sudo apt install neovim
```

or as the official AppImage:

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
```

Check with `nvim --version`.

macOS ([Homebrew](https://brew.sh/)):

```bash
xcode-select --install   # git, clang, make
brew install neovim ripgrep fd node php composer
brew install --cask font-jetbrains-mono-nerd-font
```

Then select the Nerd Font in your terminal (iTerm2: Settings → Profiles → Text → Font).
The default macOS Terminal.app has limited color support; iTerm2, WezTerm, Kitty or Ghostty are recommended.
The config path is the same on macOS: `~/.config/nvim`.

## Update

```bash
cd ~/.config/nvim && git pull
```

Then in Neovim run `:Lazy restore` to sync plugins to the versions in `lazy-lock.json`.
