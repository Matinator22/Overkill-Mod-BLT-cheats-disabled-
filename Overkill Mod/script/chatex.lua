--==============================--
-- CHAT BOX EXPANSION By Aiirik --
--==============================--
if inGame() and isPlaying() and not inChat() then
	_toggleHUDChat = not _toggleHUDChat
	if _toggleHUDChat then
		HUDChat.line_height = 50 
		managers.mission._fading_debug_output:script().log(' EXPANDED ', Color("2ebdf5") )
		managers.mission._fading_debug_output:script().log(' CHATEX : ',  tweak_data.system_chat_color)
	else
		HUDChat.line_height = 21
		managers.mission._fading_debug_output:script().log(' DEFAULT ', Color.Orange )
		managers.mission._fading_debug_output:script().log(' CHATEX : ',  tweak_data.system_chat_color)
	end
end