--=====================--
--     OVERKILL MOD    --
--      CORE MENU      --
--     BY OVERKILL     --
--=====================--
-- r2.2
--========================--
-- USER SETTINGS ( EDIT ) --
--========================--
local exp_multiplier_amount = 4
local interaction_distance = 10000
local weapon_fireRate_amount = 5000
local weapon_swapRate_amount = 1.8
local weapon_reloadRate_amount = 10
local mission_lobby_access = "public" -- "friends_only" or "public" or "private"
local mission_lobby_dropin_allow = false -- true or false
--=============================--
-- DO NOT EDIT BELOW THIS LINE --
--=============================--
-------------------
-- SAVE SETTINGS --
-------------------
local ovkMap = managers.job:current_level_id()
------------------
-- GAME WRAPPER --
------------------
if inGame() then
	------------------------------------------
	-- INTERACT DATA (REQUIRED) by LazyOzzy --
	------------------------------------------
	local function InteractData(interact_data)
	if not managers.interaction then return end
	local objects = {}
		for _,v in pairs(managers.interaction._interactive_units) do
			if table.contains(interact_data, v:interaction().tweak_data) then
				table.insert(objects, v:interaction())
			end
		end
		for _,v in ipairs(objects) do
			v:interact(managers.player:player_unit())
		end
	end
	--------------
	-- GOD MODE --
	--------------
	function godMode()
	Toggle.godMode = not Toggle.godMode
		if not Toggle.godMode then
			managers.player:player_unit():character_damage():set_god_mode(false)
			managers.mission._fading_debug_output:script().log("GODMODE : DISABLED", Color("FFE29D"))
			return
		end
		managers.player:player_unit():character_damage():set_god_mode(true)
		managers.mission._fading_debug_output:script().log("GODMODE : ENABLED", Color("FFE29D"))
		ChatMessage('ENABLED', 'GODMODE')
		ChatMessage('DO NOT FORGET TO DISABLE GODMODE BEFORE LEAVING A HEIST', 'WARNING')
	end
	-------------
	-- COUNTER --
	-------------
	function clkCounter()
	Toggle.clkCounter = not Toggle.clkCounter
		if not Toggle.clkCounter then
			backuper:restore('PlayerMovement.on_SPOOCed')
			managers.mission._fading_debug_output:script().log("COUNTER CLOAKER : DISABLED", Color("FFE29D"))
			return
		end
		if PlayerMovement then
			backuper:backup('PlayerMovement.on_SPOOCed')
			function PlayerMovement:on_SPOOCed(enemy_unit)
				return "countered"
			end
		end
		managers.mission._fading_debug_output:script().log("COUNTER CLOAKER : ENABLED", Color("FFE29D"))
	end
	------------------------
	-- FLASHBANG IMMUNITY --
	------------------------
	function fbMode()
		Toggle.fbMode = not Toggle.fbMode
		if not Toggle.fbMode then
			backuper:restore('CoreEnvironmentControllerManager.set_flashbang')
			managers.mission._fading_debug_output:script().log("FLASHBANG IMMUNITY : DISABLED", Color("FFE29D"))
			return 
		end
		backuper:backup('CoreEnvironmentControllerManager.set_flashbang')
		function CoreEnvironmentControllerManager:set_flashbang( flashbang_pos, line_of_sight, travel_dis, linear_dis ) end
		managers.mission._fading_debug_output:script().log("FLASHBANG IMMUNITY : ENABLED", Color("FFE29D"))
	end
	----------------
	-- SHOCKPROOF --
	----------------
	function shockMode()
		Toggle.shockMode = not Toggle.shockMode
		if not Toggle.shockMode then
			backuper:restore('PlayerTased.enter')
			managers.mission._fading_debug_output:script().log("SHOCKPROOF : DISABLED", Color("FFE29D"))
			return
		end
		backuper:backup('PlayerTased.enter')
		function PlayerTased:enter( state_data, enter_data )
			PlayerTased.super.enter( self, state_data, enter_data )
			self._next_shock = Application:time() + 10
			self._taser_value = 1
			self._recover_delayed_clbk = "PlayerTased_recover_delayed_clbk"
			managers.enemy:add_delayed_clbk( self._recover_delayed_clbk, callback( self, self, "clbk_exit_to_std" ), Application:time() )
		end
		managers.mission._fading_debug_output:script().log("SHOCKPROOF : ENABLED", Color("FFE29D"))
	end
	--------------------
	-- NO FALL DAMAGE --
	--------------------
	function fallMode()
		Toggle.fallMode = not Toggle.fallMode
		if not Toggle.fallMode then
			backuper:restore('PlayerDamage.damage_fall')
			managers.mission._fading_debug_output:script().log("NO FALL DAMAGE : DISABLED", Color("FFE29D"))
			return
		end
		backuper:backup('PlayerDamage.damage_fall')
		function PlayerDamage:damage_fall( data ) end
		managers.mission._fading_debug_output:script().log("NO FALL DAMAGE : ENABLED", Color("FFE29D"))
	end
	----------------------
	-- NO STAMINA DRAIN --
	----------------------
	function runMode()
		Toggle.runMode = not Toggle.runMode
		if not Toggle.runMode then
			backuper:restore('PlayerMovement._change_stamina')
			backuper:restore('PlayerMovement.is_stamina_drained')
			managers.mission._fading_debug_output:script().log("NO STAMINA DRAIN : DISABLED", Color("FFE29D"))
			return
		end
		backuper:backup('PlayerMovement._change_stamina')
		function PlayerMovement:_change_stamina( value ) end
		backuper:backup('PlayerMovement._change_stamina')
		function PlayerMovement:is_stamina_drained() return false end
		managers.mission._fading_debug_output:script().log("NO STAMINA DRAIN : ENABLED", Color("FFE29D"))
	end
	--------------
	-- PUGILIST --
	--------------
	function pugilistMode()
		Toggle.pugilistMode = not Toggle.pugilistMode
		if not Toggle.pugilistMode then
			backuper:restore('CopDamage.damage_melee')
			managers.mission._fading_debug_output:script().log("PUGILIST : DISABLED", Color("FFE29D"))
			return 
		end 
		local melee_original = backuper:backup('CopDamage.damage_melee') 
		function CopDamage:damage_melee( attack_data ) 
			attack_data.damage = attack_data.damage * 500 
			return melee_original(self, attack_data) end
		managers.mission._fading_debug_output:script().log("PUGILIST : ENABLED", Color("FFE29D"))
	end
	------------------
	-- BULLETSTORM --
	------------------
	function infMode()
		Toggle.infMode = not Toggle.infMode
		if not Toggle.infMode then
			backuper:restore("NewRaycastWeaponBase.fire")
			backuper:restore("SawWeaponBase.fire")
			managers.mission._fading_debug_output:script().log("BULLETSTORM : DISABLED", Color("97d04d") )
			return
		end
		local _fireWep = backuper:backup("NewRaycastWeaponBase.fire")
		function NewRaycastWeaponBase:fire(from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit)
			local result = _fireWep( self, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit )
			if managers.player:player_unit() == self._setup.user_unit then
				self.set_ammo(self, 1.0)
			end
			return result
		end
		local _fireSaw = backuper:backup("SawWeaponBase.fire")
		function SawWeaponBase:fire( from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit )
			local result = _fireSaw( self, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit )
			if managers.player:player_unit() == self._setup.user_unit then
				self.set_ammo(self, 1.0)
			end
			return result
		end
		managers.mission._fading_debug_output:script().log("BULLETSTORM : ENABLED", Color("97d04d") )
	end
	--------------------
	-- BULLET EXPLODE --
	--------------------
	function shellMode()
	Toggle.shellMode = not Toggle.shellMode
		if not Toggle.shellMode then
			backuper:restore("InstantBulletBase.on_collision")
			backuper:restore("InstantExplosiveBulletBase.on_collision")
			backuper:restore("InstantExplosiveBulletBase.on_collision_server")
			managers.mission._fading_debug_output:script().log("ROUNDS : DEFAULT", Color("97d04d") )
			return
		end
		InstantBulletBase.CURVE_POW = tweak_data.upgrades.explosive_bullet.curve_pow
		InstantBulletBase.PLAYER_DMG_MUL = tweak_data.upgrades.explosive_bullet.player_dmg_mul
		InstantBulletBase.RANGE = tweak_data.upgrades.explosive_bullet.range
		InstantBulletBase.EFFECT_PARAMS = {
			effect = "effects/payday2/particles/impacts/shotgun_explosive_round",
			sound_event = "round_explode",
			feedback_range = tweak_data.upgrades.explosive_bullet.feedback_range,
			camera_shake_max_mul = tweak_data.upgrades.explosive_bullet.camera_shake_max_mul,
			sound_muffle_effect = true,
			on_unit = true,
			idstr_decal = Idstring("explosion_round"),
			idstr_effect = Idstring("")
		}
		InstantBulletBase.old_on_collision = backuper:backup("InstantBulletBase.on_collision")
		InstantBulletBase.new_on_collision = backuper:backup("InstantExplosiveBulletBase.on_collision")
		InstantBulletBase.on_collision_server = backuper:backup("InstantExplosiveBulletBase.on_collision_server")
		function InstantBulletBase:on_collision(col_ray, weapon_unit, user_unit, damage, blank)
			if user_unit == managers.player:player_unit() then
				return self:new_on_collision(col_ray, weapon_unit, user_unit, damage * 8, blank)
			end
			return self:old_on_collision(col_ray, weapon_unit, user_unit, damage, blank)
		end
		managers.mission._fading_debug_output:script().log("ROUNDS : EXPLOSIVE", Color("97d04d") )
	end
	-------------------
	-- WEAPON SPREAD --
	-------------------
	-- NewRaycastWeaponBase._get_spread = function(self) return 0 end
	function wpn_spread()
		Toggle.wpn_spread = not Toggle.wpn_spread
		if not Toggle.wpn_spread then
			backuper:restore('NewRaycastWeaponBase._get_spread')
			managers.mission._fading_debug_output:script().log("SPREAD : DEFAULT", Color("97d04d"))
			return
		end
		backuper:backup('NewRaycastWeaponBase._get_spread')
		local NewRaycastWeaponBase_get_spread_original = NewRaycastWeaponBase._get_spread
		function NewRaycastWeaponBase:_get_spread(...)
			if self:weapon_tweak_data().category == "shotgun" then
				return NewRaycastWeaponBase_get_spread_original(self, ...)
			end
			return 0
		end
		managers.mission._fading_debug_output:script().log("SHOTGUN EXCLUDED", Color("FFE29D"))
		managers.mission._fading_debug_output:script().log("SPREAD : REDUCED", Color("97d04d"))
	end
	-------------------
	-- WEAPON RECOIL --
	-------------------
	-- NewRaycastWeaponBase.recoil_multiplier = function(self) return 0 end
	function wpn_recoil()
		Toggle.wpn_recoil = not Toggle.wpn_recoil
		if not Toggle.wpn_recoil then
			backuper:restore('NewRaycastWeaponBase.recoil_multiplier')
			managers.mission._fading_debug_output:script().log("RECOIL : DEFAULT", Color("97d04d"))
			return
		end
		backuper:backup('NewRaycastWeaponBase.recoil_multiplier')
		function NewRaycastWeaponBase:recoil_multiplier()
			if self:weapon_tweak_data().category == "shotgun" then
				return managers.blackmarket:recoil_multiplier(self._name_id, self:weapon_tweak_data().category, self._silencer, self._blueprint)
			end
			return 0
		end
		managers.mission._fading_debug_output:script().log("SHOTGUN EXCLUDED", Color("FFE29D"))
		managers.mission._fading_debug_output:script().log("RECOIL : REDUCED", Color("97d04d"))
	end
	-------------------
	-- WEAPON RELOAD --
	-------------------
	function wpn_reload()
		Toggle.wpn_reload = not Toggle.wpn_reload
		if not Toggle.wpn_reload then
			backuper:restore('NewRaycastWeaponBase.reload_speed_multiplier')
			managers.mission._fading_debug_output:script().log("RELOAD SPEED : DEFAULT", Color("97d04d"))
			return
		end
		backuper:backup('NewRaycastWeaponBase.reload_speed_multiplier')
		function NewRaycastWeaponBase:reload_speed_multiplier()
			return weapon_reloadRate_amount
		end
		managers.mission._fading_debug_output:script().log("RELOAD SPEED : INCREASED", Color("97d04d"))
	end
	-----------------
	-- WEAPON SWAP --
	-----------------
	function wpn_swap()
		Toggle.wpn_swap = not Toggle.wpn_swap
		if not Toggle.wpn_swap then
			backuper:restore('PlayerStandard._get_swap_speed_multiplier')
			managers.mission._fading_debug_output:script().log("SWITCH SPEED : DEFAULT", Color("97d04d"))
			return
		end
		backuper:backup('PlayerStandard._get_swap_speed_multiplier')
		function PlayerStandard:_get_swap_speed_multiplier()
			return weapon_swapRate_amount
		end
		managers.mission._fading_debug_output:script().log("SWITCH SPEED : INCREASED", Color("97d04d"))
	end
	---------------------
	-- WEAPON FIRERATE --
	---------------------
	function wpn_firerate()
		Toggle.wpn_firerate = not Toggle.wpn_firerate
		if not Toggle.wpn_firerate then
			backuper:restore('NewRaycastWeaponBase.fire_rate_multiplier')
			managers.mission._fading_debug_output:script().log("FIRERATE : DEFAULT", Color("97d04d"))
			return
		end
		backuper:backup('NewRaycastWeaponBase.fire_rate_multiplier')
		function NewRaycastWeaponBase:fire_rate_multiplier()
			return weapon_fireRate_amount
		end
		managers.mission._fading_debug_output:script().log("FIRERATE : INCREASED", Color("97d04d"))
	end
	------------------
	-- DRILL REMOTE --
	------------------
	function drillremotefix()
		InteractData({'apartment_drill_jammed','apartment_saw_jammed','drill_jammed','gen_int_saw','gen_int_saw_jammed','goldheist_drill_jammed','huge_lance_jammed','lance_jammed','suburbia_drill_jammed'})
		managers.mission._fading_debug_output:script().log("DRILL REMOTE : REPAIRED", Color("FFE29D"))
	end
	-------------------
	-- DRILL AUTOFIX --
	-------------------
	function drillautofix()
		Toggle.drillautofix = not Toggle.drillautofix
		if not Toggle.drillautofix then
			backuper:restore('Drill.set_jammed')
			managers.mission._fading_debug_output:script().log("INSTANT AUTOREPAIR : DISABLED", Color("FFE29D"))
			return
		end
		managers.mission._fading_debug_output:script().log("INSTANT AUTOREPAIR : ENABLED", Color("FFE29D"))
		local set_jammed_original = backuper:backup('Drill.set_jammed')
		function Drill:set_jammed(jammed)
			local player = managers.player:local_player()
			if alive(player) and alive(self._unit) and (self._unit.interaction and
			self._unit:interaction()) and (self._unit:interaction().interact) then
				self._unit:interaction():interact(player)
			end
			return set_jammed_original(self, jammed)
		end
	end
	----------------------
	-- INSTANT INTERACT --
	----------------------
	function intInst()
		Toggle.intInst = not Toggle.intInst
		if not Toggle.intInst then
			backuper:restore('BaseInteractionExt._get_timer')
			backuper:restore('PlayerManager.selected_equipment_deploy_timer')
			managers.mission._fading_debug_output:script().log("INSTANT INTERACT : DISABLED", Color("FFE29D"))
			return
		end
		backuper:backup('BaseInteractionExt._get_timer')
		function BaseInteractionExt:_get_timer()
			return 0.001
		end
		backuper:backup('PlayerManager.selected_equipment_deploy_timer')
		function PlayerManager:selected_equipment_deploy_timer()
			return 0
		end
		managers.mission._fading_debug_output:script().log("INSTANT INTERACT : ENABLED", Color("FFE29D"))
	end
	-------------------------------------
	-- ALLOW INTERACTION WITH ANYTHING --
	-------------------------------------
	function intAll()
		Toggle.intAll = not Toggle.intAll
		if not Toggle.intAll then
			backuper:restore('BaseInteractionExt._has_required_upgrade')
			backuper:restore('BaseInteractionExt._has_required_deployable')
			backuper:restore('BaseInteractionExt.can_interact')
			backuper:restore('PlayerManager.remove_equipment')
			managers.mission._fading_debug_output:script().log("INTERACT WITH ANYTHING : DISABLED", Color("FFE29D"))
			return
		end
		-- CAMERA LOOP OVERRIDE (1 = BASIC SKILL, 2 = ACED SKILL)
		function SecurityCamera:_start_tape_loop_by_upgrade_level(time_upgrade_level)
			local time_upgrade_level = managers.player:upgrade_level("player", "tape_loop_duration", 2)
			local tape_loop_t = managers.player:upgrade_value_by_level("player", "tape_loop_duration", time_upgrade_level)
			self:_start_tape_loop(tape_loop_t)
		end
		backuper:backup('BaseInteractionExt._has_required_upgrade') -- HAS UPGRADE
		function BaseInteractionExt:_has_required_upgrade(movement_state) return true end
		backuper:backup('BaseInteractionExt._has_required_deployable') -- HAS DEPLOY
		function BaseInteractionExt:_has_required_deployable() return true end
		backuper:backup('BaseInteractionExt.can_interact') -- CAN INTERACT
		function BaseInteractionExt:can_interact(player) return true end
		backuper:backup('PlayerManager.remove_equipment') -- REMOVE EQUIP
		function PlayerManager:remove_equipment(equipment_id) end
		managers.mission._fading_debug_output:script().log("INTERACT WITH ANYTHING : ENABLED", Color("FFE29D"))
	end
	-----------------------
	-- INTERACT DISTANCE --
	-----------------------
	-- SOURCE CREDIT: TRANSCEND
	function intDist()
		Toggle.intDist = not Toggle.intDist
		if not Toggle.intDist then
			backuper:restore('BaseInteractionExt.interact_distance')
			managers.mission._fading_debug_output:script().log("INTERACT DISTANCE : DISABLED", Color("FFE29D"))
			return
		end
		backuper:backup('BaseInteractionExt.interact_distance')
		function BaseInteractionExt:interact_distance()
		-- OMITTING ITEMS TO INTERACT WITH (A-Z)
		-- IDSTRING ITEMS : BODYBAG (tostring(self._unit:name()) == "Idstring(@ID14f05c3d9ebb44b6@)")
			if self.tweak_data == "access_camera"
				or self.tweak_data == "stn_int_place_camera"
				or self.tweak_data == "activate_camera"
				or self.tweak_data == "ammo_bag"
				or self.tweak_data == "apartment_key"
				or self.tweak_data == "apply_thermite_paste"
				or self.tweak_data == "bag_zipline"
				or self.tweak_data == "barricade_fence"
				or self.tweak_data == "barrier_numpad"
				-- or self.tweak_data == "bodybags_bag"
				or self.tweak_data == "burning_money"
				-- or self.tweak_data == "button_infopad"
				-- or self.tweak_data == "carry_drop"
				or self.tweak_data == "cas_elevator_door_open"
				or self.tweak_data == "cas_close_door"
				or self.tweak_data == "cas_open_door"
				or self.tweak_data == "cas_open_powerbox"
				or self.tweak_data == "cas_open_securityroom_door"
				or self.tweak_data == "cas_slot_machine"
				or self.tweak_data == "cas_take_unknown"
				-- or self.tweak_data == "circuit_breaker"
				-- or self.tweak_data == "corpse_dispose"
				-- or self.tweak_data == "corpse_alarm_pager"
				-- or self.tweak_data == "crane_joystick_left"
				-- or self.tweak_data == "crane_joystick_release"
				or self.tweak_data == "crate_loot_crowbar"
				or self.tweak_data == "cut_fence"
				or self.tweak_data == "diamond_pickup"
				or self.tweak_data == "doctor_bag"
				or self.tweak_data == "drill"
				or self.tweak_data == "drill_jammed"
				or self.tweak_data == "gage_assignment"
				-- or self.tweak_data == "gen_pku_evidence_bag"
				or self.tweak_data == "gen_pku_fusion_reactor"
				or self.tweak_data == "gen_prop_container_a_vault_seq"
				or self.tweak_data == "gold_pile"
				or self.tweak_data == "grenade_briefcase"
				-- or self.tweak_data == "hold_take_painting"
				-- or self.tweak_data == "hospital_phone"
				or self.tweak_data == "hostage_move"
				or self.tweak_data == "hostage_stay"
				or self.tweak_data == "intimidate"
				or self.tweak_data == "invisible_interaction_open"
				or self.tweak_data == "key"
				or self.tweak_data == "lance"
				or self.tweak_data == "lockpick_locker"
				or self.tweak_data == "mcm_break_planks"
				or self.tweak_data == "mcm_fbi_taperecorder"
				or self.tweak_data == "money_wrap"
				or self.tweak_data == "money_wrap_single_bundle"
				or self.tweak_data == "money_wrap_single_bundle_active"
				or self.tweak_data == "need_boards"
				or self.tweak_data == "open_door"
				or self.tweak_data == "open_door_with_keys"
				or self.tweak_data == "open_from_inside"
				or self.tweak_data == "open_slash_close"
				or self.tweak_data == "open_slash_close_act"
				or self.tweak_data == "open_slash_close_sec_box"
				-- or self.tweak_data == "pickup_asset"
				or self.tweak_data == "pick_lock_deposit_transport"
				or self.tweak_data == "pick_lock_easy"
				or self.tweak_data == "pick_lock_easy_no_skill"
				or self.tweak_data == "pick_lock_hard"
				or self.tweak_data == "pick_lock_hard_no_skill"
				-- or self.tweak_data == "pick_lock_x_axis"
				-- or self.tweak_data == "pku_safe"
				or self.tweak_data == "player_zipline"
				-- or self.tweak_data == "push_button"
				or self.tweak_data == "requires_ecm_jammer"
				or self.tweak_data == "requires_ecm_jammer_atm"
				-- or self.tweak_data == "safe_carry_drop"
				or self.tweak_data == "samurai_armor"
				or self.tweak_data == "sc_tape_loop"
				or self.tweak_data == "sentry_gun_refill"
				or self.tweak_data == "set_off_alarm"
				or self.tweak_data == "sewer_manhole"
				or self.tweak_data == "shaped_sharge"
				or self.tweak_data == "shelf_sliding_suburbia"
				or self.tweak_data == "stash_planks"
				or self.tweak_data == "stash_planks_pickup"
				or self.tweak_data == "trip_mine"
				or self.tweak_data == "use_hotel_room_key_no_access"
				or self.tweak_data == "weapon_case" then
				return self._tweak_data.interact_distance or tweak_data.interaction.INTERACT_DISTANCE
			end
			return interaction_distance or 200 -- DEFAULT IS 200
		end
		managers.mission._fading_debug_output:script().log("INTERACT DISTANCE : ENABLED", Color("FFE29D"))
	end
	------------------------
	-- INTERACT THRU WALL --
	------------------------
	-- SOURCE CREDIT: TRANSCEND
	function intWall()
		Toggle.intWall = not Toggle.intWall
		if not Toggle.intWall then
			backuper:restore('ObjectInteractionManager._update_targeted')
			backuper:restore('ObjectInteractionManager.interact')
			managers.mission._fading_debug_output:script().log("INTERACT THRU WALL : DISABLED", Color("FFE29D"))
			return
		end
		backuper:backup('ObjectInteractionManager.interact')
		function ObjectInteractionManager:interact(player)
			if(alive(self._active_unit)) then
				local interacted,timer = self._active_unit:interaction():interact_start(player)
				if timer then
					self._active_object_locked_data = true
				end
				return interacted or interacted == nil or false, timer, self._active_unit
			end
			return false
		end
		backuper:backup('ObjectInteractionManager._update_targeted')
		function ObjectInteractionManager:_update_targeted(player_pos, player_unit)	
			local mvec1 = Vector3()
			local mvec3_dis = mvector3.distance
			if #self._close_units > 0 then
				for k, unit in pairs(self._close_units) do
					if alive(unit) and unit:interaction():active() then
						if mvec3_dis(player_pos, unit:interaction():interact_position()) > unit:interaction():interact_distance() then
							table.remove(self._close_units, k)
						end
					else
						table.remove(self._close_units, k)
					end	
				end	
			end
			for i = 1, self._close_freq, 1 do
				if(self._close_index >= self._interactive_count) then
					self._close_index = 1
				else
					self._close_index = self._close_index + 1
				end
				local unit = self._interactive_units[self._close_index]
				if alive(unit) and unit:interaction():active() and not self:_in_close_list(unit) and mvec3_dis(player_pos, unit:interaction():interact_position()) <= unit:interaction():interact_distance() then
					table.insert(self._close_units, unit)
				end
		end
		local locked = false
			if self._active_object_locked_data then
				if not alive( self._active_unit ) or not self._active_unit:interaction():active() then
					self._active_object_locked_data = nil
				else
					locked = ( mvec3_dis(player_pos, self._active_unit:interaction():interact_position()) <= self._active_unit:interaction():interact_distance() )
				end	
			end
		if locked then
			return
		end
		local last_active = self._active_unit
		local blocked = player_unit:movement():object_interaction_blocked()
		local driving = managers.player:current_state() == "driving"
		local bipod = managers.player:current_state() == "bipod"
		if #self._close_units > 0 and not blocked and not driving and not bipod then
			-- FIND THE ONE THE PLAYER IS LOOKING AT
			local active_unit
			local current_dot = 0.9
			local closest_locator
			local player_fwd = player_unit:camera():forward()
			local camera_pos = player_unit:camera():position()
			tweak_data.interaction.open_from_inside.interact_distance = 0
				for _, unit in pairs( self._close_units ) do
					if( alive( unit ) ) then
						
						mvector3.set(mvec1, unit:interaction():interact_position())
						mvector3.subtract( mvec1, camera_pos )
						mvector3.normalize( mvec1 )
						local dot = mvector3.dot( player_fwd, mvec1 )
						
						if( dot > current_dot ) then
							current_dot = dot
							active_unit = unit
						end	
					end	
				end
			if( active_unit and self._active_unit ~= active_unit ) then
				if alive( self._active_unit ) then
					self._active_unit:interaction():unselect()
				end
				if not active_unit:interaction():selected( player_unit, self._active_locator ) then
					active_unit = nil
				end	
			end
				self._active_unit = active_unit
			else
				self._active_unit = nil
			end
			if( alive( last_active ) ) then
				if( not self._active_unit ) then
					self._active_unit = nil
					last_active:interaction():unselect()
				end	
			end	
		end
		managers.mission._fading_debug_output:script().log("INTERACT THRU WALL : ENABLED", Color("FFE29D") )
	end
	-----------------
	-- FREE ASSETS --
	-----------------
	-- SOURCE CREDIT: v00d00
	function freeAss()
		if MoneyManager then
			function MoneyManager:on_buy_mission_asset( asset_id ) return 0 end
			function MoneyManager:get_mission_asset_cost() return 0 end
			function MoneyManager:get_mission_asset_cost_by_stars( stars ) return 0 end
			function MoneyManager:get_mission_asset_cost_by_id( id ) return 0 end
			function MoneyManager:get_preplanning_type_cost(type) return 0 end
			tweak_data.preplanning.gui.MAX_DRAW_POINTS = 100000000000000 -- UNLIMITED DRAWING
		end
		managers.mission._fading_debug_output:script().log("FREE ASSETS", Color("FFE29D"))
	end
	----------------
	-- ALL ASSETS --
	----------------
	-- SOURCE CREDIT: mikethemak
	function getAss()
		if not isPlaying() then
			for _,asset_id in pairs (managers.assets:get_all_asset_ids(true)) do
				managers.assets:unlock_asset(asset_id)
			end
		end
	end
	--------------------
	-- EXP MULTIPLIER --
	--------------------
	function xpMulti()
	Toggle.xpMulti = not Toggle.xpMulti
		if not Toggle.xpMulti then
			backuper:restore('ExperienceManager.give_experience')
			managers.mission._fading_debug_output:script().log('EXP MULTIPLIER : DISABLED',  tweak_data.system_chat_color)
			return
		end
		managers.mission._fading_debug_output:script().log('EXP MULTIPLIER : ENABLED',  tweak_data.system_chat_color)
		backuper:backup('ExperienceManager.give_experience')
		function ExperienceManager:give_experience(xp)
			xp = xp * exp_multiplier_amount
			self._experience_progress_data = {}
			self._experience_progress_data.gained = xp
			self._experience_progress_data.start_t = {}
			self._experience_progress_data.start_t.level = self:current_level()
			self._experience_progress_data.start_t.current = self._global.next_level_data and self:next_level_data_current_points() or 0
			self._experience_progress_data.start_t.total = self._global.next_level_data and self:next_level_data_points() or 1
			self._experience_progress_data.start_t.xp = self:xp_gained()
			table.insert(self._experience_progress_data, {
				level = self:current_level() + 1,
				current = self:next_level_data_current_points(),
				total = self:next_level_data_points()
			})
			local level_cap_xp_leftover = self:add_points(xp, true, false)
				if level_cap_xp_leftover then
					self._experience_progress_data.gained = self._experience_progress_data.gained - level_cap_xp_leftover
				end
			self._experience_progress_data.end_t = {}
			self._experience_progress_data.end_t.level = self:current_level()
			self._experience_progress_data.end_t.current = self._global.next_level_data and self:next_level_data_current_points() or 0
			self._experience_progress_data.end_t.total = self._global.next_level_data and self:next_level_data_points() or 1
			self._experience_progress_data.end_t.xp = self:xp_gained()
			table.remove(self._experience_progress_data, #self._experience_progress_data)
			local return_data = deep_clone(self._experience_progress_data)
			self._experience_progress_data = nil
			managers.skilltree:give_specialization_points(xp)
			return return_data
		end
	end
	----------------------------------
	-- NO PENALTY FOR CIVILIAN KILL --
	----------------------------------
	-- SOURCE CREDIT: mikethemak
	function freeKill()
	Toggle.freeKill = not Toggle.freeKill
		if not Toggle.freeKill then
		backuper:restore('MoneyManager.get_civilian_deduction')
		backuper:restore('MoneyManager.civilian_killed')
		backuper:restore('UnitNetworkHandler.sync_hostage_killed_warning')
		managers.mission._fading_debug_output:script().log("NO PENALTY FOR CIVILIAN KILL : DISABLED", Color("FFE29D"))
		return
		end
		backuper:backup('MoneyManager.get_civilian_deduction')
		function MoneyManager.get_civilian_deduction() 
			return 0 
		end
		backuper:backup('MoneyManager.civilian_killed')
		function MoneyManager.civilian_killed() 
			return 
		end
		backuper:backup('UnitNetworkHandler.sync_hostage_killed_warning')
		function UnitNetworkHandler:sync_hostage_killed_warning(warning) 
			return 
		end	
		managers.mission._fading_debug_output:script().log("NO PENALTY FOR CIVILIAN KILL : ENABLED", Color("FFE29D"))
	end
	----------------------------
	-- SMARTPHONE CAMERA HACK --
	----------------------------
	function iphonycam()
		if not ( managers.player:current_state() == "civilian" ) then
			game_state_machine:change_state_by_name( "ingame_access_camera" )
		else
			managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
			managers.mission._fading_debug_output:script().log(' CAMERA : ', Color('ffc300') )
		end
	end
	------------------
	-- HOST WRAPPER --
	------------------
	if isHost() then
		-------------------
		-- DRILL INSTANT --
		-------------------
		function drillInst()
			Toggle.drillInst = not Toggle.drillInst
			if not Toggle.drillInst then
				backuper:restore('TimerGui.update')
				managers.mission._fading_debug_output:script().log("INSTANT DRILL : DISABLED", Color("FFE29D") )
				return
			end
			managers.mission._fading_debug_output:script().log("INSTANT DRILL : ENABLED", Color("FFE29D") )
			backuper:hijack('TimerGui.update',function(o, self, ...)
				self._current_timer = 0
				return o(self, ...)
			end )
		end
		----------------------
		-- DRILL PROTECTION --
		----------------------
		function drillDEF()
			Toggle.drillDEF = not Toggle.drillDEF
			if not Toggle.drillDEF then
				backuper:restore('Drill._register_sabotage_SO')
				managers.mission._fading_debug_output:script().log("DRILL PROTECTION : DISABLED", Color("FFE29D") )
				return
			end
			backuper:backup('Drill._register_sabotage_SO')
			function Drill:_register_sabotage_SO()
				if self._sabotage_SO_id or not managers.navigation:is_data_ready() or not (self._unit:timer_gui() and self._unit:timer_gui()._can_jam) or not self._sabotage_align_obj_name then
					return
				end
				local field_pos = self._nav_tracker:field_position()
				local field_z = self._nav_tracker:field_z() - 25 -- SUBTRACT NAV_FIELD PADDING
				local height = self._pos.z - field_z
				local act_anim = "sabotage_device_"..(height > 100 and "high" or height > 60 and "mid" or "low")
				local align_obj = self._unit:get_object( Idstring(self._sabotage_align_obj_name))
				local objective_rot = align_obj:rotation()
				local objective_pos = align_obj:position()
				self._SO_area = managers.groupai:state():get_area_from_nav_seg_id(self._nav_tracker:nav_segment())
				local followup_objective = {
					type = "defend_area",
					nav_seg = self._nav_tracker:nav_segment(),
					area = self._SO_area,
					attitude = "avoid",
					stance = "hos",
					scan = true,
					interrupt_dis = 500,
					interrupt_health = 1
				}
				local objective = {
					type = "act",
					nav_seg = self._nav_tracker:nav_segment(),
					area = self._SO_area,
					pos = objective_pos,
					rot = objective_rot,
					stance = "hos",
					haste = "run",
					fail_clbk = callback(self, self, "on_sabotage_SO_failed"),
					complete_clbk = callback(self, self, "on_sabotage_SO_completed"),
					action_start_clbk = callback(self, self, "on_sabotage_SO_started"),
					scan = true,
					followup_objective = followup_objective,
					interrupt_dis = 800,
					interrupt_health = 1,
					action = {
						type = "act",
						variant = act_anim,
						body_part = 1,
						blocks = {
							action = -1,
							light_hurt = -1,
							aim = -1
						},
						align_sync = true
					}
				}
				local so_descriptor = {
				objective = objective,
				base_chance = 1,  -- [[ DEFAULT 1 ]]
				chance_inc = 0,
				interval = 0,
				search_pos = field_pos,
				search_dis_sq = 1000000, -- [[ DEFAULT 1000000 : 10m radius ]]
				verification_clbk = callback(self, self, "clbk_sabotage_SO_verification"),
				usage_amount = 1,
				AI_group = "enemies",
				access = managers.navigation:convert_access_filter_to_number({
				-- [[ALL UNITS DISABLED FROM BREAKING THE DRILL EXCEPT SECURITY TO AVOID CRASH]]
				--"gangster",
				--"cop",
				--"fbi",
				--"swat",
				--"murky",
				--"sniper",
				--"spooc",
				--"tank",
				--"taser"
				"security",
				"security_patrol"
				}),
				admin_clbk = callback(self, self, "on_sabotage_SO_administered")
				}
			self._sabotage_SO_id = "drill_sabotage" .. tostring(self._unit:key())
			managers.groupai:state():add_special_objective(self._sabotage_SO_id, so_descriptor)
			end
			managers.mission._fading_debug_output:script().log("DRILL PROTECTION : ENABLED", Color("FFE29D"))
		end
		---------------------------------
		-- FORCE GAMESTART FOR CLIENTS --
		---------------------------------
		-- CONFLICTS WITH PREPLANNING
		function forcestart()
			if managers.network:session() and not ( ovkMap == 'branchbank' 
			or ovkMap == 'big'
			or ovkMap == 'crojob2'
			or ovkMap == 'crojob3'
			or ovkMap == 'firestarter_3'
			or ovkMap == 'framing_frame_1'
			or ovkMap == 'framing_frame_3'
			or ovkMap == 'gallery'
			or ovkMap == 'kenaz'
			or ovkMap == 'kosugi'
			or ovkMap == 'mia_1'
			or ovkMap == 'mia_2'
			or ovkMap == 'mus'
			or ovkMap == 'pbr' ) then
				managers.network:session():spawn_players()
			else
				managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
				managers.mission._fading_debug_output:script().log(' GAME PROTECTION : ', Color('ffc300') )
			end
		end
		-----------------
		-- INSTANT WIN --
		-----------------
		function jobWin()
			local num_winners = managers.network:session():amount_of_alive_players()
			managers.network:session():send_to_peers("mission_ended", true, num_winners)
			game_state_machine:change_state_by_name("victoryscreen", { num_winners = num_winners, personal_win = true })
		end
		------------------
		-- INSTANT LOSS --
		------------------
		function jobLoss()
			managers.network:session():send_to_peers("mission_ended", false, 0)
			game_state_machine:change_state_by_name("gameoverscreen")
		end
		---------------------
		-- NO ESCAPE TIMER --
		---------------------
		function noEscape()
		Toggle.noEscape = not Toggle.noEscape
			if not Toggle.noEscape then
				backuper:restore('ElementPointOfNoReturn.on_executed')
				managers.mission._fading_debug_output:script().log("ESCAPE TIMER : RESTORED", Color("FFE29D"))
				return
			end
			backuper:backup('ElementPointOfNoReturn.on_executed')
			function ElementPointOfNoReturn:on_executed(...) end
			managers.mission._fading_debug_output:script().log("ESCAPE TIMER : DEACTIVATED", Color("FFE29D"))
		end
		----------------------
		-- UNLIMITED FAVORS --
		----------------------
		function getFavor()
		Toggle.getFavor = not Toggle.getFavor
			if not Toggle.getFavor then
				backuper:restore('PrePlanningManager.get_type_budget_cost')
				managers.mission._fading_debug_output:script().log("PREPLANNING : DEFAULT FAVORS", Color("FFE29D"))
				return
			end
			if MoneyManager then
				backuper:backup('PrePlanningManager.get_type_budget_cost')
				function PrePlanningManager:get_type_budget_cost(type, default) return 0 end
			end
			managers.mission._fading_debug_output:script().log("PREPLANNING : UNLIMITED FAVORS", Color("FFE29D"))
		end
		-------------------------
		-- UNLIMITED DEADDROPS --
		-------------------------
		function getDrop()
		Toggle.getDrop = not Toggle.getDrop
			if not Toggle.getDrop then
				backuper:restore('PrePlanningManager.can_reserve_mission_element')
				managers.mission._fading_debug_output:script().log("PREPLANNING : DEFAULT DEADDROPS", Color("FFE29D"))
				return
			end
			if MoneyManager then
				backuper:backup('PrePlanningManager.can_reserve_mission_element')
				function PrePlanningManager:can_reserve_mission_element(type, peer_id) return true end
			end
			managers.mission._fading_debug_output:script().log("PREPLANNING : UNLIMITED DEADDROPS", Color("FFE29D"))
		end
	----------------------
	-- END HOST WRAPPER --
	----------------------
	end
----------------------
-- END GAME WRAPPER --
----------------------
end
-----------------------------
-- FREE CRIME.NET CONTRACT --
-----------------------------
function freeJob()
Toggle.freeJob = not Toggle.freeJob
	if not Toggle.freeJob then
		backuper:restore('MoneyManager.get_cost_of_premium_contract')
		managers.mission._fading_debug_output:script().log("CONTRACTS : DEFAULT", Color("FFE29D"))
		return
	end
	if MoneyManager then
		backuper:backup('MoneyManager.get_cost_of_premium_contract')
		function MoneyManager:get_cost_of_premium_contract(job_id, difficulty_id) return 0 end
	end
	managers.mission._fading_debug_output:script().log("CONTRACTS : FREE", Color("FFE29D"))
end
---------------------------
-- FREE CRIME.NET CASINO --
---------------------------
function freeCasino()
Toggle.freeCasino = not Toggle.freeCasino
	if not Toggle.freeCasino then
		backuper:restore('MoneyManager.get_cost_of_casino_entrance')
		backuper:restore('MoneyManager.get_cost_of_casino_fee')
		managers.mission._fading_debug_output:script().log("CASINO : DEFAULT", Color("FFE29D"))
		return
	end
	if MoneyManager then
		backuper:backup('MoneyManager.get_cost_of_casino_entrance')
		function MoneyManager:get_cost_of_casino_entrance()
			return 0
		end
		backuper:backup('MoneyManager.get_cost_of_casino_fee')
		function MoneyManager:get_cost_of_casino_fee(secured_cards, increase_infamous, preferred_card)
			return 0
		end
	end
	managers.mission._fading_debug_output:script().log("CASINO : FREE", Color("FFE29D"))
end
------------------------------
-- FREE CRIME.NET CHALLENGE --
------------------------------
function freeChallenge()
	local ChallengeManager_activate_challenge_original = ChallengeManager.activate_challenge
	function ChallengeManager:activate_challenge(id, key, category)
		if self:has_active_challenges(id, key) then
			local active_challenge = self:get_active_challenge(id, key)
			active_challenge.completed = true
			active_challenge.category = category
			return true
		end
		return ChallengeManager_activate_challenge_original(self, id, key, category)
	end
	managers.mission._fading_debug_output:script().log("SIDE JOBS : COMPLETED", Color("FFE29D"))
end
--------------------------------
-- OVK EXTENSION: JOB MANAGER --
--------------------------------
-- MISSION SELECTOR v1.5 by B1313
-- Global.game_settings.permission = "friends_only" or "public" or "private"
-- Global.game_settings.reputation_permission = 0 -- SET LEVEL LIMIT
-- Global.game_settings.drop_in_allowed = true -- SET TRUE TO ALLOW PEOPLE TO JOIN
-- MissionSelector_Permission = "public"
-- CREATE LOCAL METHODS --
MissionSelector_Contractor = 0
MissionSelector_Difficulty = nil
MissionSelector_Permission = mission_lobby_access
Global.game_settings.drop_in_allowed = mission_lobby_dropin_allow
-------------------------
-- CRIME.NET CONTRACTS --
-------------------------
function MissionDifficulty(difficulty_index)
	MissionSelector_Difficulty = difficulty_index
	local missions_initialzation = {
		{
			{text = "BANK HEIST: CASH", callback = MissionCreator, data = {"branchbank"}},
			{text = "BANK HEIST: DEPOSIT", callback = MissionCreator, data = {"branchbank_deposit", "branchbank"}},
			MissionSelector_Difficulty ~= "normal" and {text = "BANK HEIST (PRO JOB)", callback = MissionCreator, data = {"branchbank_prof", "branchbank"}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "BANK HEIST: GOLD (PRO JOB)", callback = MissionCreator, data = {"branchbank_gold_prof", "branchbank"}} or {},
			{text = "CAR SHOP", callback = MissionCreator, data = {"cage"}},
			{text = "COOK OFF", callback = MissionCreator, data = {"rat"}},
			{text = "DIAMOND STORE", callback = MissionCreator, data = {"family"}},
			{text = "JEWELRY STORE", callback = MissionCreator, data = {"jewelry_store"}},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "ART GALLERY", callback = MissionCreator, data = {"gallery"}},
			{text = "ALESSO HEIST", callback = MissionCreator, data = {"arena"}},
			{text = "GO BANK", callback = MissionCreator, data = {"roberts"}},
			{text = "SHADOW RAID", callback = MissionCreator, data = {"kosugi"}},
			{text = "TRANSPORT: CROSSROADS", callback = MissionCreator, data = {"arm_cro"}},
			{text = "TRANSPORT: DOWNTOWN", callback = MissionCreator, data = {"arm_hcm"}},
			{text = "TRANSPORT: HARBOR", callback = MissionCreator, data = {"arm_fac"}},
			{text = "TRANSPORT: UNDERPASS", callback = MissionCreator, data = {"arm_und"}},
			{text = "TRANSPORT: PARK", callback = MissionCreator, data = {"arm_par"}},
			{text = "TRANSPORT: TRAIN HEIST", callback = MissionCreator, data = {"arm_for"}},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "THE BIG BANK", callback = MissionCreator, data = {"big"}},
			{text = "THE DIAMOND", callback = MissionCreator, data = {"mus"}},
			{text = "HOTLINE MIAMI DAY 1", callback = MissionCreator, data = {"mia", "mia_1", 1}},
			{text = "HOTLINE MIAMI DAY 2", callback = MissionCreator, data = {"mia", "mia_2", 2}},
			MissionSelector_Difficulty ~= "normal" and {text = "HOTLINE MIAMI (PRO JOB) DAY 1", callback = MissionCreator, data = {"mia_prof", "mia_1", 1}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "HOTLINE MIAMI (PRO JOB) DAY 2", callback = MissionCreator, data = {"mia_prof", "mia_2", 2}} or {},
			{text = "HOXTON BREAKOUT DAY 1", callback = MissionCreator, data = {"hox", "hox_1", 1}},
			{text = "HOXTON BREAKOUT DAY 2", callback = MissionCreator, data = {"hox", "hox_2", 2}},
			MissionSelector_Difficulty ~= "normal" and {text = "HOXTON BREAKOUT (PRO JOB) DAY 1", callback = MissionCreator, data = {"hox_prof", "hox_1", 1}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "HOXTON BREAKOUT (PRO JOB) DAY 2", callback = MissionCreator, data = {"hox_prof", "hox_2", 2}} or {},
			{text = "HOXTON REVENGE", callback = MissionCreator, data = {"hox_3"}},
			{text = "GOLDEN GRIN CASINO", callback = MissionCreator, data = {"kenaz"}},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "POINT BREAK : BENEATH THE MOUNTAIN", callback = MissionCreator, data = {"pbr"}},
			{text = "POINT BREAK : BIRTH OF THE SKY", callback = MissionCreator, data = {"pbr2"}},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "THE BOMB: DOCKYARD", callback = MissionCreator, data = {"crojob1", "crojob2"}},
			{text = "THE BOMB: FOREST", callback = MissionCreator, data = {"crojob2", "crojob3"}},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "FIRE STARTER DAY 1", callback = MissionCreator, data = {"firestarter", "firestarter_1", 1}},
			{text = "FIRE STARTER DAY 2", callback = MissionCreator, data = {"firestarter", "firestarter_2", 2}},
			{text = "FIRE STARTER DAY 3", callback = MissionCreator, data = {"firestarter", "firestarter_3", 3}},
			MissionSelector_Difficulty ~= "normal" and {text = "FIRE STARTER (PRO JOB) DAY 1", callback = MissionCreator, data = {"firestarter_prof", "firestarter_1", 1}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "FIRE STARTER (PRO JOB) DAY 2", callback = MissionCreator, data = {"firestarter_prof", "firestarter_2", 2}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "FIRE STARTER (PRO JOB) DAY 3", callback = MissionCreator, data = {"firestarter_prof", "firestarter_3", 3}} or {},
			{text = "RATS DAY 1", callback = MissionCreator, data = {"alex", "alex_1", 1}},
			{text = "RATS DAY 2", callback = MissionCreator, data = {"alex", "alex_2", 2}},
			{text = "RATS DAY 3", callback = MissionCreator, data = {"alex", "alex_3", 3}},
			MissionSelector_Difficulty ~= "normal" and {text = "RATS (PRO JOB) DAY 1", callback = MissionCreator, data = {"alex_prof", "alex_1", 1}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "RATS (PRO JOB) DAY 2", callback = MissionCreator, data = {"alex_prof", "alex_2", 2}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "RATS (PRO JOB) DAY 3", callback = MissionCreator, data = {"alex_prof", "alex_3", 3}} or {},
			{text = "WATCHDOGS DAY 1", callback = MissionCreator, data = {"watchdogs", "watchdogs_1", 1}},
			{text = "WATCHDOGS DAY 2", callback = MissionCreator, data = {"watchdogs", "watchdogs_2", 2}},
			MissionSelector_Difficulty ~= "normal" and {text = "WATCHDOGS (PRO JOB) DAY 1", callback = MissionCreator, data = {"watchdogs_prof", "watchdogs_1", 1}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "WATCHDOGS (PRO JOB) DAY 2", callback = MissionCreator, data = {"watchdogs_prof", "watchdogs_2", 2}} or {},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			MissionSelector_Difficulty ~= "normal" and {text = "BIG OIL (PRO JOB) DAY 1", callback = MissionCreator, data = {"welcome_to_the_jungle_prof", "welcome_to_the_jungle_1", 1}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "BIG OIL (PRO JOB) DAY 2", callback = MissionCreator, data = {"welcome_to_the_jungle_prof", "welcome_to_the_jungle_2", 2}} or {},
			{text = "ELECTION DAY DAY 1", callback = MissionCreator, data = {"election_day", "election_day_1", 1}},
			{text = "ELECTION DAY DAY 2", callback = MissionCreator, data = {"election_day", "election_day_2", 2}},
			{text = "ELECTION DAY DAY 3", callback = MissionCreator, data = {"election_day", "election_day_3", 2}},
			MissionSelector_Difficulty ~= "normal" and {text = "ELECTION DAY (PRO JOB) DAY 1", callback = MissionCreator, data = {"election_day_prof", "election_day_1", 1}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "ELECTION DAY (PRO JOB) DAY 2", callback = MissionCreator, data = {"election_day_prof", "election_day_2", 2}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "ELECTION DAY (PRO JOB) DAY 3", callback = MissionCreator, data = {"election_day_prof", "election_day_3", 2}} or {},
			{text = "FRAMING FRAME DAY 1", callback = MissionCreator, data = {"framing_frame", "framing_frame_1", 1}},
			{text = "FRAMING FRAME DAY 3", callback = MissionCreator, data = {"framing_frame", "framing_frame_3", 3}},
			MissionSelector_Difficulty ~= "normal" and {text = "FRAMING FRAME (PRO JOB) DAY 1", callback = MissionCreator, data = {"framing_frame_prof", "framing_frame_1", 1}} or {},
			MissionSelector_Difficulty ~= "normal" and {text = "FRAMING FRAME (PRO JOB) DAY 3", callback = MissionCreator, data = {"framing_frame_prof", "framing_frame_3", 3}} or {},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "AFTERSHOCK", callback = MissionCreator, data = {"jolly"}},
			{text = "FOUR STORES", callback = MissionCreator, data = {"four_stores"}},
			{text = "MALLCRASHER", callback = MissionCreator, data = {"mallcrasher"}},
			{text = "MELTDOWN", callback = MissionCreator, data = {"shoutout_raid"}},
			{text = "NIGHTCLUB", callback = MissionCreator, data = {"nightclub"}},
			{text = "SANTA\'S WORKSHOP", callback = MissionCreator, data = {"cane"}},
			{text = "WHITE XMAS", callback = MissionCreator, data = {"pines"}},
			MissionSelector_Difficulty ~= "normal" and {text = "UKRAINIAN JOB (PRO JOB)", callback = MissionCreator, data = {"ukrainian_job_prof", "ukrainian_job"}} or {},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "FIRST WORLD BANK", callback = MissionCreator, data = {"red2"}},
			{text = "SLAUGHTERHOUSE", callback = MissionCreator, data = {"dinner"}},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "LAB RATS", callback = MissionCreator, data = {"nail"}},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		},
		{
			{text = "ESCAPE: CAFE (NIGHT)", callback = MissionCreator, data = {"ukrainian_job", "escape_cafe"}},
			{text = "ESCAPE: CAFE (DAY)", callback = MissionCreator, data = {"ukrainian_job", "escape_cafe_day"}},
			{text = "ESCAPE: PARK (NIGHT)", callback = MissionCreator, data = {"ukrainian_job", "escape_park"}},
			{text = "ESCAPE: PARK (DAY)", callback = MissionCreator, data = {"ukrainian_job", "escape_park_day"}},
			{text = "ESCAPE: OVERPASS (NIGHT)", callback = MissionCreator, data = {"ukrainian_job", "escape_overpass_night"}},
			{text = "ESCAPE: OVERPASS (DAY)", callback = MissionCreator, data = {"ukrainian_job", "escape_overpass"}},
			{text = "ESCAPE: STREET", callback = MissionCreator, data = {"ukrainian_job", "escape_street"}},
			{text = "ESCAPE: GARAGE", callback = MissionCreator, data = {"ukrainian_job", "escape_garage"}},
			{ text = "" },
			{text = "CANCEL", is_cancel_button = true}
		}
	}
	local function CleanMissions()
		for j, missions in ipairs(missions_initialzation) do
			for i, entries in ipairs(missions) do
				if not entries.text then
					table.remove(missions_initialzation[j], i)
					return CleanMissions()
				end
			end
		end
	end
	CleanMissions()
	SimpleMenu:new("MISSION SELECTOR", "CHOOSE HEIST", missions_initialzation[MissionSelector_Contractor]):show()
