# LazyVim Nix

Standalone nix package containing a whole lazyvim config, together with all dependencies.

>[!NOTE]
>I have since switched to a version that ditches lazyvim entirely and uses `lz.n` instead of lazy.
>See https://github.com/jla2000/nvim-bundle

## Installation

Install the `nix` package manager (<https://nixos.org/download>).

Run lazyvim-nix:

```bash
nix run --extra-experimental-features "nix-command flakes" github:jla2000/lazyvim-nix
```

Nix will now download all dependencies and startup a fully configured neovim instance.
