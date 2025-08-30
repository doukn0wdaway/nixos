return {
  { "rebelot/kanagawa.nvim", priority = 1000, event = "VeryLazy" },
  { "Mofiqul/dracula.nvim", priority = 1000, event = "VeryLazy" },
  { "folke/tokyonight.nvim", priority = 1000, event = "VeryLazy" },
  { "Mofiqul/vscode.nvim", priority = 1000, event = "VeryLazy" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    event = "VeryLazy",
    opts = {
      no_underline = true,
      show_end_of_buffer = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      news = { lazyvim = false },
      colorscheme = function()
        vim.cmd("colorscheme " .. "tokyonight-moon")
      end,
    },
  },
}
