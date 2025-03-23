# .files

These are my dotfiles, forked from Lars Kappert's [dotfiles](https://github.com/webpro/dotfiles). Take anything you want, but at your own risk.

It mainly targets macOS systems (should install on e.g. Ubuntu as well for many tools, config and aliases etc).

This is a work in progress. I've tried to strip down everything to the barebones of what I want with the hope of making a dotfiles repo that is easier to rapidly customize.

## Highlights

- Minimal efforts to install everything, using a [Makefile](./Makefile)
- Mostly based around Homebrew and Zsh
- Well-organized and easy to customize
- The installation and runcom setup is
  [tested weekly on real Ubuntu and macOS machines](https://github.com/andrewbaughman/dotfiles/actions)
  (Ventura/13, Sonomo/14, Sequoia/15) using [a GitHub Action](./.github/workflows/dotfiles-installation.yml)
- Supports both Apple Silicon (M1) and Intel chips

## Packages Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- Latest Git, Zsh, curl

## Installation

On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now there are two options:

1. Install this repo with `curl` available:

```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/andrewbaughman/dotfiles/master/remote-install.sh`"
```

This will clone or download this repo to `~/.dotfiles` (depending on the availability of `git`, `curl` or `wget`).

1. Alternatively, clone manually into the desired location:

```bash
git clone https://github.com/andrewbaughman/dotfiles.git ~/.dotfiles
```

2. Use the [Makefile](./Makefile) to install the [packages listed above](#packages-overview), and symlink
   [runcom](./runcom) and [config](./config) files (using [stow](https://www.gnu.org/software/stow/)):

```bash
cd ~/.dotfiles
make
```

Running `make` with the Makefile is idempotent. The installation process in the Makefile is tested on every push and every week in this
[GitHub Action](https://github.com/andrewbaughman/dotfiles/actions). Please file an issue in this repo if there are errors.

## Post-Installation

1. Set your Git credentials:

```sh
git config --global user.name "your name"
git config --global user.email "your@email.com"
git config --global github.user "your-github-username"
```

## The `dot` command

```
$ dot help
Usage: dot <command>

Commands:
   help             This help message
   test             Run tests
```

## Customize

To customize the dotfiles to your likings, fork it and [be the king of your castle!](https://www.webpro.nl/articles/getting-started-with-dotfiles)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
Thank you Lars Kappert. Your dotfiles were so easy to read. I learned a lot.
Also, thanks to everyone who works on AI tools like ChatGPT and especially to everyone who writes documentation. ChatGPT and [GNU make documentation](https://www.gnu.org/software/make/manual/make.html) have been super helpful since I'm new to Makefiles.
