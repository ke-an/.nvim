vim.api.nvim_create_user_command("PhpcsLint", function()
  local lint = require("lint")
  lint.linters_by_ft.php = { "phpcs" }
  lint.try_lint("php")
end, { desc = "Run phpcs manually" })

