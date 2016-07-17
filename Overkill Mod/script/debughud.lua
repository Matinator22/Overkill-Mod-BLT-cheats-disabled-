--====================--
--    OVERKILL MOD    --
--      DEBUGHUD      --
--====================--
if inGame() and isPlaying() and not inChat() then
DEBUGHUD = not (DEBUGHUD or false) 
	if DEBUGHUD then
		managers.hud:debug_show_coordinates()
	else
		managers.hud:debug_hide_coordinates()
	end
end