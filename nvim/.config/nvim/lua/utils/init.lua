local M = {}

function M.get_date_zw()
	local start_week_day = "sunday"
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

return M
