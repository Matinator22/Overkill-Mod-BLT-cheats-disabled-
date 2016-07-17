--================================--
--          OVERKILL MOD          --
--     GLOBAL PERSIST SCRIPTS     --
--================================--
-- r2.2
---------------
-- FAST MASK --
---------------
if ovkmenu._data.fastmask then
	if not _fastMask then
		tweak_data.player.put_on_mask_time = 0.4
		_fastMask = true
	end
end
----------------
-- LASERLIGHT --
----------------
if not _colorSight then
	if WeaponLaser then
		local weapon_laser_update_orig = WeaponLaser.update
		function WeaponLaser:update(unit, t, dt)
		weapon_laser_update_orig(self, unit, t, dt)
			self._themes.red = {
				light = Color(255, 0, 0) * 10,
				glow = Color(255, 0, 0) / 2,
				brush = Color(0.1, 0.3, 0, 0)
			}
			self._themes.blue = {
				light = Color(0, 0, 255) * 10,
				glow = Color(0, 0, 255) / 2,
				brush = Color(0.3, 0, 0, 0.3)
			}	
			self._themes.yellow = {
				light = Color(255, 239, 0) * 10,
				glow = Color(255, 239, 0) / 2,
				brush = Color(0.1, 0.3, 0.3, 0)
			}
			self._themes.white = {
				light = Color(255, 250, 250) * 10,
				glow = Color(255, 250, 250) / 2,
				brush = Color(0.1, 0.3, 0.3, 0.3)
			}
			self._themes.purple = {
				light = Color(128, 0, 128) * 10,
				glow = Color(128, 0, 128) / 2,
				brush = Color(0.1, 0.3, 0, 0.3)
			}
			self._themes.rainbowlaser = {
				light = Color(math.sin(135 * t + 0) / 2 + 0.5, math.sin(140 * t + 60) / 2 + 0.5, math.sin(145 * t + 120) / 2 + 0.5) * 10,
				glow = Color(math.sin(135 * t + 0) / 2 + 0.5, math.sin(140 * t + 60) / 2 + 0.5, math.sin(145 * t + 120) / 2 + 0.5) / 2,
				brush = Color(0.1, math.sin(135 * t + 0) / 2 + 0.5, math.sin(140 * t + 60) / 2 + 0.5, math.sin(145 * t + 120) / 2 + 0.5)
			}
			if ovkmenu._data.laserColor == 1 then
			self:set_color_by_theme("default")
			elseif ovkmenu._data.laserColor == 2 then
			self:set_color_by_theme("red")
			elseif ovkmenu._data.laserColor == 3 then
			self:set_color_by_theme("blue")
			elseif ovkmenu._data.laserColor == 4 then
			self:set_color_by_theme("yellow")
			elseif ovkmenu._data.laserColor == 5 then
			self:set_color_by_theme("white")
			elseif ovkmenu._data.laserColor == 6 then
			self:set_color_by_theme("purple")
			elseif ovkmenu._data.laserColor == 7 then
			self:set_color_by_theme("rainbowlaser")
			end
		end
	end
_colorSight = true
end
----------------
-- FLASHLIGHT --
----------------
if not _colorLight then
	if WeaponFlashLight then
		function WeaponFlashLight:update(unit, t, dt)
			self._light:set_far_range(1000)
			self._light:set_color(Color.white)
			if ovkmenu._data.flashRange == 2 then
				self._light:set_far_range(2000)
			end
			if ovkmenu._data.flashColor == 2 then
				self._light:set_color(Color.red)
			elseif ovkmenu._data.flashColor == 3 then
				self._light:set_color(Color.blue)
			elseif ovkmenu._data.flashColor == 4 then
				self._light:set_color(Color.yellow)
			elseif ovkmenu._data.flashColor == 5 then
				self._light:set_color(Color.green)
			elseif ovkmenu._data.flashColor == 6 then
				self._light:set_color(Color.purple)
			elseif ovkmenu._data.flashColor == 7 then
				self._light:set_color(Color(math.sin(135 * t + 0) / 2 + 0.5, math.sin(140 * t + 60) / 2 + 0.5, math.sin(145 * t + 120) / 2 + 0.5) * 10)
			end
		end
		local weaponflashlight__check_state_original = WeaponFlashLight._check_state
		function WeaponFlashLight:_check_state()
			self._unit:set_extension_update_enabled(Idstring("base"), self._on)
			return weaponflashlight__check_state_original(self)
		end
	end
	_colorLight = true
end
------------------------
-- FIRE MODE ANTILOCK --
------------------------
if ovkmenu._data.firemode then
	if not _fireMode then
		tweak_data.weapon.factory.parts.wpn_fps_upg_i_singlefire.perks = {}
		tweak_data.weapon.factory.parts.wpn_fps_upg_i_autofire.perks = {}
		_fireMode = true
	end
end
----------------------
-- DRILL AUTOREPAIR --
----------------------
if ovkmenu._data.autorepair then
	if not _autoRepair then
		tweak_data.upgrades.values.player.drill_autorepair = {1.0}
	_autoRepair = true
	end
end
--------------
-- EXP HEAT --
--------------
if ovkmenu._data.xpheat then
	if not _xpHeat then
		if Global.job_manager then
			function JobManager:heat_to_experience_multiplier(heat)
				return 1.15 -- DEFAULT MAX 115%
			end
			for k,v in pairs(Global.job_manager.heat) do
				managers.job:set_job_heat(k, 500)
			end
		end
	_xpHeat = true
	end
