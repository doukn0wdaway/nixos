return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        markdown = { "prettierd" },
        json = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {},

        -- HTML/CSS/JSON
        html = {},
        cssls = {},
        jsonls = {},

        -- Tailwind
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                -- если нужно распознавать tw-классы в нестандартных атрибутах/шаблонах:
                classRegex = {
                  { "tw`([^`]*)`", "tw\\(([^)]*)\\)", 'tw="([^"]*)"' }, -- twin.macro/clsx и т.п.
                },
              },
              classAttributes = { "class", "className", "ngClass" },
              emmetCompletions = true,
            },
          },
        },

        -- ESLint (по желанию)
        -- eslint = {},
      },
      setup = {},
    },
  },
}
