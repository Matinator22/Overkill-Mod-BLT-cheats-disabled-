--=========================--
--      OVERKILL MOD       --
--   CORE (POST REQUIRE)   --
--=========================--
-- r2.2
-----------------------------
-- RESTART PRO BY OVERKILL --
-----------------------------
if RequiredScript == "lib/managers/menumanager" then
	function MenuCallbackHandler:_restart_level_visible()
		if not self:is_multiplayer() or managers.job:stage_success() then
			return false
		end
		local state = game_state_machine:current_state_name()
		return state ~= "ingame_waiting_for_players" and state ~= "ingame_lobby_menu" and state ~= "empty"
	end
elseif RequiredScript == "lib/managers/menumanager" then
	function MenuCallbackHandler:singleplayer_restart()
		return self:is_singleplayer() and self:has_full_game() and not managers.job:stage_success()
	end
end
----------------------------------
-- VOICE CHAT ICONS BY LAZYOZZY --
----------------------------------
if RequiredScript == "lib/managers/hudmanagerpd2" then
	function HUDManager:set_mugshot_voice(id, active)
		local panel_id
		for _, data in pairs(managers.criminals:characters()) do
			if data.data.mugshot_id == id then
				panel_id = data.data.panel_id
				break
			end
		end
		if panel_id and panel_id ~= HUDManager.PLAYER_PANEL then
			self._teammate_panels[panel_id]:set_voice_com(active)
		end
	end
end
if RequiredScript == "lib/managers/hud/hudteammate" then
	function HUDTeammate:set_voice_com(status)
		local texture = status and "guis/textures/pd2/jukebox_playing" or "guis/textures/pd2/hud_tabs"
		local texture_rect = status and { 0, 0, 16, 16 } or { 84, 34, 19, 19 }
		local callsign = self._panel:child("callsign")
		
		callsign:set_image(texture, unpack(texture_rect))
	end
end
---------------------------------
-- SAW DAMAGE BY DEADMANSCHEST --
---------------------------------
if RequiredScript == "lib/units/weapons/sawweaponbase" then
	SawHit = SawHit or class(InstantBulletBase)
	function SawHit:on_collision(col_ray, weapon_unit, user_unit, damage)
		local hit_unit = col_ray.unit
		if hit_unit then
			damage = 50
		end
		local result = InstantBulletBase.on_collision(self, col_ray, weapon_unit, user_unit, damage)
		if hit_unit:damage() and col_ray.body:extension() and col_ray.body:extension().damage then
			damage = math.clamp(damage * managers.player:upgrade_value("saw", "lock_damage_multiplier", 1) * 4, 0, 200)
			col_ray.body:extension().damage:damage_lock(user_unit, col_ray.normal, col_ray.position, col_ray.direction, damage)
			if hit_unit:id() ~= -1 then
				managers.network:session():send_to_peers_synched("sync_body_damage_lock", col_ray.body, damage)
			end
		end
		return result
	end
end
----------------------------------
-- SENSOR HIGHLIGHT BY LAZYOZZY --
----------------------------------
if RequiredScript == "lib/units/weapons/trip_mine/TripMineBase" then
local sync_mark = true
function TripMineBase:_sensor(t)
local ray = self:_raycast()
	if ray and ray.unit and not tweak_data.character[ray.unit:base()._tweak_table].is_escort then
		self._sensor_units_detected = self._sensor_units_detected or {}
		if not self._sensor_units_detected[ray.unit:key()] then
			if ray.unit:contour() and ray.unit:base() then
				local char_tweak = tweak_data.character[ray.unit:base()._tweak_table]
				if char_tweak and (--[[char_tweak.priority_shout or]] managers.groupai:state():whisper_mode() and char_tweak.silent_priority_shout) then
					ray.unit:contour():add("mark_enemy", sync_mark)
				end
			end
			self._sensor_units_detected[ray.unit:key()] = true
			self:_emit_sensor_sound_and_effect()
			if managers.network:session() then
				managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "base", TripMineBase.EVENT_IDS.sensor_beep)
			end
			self._sensor_last_unit_time = t + 5
		end
	end
end
end
---------------------------------------
-- SENTRY IGNORES SHIELD BY LAZYOZZY --
---------------------------------------
if RequiredScript == "lib/units/equipment/sentry_gun/sentrygunbrain" then
	local _select_focus_attention_original = SentryGunBrain._select_focus_attention
	local _upd_fire_original = SentryGunBrain._upd_fire
	
	function SentryGunBrain:_select_focus_attention(...)
		local is_criminal = self._unit:movement():team().id == "criminal1"
		local all_targets = self._detected_attention_objects
		if is_criminal then
			local valid_targets = {}
			local obstructed_targets = {}
			all_targets = {}
			for key, data in pairs(self._detected_attention_objects) do
				all_targets[key] = data
				
				if self._unit:weapon():check_lof(data.unit, data.handler:get_attention_m_pos()) then
					valid_targets[key] = data
				else
					obstructed_targets[key] = data
				end
			end
			if next(valid_targets) ~= nil then
				self._fire_at_will = true
				self._detected_attention_objects = valid_targets
			else
				self._fire_at_will = false
				self._detected_attention_objects = obstructed_targets
			end
		end
		_select_focus_attention_original(self, ...)
		self._detected_attention_objects = all_targets
	end
	function SentryGunBrain:_upd_fire(...)
		if self._fire_at_will or self._fire_at_will == nil then
			_upd_fire_original(self, ...)
		elseif self._firing then
			self._unit:weapon():stop_autofire()
			self._firing = false
		end
	end
