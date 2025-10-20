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
      local function load_mistral_key()
        local env_path = vim.fn.getcwd() .. "/.env"

        if vim.fn.filereadable(env_path) == 0 then
          vim.notify("CodeCompanion: .env not found at " .. env_path, vim.log.levels.WARN)
          return nil
        end

        local file = io.open(env_path, "r")
        if not file then
          vim.notify("CodeCompanion: failed to open .env", vim.log.levels.ERROR)
          return nil
        end

        for line in file:lines() do
          local key, value = line:match("^%s*([%w_]+)%s*=%s*(.+)%s*$")
          if key == "MISTRAL_API_KEY" then
            file:close()
            return value:gsub("^['\"](.+)['\"]$", "%1")
          end
        end

        file:close()
        vim.notify("CodeCompanion: MISTRAL_API_KEY not found in .env", vim.log.levels.WARN)
        return nil
      end

      require("codecompanion").setup({
        strategies = {
          chat = { adapter = "mistral" },
          inline = { adapter = "mistral" },
        },
        adapters = {
          mistral = function()
            return require("codecompanion.adapters").extend("mistral", {
              env = {
                api_key = load_mistral_key(),
              },
              schema = {
                model = {
                  default = "pixtral-12b-2409",
                },
              },
            })
          end,
        },
        display = {
          chat = {
            render_headers = false,
          },
        },
        prompt_library = {
          ["Code Review"] = {
            strategy = "chat",
            description = "Review code for bugs and improvements",
            prompts = {
              {
                role = "system",
                content = "You are a code reviewer. Analyze code for: logic errors, potential runtime issues, performance bottlenecks, security vulnerabilities, code style violations. Output findings in structured format. No emoji. No motivational language. Focus on technical correctness.",
              },
            },
          },
          ["Refactor"] = {
            strategy = "inline",
            description = "Refactor selected code",
            prompts = {
              {
                role = "system",
                content = "Refactor code to improve readability, maintainability, and performance. Preserve functionality. Remove redundancy. Apply language-specific best practices. No emoji. No explanatory prose unless errors found.",
              },
            },
          },
          ["Debug"] = {
            strategy = "chat",
            description = "Identify bugs and propose fixes",
            prompts = {
              {
                role = "system",
                content = "Identify bugs, logic errors, edge cases, and runtime risks. Propose minimal fix. No emoji. No encouragement. Direct technical analysis only.",
              },
            },
          },
        },
      })
    end,
  },
}
