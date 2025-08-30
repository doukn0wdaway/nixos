-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "gR", "<cmd> Trouble lsp_references <CR>")

vim.keymap.set("n", "<tab>", "<cmd> bn <CR>")
vim.keymap.set("n", "<S-tab>", "<cmd> bp <CR>")
for _, mode in ipairs({ "n", "i", "v", "x", "s", "o", "c", "t" }) do
  vim.keymap.set(mode, "<M-j>", "<Nop>", { silent = true })
  vim.keymap.set(mode, "<M-k>", "<Nop>", { silent = true })
end

vim.keymap.del("n", "<Esc>") -- по дефу оно вызывает очистку хайлайта
