-- TOGGLE XRAY PUBLIC ON/OFF v0.2 by B1313 (Original Script by Slynderdale)
if not markToggle then return end
local level = managers.job:current_level_id()
if inGame() and isPlaying() and not inChat() then
	if level == "cane" then
		managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
		managers.mission._fading_debug_output:script().log(' GAME PROTECTION : ', Color('ffc300') )
	else
		_togglePublicXRay = not _togglePublicXRay
		if _togglePublicXRay then
			markToggle(true)
			managers.mission._fading_debug_output:script().log(' PUBLIC SYNC ON ', Color("2ebdf5") )
			managers.mission._fading_debug_output:script().log(' XRAY : ',  tweak_data.system_chat_color)
		else
			markClear()
			markToggle(true)
			markData()
			managers.mission._fading_debug_output:script().log(' PUBLIC SYNC OFF ', Color.Orange )
			managers.mission._fading_debug_output:script().log(' XRAY : ',  tweak_data.system_chat_color)
		end
	end
end