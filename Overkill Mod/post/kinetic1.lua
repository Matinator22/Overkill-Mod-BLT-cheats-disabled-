--====================--
--    OVERKILL MOD    --
--       KINETIC      --
--====================--
-- lib/units/beings/player/states/PlayerStandard
---------------------------------
-- INTERACT TOGGLE by LazyOzzy --
---------------------------------
if not _PlayerStandard__check_action_interact then 
	_PlayerStandard__check_action_interact = PlayerStandard._check_action_interact 
end
function PlayerStandard:_check_action_interact(t, input)
	if input.btn_interact_press and self:_interacting() then
		self:_interupt_action_interact()
		return false
	elseif input.btn_interact_release then
		return false
	end
	return _PlayerStandard__check_action_interact(self, t, input)
end
--------------------------------
-- EQUIPMENT TOGGLE by Hejoro --
--------------------------------
if not _PlayerStandard__check_use_item then 
	_PlayerStandard__check_use_item = PlayerStandard._check_use_item 
end
function PlayerStandard:_check_use_item( t, input )
	if input.btn_use_item_press and self:is_deploying() then
		self:_interupt_action_use_item()
		return false
	elseif input.btn_use_item_release then
		return false
	end
	return _PlayerStandard__check_use_item(self, t, input)
end
---------------------------------
-- STEALTH GRENADE by LazyOzzy --
---------------------------------
if not _PlayerStandard__check_action_throw_grenade then 
	_PlayerStandard__check_action_throw_grenade = PlayerStandard._check_action_throw_grenade 
end
function PlayerStandard:_check_action_throw_grenade(t, input)
	if input.btn_throw_grenade_press and managers.groupai:state():whisper_mode() and (not self._last_grenade_t or t > self._last_grenade_t + 0.25) then
		self._last_grenade_t = t
		return
	end
		return _PlayerStandard__check_action_throw_grenade(self, t, input)
end
-------------------------------------------
-- THEIA SCOPE THROUGH GLASS by LazyOzzy --
-------------------------------------------
function PlayerStandard:_update_fwd_ray()
	local from = self._unit:movement():m_head_pos()
	local range = self._equipped_unit and self._equipped_unit:base():has_range_distance_scope() and 20000 or 4000
	local to = self._cam_fwd * range
	mvector3.add(to, from)
	self._fwd_ray = World:raycast("ray", from, to, "slot_mask", self._slotmask_fwd_ray)
	managers.environment_controller:set_dof_distance(math.max(0, math.min(self._fwd_ray and self._fwd_ray.distance or 4000, 4000) - 200), self._state_data.in_steelsight)
	if self._equipped_unit then
		local ranging_distance
		if self._state_data.in_steelsight and self._equipped_unit:base().check_highlight_unit then
			local ignore_units = { }
			local unit_hit = true
			
			while unit_hit do
				unit_hit = false
				local ray = World:raycast("ray", from, to, "slot_mask", World:make_slot_mask(12, 33), "ignore_unit", ignore_units)
				if ray and ray.unit then
					if not World:raycast("ray", from, ray.hit_position, "slot_mask", managers.slot:get_mask( "AI_visibility" ), "ray_type", "ai_vision") then
						self._equipped_unit:base():check_highlight_unit(ray.unit)
						ranging_distance = ranging_distance or ray.distance / 100
						table.insert(ignore_units, ray.unit)
						unit_hit = true
					end
				end
			end
		end
		if self._equipped_unit:base().set_scope_range_distance then
			if not ranging_distance then
				local ai_vision_ray = World:raycast("ray", from, to, "slot_mask", managers.slot:get_mask( "AI_visibility" ), "ray_type", "ai_vision")
				ranging_distance = ai_vision_ray and ai_vision_ray.distance / 100 or false
			end
			
			self._equipped_unit:base():set_scope_range_distance(ranging_distance)
		end
	end
end