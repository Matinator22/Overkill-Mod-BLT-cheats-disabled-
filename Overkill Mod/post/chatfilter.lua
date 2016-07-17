--==================================--
--           OVERKILL MOD           --
--       CHAT FILTER COMMANDS       --
--           BY OVERKILL            --
--==================================--
-- SOURCE CREDIT: LazyOzzy (Pocofilter script)
-- r2.2
--=========================--
-- FILTER SETTINGS (REGEX) --
--=========================--
-- .	all characters
-- %a	letters
-- %c	control characters
-- %d	digits
-- %l	lower case letters
-- %p	punctuation characters
-- %s	space characters
-- %u	upper case letters
-- %w	alphanumeric characters
-- %x	hexadecimal digits
-- %z	the character with representation 0
-- +	Match the previous character 1 or more repetitions
-- *	Match the previous character 0 or more repetitions
-- -	Match the previous character 0 or more repetitions (few as possible)
-- ?	Make the previous character optional (0 or 1 occurrence)
--=========================--
--=============--
-- FILTER CHAT --
--=============--
ChatManager._GO_READY = {
"[Ll][Ee][Tt]'[Ss] [Gg][Oo] [Aa][Ll][Rr][Ee][Aa][Dd][Yy]%p*",
}
ChatManager._GO_SECRET = {
"[Ww]ind [Bb]lows,? [Ff]ire [Bb]urns,? [Ww]ater [Ff]lows,? [Aa]nd [Tt]he [Ee]arth [Tt]urns%p?",
}
ChatManager._GO_INSULT = {
"[Oo][Vv][Ee][Rr][Kk][Ii][Ll][Ll]%p?",
"[Aa][Ll][Mm][Ii][Rr]",
}
ChatManager._GO_DRILL = {
"[Bb]roke [Dd]ick [Pp]iece [Oo]f [Ss]hit [Dd]rill%p*",
"[Pp]iece [Oo]f [Ss]hit [Dd]rill%p*",
"[Ff][Uu][Cc][Kk] [Tt][Hh][Ii][Ss] [Dd][Rr][Ii][Ll][Ll]%p*",
"[Ff][Uu][Cc][Kk][Ii][Nn][Gg] [Dd][Rr][Ii][Ll][Ll]%p*",
"[Ff][Uu][Cc][Kk]%p*",
"[Ss][Hh][Ii][Tt]%p*",
}
ChatManager._GO_DANCE = {
"Hoxtalicious!!*",
"[Dd]ance [Oo]ff,? [Bb]ro%p?",
}
ChatManager._GO_SMOKE = {
"Nothing like a good smoke.",
"Need a light?",
"Naturally.",
}
--===============--
-- GLOBAL CHECKS --
--===============--
-- BEEP CHECK
local function beep()
	if managers and managers.menu_component then
		managers.menu_component:post_event("menu_enter")
	end
end
-- HOST CHECK
local function isHost()
	if not Network then
		return false
	end
	return not Network:is_client()
end
-- CLIENT CHECK
local function isClient()
	if not Network then
		return false
	end
	return Network:is_client()
end
-- GAME CHECK
local function inGame()
	if not game_state_machine then return false end
	return string.find(game_state_machine:current_state_name(), "game")
end
-- PLAY CHECK
local function isPlaying()
	if not BaseNetworkHandler then
		return false
	end
	return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
end
--===============--
-- CMD FUNCTIONS --
--===============--
------------------------------------------
-- INTERACT DATA (REQUIRED) by LazyOzzy --
------------------------------------------
local function InteractData(interact_data)
if not managers.interaction then return end
local objects = {}
	for _,v in pairs(managers.interaction._interactive_units) do
		if table.contains(interact_data, v:interaction().tweak_data) then
			table.insert(objects, v:interaction())
		end
	end
	for _,v in ipairs(objects) do
		v:interact(managers.player:player_unit())
	end
end
-------------------------
-- REMOTE DRILL REPAIR --
-------------------------
local function drill()
	if isPlaying() then
	InteractData({'apartment_drill_jammed','apartment_saw_jammed','drill_jammed','gen_int_saw','gen_int_saw_jammed','goldheist_drill_jammed','huge_lance_jammed','lance_jammed','suburbia_drill_jammed'})
	end
end
--------------
-- OVERKILL --
--------------
local function insult()
	if isPlaying() then
	managers.player:local_player():sound():say("cloaker_taunt_after_assault", false, true)
	end
