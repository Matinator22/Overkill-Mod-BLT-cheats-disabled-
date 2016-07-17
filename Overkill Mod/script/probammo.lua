--======================================--
--   INFINITE AMMO SCRIPT PROBABILITY   --
--            by LazyOzzy               --
--======================================--
-- IT IS PROBABILITY-BASED
-- REPLACE "RETURN 1" WITH "RETURN 0.5" 
-- AND YOU'VE GOT A 50% CHANCE OF LOSING A BULLET PER SHOT (BOTH FROM THE MAG AND TOTAL AMMO) 
if inGame and isPlaying() and not inChat() and _cheatToggle then
	probammo = not (probammo or false)
	--===================--
	-- SETTINGS ( EDIT ) --
	--===================--
	local chance = 0.60
	--=============================--
	-- DO NOT EDIT BELOW THIS LINE --
	--=============================--
	local f = chance * 100 
	local num = string.format("%.1f", f)
	local tog = string.format("%s", probammo and "ENABLED" or "DISABLED")
	if managers.hud then 
		managers.mission._fading_debug_output:script().log(""..num.."%", Color("97d04d"))
		managers.mission._fading_debug_output:script().log("PROBABILITY "..tog, Color("ea984f"))
		managers.mission._fading_debug_output:script().log("AMMO RETURN", Color("a7ddf4"))
	end
	--======================--
	-- PROBABILITY FUNCTION --
	--======================--
	if not _PlayerManager_upgrade_value then 
		_PlayerManager_upgrade_value = PlayerManager.upgrade_value 
	end 
	function PlayerManager:upgrade_value( category, upgrade, default ) 
		if upgrade == "consume_no_ammo_chance" then 
			managers.player:activate_temporary_upgrade( "temporary", "no_ammo_cost" )
			return chance
		end 
		return _PlayerManager_upgrade_value(self, category, upgrade, default)
	end
	if not _PlayerManager_has_category_upgrade then 
		_PlayerManager_has_category_upgrade = PlayerManager.has_category_upgrade 
	end
	function PlayerManager:has_category_upgrade( category, upgrade, default ) 
		if upgrade == "consume_no_ammo_chance" then 
			return probammo 
		end
		return _PlayerManager_has_category_upgrade(self, category, upgrade, default) 
	end
end