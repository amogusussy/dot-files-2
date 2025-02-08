return {
	config = function()
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = ("  %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					-- str width returned from truncate() may less than 2nd argument, need padding
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end

		local ftMap = {
			vim = "indent",
			python = { "indent" },
			git = "",
		}

		local opts = { noremap = false, silent = true }
		local keymap = vim.keymap.set
		--Folds
		keymap("n", "zR", require("ufo").openAllFolds, opts)
		keymap("n", "zM", require("ufo").closeAllFolds, opts)
		keymap("n", "zr", require("ufo").openFoldsExceptKinds, opts)
		keymap("n", "zm", require("ufo").closeFoldsWith, opts)
		keymap("n", "zk", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end)

		require("ufo").setup({
			fold_virt_text_handler = handler,
			open_fold_hl_timeout = 150,
			close_fold_kinds = { "imports", "comment" },

			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
				},
			},

			provider_selector = function(bufnr, filetype, buftype)
				return ftMap[filetype] or { "treesitter", "indent" }
			end,
		})
	end,
}
