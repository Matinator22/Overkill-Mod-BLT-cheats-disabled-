--=====================--
--     OVERKILL MOD    --
--  CIVILIAN INTERACT  --
--=====================--
-- lib/units/beings/player/states/PlayerCivilian
-- r2.1
---------------------------------
-- INTERACT TOGGLE by OVERKILL --
---------------------------------
if not _PlayerCivilian__check_action_interact then
	_PlayerCivilian__check_action_interact = PlayerCivilian._check_action_interact
end
function PlayerCivilian:_check_action_interact(t, input)
	if input.btn_interact_press and self:_interacting() then
		self:_interupt_action_interact()
		return false
	elseif input.btn_interact_release then
		return false
	end
	return _PlayerCivilian__check_action_interact(self, t, input)
end