require "nvchad.options"

--Cursor Line
--local o = vim.o
--o.cursorlineopt ='both' -- to enable cursorline!

--Hyprlang file recognition
vim.filetype.add {
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}

-- Auto open nvim-tree
require("nvim-tree.api").tree.open {
  path = nil,
  current_window = false,
  find_file = false,
  update_root = false,
}

-- Auto close nvim tree
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if
      layout[1] == "leaf"
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
      and layout[3] == nil
    then
      vim.cmd "confirm quit"
    end
  end,
})
