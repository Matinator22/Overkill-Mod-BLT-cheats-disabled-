------------------------------------
-- FOR KNOWLEDGEABLE USERS ONLY ----
------------------------------------
--=======================--
--     OVERKILL MOD      --
--        DIALOG         --
--=======================--
-- r2.1
local path = "mods/Overkill Mod/mission/dialog.txt"
local mission = managers.job:current_level_id()
------------------------------------------------------------------
-- MISSION BLOCK ALLOWS DIALOG MANAGER TO BE USED IN THESE MAPS --
------------------------------------------------------------------
if inGame() and not inChat() and not (mission == 'rat' or mission == 'alex_1' or mission == 'nail' or mission == 'arm_hcm' or mission == 'arm_fac' or mission == 'escape_overpass_night' or mission == 'escape_overpass' or mission == 'escape_street') then
	DIALOG = not (DIALOG or false)
	if DIALOG then 
		managers.mission._fading_debug_output:script().log(' SHOW DIALOG ', Color("2ebdf5") )
		managers.mission._fading_debug_output:script().log(' DIALOG : '..mission..'\.txt ',  tweak_data.system_chat_color)
	else
		managers.mission._fading_debug_output:script().log(' HIDE DIALOG ', Color.Orange )
		managers.mission._fading_debug_output:script().log(' DIALOG : '..mission..'\.txt ',  tweak_data.system_chat_color)
	end
	-- [[ DIALOG LIST PASTED BELOW ]] --
	-----------------------
	-- PRIORITY SETTINGS --
	-----------------------
	-- PRIO (LOW -> HIGH): 0-4
	local X = "X"
	local chatter = 1
	local objective = 2
	local tactics = 3
	local team = 4
	local escape = 5
	local allowed_types = { X, chatter, objective, tactics, team, escape }
	local allowed_prios = { X, 0, 1, 2, 3, 4 }
	local dialog_list = {}
	-----------------------
	-- FUNCTION LEVEL ID --
	-----------------------
	local function new_level(id)
		if not dialog_list[id] then 
			return false 
		end
		local level = managers.job:current_level_id()
		local levels = dialog_list[id] and dialog_list[id].levels
		if not levels then 
			return false 
		end
		for _, l in pairs(levels) do 
			if l == level then 
				return false 
			end 
		end
		return true
	end
	------------------------
	-- FUNCTION DIALOG ID --
	------------------------
	local function play_dialog(id)
		if not dialog_list[id] then 
			return true 
		end
	local prio = dialog_list[id].prio
	local type = dialog_list[id].type
	local p_ok = not prio and true or false
	local t_ok = not type and true or false
		for _, p in ipairs(allowed_prios) do 
			if p == prio then 
				p_ok = true; break 
			end 
		end
		for _, t in ipairs(allowed_types) do 
			if t == type then 
				t_ok = true; break 
			end 
		end
		return p_ok and t_ok or false
	end
	--------------------
	-- FUNCTION LOGME --
	--------------------
	local function logme(id, params)
	local level = managers.job:current_level_id()
	local str = string.format("%s - %s", tostring(level), tostring(id))
	if params then
		for k, v in pairs(params) do
			if not (tostring(k) == "case" or tostring(k) == "done_cbk") then
				local tmp = " " .. tostring(k) .. " -> " .. tostring(v)
				str = str .. tmp
			end
		end
	end
	if new_level(id) then 
		str = "NEW LEVEL\t" .. str 
	end	
	str = str .. "\n"
	io.write(str)
	--------------
	-- GAME MSG --
	--------------
	if DIALOG then
		managers.chat:_receive_message(1, 'DIALOG', ''..(str), tweak_data.system_chat_color)
	end
	
	local file = io.open(path, "a")
	file:write(str)
	file:close()
	end
	--------------------
	-- DIALOG MANAGER --
	--------------------
	local printed = {}
	function DialogManager:queue_dialog(id, params)
		if dialog_list[id] and dialog_list[id].callback then
			dialog_list[id].callback(unpack(dialog_list[id].args))
		end
		if not params.skip_idle_check and managers.platform:presence() == "Idle" then
			return
		end
		if not self._dialog_list[id] then
			debug_pause("The dialog script tries to queue a dialog with id '" .. tostring(id) .. "' which doesn't seem to exist!")
			return false
		end
		if not dialog_list[id] or new_level(id) then
			if not printed[id] then
				logme(id, params)
				printed[id] = true
			end
		end
		if not play_dialog(id) then
			if params and params.done_cbk then
				self:_call_done_callback(params.done_cbk, "skipped")
			end
			io.write("BLOCKED ID: " .. tostring(id) .. "\n")
			return false
		end
		if not self._current_dialog then
			self._current_dialog = {id = id, params = params}
			self:_play_dialog(self._dialog_list[id], params)
		else
			local dialog = self._dialog_list[id]
				if self._next_dialog and dialog.priority > self._dialog_list[self._next_dialog.id].priority then
					self:_call_done_callback(params and params.done_cbk, "skipped")
					return false
				end
			if dialog.priority < self._dialog_list[self._current_dialog.id].priority then
				if self._next_dialog then
					self:_call_done_callback(self._dialog_list[self._next_dialog.id].params and self._dialog_list[self._next_dialog.id].params.done_cbk, "skipped")
				end
				self._next_dialog = {id = id, params = params}
			else
				self:_call_done_callback(params and params.done_cbk, "skipped")
			end
		end
		return true
	end
-----------------------
-- END MISSION BLOCK --
-----------------------
else
	managers.mission._fading_debug_output:script().log(' DISPLAY CONFLICT. FEATURE DISABLED. ', Color("97d04d") )
	managers.mission._fading_debug_output:script().log(' DIALOG : '..mission..'\.txt',  tweak_data.system_chat_color)
end