end
-----------------
-- FORCE READY --
-----------------
-- CONFLICTS WITH PREPLANNING
local function ready()
	local level = managers.job:current_level_id()
	if isHost() and not isPlaying() and not (level == 'branchbank' 
	or level == 'big'
	or level == 'crojob2'
	or level == 'crojob3'
	or level == 'firestarter_3'
	or level == 'framing_frame_1'
	or level == 'framing_frame_3'
	or level == 'gallery'
	or level == 'kenaz'
	or level == 'kosugi'
	or level == 'mia_1'
	or level == 'mia_2'
	or level == 'mus'
	or level == 'pbr' ) then
		managers.network:session():spawn_players()
	end
end
-------------------------
-- FWB OVERDRILL VAULT --
-------------------------
local function overdrill()
	if isHost() and isPlaying() and managers.job:current_level_id() == "red2" and not managers.groupai:state():whisper_mode() and Global.game_settings.difficulty == "overkill_290" then
		for _, script in pairs(managers.mission:scripts()) do
			for id, element in pairs(script:elements()) do
				for _, trigger in pairs(element:values().trigger_list or {}) do
					if trigger.notify_unit_sequence == "light_on" then
						element:on_executed()
					end
				end
			end
		end
	end
end
--------------------
-- CIVILIAN DANCE --
--------------------
local function dance()
	if isHost() and isPlaying() then
		local poses = {"cf_sp_dance_slow", "cf_sp_dance_sexy", "cf_sp_pole_dancer_expert", "cf_sp_pole_dancer_basic"}
		for k,v in pairs(managers.enemy:all_civilians()) do
			local act = {type = "act", variant = poses[math.random(4)], body_part = 1, align_sync = true}
			v.unit:movement():action_request(act)		
		end
	end
end
--------------------
-- CIVILIAN SMOKE --
--------------------
local function smoke()
	if isHost() and isPlaying() then
		local poses = {"cm_sp_smoking_left1", "cf_sp_smoking_var1", "cm_sp_smoking_right1", "cmf_so_smoke"}
		for k,v in pairs(managers.enemy:all_civilians()) do
			local act = {type = "act", variant = poses[math.random(4)], body_part = 1, align_sync = true}
			v.unit:movement():action_request(act)
		end	
	end
end
--==========================================================================================================--
--                          CHAT MANAGER : EXECUTE SCRIPT UPON RECEIVING MSG                                --
--                                                                                                          --
--                       managers.chat:feed_system_message(ChatManager.GAME, "")                            --
--    managers.chat:send_message(ChatManager.GAME, managers.network.account:username() or "Offline", "")    --
--                         string.match(tostring(message), "^" .. str .. "$")                               --
--                                message:match("^" .. msg .. "$")                                          --
--==========================================================================================================--
if RequiredScript == 'lib/managers/chatmanager' then 
	local _receive_message_original = ChatManager._receive_message
	function ChatManager:_receive_message(channel_id, name, message, ...)
		
		for i, msg in ipairs(ChatManager._GO_INSULT) do
			if message:match(msg) then
				DelayedCalls:Add("_BLOCK_INSULT_1", 1, function() insult() end)
				DelayedCalls:Add("_BLOCK_INSULT_2", 5, function() insult() end)
				DelayedCalls:Add("_BLOCK_INSULT_3", 10, function() insult() end)
			end
		end
		
		for i, msg in ipairs(ChatManager._GO_DRILL) do
			if message:match(msg) then
				DelayedCalls:Add("_BLOCK_DRILL", 1, function() drill() end)
			end
		end
		
		for i, msg in ipairs(ChatManager._GO_READY) do
			if message:match("^" .. msg .. "$") then
				DelayedCalls:Add("_BLOCK_READY_30", 30, function() ready() end)
			end
		end
		
		for i, msg in ipairs(ChatManager._GO_SECRET) do
			if message:match("^" .. msg .. "$") then
				DelayedCalls:Add("_BLOCK_SECRET", 1, function() overdrill() end)
			end
		end
		
		for i, msg in ipairs(ChatManager._GO_DANCE) do
			if message:match("^" .. msg .. "$") then
				DelayedCalls:Add("_BLOCK_DANCE", 1, function() dance() end)
			end
		end
		
		for i, str in ipairs(ChatManager._GO_SMOKE) do
			if string.match(tostring(message), "^" .. str .. "$") then
				DelayedCalls:Add("_BLOCK_SMOKE", 1, function() smoke() end)
			end
		end
		
		return _receive_message_original(self, channel_id, name, message, ...)
	end
end