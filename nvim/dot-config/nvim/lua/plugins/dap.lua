return {
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
      local configurations = require("dap").configurations.python
      for _, configuration in pairs(configurations) do
        -- NOTE: Using brackets instead of . to fix lsp warning. Revert if problems
        configuration["justMyCode"] = false
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      -- HACK: LazyVim sets host to localhost, which does not work for me because ipv6 or something
      -- Ref: https://github.com/LazyVim/LazyVim/issues/3577
      local dap = require("dap")
      if dap.adapters["codelldb"] then
        dap.adapters.codelldb["host"] = "127.0.0.1"
      end
    end,
  },
}
