return {
  "windwp/nvim-ts-autotag",
  ft = {
    "astro",
    "glimmer",
    "handlebars",
    "hbs",
    "html",
    "javascript",
    "javascriptreact",
    "jsx",
    "markdown",
    "php",
    "svelte",
    "tsx",
    "typescript",
    "typescriptreact",
    "vue",
    "xml",
  },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