end
------------------------
-- MISSION CONTRACTOR --
------------------------
function MissionContractor(mission_menu)
	MissionSelector_Contractor = mission_menu
	SimpleMenu:new("MISSION SELECTOR", "CHOOSE DIFFICULTY", {
		{text = "NORMAL", callback = MissionDifficulty, data = "normal"},
		{text = "HARD", callback = MissionDifficulty, data = "hard"},
		{text = "VERY HARD", callback = MissionDifficulty, data = "overkill"},
		{text = "OVERKILL", callback = MissionDifficulty, data = "overkill_145"},
		{text = "DEATH WISH", callback = MissionDifficulty, data = "overkill_290"},
		{},
		{text = "CANCEL", is_cancel_button = true}
	}):show()
end
----------------
-- DIFFICULTY --
----------------
function makeitnormal()
	Global.game_settings.difficulty = "normal"
	managers.mission._fading_debug_output:script().log(' PLEASE RESTART... ', Color("2ebdf5") )
	managers.mission._fading_debug_output:script().log(' NORMAL DIFFICULTY : SELECTED',  tweak_data.system_chat_color)
end
function makeithard()
	Global.game_settings.difficulty = "hard"
	managers.mission._fading_debug_output:script().log(' PLEASE RESTART... ', Color("2ebdf5") )
	managers.mission._fading_debug_output:script().log(' HARD DIFFICULTY : SELECTED',  tweak_data.system_chat_color)
