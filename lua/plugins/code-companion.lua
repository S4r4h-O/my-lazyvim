return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local function load_env()
        local env_file = vim.fn.getcwd() .. "/.env"
        if vim.fn.filereadable(env_file) == 0 then
          return nil
        end

        for line in io.lines(env_file) do
          local key, value = line:match("^([%w_]+)=(.+)$")
          if key and value then
            value = value:gsub("^['\"](.+)['\"]$", "%1")
            if key == "MISTRAL_API_KEY" then
              return value
            end
          end
        end
        return nil
      end

      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "mistral",
          },
          inline = {
            adapter = "mistral",
          },
        },
        adapters = {
          mistral = function()
            return require("codecompanion.adapters").extend("mistral", {
              env = {
                api_key = load_env(),
              },
            })
          end,
        },
      })
    end,
  },
}
