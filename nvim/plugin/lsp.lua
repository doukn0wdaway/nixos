local on_attach = function(_, bufnr)

  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()
require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
	root_dir = function()
        return vim.loop.cwd()
    end,
	cmd = { "lua-language-server" },
	settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',  -- Настроим, что это будет LuaJIT
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = { 'vim' },  -- Явно указываем, что vim должен быть доступен для диагностики
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),  -- Указываем библиотеку Neovim
            },
        },
    },
}

require('lspconfig').nil_ls.setup {  -- Here, replace 'nil_ls' with the correct name of the server
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function()
        return vim.loop.cwd()
    end,
    cmd = { "nil" },  -- Or the correct path to the nil-ls executable
		filetypes = { "nix" };
    settings = {
        Nix = {
            formatting = { enable = true, command = {"nixftm"};},
            linting = { enable = true },
        },
    }
}

require('lspconfig').typescript.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function()
        return vim.loop.cwd()
    end,
    cmd = { "typescript-language-server" },
		filetypes = { "ts", "tsx" };
}

-- require('lspconfig').prettier.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     root_dir = function()
--         return vim.loop.cwd()  -- Устанавливаем корень проекта как текущую директорию
--     end,
--     cmd = { "prettier", "--stdio" },  -- Используем stdio для взаимодействия с LSP
--     settings = {
--         prettier = {
--             -- Указываем, что prettier должен искать свою конфигурацию в node_modules
--             configPath = vim.fn.getcwd() .. "/node_modules/prettier",
--         },
--     },
--     -- Проверяем, установлен ли prettier в node_modules
--     condition = function()
--         return vim.fn.executable(vim.fn.getcwd() .. "/node_modules/.bin/prettier") == 1
--     end,
-- }

require('lspconfig').tailwindcss.setup { cmd = { "tailwind-language-server"}}