end
function makeitveryhard()
	Global.game_settings.difficulty = "overkill"
	managers.mission._fading_debug_output:script().log(' PLEASE RESTART... ', Color("2ebdf5") )
	managers.mission._fading_debug_output:script().log(' VERY HARD DIFFICULTY : SELECTED',  tweak_data.system_chat_color)
end
function makeitoverkill()
	Global.game_settings.difficulty = "overkill_145"
	managers.mission._fading_debug_output:script().log(' PLEASE RESTART... ', Color("2ebdf5") )
	managers.mission._fading_debug_output:script().log(' OVERKILL DIFFICULTY : SELECTED',  tweak_data.system_chat_color)
end
function makeitdeathwish()
	Global.game_settings.difficulty = "overkill_290"
	managers.mission._fading_debug_output:script().log(' PLEASE RESTART... ', Color("2ebdf5") )
	managers.mission._fading_debug_output:script().log(' DEATHWISH DIFFICULTY : SELECTED',  tweak_data.system_chat_color)
end
---------------------
-- MISSION CREATOR --
---------------------
-- Global.game_settings.reputation_permission = 0 -- SET LEVEL LIMIT
-- Global.game_settings.drop_in_allowed = true -- SET TRUE TO ALLOW PEOPLE TO JOIN
function MissionCreator(mission_parameters)
	local mission_parameter_job, mission_parameter_level, mission_parameter_day = unpack(mission_parameters)
	if mission_parameter_level == nil then
		mission_parameter_level = mission_parameter_job
	end
	managers.job:activate_job (mission_parameter_job, mission_parameter_day)
	Global.game_settings.level_id = mission_parameter_level
	Global.game_settings.mission = managers.job:current_mission()
	Global.game_settings.difficulty = MissionSelector_Difficulty
	Global.game_settings.permission = MissionSelector_Permission
	Global.game_settings.drop_in_allowed = false
	local level_id = tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id)
	local job_id = tweak_data.narrative:get_index_from_job_id(managers.job:current_job_id())
	managers.network.matchmake:create_lobby({numbers = {level_id, MissionSelector_Difficulty, MissionSelector_Permission, nil, nil, 1, 1, 1}})
