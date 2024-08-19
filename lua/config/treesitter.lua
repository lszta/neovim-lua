require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "go",
    "groovy",
    "javascript",
    "lua",
    "python",
    "scala",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
    "c",
    "lua",
    "query",
    "vim",
    "vimdoc"
  },
  sync_install = true,
  auto_install = false,
  highlight = {
    enable = true,
  },
  additional_vim_regex_higlighting = false,
}
