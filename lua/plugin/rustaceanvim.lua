return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  ft = { "rust" },
  config = function()
    local cfg = require("rustaceanvim.config")
    local codelldb_ext_path = vim.fn.expand("$MASON/packages/codelldb") .. "/extension"
    local codelldb_path = codelldb_ext_path .. "/adapter/codelldb"
    local liblldb_ext = vim.uv.os_uname().sysname == "Darwin" and ".dylib" or ".so"
    local liblldb_path = codelldb_ext_path .. "/lldb/lib/liblldb" .. liblldb_ext
    vim.g.rustaceanvim = {
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end,
}
