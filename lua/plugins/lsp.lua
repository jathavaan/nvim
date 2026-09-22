return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = { border = "rounded" },
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"prettier",
				"sql-formatter",
				"shfmt",
				"shellcheck",
				"hadolint",
				"actionlint",
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 3000,
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/SchemaStore.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = true },
			})

			local servers = {
				-- Python
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
				ruff = {},

				-- Docker
				dockerls = {},
				docker_compose_language_service = {},

				-- Azure / infra
				bicep = {},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = { enable = false, url = "" },
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				-- TypeScript / JavaScript
				vtsls = {
					settings = {
						complete_function_calls = true,
						vtsls = {
							autoUseWorkspaceTsdk = true,
							enableMoveToFileCodeAction = true,
							experimental = {
								completion = { enableServerSideFuzzyMatch = true },
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = { completeFunctionCalls = true },
							inlayHints = {
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = false },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
						},
					},
				},
				eslint = {},

				-- Other
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					},
				},
				lemminx = {},
				bashls = {},
				marksman = {},
				powershell_es = {},
			}

			-- Register configs before mason-lspconfig enables the servers
			for name, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(name, config)
			end

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
				callback = function(ev)
					local function map(keys, fn, desc, mode)
						vim.keymap.set(mode or "n", keys, fn, { buffer = ev.buf, desc = desc })
					end

					-- Navigation
					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gD", vim.lsp.buf.declaration, "Go to declaration")
					map("gI", vim.lsp.buf.implementation, "Go to implementation")
					map("gy", vim.lsp.buf.type_definition, "Go to type definition")
					map("gr", vim.lsp.buf.references, "References")

					-- Information
					map("K", vim.lsp.buf.hover, "Hover docs")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")
					map("<leader>lh", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
							{ bufnr = ev.buf }
						)
					end, "Toggle inlay hints")

					-- Actions
					map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>la", vim.lsp.buf.code_action, "Code action", { "n", "v" })
					map("<leader>lo", function()
						vim.lsp.buf.code_action({
							context = { only = { "source.organizeImports" } },
							apply = true,
						})
					end, "Organize imports")
					map("<leader>lO", function()
						vim.lsp.buf.code_action({
							context = { only = { "source.fixAll" } },
							apply = true,
						})
					end, "Fix all auto-fixable")

					-- Diagnostics
					map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
					map("[d", function()
						vim.diagnostic.jump({ count = -1 })
					end, "Prev diagnostic")
					map("]d", function()
						vim.diagnostic.jump({ count = 1 })
					end, "Next diagnostic")

					-- Server-specific setup
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if not client then
						return
					end

					if client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
					end

					if client.name == "eslint" then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("EslintFixOnSave" .. ev.buf, { clear = true }),
							buffer = ev.buf,
							command = "LspEslintFixAll",
						})
					end
				end,
			})
		end,
	},
}