end
--------------------------
-- ESCAPE CHAIN CREATOR --
--------------------------
function EscapeChainCreator(level_parameters)
	local level_index, level_text = unpack(level_parameters)
	managers.job:set_next_interupt_stage(level_index)
	show_mid_text("CHAINED", "ESCAPE CHAIN: " .. level_text, 3,5)
end
----------------
-- RANDOMIZER --
----------------
local pie = { "... We Pay2Day: Global Offensive", "... Hatin\' n\' lovin\' one update at a time.", "... Community care was SOOO two years ago.", "... Don\'t worry, there are plenty of wallets out there.", "... We can\'t believe you like money too. We should hang out ;)", "... OVERKILL [...] brought to you by Carl\'s Jr.", "... Community was like \"blah blah blah. You gotta listen to us!\" But then the CEO, Bo Andersson just went off. He said \"man, whatever! gamers are dumb as shit! we all know that... \" And he sentenced the community to one week of Crimefest and introduced the Black Market Update. - The Payday Story", "... We\'re sorry brah, but we hungry.", "... Keep those wallets flying heisters! - Almir Listo", "... We don\'t get paid enough - OVERKILL STAFF", "... We understand everyone\'s shit\'s emotional right now.", "... We are not independent [...] we are independent. - Almir", "... Microtransactions, the STD of the gaming industry.", "... Who knows, you might like it.", "... Hesitation will cause your worst fears to come true.", "... Are you crazy enough?", "... Are you aggravated brother?", "... If you want the ultimate, you've got to be willing to pay the ultimate price.","... Life sure has a sick sense of humor, doesn\'t it?", "... Peace, through superior firepower.", "... Shit happens.", "... The whole world must learn of our peaceful ways, BY FORCE.", "... You got a death wish, Brah?", "... I'm so hungry I could eat the ass end out of a dead rhino.", "... Little hand says it's time to rock and roll", "... for me, the action is the juice.", "... goddamn! You are one radical son of a bitch!", "... Have you ever shot your gun in the air whilst yelling AHHHHHHH?!","... Gotta be fucking crazy!", "... Dance off, Bro.", "... Young, dumb, and full of cum.", "... Enjoy it while it lasts.", "... Respect your elders!", "... You gonna shoot or jerk off?", "... PUNCH-THAT-SHIT!", "... Four blokes and a fuckload of weaponry!", "... It's not murder, it\'s ketchup!", "... I hungry, let\'s grind!", "... Your opinion. My choice.", "... What are we robbing today?", "... Your failures are your own, old man! I say, FOLLOW THROOOUGH!", "... Feel that? The way shit clings to the air? It's already started. The shit blizzard.", "... My wounds will heal. What about yours?", "... There are worse games to play.", "... Trust in the principle of reciprocity.", "... I know what dude I am. I\'m the dude playin\' the dude, disguised as another dude!", "... Everybody knows you never go full retard.", "... A license to kill also means a license NOT to kill.", "... While I was waiting, I ate your lunch.", "... They suffer from who-gives-a-shit-syndrome. Light\'s on, nobody human home.", "... WHY\'D YOU EVEN ROPE ME INTO THIS?!", "... Some of us have better things to do than read forum threads, Jerry!", "...Yeah if you spend all day shuffling words around you can make anything sound bad.", "... NOT TODAY BITCH!", "... Don\'t break an arm jerking yourself off.", "... Monument to compromise.", "... It\'s fine, everything is fine.", "... They\'re robots! It\'s okay to shoot them! They\'re just robots!", "... Oh my god, how could I not see this coming?", "... I don\'t get it and I don\'t need to.", "... Get your shit together, get it all together. Go to your inventory get all your shit, so it\'s together... and if you gotta take it somewhere, take it somewhere ya know? Put it on the shit market and sell it, or leave it on display like a shit museum. I don\'t care what you do, you just gotta get it together... Get your shit together.", "... Hug it out, bitch." }
local rng = math.random( #pie )
----------------
-- DIFFICULTY --
----------------
changeHazard = function()
local data = {
	{ text = "NORMAL", callback = makeitnormal },
	{ text = "HARD", callback = makeithard },
	{ text = "VERY HARD", callback = makeitveryhard },
	{ text = "OVERKILL", callback = makeitoverkill },
	{ text = "DEATHWISH", callback = makeitdeathwish },
	{}
	}
show_sorted_dialog("CHANGE MISSION DIFFICULTY", "... Why don't we do this the easy way.", data, mission_menu)
end
------------------
-- CHAIN ESCAPE --
------------------
chainEscape = function()
local data = {
	{text = "CAFE (DAY) \[ESCAPE\]", callback = EscapeChainCreator, data = {"escape_cafe_day", "ESCAPE: CAFE (DAY)"}},
	{text = "CAFE (NIGHT) \[ESCAPE\]", callback = EscapeChainCreator, data = {"escape_cafe", "ESCAPE: CAFE"}},
	{text = "PARK (DAY) \[ESCAPE\]", callback = EscapeChainCreator, data = {"escape_park_day", "ESCAPE: PARK (DAY)"}},
	{text = "PARK (NIGHT) \[ESCAPE\]", callback = EscapeChainCreator, data = {"escape_park", "ESCAPE: PARK"}},
	{text = "OVERPASS (DAY) \[ESCAPE\]", callback = EscapeChainCreator, data = {"escape_overpass", "ESCAPE: OVERPASS"}},
	{text = "OVERPASS (NIGHT) \[ESCAPE\]", callback = EscapeChainCreator, data = {"escape_overpass_night", "ESCAPE: OVERPASS (NIGHT)"}},
	{text = "STREET \[ESCAPE\]", callback = EscapeChainCreator, data = {"escape_street", "ESCAPE: STREET"}},
	{text = "GARAGE \[ESCAPE\]", callback = EscapeChainCreator, data = {"escape_garage", "ESCAPE: GARAGE"}},
	{}
	}
show_sorted_dialog("ESCAPE MISSION SELECTOR", "... What if there is no tomorrow?", data, mission_menu)
end
------------------
-- MISSION MENU --
------------------
mission_menu = function()
	if isHost() then
		mission_menu_A()
	else
		managers.mission._fading_debug_output:script().log("MISSION OPTIONS : ERROR", Color("cc0000"))
	end
end
mission_menu_A = function()
local data = {
	{ text = "FAIL MISSION \[INSTANT\]", callback = jobLoss },
	{ text = "COMPLETE MISSION \[INSTANT\]", callback = jobWin },
	{},
	{ text = "CHANGE DIFFICULTY \[MENU\]", callback = changeHazard },
	{ text = "CHAIN ESCAPE \[MENU\]", callback = chainEscape },
	{},
	{ text = "DEACTIVATE ESCAPE TIMER \[TOGGLE\]", callback = noEscape },
	{}
	}
show_sorted_dialog("MISSION OPTIONS \[HOST\]", "... Take your free win and get out of here.", data, core_game)
end
-------------------
-- ANTIHERO MENU --
-------------------
antihero_menu = function()
local rock = { "... You are like my DWAYNE JOHNSON.", "... Hot damn son! It\'s robocop!" }
local rng = math.random( #rock )
local data = {
	{ text = "GOD MODE \[TOGGLE\]", callback = godMode },
	{},
	{ text = "CLOAKER COUNTER \[TOGGLE\]", callback = clkCounter },
	{ text = "FLASHBANG IMMUNITY \[TOGGLE\]", callback = fbMode },
	{ text = "SHOCKPROOF \[TOGGLE\]", callback = shockMode },
	{ text = "NO FALL DAMAGE \[TOGGLE\]", callback = fallMode },
	{ text = "NO STAMINA DRAIN \[TOGGLE\]", callback = runMode },
	{ text = "PUGILIST \[TOGGLE\]", callback = pugilistMode },
	{}
	}
show_sorted_dialog("ANTIHERO OPTIONS", ""..rock[rng], data, core_game)
end
-------------------
-- MUNITION MENU --
-------------------
munition_menu = function()
local data = {
	{ text = "HIGH EXPLOSIVE ROUNDS \[TOGGLE\]", callback = shellMode },
	{ text = "BULLETSTORM \[TOGGLE\]", callback = infMode },
	{},
	{ text = "REDUCE RECOIL \[TOGGLE\]", callback = wpn_recoil },
	{ text = "REDUCE SPREAD \[TOGGLE\]", callback = wpn_spread },
	{ text = "INCREASE FIRERATE \[TOGGLE\]", callback = wpn_firerate },
	{ text = "INCREASE RELOAD SPEED \[TOGGLE\]", callback = wpn_reload },
	{ text = "INCREASE SWITCH SPEED \[TOGGLE\]", callback = wpn_swap },
	{}
	}
show_sorted_dialog("MUNITION OPTIONS", "... Took the red pill.", data, core_game)
end
----------------
-- DRILL MENU --
----------------
drill_menu = function()
	if isHost() then
		drill_menu_A()
	else
		drill_menu_B()
	end
end
drill_menu_A = function()
local data = {
	{ text = "DRILL INSTANT \[TOGGLE\]", callback = drillInst },
	{ text = "DRILL PROTECTION \[TOGGLE\]", callback = drillDEF },
	{},
	{ text = "AUTOREPAIR SERVICE \[TOGGLE\]", callback = drillautofix },
	{ text = "REPAIR ALL DRILLS REMOTELY", callback = drillremotefix },
	{}
	}
show_sorted_dialog("DRILL CONTROLS \[HOST\]", "... It comes with a remote", data, core_game)
end
drill_menu_B = function()
local data = {
	{ text = "AUTOREPAIR SERVICE \[TOGGLE\]", callback = drillautofix },
	{ text = "REPAIR ALL DRILLS REMOTELY", callback = drillremotefix },
	{}
	}
show_sorted_dialog("DRILL CONTROLS \[CLIENT\]", "... It comes with a remote", data, core_game)
end
-------------------
-- INTERACT MENU --
-------------------
interact_menu = function()
local data = {
	{ text = "INTERACT INSTANT \[TOGGLE\]", callback = intInst },
	{},
	{ text = "INTERACT ANYTHING \[TOGGLE\]", callback = intAll },
	{ text = "INTERACT DISTANCE \[TOGGLE\]", callback = intDist },
	{ text = "INTERACT WALLS \[TOGGLE\]", callback = intWall },
	{}
	}
show_sorted_dialog("INTERACT CONTROLS", "... Magic, everyone!", data, core_game)
end
----------------
-- INTRO MENU --
----------------
core_intro = function()
local data = {
	{ text = "BAIN \[MENU\]", callback = MissionContractor, data = 1},
	{ text = "BAIN DLCS \[MENU\]", callback = MissionContractor, data = 2},
	{ text = "THE DENTIST \[MENU\]", callback = MissionContractor, data = 3},
	{ text = "LOCKE \[MENU\]", callback = MissionContractor, data = 4},
	{ text = "THE BUTCHER \[MENU\]", callback = MissionContractor, data = 5},
	{ text = "HECTOR \[MENU\]", callback = MissionContractor, data = 6},
	{ text = "THE ELEPHANT \[MENU\]", callback = MissionContractor, data = 7},
	{ text = "VLAD \[MENU\]", callback = MissionContractor, data = 8},
	{ text = "CLASSICS \[MENU\]", callback = MissionContractor, data = 9},
	{ text = "EVENTS \[MENU\]", callback = MissionContractor, data = 10},
	{},
	{ text = "ESCAPE MISSIONS \[MENU\]", callback = MissionContractor, data = 11},
	{},
	{ text = "FREE CONTRACTS \[CRIME.NET\]", callback = freeJob },
	{ text = "FREE OFFSHORE CASINO \[CRIME.NET\]", callback = freeCasino },
	{ text = "COMPLETE SIDE JOBS \[CRIME.NET\]", callback = freeChallenge },
	{}
	}
	show_sorted_dialog("OVERKILL MISSION MODIFIER", ""..pie[rng], data, nil)
end
----------------
-- LOBBY MENU --
----------------
core_lobby = function()
	if isHost() then
		core_lobby_A()
	else
		core_lobby_B()
	end
end
core_lobby_A = function()
local data = {
	{ text = "FREE ASSETS", callback = freeAss },
	{ text = "BUY ALL ASSETS", callback = getAss },
	{},
	{ text = "EXP MULTIPLIER \[TOGGLE\]", callback = xpMulti },
	{ text = "CLEANER COSTS \[TOGGLE\]", callback = freeKill },
	{},
	{ text = "UNLIMITED FAVORS \[TOGGLE\]", callback = getFavor },
	{ text = "UNLIMITED DEADDROPS \[TOGGLE\]", callback = getDrop },
	{ text = "DEACTIVATE ESCAPE TIMER \[TOGGLE\]", callback = noEscape },
	{},
	{ text = "FORCE READY", callback = forcestart },
	{}
	}
	show_sorted_dialog("OVERKILL PREPLANNING [HOST]", ""..pie[rng], data, nil)
end
core_lobby_B = function()
local data = {
	{ text = "FREE ASSETS", callback = freeAss },
	{ text = "BUY ALL ASSETS", callback = getAss },
	{},
	{ text = "EXP MULTIPLIER \[TOGGLE\]", callback = xpMulti },
	{ text = "CLEANER COSTS \[TOGGLE\]", callback = freeKill },
	{}
	}
	show_sorted_dialog("OVERKILL PREPLANNING [CLIENT]", ""..pie[rng], data, nil)
end
---------------
-- GAME MENU --
---------------
core_game = function()
	if isHost() then
		core_game_A()
	else
		core_game_B()
	end
end
core_game_A = function()
local data = {
	{ text = "SMARTPHONE CAMERA", callback = iphonycam },
	{ text = "MISSION OPTIONS \[MENU\]", callback = mission_menu },
	{},
	{ text = "ANTIHERO OPTIONS \[MENU\]", callback = antihero_menu },
	{ text = "DRILL CONTROLS \[MENU\]", callback = drill_menu },
	{ text = "INTERACT CONTROLS \[MENU\]", callback = interact_menu },
	{ text = "MUNITION OPTIONS \[MENU\]", callback = munition_menu },
	{}
	}
	show_sorted_dialog("OVERKILL CORE MENU [HOST]", ""..pie[rng], data, nil)
end
core_game_B = function()
local data = {
	{ text = "SMARTPHONE CAMERA", callback = iphonycam },
	{},
	{ text = "ANTIHERO OPTIONS \[MENU\]", callback = antihero_menu },
	{ text = "DRILL CONTROLS \[MENU\]", callback = drill_menu },
	{ text = "INTERACT CONTROLS \[MENU\]", callback = interact_menu },
	{ text = "MUNITION OPTIONS \[MENU\]", callback = munition_menu },
	{}
	}
	show_sorted_dialog("OVERKILL CORE MENU [CLIENT]", ""..pie[rng], data, nil)
end
-------------------
-- MENU DIRECTOR --
-------------------
if not inGame() and _cheatToggle then
	core_intro()
elseif inGame() and not isPlaying() and _cheatToggle and not inChat() then
	core_lobby()
elseif inGame() and isPlaying() and _cheatToggle and not inChat() then
	core_game()
end