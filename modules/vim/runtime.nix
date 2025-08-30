{ pkgs, ... }:
let
  make-lazy = pkg: bin: pkgs.writeShellScriptBin "${bin}" ''
    nix shell nixpkgs#${pkg} --command ${bin} "$@"
  '';
in
# Link together all runtime dependencies into one derivation
pkgs.symlinkJoin {
  name = "lazyvim-nix-runtime";
  paths = with pkgs; [
    # LazyVim dependencies
    lazygit
    ripgrep
    fd
    nodejs

    # LSP's
    #(make-lazy "clang-tools_16" "clangd")
    (make-lazy "nil" "nil")
    (make-lazy "taplo" "taplo")
    (make-lazy "rust-analyzer" "rust-analyzer")
    (make-lazy "marksman" "marksman")
    (make-lazy "yaml-language-server" "yaml-language-server")
    (make-lazy "lua-language-server" "lua-language-server")

    (make-lazy "typescript" "typescript")
    (make-lazy "typescript-language-server" "typescript-language-server")

    (make-lazy "typescript" "typescript")
    (make-lazy "typescript-language-server" "typescript-language-server")

    (make-lazy "vscode-langservers-extracted" "vscode-html-language-server")
    (make-lazy "vscode-langservers-extracted" "vscode-css-language-server")
    (make-lazy "vscode-langservers-extracted" "vscode-html-language-server")

    (make-lazy "tailwindcss-language-server" "tailwindcss-language-server")
    #TODO: add [emmet] (https://github.com/olrtg/emmet-language-server)
    # Debuggers

    # Formatters
    (make-lazy "stylua" "stylua")
    (make-lazy "nixpkgs-fmt" "nixpkgs-fmt")
    (make-lazy "prettierd" "prettierd")

    # Linters
    (make-lazy "markdownlint-cli" "markdownlint-cli")

  ];
}
