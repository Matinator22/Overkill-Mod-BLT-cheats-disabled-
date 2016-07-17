--=====================--
--    OVERKILL MOD     --
--  SLOWMO SCRIPT 1.1  --
--=====================--
if inGame() and isPlaying() and _cheatToggle and not inChat() then
	-- TOGGLE SLOWMO
	SLOWMO_WORLD_ONLY = nil -- POSSIBLE VALUES 'nil' or 'true'
	if string.find(game_state_machine:current_state_name(), "game") then
		our_id = "_MaskOn_Peer"..tostring( managers.network:session():local_peer():id() )
		slowmo_id_world = "world" .. our_id
		slowmo_id_player = "player" .. our_id
		if not _timeEffectExpired then
		-- ENABLE
		_timeEffectExpired = TimeSpeedManager._on_effect_expired
		function TimeSpeedManager:_on_effect_expired( effect_id )
			local ret = _timeEffectExpired(self, effect_id)
			-- CHECK IF WE ARE INGAME
			if string.find(game_state_machine:current_state_name(), "game") then
			-- RESTART EACH EFFECT
				if effect_id == slowmo_id_world then
					managers.time_speed:play_effect( slowmo_id_world, tweak_data.timespeed.mask_on )
				elseif effect_id == slowmo_id_player and not SLOWMO_WORLD_ONLY then
					managers.time_speed:play_effect( slowmo_id_player, tweak_data.timespeed.mask_on_player )
			end	end
			return ret
		end
		tweak_data.timespeed.mask_on.fade_in_delay = 0
		tweak_data.timespeed.mask_on.fade_out = 0
		tweak_data.timespeed.mask_on_player.fade_in_delay = 0
		tweak_data.timespeed.mask_on_player.fade_out = 0
		managers.time_speed:play_effect( slowmo_id_world, tweak_data.timespeed.mask_on )
		if not SLOWMO_WORLD_ONLY then 
			managers.time_speed:play_effect( slowmo_id_player, tweak_data.timespeed.mask_on_player ) 
		end
			managers.mission._fading_debug_output:script().log(' ACTIVATED ', Color("2ebdf5") )
			managers.mission._fading_debug_output:script().log(' SLOW-MO : ',  tweak_data.system_chat_color)
		else
			-- DISABLE
			TimeSpeedManager._on_effect_expired = _timeEffectExpired
			_timeEffectExpired = nil
			if managers.time_speed._playing_effects then
				for id,_ in pairs(managers.time_speed._playing_effects) do
					if string.find(id, our_id) then
						managers.time_speed:stop_effect(id)
					end
				end
			end
			SoundDevice:set_rtpc( "game_speed", 1 )
			managers.mission._fading_debug_output:script().log(' DEACTIVATED ', Color.orange )
			managers.mission._fading_debug_output:script().log(' SLOW-MO : ',  tweak_data.system_chat_color)
		end
	end
end