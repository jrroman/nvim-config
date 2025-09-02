return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_go = require("dap-go")

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl",    size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
    })

    dap.adapters.lldb = {
      type = "executable",
      command = "/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap",
      name = "lldb"
    }

    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      }
    }

    dap.configurations.c = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      }
    }

    dap_go.setup({
      -- Additional dap configurations can be added
      dap_configurations = {
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
      -- Delve configurations
      delve = {
        -- Path to delve executable
        path = "dlv",
        -- Log level for delve
        log_level = "info",
        -- Initialize timeout
        initialize_timeout_sec = 20,
        -- Port for delve headless mode
        port = "${port}",
      },
    })

    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      filter_references_pattern = "<module",
      virt_text_pos = "eol",
      all_frames = false,
    })

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Key mappings for debugging
    vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Dap: Start/Continue" })
    vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Dap: Step Into" })
    vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Dap: Step Over" })
    vim.keymap.set("n", "<leader>dsu", dap.step_out, { desc = "Dap: Step Out" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Dap: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Dap: Set Conditional Breakpoint" })
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Dap: Toggle REPL" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Dap: Run Last" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Dap: Toggle UI" })
    vim.keymap.set("n", "<leader>dc", dap.disconnect, { desc = "Dap: Disconnect from debug session" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Dap: Terminate debug session" })
    vim.keymap.set("n", "<leader>dcb", dap.clear_breakpoints, { desc = "Dap: Clear all breakpoints" })

    -- Go-specific key mappings
    vim.keymap.set("n", "<leader>dgt", function()
      require("dap-go").debug_test()
    end, { desc = "Debug: Go Test" })

    vim.keymap.set("n", "<leader>dgl", function()
      require("dap-go").debug_last_test()
    end, { desc = "Debug: Go Last Test" })

    -- Custom configuration for debugging different Go scenarios
    table.insert(dap.configurations.go, {
      type = "go",
      name = "Debug Package",
      request = "launch",
      program = "${workspaceFolder}",
      args = {},
      showLog = true,
    })

    table.insert(dap.configurations.go, {
      type = "go",
      name = "Debug File",
      request = "launch",
      program = "${file}",
      args = {},
      showLog = true,
    })

    table.insert(dap.configurations.go, {
      type = "go",
      name = "Debug with Arguments",
      request = "launch",
      program = "${workspaceFolder}",
      args = function()
        local args_str = vim.fn.input("Arguments: ")
        return vim.split(args_str, " ")
      end,
      showLog = true,
    })
  end,
}