end
------------------
-- DLC UNLOCKER --
------------------
if ovkmenu._data.dlc then
	if not _runDLC then
		if WINDLCManager then
			for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
				dlc_data.verified = true
			end
		end
	_runDLC = true
	end
end
-------------------
-- SKIN UNLOCKER --
-------------------
-- SOURCE CREDIT: Simplity (Pirate Perfection)
if ovkmenu._data.skin then
	if not _runSkin then
		if Global.blackmarket_manager then
			local M_blackmarket = managers.blackmarket
			local weapon_skins = tweak_data.blackmarket.weapon_skins
			local i = 1
			for id, data in pairs( weapon_skins ) do
				while M_blackmarket._global.inventory_tradable[i] ~= nil do
					i = i + 1
				end
				if ovkmenu._data.skin and not M_blackmarket:have_inventory_tradable_item( "weapon_skins", id ) then
					M_blackmarket:tradable_add_item( i, "weapon_skins", id, "mint", true, 1 )
				end
			end
			function BlackMarketManager:tradable_update() end
			function GuiTweakData:tradable_inventory_sort_func(index)
				-- temp fix
				return nil
			end
		end
	_runSkin = true
	end
end
--------------------
-- INFAMY SPOOFER --
--------------------
-- 	managers.network:session():send_to_peers_loaded("sync_profile", level, rank)
if networkpeer then
	local send_after_load_orig = NetworkPeer.send_after_load
	function NetworkPeer:send_after_load(type, level, rank, ...)
		if type == "sync_profile" or type == "lobby_info" then
			if ovkmenu._data.spoof == 2 then
				return send_after_load_orig(self, type, level, 5, ...)
			elseif ovkmenu._data.spoof == 3 then
				return send_after_load_orig(self, type, level, 10, ...)
			elseif ovkmenu._data.spoof == 4 then
				return send_after_load_orig(self, type, level, 12, ...)
			elseif ovkmenu._data.spoof == 5 then
				return send_after_load_orig(self, type, level, 15, ...)
			elseif ovkmenu._data.spoof == 6 then
				return send_after_load_orig(self, type, level, 18, ...)
			elseif ovkmenu._data.spoof == 7 then
				return send_after_load_orig(self, type, level, 20, ...)
			elseif ovkmenu._data.spoof == 8 then
				return send_after_load_orig(self, type, level, 24, ...)
			elseif ovkmenu._data.spoof == 9 then
				return send_after_load_orig(self, type, level, 25, ...)
			else
				return send_after_load_orig(self, type, level, rank, ...)
			end
		end
		return send_after_load_orig(self, type, level, rank, ...)
	end
end
---------------------
-- STEAM STATBLOCK --
---------------------
-- function NetworkAccountSTEAM:publish_statistics()
if ovkmenu._data.stats == 2 then
	if not _blckStat then
		function StatisticsManager:publish_to_steam(...)
			log("\[STEAM\] PUBLIC STAT BLOCKED!\n")end
	_blckStat = true
	end
end
--------------------
-- LMG IRONSIGHTS --
--------------------
if ovkmenu._data.rpk_vf then
	if not _rpk then
		local pivot_shoulder_translation = Vector3(10.6725, 27.7166, -4.93564)
		local pivot_shoulder_rotation = Rotation(0.1067, -0.0850111, 0.629008)
		local pivot_head_translation = Vector3(0, 28, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
			tweak_data.player.stances[ "rpk" ].steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
			tweak_data.player.stances[ "rpk" ].steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	_rpk = true
	end
end
if ovkmenu._data.m249_vf then
	if not _m249 then
		local pivot_shoulder_translation = Vector3(10.7806, 4.38612, -0.718837)
		local pivot_shoulder_rotation = Rotation(0.106596, -0.0844502, 0.629187)
		local pivot_head_translation = Vector3(0, 12, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
			tweak_data.player.stances[ "m249" ].steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
			tweak_data.player.stances[ "m249" ].steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	_m249 = true
	end
end
if ovkmenu._data.buzz_vf then
	if not _buzz then
		local pivot_shoulder_translation = Vector3(10.713, 47.8277, 0.873785)
		local pivot_shoulder_rotation = Rotation(0.10662, -0.0844545, 0.629209)
		local pivot_head_translation = Vector3(0, 40, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
			tweak_data.player.stances[ "mg42" ].steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
			tweak_data.player.stances[ "mg42" ].steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	_buzz = true
	end
end
if ovkmenu._data.par_vf then
	if not _par then
		local pivot_shoulder_translation = Vector3(10, 4, -4)
		local pivot_shoulder_rotation = Rotation(0.106596, -0.0844502, 0.629187)
		local pivot_head_translation = Vector3(0, 12, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
			tweak_data.player.stances[ "par" ].steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
			tweak_data.player.stances[ "par" ].steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	_par = true
	end
end
if ovkmenu._data.bren_vf then
	if not _bren then
		local pivot_shoulder_translation = Vector3(8.59464, 11.3996, -3.26142)
		local pivot_shoulder_rotation = Rotation(7.08051E-6, 0.00559065, 3.07211E-4)
		local pivot_head_translation = Vector3(0, 10, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
			tweak_data.player.stances[ "hk21" ].steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
			tweak_data.player.stances[ "hk21" ].steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	_bren = true
	end
end