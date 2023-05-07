local M = {}

function M.RunPyFile()
	-- TODO: probably a way to do this with toggleterm+lua
	-- TODO: Separate function to handle the "shellescape" part
	local myfn = vim.fn.expand("%"):gsub(" ", "\\\\ "):gsub("#", "\\\\#")
	vim.cmd([[:TermExec cmd="python ]] .. myfn .. [["<CR>]])
end

function M.get_date_zw(start_week_day)
  start_week_day = start_week_day or "sunday"
	if string.lower(os.date("%A")) == start_week_day then
		return "today"
	else
		return start_week_day
	end
end

function M.create_reading_tbl()
	local author = vim.fn.input("Author: ")
	local year = vim.fn.input("Year: ")
	local readingid = vim.fn.input("Reading ID: ")

	local title = table.concat({ author, year, readingid }, " ")

	local zk_tbl = { title = title, dir = "readings", extra = { author = author, year = year, readingid = readingid } }
	-- NOTE: This would be the code to return str with table info instead, keeping in case
	-- local reading_str = vim.inspect(zk_tbl, {newline = " ", indent=""})
	-- return reading_str
	return zk_tbl
end

function M.map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- HACK: This workaround disables ltex in settings, but not actual LSP
-- works to supprress error messages, which is what I needed
function M.get_enable_ltex()
	-- local filename = vim.api.nvim_buf_get_name(0)
	local filename = vim.fn.getcwd()
	if string.match(filename, "notes") then
		return false
	end
	return {
		"bibtex",
		"context",
		"context.tex",
		"html",
		"latex",
		"markdown",
		"org",
		"restructuredtext",
		"rsweave",
		"mail",
	}
end

return M
