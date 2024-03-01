return {
  "ojroques/nvim-bufdel",
  config = function()
    require("bufdel").setup({
      next = "tabs",
    })

    vim.keymap.set("n", "<leader>bd", ":BufDel<CR>", {})
  end,
}
