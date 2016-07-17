--========================================--
--              OVERKILL MOD              --
--            THE TIME BUTTON             --
--              BY OVERKILL               --
--========================================--
-- SOURCE CREDIT: PIERREDJAYS
-- r2.1
--------------
-- SETTINGS --
--------------
local level = managers.job:current_level_id()
local state = managers.player:current_state()
local carrying = managers.player:current_carry_id()
local emergency = Vector3(351.991, -4634.66, 46203.6)
local driving = managers.player:current_state() == "driving"
local point
---------------
-- FUNCTIONS --
---------------
chroniton = chroniton or function()
	point = managers.player:player_unit():position()
end
antichroniton = antichroniton or function()
	managers.player:warp_to(point, managers.player:player_unit():position())
end
-----------------
-- TIME BUTTON --
-----------------
if inGame() and isPlaying() and not inChat() then
POINTBREAK = not (POINTBREAK or false) 
	if POINTBREAK then
		managers.player:local_player():sound():say("alarm_countdown_loop", false, false)
		-------------
		-- DRIVING --
		-------------
		if driving then end
		----------
		-- SAVE --
		----------
		managers.mission._fading_debug_output:script().log("POINT SAVE", Color("97d04d"))
		managers.mission._fading_debug_output:script().log("TIME BUTTON : ", Color("a7ddf4"))
		chroniton()
	else
		managers.player:local_player():sound():say("alarm_countdown_loop_stop", false, false)
		------------------
		-- FREE FALLING --
		------------------
		if state == "jerry1" then
		managers.player:warp_to(emergency, managers.player:player_unit():position())
		managers.player:set_player_state("standard")
		managers.player:local_player():sound():say("Stop_all_music", false, false)
		managers.mission._fading_debug_output:script().log("EMERGENCY RETURN", Color("97d04d"))
		managers.mission._fading_debug_output:script().log("TIME BUTTON : ", Color("a7ddf4"))
		return
		end
		---------------
		-- PARACHUTE --
		---------------
		if state == "jerry2" then
		managers.player:set_player_state("jerry2")
		managers.mission._fading_debug_output:script().log("DEPLOY RETURN", Color("97d04d"))
		managers.mission._fading_debug_output:script().log("TIME BUTTON : ", Color("a7ddf4"))
		end
		-------------
		-- DRIVING --
		-------------
		if driving then
		managers.mission._fading_debug_output:script().log("RETURN FAILED", Color.Orange)
		managers.mission._fading_debug_output:script().log("TIME BUTTON : ", Color("a7ddf4"))
		return end
		------------
		-- RETURN --
		------------
		managers.mission._fading_debug_output:script().log("POINT RETURN", Color("97d04d"))
		managers.mission._fading_debug_output:script().log("TIME BUTTON : ", Color("a7ddf4"))
		antichroniton()
	end
end