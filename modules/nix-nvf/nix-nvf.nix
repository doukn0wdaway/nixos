{programs, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        options.tabstop = 2;
        theme.enable = true;
        theme.name = "tokyonight";
        theme.style = "moon";
        lsp.enable = true;
        lsp.formatOnSave = true;
        autocomplete = {
          blink-cmp.enable = true;
          enableSharedCmpSources = true;
        };
        languages.nix = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };
        keymaps = [
          {
            key = ";";
            action = ":";
            mode = "n";
          }
        ];
      };
    };
  };
}