elseif RequiredScript == "lib/units/weapons/sentrygunweapon" then
	function SentryGunWeapon:check_lof(target, target_position)
		local from_pos = self._effect_align[self._interleaving_fire]:position()
		local col_ray = World:raycast("ray", from_pos, target_position, "slot_mask", self._bullet_slotmask, "ignore_unit", self._setup.ignore_units)
		return col_ray and alive(col_ray.unit) and (col_ray.unit:key() == target:key())
	end
end
-----------------------------------
---          FREEFLIGHT         ---
---          BY OVERKILL        ---
-----------------------------------
-- <F9>       ENABLES FLIGHT MODE
-- <C>        FLIGHT OPTIONS
-- <F>        FLIGHT CONTROLS
-- <MB1>      ENTER
-----------------------------------
if RequiredScript == "lib/entry" then
	core:import("CoreFreeFlight")
	Global.DEBUG_MENU_ON = true
	local FF_ON, FF_OFF, FF_ON_NOCON = 0, 1, 2

	function CoreFreeFlight.FreeFlight:_setup_actions()
		local FFA = CoreFreeFlight.CoreFreeFlightAction.FreeFlightAction
		local FFAT = CoreFreeFlight.CoreFreeFlightAction.FreeFlightActionToggle
		local dp = FFA:new("DROP PLAYER", callback(self, self, "_drop_player"))
		local yc = FFA:new("YIELD CONTROL (F9 EXIT)", callback(self, self, "_yield_control"))
		local ef = FFA:new("EXIT FREEFLIGHT", callback(self, self, "_exit_freeflight"))
		local ps = FFAT:new("PAUSE", "UNPAUSE", callback(self, self, "_pause"), callback(self, self, "_unpause"))
		self._actions = { ps, dp, yc, ef }
		self._action_index = 1
	end
end
-----------------------------
-- DISABLE DEBUG (VK_KEYS) --
-----------------------------
if GameSetup then
	function GameSetup:_update_debug_input() return end
end
-----------------------------
-- DISABLE DEBUG (BUTTONS) --
-----------------------------
if MenuManager then
	function MenuManager:debug_menu_enabled() return end
end
-------------------------------------------
-- DISTURBING THE PEACE BY BRADOLFPITLER --
--           AND SHOOT THRU BOT          --
-------------------------------------------
if RaycastWeaponBase then
	local RaycastWeaponBase_init_original = RaycastWeaponBase.init
	function RaycastWeaponBase:init(...)
		RaycastWeaponBase_init_original(self, ...)
		self._bullet_slotmask = self._bullet_slotmask - World:make_slot_mask(16)
	end
	local RaycastWeaponBase_setup_original = RaycastWeaponBase.setup
	function RaycastWeaponBase:setup(setup_data)
		RaycastWeaponBase_setup_original (self, setup_data)
		self._bullet_slotmask = self._bullet_slotmask - World:make_slot_mask(16)
		------------------------------------------
		-- DISTURBING THE PEACE (EDIT SETTINGS) --
		------------------------------------------
		if not self._panic_suppression_chance then
			if self:weapon_tweak_data().category == "lmg" then
				self._panic_suppression_chance = 0.4 -- 0.2 default
			elseif self:weapon_tweak_data().category == "snp" then
				self._panic_suppression_chance = 0.4 -- 0.2 default
			elseif self:weapon_tweak_data().category == "smg" then
				self._panic_suppression_chance = 0.2 -- 0.2 default
			elseif self:weapon_tweak_data().category == "shotgun" then
				self._panic_suppression_chance = 0.3 -- 0.2 default
			else
				self._panic_suppression_chance = 0.2 -- 0.2 default
			end
		end
	end
end
-----------------------------------
-- CHARACTER CONTOURS (DISABLED) --
-----------------------------------
if tweak_data then
	tweak_data.contour.character.standard_color = Vector3(0, 0, 0)
	local orange = Vector3(0, 0, 0) / 255
	local green = Vector3(0, 0, 0) / 255
	local brown = Vector3(0, 0, 0) / 255
	local blue = Vector3(0, 0, 0) / 255
	local team_ai = Vector3(0, 0, 0)
	tweak_data.peer_vector_colors = {
		green,
		blue,
		brown,
		orange,
		team_ai
	}
end