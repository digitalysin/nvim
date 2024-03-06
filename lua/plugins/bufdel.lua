return {
  "ojroques/nvim-bufdel",
  config = function()
    require("bufdel").setup({
      next = "tabs",
    })
  end,
}
