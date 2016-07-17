--==========================--
--       OVERKILL MOD       --
--          HUDSET          --
--       by OVERKILL        --
--==========================--
-- r2.1
if not _toggleHud then _toggleHud = 0 end
if inGame() and isPlaying() and not inChat() then
	_toggleHud = _toggleHud + 1
	if _toggleHud > 2 then _toggleHud = 0 end
	if _toggleHud == 0 then
		managers.hud:show(PlayerBase.PLAYER_INFO_HUD)
		managers.hud:show(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN) -- RESTORES NAMES ABOVE TEAMMATES
		managers.mission._fading_debug_output:script().log(' DEFAULT ', Color("2ebdf5") )
		managers.mission._fading_debug_output:script().log(' HUDSET ',  Color("FFE29D") )
		beep()
	elseif _toggleHud == 1 then
		managers.hud:hide(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN) -- REMOVES NAMES ABOVE TEAMMATES
		managers.hud:hide(PlayerBase.PLAYER_DOWNED_HUD) -- KEEPS IT HIDDEN EVEN WHEN GOING DOWN
		managers.mission._fading_debug_output:script().log(' MODE 1 ', Color("2ebdf5") )
		managers.mission._fading_debug_output:script().log(' HUDSET ',  Color("FFE29D") )
		beep()
	elseif _toggleHud == 2 then
		managers.hud:hide(PlayerBase.PLAYER_INFO_HUD) -- REMOVES OBJECTIVE BOX, TIMER BOX, HOXHUD, DOES NOT REMOVE POCOHUD
		managers.hud:hide(PlayerBase.PLAYER_DOWNED_HUD)
		managers.mission._fading_debug_output:script().log(' MODE 2 ', Color("2ebdf5") )
		managers.mission._fading_debug_output:script().log(' HUDSET ',  Color("FFE29D") )
		beep()
	end
end