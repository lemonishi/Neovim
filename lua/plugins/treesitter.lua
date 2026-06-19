return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "groovy",
        "hcl",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "just",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "sql",
        "terraform",
        "tmux",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    })

    local ignore_filetype = {
      "checkhealth",
      "lazy",
      "mason",
      "snacks_dashboard",
      "snacks_notif",
      "snacks_win",
      "snacks_input",
      "snacks_picker_input",
      "TelescopePrompt",
      "alpha",
      "dashboard",
      "spectre_panel",
      "NvimTree",
      "undotree",
      "Outline",
      "sagaoutline",
      "copilot-chat",
      "vscode-diff-explorer",
    }

    local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      desc = "Enable TreeSitter highlighting and indentation",
      callback = function(ev)
        local ft = ev.match
        if vim.tbl_contains(ignore_filetype, ft) then
          return
        end
        local lang = vim.treesitter.language.get_lang(ft) or ft
        local buf = ev.buf
        pcall(vim.treesitter.start, buf, lang)
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
