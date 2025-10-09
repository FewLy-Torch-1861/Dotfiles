return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        json = { "prettier", "prettierd" },
        jsonc = { "prettier", "prettierd" },
      },
    },
  },
}
