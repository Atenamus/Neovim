local M = {}

local function create_floating_window(config)
	-- Create a buffer
	local buf = vim.api.nvim_create_buf(false, true)
	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, config)

	return { buf = buf, win = win }
end

M.setup = function() end
---@class present.Slides
---@field slides present.Slide[]:the slides of the file
---@class present.Slide
---@field title string:titlle of the slide
---@field body string[]:body of the slide

---takes some lines and parses them
---@param lines string[]:the lines in buffer
---@return present.Slides

local parse_slides = function(lines)
	local slides = { slides = {} }
	local seperator = "^#"
	local current_slide = {
		title = "",
		body = {},
	}

	for _, line in ipairs(lines) do
		if line:find(seperator) then
			if #current_slide.title > 0 then
				table.insert(slides.slides, current_slide)
			end
			current_slide = {
				title = line,
				body = {},
			}
		end
		table.insert(current_slide.body, line)
	end
	table.insert(slides.slides, current_slide)
	return slides
end

M.start_presentation = function(opts)
	opts = opts or {}
	opts.bufnr = opts.bufnr or 0
	local lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
	local parsed = parse_slides(lines)

	---@type vim.api.keyset.win_config
	local width = vim.o.columns
	local height = vim.o.lines
	local windows = {
		header = {
			relative = "editor",
			width = width,
			height = 1,
			style = "minimal",
			col = 1,
			row = 1,
		},
		body = {
			relative = "editor",
			width = width,
			height = height - 1,
			col = 1,
			row = 2,
			style = "minimal",
			border = { " ", " ", " ", " ", " ", " ", " ", " " },
		},
	}
	local header_float = create_floating_window(windows.header)
	local body_float = create_floating_window(windows.body)
	local current_slide = 1

	local function set_slide_content(idx)
		local slide = parsed.slides[idx]
		vim.api.nvim_buf_set_lines(header_float.buf, 0, -1, false, slide.titlle)
		vim.api.nvim_buf_set_lines(body_float.buf, 0, -1, false, slide.body)
	end

	vim.keymap.set("n", "n", function()
		current_slide = math.min(current_slide + 1, #parsed.slides)
		set_slide_content(current_slide)
	end, {
		buffer = body_float.buf,
	})
	vim.keymap.set("n", "p", function()
		current_slide = math.max(current_slide - 1, 1)
		set_slide_content(current_slide)
	end, {
		buffer = body_float.buf,
	})
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(body_float.win, true)
	end, {
		buffer = body_float.buf,
	})

	local restore = {
		cmdheight = {
			original = 1,
			present = 0,
		},
	}
	for option, config in pairs(restore) do
		vim.opt[option] = config.present
	end

	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = body_float.buf,
		callback = function()
			for option, config in pairs(restore) do
				vim.opt[option] = config.original
			end
			pcall(vim.api.nvim_win_close, header_float.win, true)
		end,
	})
	set_slide_content(current_slide)
end

M.start_presentation({ bufnr = 18 })

-- vim.print(parse_slides({
-- 	"#Hello",
-- 	"this is amazing",
-- 	"#World",
-- }))
return M
