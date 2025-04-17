{programs, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        diagnostics.enable = true;
        filetree.neo-tree.enable = true;
        notes.todo-comments.enable = true;
        binds.whichKey.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
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
        languages = {
          enableTreesitter = true;
          enableFormat = true;
          enableLSP = true;
          html.enable = true;
          ts.enable = true;
          nix.enable = true;
          css.enable = true;
          rust = {
            enable = true;
          };
        };

        keymaps = [
          {
            key = ";";
            action = ":";
            mode = "n";
          }
          {
            key = "<leader>e";
            action = "<cmd>Neotree toggle<cr>";
            mode = "n";
          }
        ];
      };
    };
  };
}
