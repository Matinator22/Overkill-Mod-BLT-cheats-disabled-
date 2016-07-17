--============================--
--       OVERKILL MOD         --
-- INVENTORY & EQUIPMENT MENU --
--       BY OVERKILL          --
--============================--
-- r2.2
-------------------
-- SAVE SETTINGS --
-------------------
local ovkMap = managers.job:current_level_id()
-------------------------
-- GIVE ITEMS FUNCTION --
-------------------------
function give_items( argumentTable )
	local itype = argumentTable["type"]
	local times = argumentTable["times"]
	local types = {"weapon_mods", "masks", "materials", "textures", "colors"}
	local skip = { masks = {"character_locked"}, materials = {"plastic"}, colors = {"nothing"}, textures = {"no_color_full_material","no_color_no_material"} }
		if not times then times = 1 end
			if type(itype) == "table" then types = itype end
			if itype == "all" or type(itype) == "table" then
			for i = 1, #types do give_items({ ["type"] = types[i], ["times"] = times }) end
			return
		end
		for i=1, times do
			for mat_id,_ in pairs(tweak_data.blackmarket[itype]) do
				if not in_table(skip[itype], mat_id) then
					local global_value = "normal"
					if _.global_value then
						global_value = _.global_value
					elseif _.infamous then
						global_value = "infamous"
					elseif _.dlcs or _.dlc then
						local dlcs = _.dlcs or {}
					if _.dlc then table.insert(dlcs, _.dlc) end
						global_value = dlcs[ math.random(#dlcs) ]
					end
				if _.unlocked == false then
					_.unlocked = true
				end
				managers.blackmarket:add_to_inventory(global_value, itype, mat_id, false)
			end
		end
	end
end
--------------------------
-- CLEAR ITEMS FUNCTION --
--------------------------
function clear_items( argumentTable )
	local itype = argumentTable["type"]
	local globalval = argumentTable["globalval"]
	local types = {"weapon_mods", "masks", "materials", "textures", "colors"}
	if not globalval then globalval = "all" end
	if type(itype) == "table" then types = itype end
	if itype == "all" or type(itype) == "table" then
		for i = 1, #types do
			clear_items({ ["type"] = types[i], ["globalval"] = globalval })
		end
	end
	for global_value, categories in pairs( Global.blackmarket_manager.inventory ) do
		if (globalval == "all" or globalval == global_value) and categories[itype] then
			for id,amount in pairs( categories[itype] ) do
				Global.blackmarket_manager.inventory[global_value][itype][id] = nil
			end
		end
	end
end
---------------------------
-- UNLOCK ITEMS FUNCTION --
---------------------------
function unlock_items( itype )
	local types = {"weapon_mods", "masks", "materials", "textures", "colors", "weapons"}
	if type(itype) == "table" then types = itype end
	if itype == "all" or type(itype) == "table" then
		for i = 1, #types do unlock_items({ ["type"] = types[i] }) end
		return
	end
	if itype == "weapons" then 
		for wep_id,_ in pairs(tweak_data.upgrades.definitions) do
			if _.category == "weapon" and not string.find(wep_id, "_primary") and not string.find(wep_id, "_secondary") then
				if not managers.upgrades:aquired(wep_id) then managers.upgrades:aquire(wep_id) end
			end
		end
	else
		for mat_id,_ in pairs(tweak_data.blackmarket[itype]) do
			if _.unlocked == false then 
				_.unlocked = true 
			end
		end
	end
end
---------------------------------
-- GIVE SPECIFIC ITEM FUNCTION --
---------------------------------
function unlock_slots()
	for i = 1, 300 do
		Global.blackmarket_manager.unlocked_mask_slots[i] = true
		Global.blackmarket_manager.unlocked_weapon_slots.primaries[i] = true
		Global.blackmarket_manager.unlocked_weapon_slots.secondaries[i] = true
	end    
end
------------------------
-- REMOVE EXCLAMATION --
------------------------
local function clear_mark()
	Global.blackmarket_manager.new_drops = {}
end
------------------
-- GAME WRAPPER --
------------------
if inGame() then
	------------------
	-- HOST WRAPPER --
	------------------
	if isHost() then
		---------------
		-- ANTICHEAT --
		---------------
		function anticheat()
		---------------------
		-- ANTICHEAT GUARD --
		---------------------
		-- CANNOT ENABLE CARRYSTACKER UNLESS ENABLED
		-- CANNOT ENABLE IF CARRYING
		-- CANNOT DISABLE IF CARRYING
		if managers.player:is_carrying() then
		managers.mission._fading_debug_output:script().log(" DROP ALL LOOT ", Color("ea984f"))
		managers.mission._fading_debug_output:script().log(" ANTICHEAT GUARD : ", Color("a7ddf4"))
		return end
		Toggle.anticheat = not Toggle.anticheat
			if not Toggle.anticheat then
				backuper:restore('PlayerManager.verify_carry')
				backuper:restore('PlayerManager.verify_equipment')
				backuper:restore('PlayerManager.verify_grenade')
				backuper:restore('PlayerManager.register_grenade')
				backuper:restore('PlayerManager.register_carry')
				backuper:restore('UnitNetworkHandler.place_deployable')
				backuper:restore('LootManager.get_secured_bonus_bags_value')
				backuper:restore('GrenadeBase.check_time_cheat')
				backuper:restore('ProjectileBase.check_time_cheat')
				tweak_data.money_manager.max_small_loot_value = 2800000
				ChatMessage('RESTORED TO DEFAULT.', 'CHEATER TAG')
				return
			end
			backuper:backup('PlayerManager.verify_carry')
			function PlayerManager:verify_carry(peer, carry_id) return true end
			backuper:backup('PlayerManager.verify_equipment')
			function PlayerManager:verify_equipment(peer, equipment_id) return true end
			backuper:backup('PlayerManager.verify_grenade')
			function PlayerManager:verify_grenade(peer) return true end	
			backuper:backup('PlayerManager.register_grenade')
			function PlayerManager:register_grenade(peer) return true end
			backuper:backup('PlayerManager.register_carry')
			function PlayerManager:register_carry(peer, carry_id) return true end
			backuper:backup('UnitNetworkHandler.place_deployable')
			function UnitNetworkHandler:place_deployable(class_name, pos, rot, upgrade_lvl, rpc) return true end
			-- REMOVE FIRERATE CHECK BY BALDWIN AND JAZZMAN
			if ( GrenadeBase ) then
				backuper:backup('GrenadeBase.check_time_cheat')
				function GrenadeBase.check_time_cheat()return true end
			end
			if ( ProjectileBase ) then
				backuper:backup('ProjectileBase.check_time_cheat')
				function ProjectileBase.check_time_cheat()return true end
			end
			-- REMOVE SMALL LOOT CAP
			tweak_data.money_manager.max_small_loot_value = 9999999999999999
			-- ANTI PAYOUT CAP BY LAZYOZZY AND HEJORO (EDITED TO ALLOW TRULY ALLOW UNLIMITED BAGS)
			backuper:backup('LootManager.get_secured_bonus_bags_value')
			local LootManager_get_secured_bonus_bags_value = LootManager.get_secured_bonus_bags_value
			function LootManager:get_secured_bonus_bags_value(level_id, is_vehicle)
				local mandatory_bags_amount = self._global.mandatory_bags.amount or 0
				local value = 0
				for _,data in ipairs( self._global.secured ) do
					if not tweak_data.carry.small_loot[data.carry_id] and not tweak_data.carry[data.carry_id].is_vehicle == not is_vehicle then
						if mandatory_bags_amount > 0 and (self._global.mandatory_bags.carry_id == "none" or self._global.mandatory_bags.carry_id == data.carry_id) then
							mandatory_bags_amount = mandatory_bags_amount - 1
						end
						value = value + managers.money:get_bag_value(data.carry_id, data.multiplier)
					end	
				end
				return value
			end
			ChatMessage('DISABLED. YOU MAY USE CHEATS.', 'CHEATER TAG')
		end
		---------------------------
		-- MODIFIED CARRYSTACKER --
		---------------------------
		-- SOURCE CREDIT: HARFATUS/BALDWIN/SIRGOODSMOKE
		function carrystacker()
		local managers = managers
		local _debugEnabled = false
		local BagIcon = "pd2_loot"
		
		if not Toggle.anticheat then
			managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
			managers.mission._fading_debug_output:script().log(" CARRYSTACKER : ", Color("a7ddf4"))
			return
		end
		Toggle.carrystacker = not Toggle.carrystacker
		if Toggle.carrystacker and Toggle.anticheat then
		managers.mission._fading_debug_output:script().log(" ENABLED ", Color("97d04d") )
		managers.mission._fading_debug_output:script().log(" CARRYSTACKER : ", Color("a7ddf4"))
			local backup_func
				do
					local backuper = backuper
					local backup = backuper.backup
					backup_func = function( ... )
						return backup(backuper, ...)
					end
				end
				local table = table
				local tab_insert = table.insert
				local tab_remove = table.remove
				local PlayerManager = PlayerManager
				PlayerManager.carry_stack = {}
				PlayerManager.carrystack_lastpress = 0
				PlayerManager.drop_all_bags = false
				local HUDManager = HUDManager
				local ofuncs = {
					managers_player_set_carry = backup_func('PlayerManager.set_carry'),
					managers_player_drop_carry = backup_func('PlayerManager.drop_carry'),
					IntimitateInteractionExt__interact_blocked = backup_func('IntimitateInteractionExt._interact_blocked'),
					CarryInteractionExt__interact_blocked = backup_func('CarryInteractionExt._interact_blocked'),
					CarryInteractionExt_can_select = backup_func('CarryInteractionExt.can_select'),
				}
				function PlayerManager:refresh_stack_counter()
					local count = #self.carry_stack + (self:is_carrying() and 1 or 0)
					managers.hud:remove_special_equipment("carrystacker")
					if count > 0 then
						managers.hud:add_special_equipment({id = "carrystacker", icon = BagIcon, amount = count})
					end
				end
				function PlayerManager:rotate_stack(dir)
					if #managers.player.carry_stack < 1 or (#managers.player.carry_stack < 2 and not self:is_carrying()) then
						return
					end
					if self:is_carrying() then
						tab_insert(self.carry_stack, self:get_my_carry_data())
					end
					if dir == "up" then
						tab_insert(self.carry_stack, 1, tab_remove(self.carry_stack))
					else
						tab_insert(self.carry_stack, tab_remove(self.carry_stack, 1))
					end
					local cdata = tab_remove(self.carry_stack)
					if cdata then
						if self:is_carrying() then self:carry_discard() end
						ofuncs.managers_player_set_carry(self, cdata.carry_id, cdata.value or 100, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier)
					end
				end
				-- POPS AN ITEM FROM THE STACK WHEN THE PLAYER DROPS THEIR CARRIED ITEM
				function PlayerManager:drop_carry( ... ) 
					ofuncs.managers_player_drop_carry(self, ... )
					if #self.carry_stack > 0 then
						local cdata = tab_remove(self.carry_stack)
						if cdata then
							self:set_carry(cdata.carry_id, cdata.value or 100, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier)
						end
					end
					self:refresh_stack_counter()
					if self.drop_all_bags then
						if #self.carry_stack > 0 or self:is_carrying() then
							self:drop_carry()
						end
						self.drop_all_bags = false
					end
					if not Toggle.carrystacker and not Toggle.anticheat then
						if #self.carry_stack > 0 then
							self:drop_carry()
						end	
					end
				end
				-- SAVES THE CURRENT ITEM TO THE STACK IF WE'RE ALREADY CARRYING SOMETHING
				function PlayerManager:set_carry( ... )
					if self:is_carrying() and self:get_my_carry_data() then
						tab_insert(self.carry_stack, self:get_my_carry_data())
					end
					ofuncs.managers_player_set_carry(self, ...)
					self:refresh_stack_counter()
				end
				-- NEW FUNCTION TO DISCARD THE CURRENTLY CARRIED ITEM
				function PlayerManager:carry_discard()
					local wave = managers.hud
					wave:remove_teammate_carry_info( HUDManager.PLAYER_PANEL )
					wave:temp_hide_carry_bag()
					self:update_removed_synced_carry_to_peers()
					if self._current_state == "carry" then
						managers.player:set_player_state( "standard" )
					end
				end
				local IntimitateInteractionExt = IntimitateInteractionExt
				local CarryInteractionExt = CarryInteractionExt
				-- OVERRIDDEN TO PREVENT BLOCKING US FROM PICKING UP A DEAD BODY
				function IntimitateInteractionExt:_interact_blocked( player )
					if Toggle.carrystacker and self.tweak_data == "corpse_dispose" then
						if not managers.player:has_category_upgrade( "player", "corpse_dispose" ) then
							return true
						end
						return not managers.player:can_carry( "person" )
					end
					return ofuncs.IntimitateInteractionExt__interact_blocked(self, player)
				end
				-- OVERRIDDEN TO ALWAYS ALLOW US TO PICK UP A CARRY ITEM
				function CarryInteractionExt:_interact_blocked( player )
					if Toggle.carrystacker and Toggle.anticheat then
					return not managers.player:can_carry( self._unit:carry_data():carry_id() )
					end
					-- RUN THE ORIGINAL FUNCTION IF CARRYSTACKER IS OFF
					return ofuncs.CarryInteractionExt__interact_blocked(self, player)
				end
				-- OVERRIDDEN TO ALWAYS ALLOW US TO SELECT A CARRY ITEM
				function CarryInteractionExt:can_select( player )
					if Toggle.carrystacker and Toggle.anticheat then
					return CarryInteractionExt.super.can_select( self, player )
					end
					-- RUN THE ORIGINAL FUNCTION IF CARRYSTACKER IS OFF
					return ofuncs.CarryInteractionExt_can_select(self, player)
				end
				-- BAG SETTINGS (ENABLE)
				local car_arr = {'being', 'mega_heavy', 'heavy', 'medium', 'light', 'coke_light', 'very_heavy', 'explosives'}
				for i, name in ipairs(car_arr) do
					if not tweak_data.carry.types["__" .. name] then
						tweak_data.carry.types["__" .. name] = clone(tweak_data.carry.types[name])
					end
					tweak_data.carry.types[name].throw_distance_multiplier = 1.5
					tweak_data.carry.types[name].move_speed_modifier = 1
					tweak_data.carry.types[name].jump_modifier = 1
					tweak_data.carry.types[name].can_run = true
					tweak_data.carry.types.explosives.can_explode = false					
				end
				function PlayerManager:carry_blocked_by_cooldown() return false end
				-- CUSTOM FUNCTION. PUSHES A CARRIED ITEM TO STACK AND DISCARDS IT OR POPS ONE IF WE'RE NOT CARRYING ANYTHING.
				-- THIS FUNCTION IS CALLED EVERY TIME THE SCRIPT GETS RUN.
				function PlayerManager:carry_stacker()
					local cdata = self:get_my_carry_data()
					if self:is_carrying() and cdata then
						tab_insert(self.carry_stack, self:get_my_carry_data())
						self:carry_discard()
						managers.hud:present_mid_text( { title = "Carry Stack", text = cdata.carry_id .. " Pushed", time = 1 } )
					elseif #self.carry_stack > 0 then
						cdata = tab_remove(self.carry_stack)
						self:set_carry(cdata.carry_id, cdata.value, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier)
						managers.hud:present_mid_text( { title = "Carry Stack", text = cdata.carry_id .. " Popped", time = 1 } )
					else
						managers.hud:present_mid_text( { title = "Carry Stack", text = "Empty", time = 1 } )
					end
					if (Application:time() - self.carrystack_lastpress) < 0.3 and (self:is_carrying() or #self.carry_stack > 0) then
						self.drop_all_bags = true
						self:drop_carry()
					end
					self.carrystack_lastpress = Application:time()
					self:refresh_stack_counter()
				end
			else
				-- BAG SETTINGS (DISABLED)
				local car_arr = {'being', 'mega_heavy', 'heavy', 'medium', 'light', 'coke_light', 'very_heavy', 'explosives'}
				for i, name in ipairs(car_arr) do
					tweak_data.carry.types[name].can_run = false
					tweak_data.carry.types.being.move_speed_modifier = 0.5
					tweak_data.carry.types.being.jump_modifier = 0.5
					tweak_data.carry.types.being.throw_distance_multiplier = 0.5
					tweak_data.carry.types.mega_heavy.move_speed_modifier = 0.25
					tweak_data.carry.types.mega_heavy.jump_modifier = 0.25
					tweak_data.carry.types.mega_heavy.throw_distance_multiplier = 0.125
					tweak_data.carry.types.very_heavy.move_speed_modifier = 0.25
					tweak_data.carry.types.very_heavy.jump_modifier = 0.25
					tweak_data.carry.types.very_heavy.throw_distance_multiplier = 0.3
					tweak_data.carry.types.heavy.move_speed_modifier = 0.5
					tweak_data.carry.types.heavy.jump_modifier = 0.5
					tweak_data.carry.types.heavy.throw_distance_multiplier = 0.5
					tweak_data.carry.types.medium.move_speed_modifier = 0.75
					tweak_data.carry.types.medium.jump_modifier = 1
					tweak_data.carry.types.medium.throw_distance_multiplier = 1
					tweak_data.carry.types.light.move_speed_modifier = 1
					tweak_data.carry.types.light.jump_modifier = 1
					tweak_data.carry.types.light.can_run = true
					tweak_data.carry.types.light.throw_distance_multiplier = 1
					tweak_data.carry.types.coke_light.move_speed_modifier = tweak_data.carry.types.light.move_speed_modifier
					tweak_data.carry.types.coke_light.jump_modifier = tweak_data.carry.types.light.jump_modifier
					tweak_data.carry.types.coke_light.can_run = tweak_data.carry.types.light.can_run
					tweak_data.carry.types.coke_light.throw_distance_multiplier = tweak_data.carry.types.light.throw_distance_multiplier
					tweak_data.carry.types.explosives.can_explode = true
				end
				managers.mission._fading_debug_output:script().log(" DISABLED ", Color("97d04d"))
				managers.mission._fading_debug_output:script().log(" CARRYSTACKER : ", Color("a7ddf4"))
				managers.player:carry_stacker()
			end
		managers.player:carry_stacker()
		end
		---------------------
		-- VEHICLE SPAWNER --
		---------------------
		-- SOURCE CREDIT: SIRGOODSMOKE(MVP)
		-- ADDED AFTERSHOCK TRUCK
		function vehicleSpawn()
			local rr = math.random(-360,360)
			local randvrot = Rotation(rr)
			local pos = get_crosshair_pos()
			if not pos or not randvrot then return end
			-----------------
			-- VEHICLE LOT --
			-----------------
			local falcogini = "units/pd2_dlc_cage/vehicles/fps_vehicle_falcogini_1/fps_vehicle_falcogini_1"
			local Longfellow = "units/pd2_dlc_shoutout_raid/vehicles/fps_vehicle_muscle_1/fps_vehicle_muscle_1"
			local forklift = "units/pd2_dlc_arena/vehicles/fps_vehicle_forklift_2/fps_vehicle_forklift_2"
			local truck = "units/pd2_dlc_jolly/vehicles/fps_vehicle_box_truck_1/fps_vehicle_box_truck_1"
			---------------
			-- SPAWN SET --
			---------------
			if ( ovkMap == "arena" ) then	
				World:spawn_unit(Idstring(forklift), pos, randvrot)
			elseif ( ovkMap == "cage" ) then	
				World:spawn_unit(Idstring(falcogini), pos, randvrot)
			elseif ( ovkMap == "jolly" ) then
				World:spawn_unit(Idstring(truck), pos, randvrot)
				ChatMessage('DO NOT SECURE LOOT IN EXTRA TRUCK.', 'WARNING')
			elseif ( ovkMap == "shoutout_raid" ) then	
				World:spawn_unit(Idstring(Longfellow), pos, randvrot)
			else
			managers.mission._fading_debug_output:script().log(" - MELTDOWN ", Color("a7ddf4"))
			managers.mission._fading_debug_output:script().log(" - CAR SHOP ", Color("a7ddf4"))
			managers.mission._fading_debug_output:script().log(" - ALESSO HEIST ", Color("a7ddf4"))
			managers.mission._fading_debug_output:script().log(" - AFTERSHOCK ", Color("a7ddf4"))
			managers.mission._fading_debug_output:script().log(" APPROVED MAPS : ", Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
			end
		end
		------------------------
		-- SPAWN BAG FUNCTION --
		------------------------
		-- SOURCE CREDIT: SIRGOODSMOKE(MVP)
		function ServerSpawnBag(name, zipline_unit)
			local carry_data = tweak_data.carry[name]
			local player = managers.player:player_unit()
			if player then
				player:sound():play("Play_bag_generic_throw", nil, false)
			end	
			local camera_ext = player:camera()
			local dye_initiated = carry_data.dye_initiated
			local has_dye_pack = carry_data.has_dye_pack
			local dye_value_multiplier = carry_data.dye_value_multiplier
			local throw_dist_multi_upgrade_lvl = managers.player:upgrade_level("carry", "throw_distance_multiplier", 0)
			if Network:is_client() then
				managers.network:session():send_to_host("server_drop_carry", name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), player:camera():forward(), throw_dist_multi_upgrade_lvl, zipline_unit)
			else
				managers.player:server_drop_carry(name, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), player:camera():forward(), throw_dist_multi_upgrade_lvl, zipline_unit, managers.network:session():local_peer())
			end
		end
		-------------------
		-- SPAWNED ITEMS --
		-------------------
		function safes_1()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			if isPlaying() then
				ServerSpawnBag("safe_ovk")
			end
		end
		-------------------------
		-- SILENT SECURE SPAWN --
		-------------------------
		-- SOURCE CREDIT: KIDNEY
		function secure(name, amount, silent)
			if managers.loot then
				for i=1, amount do
					managers.loot:secure( name, managers.money:get_bag_value( name ), silent)
				end
			end
			managers.player:local_player():sound():say("menu_skill_investment", false, false)
			managers.mission._fading_debug_output:script().log(" SPAWNED AMOUNT : "..amount, Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" SILENTLY SECURED : ", Color("a7ddf4"))
		end
		-------------------
		-- SECURED ITEMS --
		-------------------
		-- THE KWHALI TEST
		function diamonds_1()
			if isPlaying() then
				secure("hope_diamond", 10, true)
			end
		end
		function diamonds_2()
			if isPlaying() then
				secure("hope_diamond", 50, true)
			end
		end
		-----------------------------
		-- EQUIPMENT SPAWNS (HOST) --
		-----------------------------
		-- SPAWN AMMOBAG
		function spammobag()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			local from = managers.player:player_unit():movement():m_head_pos()
			local to = from + managers.player:player_unit():movement():m_head_rot():y() * 200
			local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
			if ray then
				local position = ray.position
				local rotation = managers.player:player_unit():movement():m_head_rot()
				local rotation = Rotation( rotation:yaw(), 0, 0 )
				local peer_id = managers.network:session():local_peer():id()
				local upgrade = managers.player:upgrade_value("player", "amount_increase", 1)
				local unit_name = "units/payday2/equipment/gen_equipment_ammobag/gen_equipment_ammobag"
				local unit = World:spawn_unit(Idstring(unit_name), position, rotation, upgrade)
				managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, upgrade, peer_id or 0)
				unit:base():setup(upgrade)
			end
		end
		-- SPAWN BODYBAGS
		function spbodybag()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			local from = managers.player:player_unit():movement():m_head_pos()
			local to = from + managers.player:player_unit():movement():m_head_rot():y() * 200
			local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
			if ray then
				local position = ray.position
				local rotation = managers.player:player_unit():movement():m_head_rot()
				local rotation = Rotation( rotation:yaw(), 0, 0 )
				local peer_id = managers.network:session():local_peer():id()
				local upgrade = 0
				local unit_name = "units/payday2/equipment/gen_equipment_bodybags_bag/gen_equipment_bodybags_bag"
				local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
				managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, upgrade, peer_id or 0)
				unit:base():setup(upgrade)
			end
		end
		-- SPAWN DOCTORBAG
		function spdocbag()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			local from = managers.player:player_unit():movement():m_head_pos()
			local to = from + managers.player:player_unit():movement():m_head_rot():y() * 200
			local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
			if ray then
				local position = ray.position
				local rotation = managers.player:player_unit():movement():m_head_rot()
				local rotation = Rotation( rotation:yaw(), 0, 0 )
				local peer_id = managers.network:session():local_peer():id()
				local upgrade = managers.player:upgrade_value("player", "amount_increase", 1)
				local unit_name = "units/payday2/equipment/gen_equipment_medicbag/gen_equipment_medicbag"
				local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
				managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, upgrade, peer_id or 0)
				unit:base():setup(upgrade)
			end
		end
		-- SPAWN ECM
		function spjammer()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			local from = managers.player:player_unit():movement():m_head_pos()
			local to = from + managers.player:player_unit():movement():m_head_rot():y() * 200
			local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
			if ray then
				local position = ray.position
				local rotation = Rotation(ray.normal, math.UP)
				local player_unit = managers.player:player_unit()
				local duration_multiplier = managers.player:upgrade_value("ecm_jammer", "duration_multiplier", 1) * 2
				local unit = ECMJammerBase.spawn( position, rotation, duration_multiplier, player_unit )
				unit:base():set_active( true )
			end
		end
		-- SPAWN FIRSTAID
		function spfirstaid()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			local from = managers.player:player_unit():movement():m_head_pos()
			local to = from + managers.player:player_unit():movement():m_head_rot():y() * 200
			local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
			if ray then
				local position = ray.position
				local rotation = managers.player:player_unit():movement():m_head_rot()
				local rotation = Rotation( rotation:yaw(), 0, 0 )
				local peer_id = managers.network:session():local_peer():id()
				local upgrade = managers.player:upgrade_value("player", "first_aid_kit", 1) and 1 or 0
				local unit_name = "units/pd2_dlc_old_hoxton/equipment/gen_equipment_first_aid_kit/gen_equipment_first_aid_kit"
				local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
				managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, upgrade, peer_id or 0)
				unit:base():setup(upgrade)
			end
		end
		-- SPAWN GRENADECASE
		function spgrencase()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			local from = managers.player:player_unit():movement():m_head_pos()
			local to = from + managers.player:player_unit():movement():m_head_rot():y() * 200
			local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
			if ray then
				local position = ray.position
				local rotation = managers.player:player_unit():movement():m_head_rot()
				local rotation = Rotation( rotation:yaw(), 0, 0 )
				local peer_id = managers.network:session():local_peer():id()
				local unit_name = "units/payday2/equipment/gen_equipment_grenade_crate/gen_equipment_grenade_crate"
				local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
				managers.network:session():send_to_peers_synched("sync_unit_event_id_16", unit, "sync", 1)
			end
		end
		-- SPAWN TRIPMINE
		function sptripmine()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			local from = managers.player:player_unit():movement():m_head_pos()
			local to = from + managers.player:player_unit():movement():m_head_rot():y() * 999999
			local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
			if ray then
				local position = ray.position
				local rotation = Rotation(ray.normal, math.UP)
				local peer_id = managers.network:session():local_peer():id()
				local upgrade = managers.player:has_category_upgrade("trip_mine", "sensor_toggle")
				local unit_name = "units/payday2/equipment/gen_equipment_tripmine/gen_equipment_tripmine"
				local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
				managers.network:session():send_to_peers_synched("sync_trip_mine_setup", unit, upgrade, peer_id or 0)
				unit:base():setup(upgrade)
				unit:base():set_active(true, managers.player:player_unit())
			end
		end
		-- SPAWN SENTRY
		function spsentry()
			if not Toggle.anticheat then
				managers.mission._fading_debug_output:script().log(" DISABLE THE CHEATER TAG ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SPAWNGUARD : ", Color("a7ddf4"))
				return
			end
			local ammo_multiplier = managers.player:upgrade_value( "sentry_gun", "extra_ammo_multiplier", 1 ) * 2
			local armor_multiplier = managers.player:upgrade_value( "sentry_gun", "armor_multiplier", 1 ) * 1000
			local damage_multiplier = managers.player:upgrade_value( "sentry_gun", "damage_multiplier", 1 ) * 3
			local player_unit = managers.player:player_unit()
			local from = managers.player:player_unit():movement():m_head_pos()
			local to = from + managers.player:player_unit():movement():m_head_rot():y() * 999999
			local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
			if ray then
				local position = ray.position
				local rotation = managers.player:player_unit():movement():m_head_rot()
				local rotation = Rotation( rotation:yaw(), 0, 0 )
				local selected_index = nil
				local shield = managers.player:has_category_upgrade( "sentry_gun", "shield" )
				local unit = SentryGunBase.spawn( player_unit, position, rotation, ammo_multiplier, armor_multiplier, damage_multiplier )
				if unit then
					managers.network:session():send_to_peers_synched( "from_server_sentry_gun_place_result",
					managers.network:session():local_peer():id(), selected_index, unit, unit:movement()._rot_speed_mul,
					unit:weapon()._setup.spread_mul, shield )
				end
			end
		end
		---------------------------
		-- SENTRY OPTIONS (HOST) --
		---------------------------
		-- SENTRY GOD MODE
		function godSentry()
			Toggle.godSentry = not Toggle.godSentry
			if not Toggle.godSentry then
				backuper:restore("SentryGunDamage.damage_bullet")
				managers.mission._fading_debug_output:script().log(" GODMODE DISABLED ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SENTRY : ", Color("a7ddf4"))
				return
			end	
			backuper:backup("SentryGunDamage.damage_bullet")
			function SentryGunDamage:damage_bullet(attack_data)
			end
			managers.mission._fading_debug_output:script().log(" GODMODE ENABLED ", Color("97d04d") )
			managers.mission._fading_debug_output:script().log(" SENTRY : ", Color("a7ddf4"))
		end
		-- SENTRY INFINITE AMMO
		function infSentry()
			Toggle.infSentry = not Toggle.infSentry
			if not Toggle.infSentry then
				backuper:restore("SentryGunWeapon.fire")
				managers.mission._fading_debug_output:script().log(" INFINITE DISABLED ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" SENTRY : ", Color("a7ddf4"))
				return
			end	
			backuper:backup("SentryGunWeapon.fire")
			function SentryGunWeapon:fire(blanks, expend_ammo, shoot_player, target_unit)
				local fire_obj = self._effect_align[self._interleaving_fire]
				local from_pos = fire_obj:position()
				local direction = fire_obj:rotation():y()
				mvector3.spread(direction, tweak_data.weapon[self._name_id].SPREAD * self._spread_mul)
				World:effect_manager():spawn(self._muzzle_effect_table[self._interleaving_fire ])
				if self._use_shell_ejection_effect then
					World:effect_manager():spawn(self._shell_ejection_effect_table)
				end
				local ray_res = self:_fire_raycast(from_pos, direction, shoot_player, target_unit)
				if self._alert_events and ray_res.rays then
					RaycastWeaponBase._check_alert(self, ray_res.rays, from_pos, direction, self._unit)
				end
				return ray_res
			end
			managers.mission._fading_debug_output:script().log(" INFINITE ENABLED ", Color("97d04d") )
			managers.mission._fading_debug_output:script().log(" SENTRY : ", Color("a7ddf4"))
		end
		-----------------------------
		-- INFINITE OPTIONS (HOST) --
		-----------------------------
		-- INFINITE PAGERS
		function infPager()
			Toggle.infPager = not Toggle.infPager
			if not Toggle.infPager then
				backuper:restore("GroupAIStateBase.on_successful_alarm_pager_bluff")
				managers.mission._fading_debug_output:script().log(" INFINITE DISABLED ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" PAGERS : ", Color("FFE29D"))
				return
			end
			backuper:backup("GroupAIStateBase.on_successful_alarm_pager_bluff")
			function GroupAIStateBase:on_successful_alarm_pager_bluff()	end
			managers.mission._fading_debug_output:script().log(" INFINITE ENABLED ", Color("97d04d") )
			managers.mission._fading_debug_output:script().log(" PAGERS : ", Color("FFE29D"))
		end
		-- INFINTE ECM BATTERY
		function infECM()
			Toggle.infECM = not Toggle.infECM
			if not Toggle.infECM then
				backuper:restore("ECMJammerBase.update")
				managers.mission._fading_debug_output:script().log(" INFINITE DISABLED ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" ECM BATTERIES : ", Color("FFE29D"))
				return
			end
			backuper:backup("ECMJammerBase.update")
			function ECMJammerBase:update(unit, t, dt)
				self._battery_life = self._max_battery_life
			end
			managers.mission._fading_debug_output:script().log(" INFINITE ENABLED ", Color("97d04d") )
			managers.mission._fading_debug_output:script().log(" ECM BATTERIES : ", Color("FFE29D"))
		end
	----------------------
	-- END HOST WRAPPER --
	----------------------
	end
	-------------------------------
	-- INFINITE OPTIONS          --
	-- SOURCE CREDIT: mikethemak --
	-------------------------------
	-- INFINITE AMMO BAG USAGE
	function infAmmobag()
		Toggle.infAmmobag = not Toggle.infAmmobag
		if not Toggle.infAmmobag then
			backuper:restore("AmmoBagBase._take_ammo")
			managers.mission._fading_debug_output:script().log(" INFINITE DISABLED ", Color("ea984f"))
			managers.mission._fading_debug_output:script().log(" AMMO BAG USAGE : ", Color("FFE29D"))
			return
		end
		backuper:backup("AmmoBagBase._take_ammo")
		function AmmoBagBase:_take_ammo(unit)
			local inventory = unit:inventory()
			if inventory then
				for _,weapon in pairs( inventory:available_selections() ) do
					local took = weapon.unit:base():add_ammo_from_bag( self._ammo_amount )
				end
			end
			return 0
		end
		managers.mission._fading_debug_output:script().log(" INFINITE ENABLED ", Color("97d04d") )
		managers.mission._fading_debug_output:script().log(" AMMO BAG USAGE : ", Color("FFE29D"))
	end
	-- INFINITE DOCTOR BAG USAGE
	function infDocbag()
		Toggle.infDocbag = not Toggle.infDocbag
		if not Toggle.infDocbag then
			backuper:restore("DoctorBagBase._take")
			managers.mission._fading_debug_output:script().log(" INFINITE DISABLED ", Color("ea984f"))
			managers.mission._fading_debug_output:script().log(" DOCTOR BAG USAGE : ", Color("FFE29D"))
			return
		end
		backuper:backup("DoctorBagBase._take")
		function DoctorBagBase:_take(unit)
			unit:character_damage():recover_health()
			return 0
		end	
		managers.mission._fading_debug_output:script().log(" INFINITE ENABLED ", Color("97d04d") )
		managers.mission._fading_debug_output:script().log(" DOCTOR BAG USAGE : ", Color("FFE29D"))
	end
	-------------------
	-- ARMOR OPTIONS --
	-------------------
	function ChangeArmor(info)
		if ( managers.player:player_unit() ) then
			local armor = managers.blackmarket:equip_armor(info)
			if armor then
				managers.blackmarket:equip_armor("armors", info)
				managers.network:session():send_to_peers_synched("set_unit", managers.player:player_unit(), managers.network:session():local_peer():character(), managers.blackmarket:outfit_string(), managers.network:session():local_peer():outfit_version(), managers.network:session():local_peer():id())
				managers.dyn_resource:load(Idstring("unit"), Idstring(tweak_data.blackmarket.armors[armor.armor_id].unit), "packages/dyn_resources", false)
				managers.player:player_unit():inventory():set_character_armor(info)
			end
		end
	end
	------------------
	-- ITEM OPTIONS --
	------------------
	-- ACCESS KEYCARD (BROADCAST)
	function spackey()
		managers.player:add_special( { name = "bank_manager_key", silent = false, amount = 1 } )
		managers.hud:show_hint( { text = "KEYCARD ADDED (BROADCAST)" } )
	end
	-- ACCESS KEYCARD (CLONE)
	function clonekey()
		if isHost() and managers.player:has_special_equipment("bank_manager_key") then
			local pos = managers.player:player_unit():position()
			local rot = managers.player:player_unit():rotation()
			World:spawn_unit(Idstring("units/payday2/pickups/gen_pku_keycard/gen_pku_keycard"), pos, rot)
			managers.mission._fading_debug_output:script().log(" KEYCARD CLONED ", Color("ea984f"))
			managers.mission._fading_debug_output:script().log(" CLONING SUCCESS ", tweak_data.system_chat_color)
		else
			managers.mission._fading_debug_output:script().log(" KEYCARD REQUIRED ", Color("ea984f"))
			managers.mission._fading_debug_output:script().log(" CLONING DENIED ", tweak_data.system_chat_color)
		end
	end
	-- ACCESS KEYCARD
	function spbmkey()
		local spID = "bank_manager_key" local spUnit = "KEYCARD"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- CAUSTIC SODA
	function spcs()
		local spID = "caustic_soda" local spUnit = "CAUSTIC SODA"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- MURIATIC ACID
	function spmu()
		local spID = "acid" local spUnit = "MURIATIC ACID"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- HCL
	function sphcl()
		local spID = "hydrogen_chloride" local spUnit = "HYDROGEN CHLORIDE"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- BOARDS
	function spboard()
		if (ovkMap == "roberts") then
			local spID = "boards" local spUnit = "BOARDS"
			if managers.player:has_special_equipment(spID) then
				managers.player:remove_special(spID)
				managers.hud:show_hint( { text = spUnit.." REMOVED" } )
			else
				managers.player:add_special( { name = spID, silent = true, amount = 1 } )
				managers.hud:show_hint( { text = spUnit.." ADDED" } )
			end
		else
			managers.mission._fading_debug_output:script().log(" MAP NOT APPROVED ", Color("FFE29D"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
		end
	end
	-- BLOOD SAMPLE
	function spbloodsample()
		local spID = "blood_sample" local spUnit = "BLOOD SAMPLE"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- BLOW TORCH
	function spblowtorch()
		local spID = "blow_torch" local spUnit = "BLOW TORCH"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- CABLE-TIE
	function spcabletie()
		managers.player:add_special( { name = "cable_tie", silent = true, amount = 2 } )
		managers.hud:show_hint( { text = "CABLE TIES ADDED" } )
	end
	-- CAR KEY
	function spcarkey()
		local spID = "c_keys" local spUnit = "CAR KEYS"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- CHAINSAW
	function spchainsaw()
		local spID = "chainsaw" local spUnit = "CHAINSAW"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- CIRCULAR CUTTER
	function spcutter()
		local spID = "circle_cutter" local spUnit = "CIRCULAR CUTTER"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- CROWBAR
	function spcrowbar()
	local spID = "crowbar" local spUnit = "crowbar"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- DRILL BIT
	function spdrillfix()
		local spID = "lance_part" local spUnit = "DRILL BIT"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- FIRE EXTINGUISHER
	function spfiregush()
		local spID = "fire_extinguisher" local spUnit = "FIRE EXTINGUISHER"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- GAS
	function spgas()
		local spID = "gas" local spUnit = "GAS"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- GLASS CUTTER
	function spglasscut()
		local spID = "mus_glas_cutter" local spUnit = "GLASS CUTTER"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- HOTEL KEY
	function sphotelkey()
		local spID = "hotel_room_key" local spUnit = "HOTEL KEY"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- KEYCHAIN
	function spkeychain()
		local spID = "keychain" local spUnit = "KEYCHAIN"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- PLANKS
	function spplank()
		if not (ovkMap == "roberts") then
			local spID = "planks" local spUnit = "PLANKS"
			if managers.player:has_special_equipment(spID) then
				managers.player:remove_special(spID)
				managers.hud:show_hint( { text = spUnit.." REMOVED" } )
			else
				managers.player:add_special( { name = spID, silent = true, amount = 1 } )
				managers.hud:show_hint( { text = spUnit.." ADDED" } )
			end
		else
			managers.mission._fading_debug_output:script().log(" MAP NOT APPROVED ", Color("FFE29D"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
		end
	end
	-- SAW BLADE
	function spsaw()
		local spID = "saw" local spUnit = "SAW"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
	-- THERMAL PASTE
	function spthermite()
		local spID = "thermite_paste" local spUnit = "THERMAL PASTE"
		if managers.player:has_special_equipment(spID) then
			managers.player:remove_special(spID)
			managers.hud:show_hint( { text = spUnit.." REMOVED" } )
		else
			managers.player:add_special( { name = spID, silent = true, amount = 1 } )
			managers.hud:show_hint( { text = spUnit.." ADDED" } )
		end
	end
----------------------
-- END GAME WRAPPER --
----------------------
end
-----------------
-- FREE SKILLS --
-----------------
function freeSkill()
Toggle.freeSkill = not Toggle.freeSkill
	if not Toggle.freeSkill then
		backuper:restore('MoneyManager.get_skillpoint_cost')
		managers.mission._fading_debug_output:script().log(" RESTORED COST ", Color("ea984f"))
		managers.mission._fading_debug_output:script().log(" SKILLS : ", Color("FFE29D"))
		return
	end
	if MoneyManager then
		backuper:backup('MoneyManager.get_skillpoint_cost')
		function MoneyManager:get_skillpoint_cost(tree, tier, points) return 0 end
	end
	managers.mission._fading_debug_output:script().log(" FREE COST ", Color("97d04d") )
	managers.mission._fading_debug_output:script().log(" SKILLS : ", Color("FFE29D"))
end
------------------
-- FREE WEAPONS --
------------------
function freeWeapon()
Toggle.freeWeapon = not Toggle.freeWeapon
	if not Toggle.freeWeapon then
		backuper:restore('MoneyManager.get_weapon_price')
		backuper:restore('MoneyManager.get_weapon_price_modified')
		managers.mission._fading_debug_output:script().log(" RESTORED COST ", Color("ea984f"))
		managers.mission._fading_debug_output:script().log(" WEAPONS : ", Color("FFE29D"))
		return
	end
	if MoneyManager then
		backuper:backup('MoneyManager.get_weapon_price')
		function MoneyManager:get_weapon_price(weapon_id) return 0 end
		backuper:backup('MoneyManager.get_weapon_price_modified')
		function MoneyManager:get_weapon_price_modified(weapon_id) return 0 end
	end
	managers.mission._fading_debug_output:script().log(" FREE COST ", Color("97d04d") )
	managers.mission._fading_debug_output:script().log(" WEAPONS : ", Color("FFE29D"))
end
---------------
-- FREE MODS --
---------------
function freeMod()
Toggle.freeMod = not Toggle.freeMod
	if not Toggle.freeMod then
		backuper:restore('MoneyManage.get_weapon_modify_price')
		managers.mission._fading_debug_output:script().log(" RESTORED COST ", Color("ea984f"))
		managers.mission._fading_debug_output:script().log(" WEAPON MODS : ", Color("FFE29D"))
		return
	end
	if MoneyManager then
		backuper:backup('MoneyManage.get_weapon_modify_price')
		function MoneyManager:get_weapon_modify_price(weapon_id, part_id, global_value) return 0 end
	end
	managers.mission._fading_debug_output:script().log(" FREE COST ", Color("97d04d") )
	managers.mission._fading_debug_output:script().log(" WEAPON MODS : ", Color("FFE29D"))
end
----------------
-- RANDOMIZER --
----------------
local iota = { "... All for one and more for Bo.", "... What?! Is it forbidden?!", "... Players love it.", "... Players seem to be loving it.", "... Stat boosts are completely fine because it helps the team.", "... the outcome was never really in doubt.", "... It's that time of the month again.", "... The secret is admiring without desiring.", "... Oh moi goosh guise check out mah skins.", "... Guns, \'Murica, tits, and explosions. Maybe this game needs more tits.", "... I'm your eyes when you must steal.", "... Palms are sweaty. Knees weak arms are heavy...", "... Well, at least one person cared. But I am not that one person.", "... There will be a day when I care. BUT THAT IS NOT THIS DAY.", "... It was me, the author of all your pain. - Bo", "... Motherfuckin\' money.", "... I\'m your dream, make you real.", "... I'll smoke it with you bro. We'll go to the loony bin together.", "... goddamit, you had ONE JOB!", "... It\'s a crime of passion, not a disgruntled gamer. Everyone here is extremely gruntled.", "... I\'m sorry, I had a very different understanding as to what \'prima nocte\' meant.", "... There are five stages to grief. Denial, anger, bargaining, depression and acceptance. If I can get them depressed, then I\'ll have done my job.", "... Anyone in the world can write anything they want about any subject, so you know you are getting the best possible information. - Benjamin Franklin", "... Oh, this is gonna work out great because communicating with players is a very important part of the job, and we haven\'t been there in months.", "... Sometimes what brings the kids together is hating the lunch lady. Ashley is that lunch lady.", "... A toast to the victims of microtransactions.", "... Now introducing a new safe, schrödinger. Add some uncertainty in your life!", "... 4-8-15-16-23-42", "... You\'re not gonna believe this, because it usually never happens, but I made a mistake.", "... What the !@#$ is going on?", "... Don\'t be trippin dog we got you.", "... That\'s what she said.", "... We're either really stupid or really evil.", "... Your failures are your own, old man! I say, FOLLOW THROOOUGH!", "... WHY\'D YOU EVEN ROPE ME INTO THIS?!", "... Don\'t look at me that guy over there roped ME into this.", "... Some of us have better things to do than read forum threads, Jerry!", "... Oh no. I\'m late to class, bitch.", "... funding our other projects with your money from Payday 2." }
local rng = math.random( #iota )
-------------------
-- ADD INVENTORY --
-------------------
addinv_menu = function()
local data = {
	{ text = "ADD 1 OF ALL WEAPON MODS", callback = give_items, data = { ["type"] = "weapon_mods", ["times"] = nil}},
	{ text = "ADD 5 OF ALL WEAPON MODS", callback = give_items, data = { ["type"] = "weapon_mods", ["times"] = 5}},
	{},
	{ text = "ADD 1 OF ALL MATERIALS", callback = give_items, data = { ["type"] = "materials", ["times"] = nil}},
	{ text = "ADD 5 OF ALL MATERIALS", callback = give_items, data = { ["type"] = "materials", ["times"] = 5}},
	{},
	{ text = "ADD 1 OF ALL PATTERNS", callback = give_items, data = { ["type"] = "textures", ["times"] = nil}},
	{ text = "ADD 5 OF ALL PATTERNS", callback = give_items, data = { ["type"] = "textures", ["times"] = 5}},
	{},
	{ text = "ADD 1 OF ALL COLORS", callback = give_items, data = { ["type"] = "colors", ["times"] = nil}},
	{ text = "ADD 5 OF ALL COLORS", callback = give_items, data = { ["type"] = "colors", ["times"] = 5}},
	{},
	{ text = "ADD 1 OF ALL MASKS", callback = give_items, data = { ["type"] = "masks", ["times"] = nil}},
	{ text = "ADD 5 OF ALL MASKS", callback = give_items, data = { ["type"] = "masks", ["times"] = 5}},
	{},
	{ text = "ADD 1 OF EVERYTHING", callback = give_items, data = { ["type"] = "all", ["times"] = nil}},
	{ text = "ADD 5 OF EVERYTHING", callback = give_items, data = { ["type"] = "all", ["times"] = 5}},
	{}
	}
show_sorted_dialog("ADD TO INVENTORY MENU", ""..iota[rng], data, inventory_intro)
end
----------------------
-- REMOVE INVENTORY --
----------------------
removeinv_menu = function()
local data = {
	{ text = "CLEAR INVENTORY \[ACTIVATE\]", callback = clear_items, data = { ["type"] = "all", ["globalval"] = "all"}},
	{},
	{ text = "REMOVE ALL WEAPON MODS", callback = clear_items, data = { ["type"] = "weapon_mods", ["globalval"] = "all"}},
	{ text = "REMOVE ALL MATERIALS", callback = clear_items, data = { ["type"] = "materials", ["globalval"] = "all"}},
	{ text = "REMOVE ALL PATTERNS", callback = clear_items, data = { ["type"] = "textures", ["globalval"] = "all"}},
	{ text = "REMOVE ALL COLORS", callback = clear_items, data = { ["type"] = "colors", ["globalval"] = "all"}},
	{ text = "REMOVE ALL MASKS", callback = clear_items, data = { ["type"] = "masks", ["globalval"] = "all"}},
	{}
	}
show_sorted_dialog("REMOVE INVENTORY ITEMS MENU", ""..iota[rng], data, inventory_intro)
end
--------------------
-- EQUIPMENT MENU --
--------------------
equipment_menu = function()
	if isHost() then
		equipment_menu_A()
	else
		managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
		managers.mission._fading_debug_output:script().log(' EQUIPMENT CHEATS : ', Color('ffc300') )
	end
end
equipment_menu_A = function()
local data = {
	{ text = "CARRY STACKER \[TOGGLE\]", callback = carrystacker },
	{},
	{ text = "SPAWN AMMO BAG", callback = spammobag },
	{ text = "SPAWN DOCTOR BAG", callback = spdocbag },
	{ text = "SPAWN FIRST AID", callback = spfirstaid },
	{},
	{ text = "SPAWN ECM", callback = spjammer },
	{ text = "SPAWN TRIP MINE", callback = sptripmine },
	{ text = "SPAWN SENTRY GUN", callback = spsentry },
	{},
	{ text = "SPAWN BODY BAG", callback = spbodybag },
	{ text = "SPAWN GRENADE CASE", callback = spgrencase },
	{}
	}
show_sorted_dialog("EQUIPMENT CHEATS", ""..iota[rng], data, inventory_game)
end
----------------
-- SPAWN MENU --
----------------
spawn_menu = function()
	if isHost() then
		spawn_menu_A()
	else
		managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
		managers.mission._fading_debug_output:script().log(' SPAWN OPTIONS : ', Color('ffc300') )
	end
end
spawn_menu_A = function()
local data = {
	{ text = "VEHICLE SPAWNER \[CREATE\]", callback = vehicleSpawn },
	{},
	{ text = "SPAWN 1 VLAD SAFE (FOR EMERGENCIES) \[SPAWN\]", callback = safes_1 },
	{},
	{ text = "10 KWHALI DIAMONDS \[SECURE\]", callback = diamonds_1 },
	{ text = "50 KWHALI DIAMONDS \[SECURE\]", callback = diamonds_2 },
	{}
	}
show_sorted_dialog("SPAWN MODIFERS \[BETA\]", "... Temptations abound.", data, inventory_game)
end
-------------------
-- INFINITE MENU --
-------------------
infinite_menu = function()
	if isHost() then
		infinite_menu_A()
	else
		infinite_menu_B()
	end
end
infinite_menu_A = function()
local data = {
	{ text = "INFINITE AMMO BAG USE \[TOGGLE\]", callback = infAmmobag },
	{ text = "INFINITE DOCTOR BAG USE \[TOGGLE\]", callback = infDocbag },
	{ text = "INFINITE ECM BATTERY \[TOGGLE\]", callback = infECM},
	{ text = "INFINITE PAGER LIMITS \[TOGGLE\]", callback = infPager },
	{}
	}
show_sorted_dialog("INFINITE SETTINGS \[HOST\]", ""..iota[rng], data, inventory_game)
end
infinite_menu_B = function()
local data = {
	{ text = "INFINITE AMMO BAG USE \[TOGGLE\]", callback = infAmmobag },
	{ text = "INFINITE DOCTOR BAG USE \[TOGGLE\]", callback = infDocbag },
	{}
	}
show_sorted_dialog("INFINITE SETTINGS \[CLIENT\]", ""..iota[rng], data, inventory_game)
end
----------------
-- ARMOR MENU --
----------------
armor_menu = function()
local data = {
	{ text = "TWO-PIECE SUIT", callback = ChangeArmor, data = 'level_1' },
	{ text = "LIGHTWEIGHT BALLISTIC VEST", callback = ChangeArmor, data = 'level_3' },
	{ text = "BALLISTIC VEST", callback = ChangeArmor, data = 'level_2' },
	{ text = "HEAVY BALLISTIC VEST", callback = ChangeArmor, data = 'level_4' },
	{ text = "FLAK JACKET", callback = ChangeArmor, data = 'level_5' },
	{ text = "COMBINED TACTICAL VEST", callback = ChangeArmor, data = 'level_6' },
	{ text = "IMPROVED COMBINED TACTICAL VEST", callback = ChangeArmor, data = 'level_7' },
	{}
	}
	show_sorted_dialog("CHANGE ARMOR", ""..iota[rng], data, inventory_game)
end
---------------
-- ITEM MENU --
---------------
item_menu = function()
local data = {
	{ text = "ADD KEYCARD \[TOGGLE\]", callback = spbmkey },
	{ text = "ADD KEYCHAIN \[TOGGLE\]", callback = spkeychain },
	{ text = "ADD CAR KEY \[TOGGLE\]", callback = spcarkey },
	{},
	{ text = "ADD HYDROGEN CHLORIDE \[TOGGLE\]", callback = sphcl },
	{ text = "ADD CAUSTIC SODA \[TOGGLE\]", callback = spcs },
	{ text = "ADD MURIATIC ACID \[TOGGLE\]", callback = spmu },
	{},
	{ text = "ADD CABLETIE \[2X\]", callback = spcabletie },
	{ text = "ADD THERMITE PASTE \[TOGGLE\]", callback = spthermite },
	{ text = "ADD CROWBAR \[TOGGLE\]", callback = spcrowbar },
	{},
	{ text = "ADD GLASS CUTTER \[TOGGLE\]", callback = spglasscut },
	{ text = "ADD CIRCULAR CUTTER \[TOGGLE\]", callback = spcutter },
	{ text = "ADD SAW \[TOGGLE\]", callback = spsaw },
	{ text = "ADD GAS \[TOGGLE\]", callback = spgas },
	{},
	{},
	{ text = "ADD FIRE EXTINGUISHER \[TOGGLE\]", callback = spfiregush },
	{ text = "ADD BOARDS \[TOGGLE\]", callback = spboard },
	{ text = "ADD PLANKS \[TOGGLE\]", callback = spplank },
	{ text = "ADD CHAINSAW \[TOGGLE\]", callback = spchainsaw },
	{ text = "ADD DRILL BIT \[TOGGLE\]", callback = spdrillfix },
	{ text = "ADD HOTEL KEY \[TOGGLE\]", callback = sphotelkey },
	{ text = "ADD BLOOD SAMPLE \[TOGGLE\]", callback = spbloodsample },
	{}
	}
show_sorted_dialog("ADD OR REMOVE MISSION ITEMS", ""..iota[rng], data, inventory_game)
end
------------------
-- SETTING MENU --
------------------
setting_menu = function()
local data = {
	{ text = "UNLOCK ALL WEAPONS \[ACTIVATE\]", callback = unlock_items, data = "weapons" },
	{ text = "UNLOCK ALL SLOTS \[ACTIVATE\]", callback = unlock_slots },
	{},
	{ text = "FREE WEAPON COST \[TOGGLE\]", callback = freeWeapon },
	{ text = "FREE WEAPON MOD COST \[TOGGLE\]", callback = freeMod },
	{ text = "FREE SKILL COST \[TOGGLE\]", callback = freeSkill },
	{}
	}
	show_sorted_dialog("INVENTORY SETTINGS", ""..iota[rng], data, inventory_intro)
end
----------------
-- INTRO MENU --
----------------
inventory_intro = function()
local data = {
	{ text = "CLEAR EXCLAMATION \[!\] MARK", callback = clear_mark },
	{},
	{ text = "REMOVE INVENTORY ITEMS \[MENU\]", callback = removeinv_menu },
	{ text = "ADD INVENTORY ITEMS \[MENU\]", callback = addinv_menu },
	{},
	{ text = "INVENTORY SETTINGS \[MENU\]", callback = setting_menu },
	{}
	}
	show_sorted_dialog("OVERKILL INVENTORY FUNCTIONS", ""..iota[rng], data, nil)
end
----------------
-- LOBBY MENU --
----------------
inventory_lobby = function()
	local data = {}
	show_sorted_dialog("OVERKILL INVENTORY DISABLED", ""..iota[rng], data, nil)
end
---------------
-- GAME MENU --
---------------
inventory_game = function()
	if isHost() then
		inventory_game_A()
	else
		inventory_game_B()
	end
end
inventory_game_A = function()
local data = {
	{ text = "CLONE ACCESS CARD", callback = clonekey },
	{ text = "ADD ACCESS CARD \[BROADCAST\]", callback = spackey },
	{ text = "DISABLE CHEATER TAG \[TOGGLE\]", callback = anticheat },
	{},
	{ text = "ADD MISSION ITEMS \[MENU\]", callback = item_menu },
	{ text = "INFINITE SETTINGS \[MENU\]", callback = infinite_menu },
	{ text = "CHANGE ARMOR \[MENU\]", callback = armor_menu },
	{ text = "EQUIPMENT CHEATS \[MENU\]", callback = equipment_menu },
	{ text = "SPAWN MODIFIERS \[MENU\]", callback = spawn_menu },
	{},
	{ text = "SENTRY INFINITE AMMO \[TOGGLE\]", callback = infSentry },
	{ text = "SENTRY GOD MODE \[TOGGLE\]", callback = godSentry },
	{}
	}
	show_sorted_dialog("OVERKILL INVENTORY FUNCTIONS [HOST]", ""..iota[rng], data, nil)
end
inventory_game_B = function()
local data = {
	{ text = "ADD ACCESS CARD \[BROADCAST\]", callback = spackey },
	{},
	{ text = "ADD MISSION ITEMS \[MENU\]", callback = item_menu },
	{ text = "INFINITE SETTINGS \[MENU\]", callback = infinite_menu },
	{ text = "CHANGE ARMOR \[MENU\]", callback = armor_menu },
	{}
	}
	show_sorted_dialog("OVERKILL INVENTORY FUNCTIONS [CLIENT]", ""..iota[rng], data, nil)
end
-------------------
-- MENU DIRECTOR --
-------------------
if not inGame() and _cheatToggle then
	inventory_intro()
elseif inGame() and not isPlaying() and _cheatToggle and not inChat() then
	inventory_lobby()
elseif inGame() and isPlaying() and _cheatToggle and not inChat() then
	inventory_game()
end