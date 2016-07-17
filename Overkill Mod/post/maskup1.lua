--====================--
--    OVERKILL MOD    --
--  MASK UP INTERACT  --
--====================--
-- lib/units/beings/player/states/PlayerMaskOff
-------------------------------
-- INSTANT MASK UP BY HEJORO --
-------------------------------
if not _PlayerMaskOff__check_use_item then 
	_PlayerMaskOff__check_use_item = PlayerMaskOff._check_use_item 
end
function PlayerMaskOff:_check_use_item( t, input )
	if input.btn_use_item_press and self._start_standard_expire_t then
		self:_interupt_action_start_standard()
	return false
	
	elseif input.btn_use_item_release then
		return false
	end
	return _PlayerMaskOff__check_use_item(self, t, input)
end
---------------------------------
-- INTERACT TOGGLE by LazyOzzy --
---------------------------------
if not _PlayerMaskOff__check_action_interact then
	_PlayerMaskOff__check_action_interact = PlayerMaskOff._check_action_interact
end
function PlayerMaskOff:_check_action_interact(t, input)
	if input.btn_interact_press and self:_interacting() then
		self:_interupt_action_interact()
		return false
	elseif input.btn_interact_release then
		return false
	end
	return _PlayerMaskOff__check_action_interact(self, t, input)
end