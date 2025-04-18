local timer_active = false
local timer_win = nil
local timer_ref = nil

local function create_timer_window()
	local buf = vim.api.nvim_create_buf(false, true)

	local config = {
		relative = "editor",
		width = 20,
		height = 1,
		row = 0,
		col = vim.o.columns - 22,
		style = "minimal",
		border = "rounded",
		focusable = false,
	}

	local win = vim.api.nvim_open_win(buf, false, config)
	return buf, win
end

local function update_timer_display(win, text)
	local buf = vim.api.nvim_win_get_buf(win)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })
end

local function timer_alert()
	vim.notify("Timer Finished!", vim.log.levels.INFO)
end

local function format_time(seconds)
	local hrs = math.floor(seconds / 3600)
	local mins = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	return string.format("%02d:%02d:%02d", hrs, mins, secs)
end

local function close_timer()
	if timer_active then
		if timer_ref then
			timer_ref:stop()
			timer_ref:close()
		end
		if timer_win and vim.api.nvim_win_is_valid(timer_win) then
			vim.api.nvim_win_close(timer_win, true)
		end
		timer_active = false
		timer_ref = nil
		timer_win = nil
	else
		vim.notify("No active timer to close.", vim.log.levels.WARN)
	end
end

local function start_timer(hours, minutes, seconds)
	if timer_active then
		vim.notify("A timer is already running.", vim.log.levels.WARN)
		return
	end

	timer_active = true
	local time_left = hours * 3600 + minutes * 60 + seconds

	local _, win = create_timer_window()
	timer_win = win

	timer_ref = vim.uv:new_timer()
	if timer_ref then
		timer_ref:start(
			0,
			1000,
			vim.schedule_wrap(function()
				if time_left > 0 then
					update_timer_display(win, "Timer: " .. format_time(time_left))
					time_left = time_left - 1
				else
					close_timer()
					timer_alert()
				end
			end)
		)
	end
end

local function set_timer()
	local hours = tonumber(vim.fn.input("Set hours: ")) or 0
	local minutes = tonumber(vim.fn.input("Set minutes: ")) or 0
	local seconds = tonumber(vim.fn.input("Set seconds: ")) or 0

	if hours < 0 or minutes < 0 or seconds < 0 or minutes >= 60 or seconds >= 60 then
		vim.notify("Invalid input. Ensure hours, minutes, and seconds are valid.", vim.log.levels.ERROR)
		return
	end

	start_timer(hours, minutes, seconds)
end

-- Commands for setting and closing the timer
vim.api.nvim_create_user_command("SetTimer", set_timer, {})
vim.api.nvim_create_user_command("CloseTimer", close_timer, {})

-- Autocommand to automatically close the timer when Neovim exits
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		close_timer()
	end,
})
