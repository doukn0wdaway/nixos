{ programs, ... }: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        diagnostics.enable = true;
        diagnostics.config.update_in_insert = true;
        diagnostics.config.virtual_text = true;
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

          html.enable = true;
          ts.enable = true;
          nix = {
            enable = true;
            lsp = {
              server = "nixd";
              options = {
                home_manager = {
                  expr = "(builtins.getFlake \"/home/etarxis/nixos\").homeConfigurations.default.options";
                };
              };
            };
          };
          css.enable = true;
          rust = {
            enable = false;
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
