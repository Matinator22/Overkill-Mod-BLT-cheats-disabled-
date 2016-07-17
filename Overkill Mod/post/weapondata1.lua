--============================--
--        OVERKILL MOD        --
--        WEAPON TWEAK        --
--============================--
-- lib/tweak_data/weapontweakdata
-- r2.2
if RequiredScript == 'lib/tweak_data/weapontweakdata' then
	local old_init = WeaponTweakData.init
	function WeaponTweakData:init(tweak_data)
		old_init(self, tweak_data)
		--=============================--
		-- DO NOT EDIT ABOVE THIS LINE --
		--=============================--
		--------------------------
		-- BIPOD PITCH SETTINGS --
		--------------------------
		-- DEPLOY LMG AND TURN WITH 90 DEG. FREEDOM
		-- DEFAULT 15 DEGREES
		self.hk21.bipod_camera_spin_limit = 90
		self.hk21.bipod_camera_pitch_limit = 90
		self.m249.bipod_camera_spin_limit = 90
		self.m249.bipod_camera_pitch_limit = 90
		self.rpk.bipod_camera_spin_limit = 90
		self.rpk.bipod_camera_pitch_limit = 90
		self.mg42.bipod_camera_spin_limit = 90
		self.mg42.bipod_camera_pitch_limit = 90
		self.par.bipod_camera_spin_limit = 90
		self.par.bipod_camera_pitch_limit = 90
		----------------------------------
		-- BULLET PENETRATION By gir489 --
		----------------------------------
		--[[
		for k, v in pairs(self) do
			if type(v) == "table" and v.category then
				self[k].can_shoot_through_shield = true
				self[k].can_shoot_through_enemy = true
				self[k].can_shoot_through_wall = false
			end
		end
		]]--
		-------------
		-- MINIGUN --
		-------------
		-- VULCAN MINIGUN
		self.m134.armor_piercing_chance = 1
		self.m134.can_shoot_through_enemy = true
		self.m134.can_shoot_through_wall = true
		self.m134.can_shoot_through_shield = true
		-------------
		-- PISTOLS --
		-------------
		-- AKIMBO DEAGLE
		self.x_deagle.armor_piercing_chance = 1
		self.x_deagle.can_shoot_through_enemy = true
		self.x_deagle.can_shoot_through_wall = false
		self.x_deagle.can_shoot_through_shield = true
		
		-- BABY DEAGLE (AKA SPARROW)
		self.sparrow.armor_piercing_chance = 1
		self.sparrow.can_shoot_through_enemy = true
		self.sparrow.can_shoot_through_wall = false
		self.sparrow.can_shoot_through_shield = true
		
		-- BRONCO .44
		self.new_raging_bull.armor_piercing_chance = 1
		self.new_raging_bull.can_shoot_through_enemy = true
		self.new_raging_bull.can_shoot_through_wall = false
		self.new_raging_bull.can_shoot_through_shield = true

		-- BROOMSTICK
		self.c96.armor_piercing_chance = 1
		self.c96.can_shoot_through_enemy = true
		self.c96.can_shoot_through_wall = false
		self.c96.can_shoot_through_shield = true
		
		-- DEAGLE
		self.deagle.armor_piercing_chance = 1
		self.deagle.can_shoot_through_enemy = true
		self.deagle.can_shoot_through_wall = false
		self.deagle.can_shoot_through_shield = true
		
		-- PEACEMAKER .45
		self.peacemaker.armor_piercing_chance = 1
		self.peacemaker.can_shoot_through_enemy = true
		self.peacemaker.can_shoot_through_wall = false
		self.peacemaker.can_shoot_through_shield = true

		-- MATEVER .357
		self.mateba.armor_piercing_chance = 1
		self.mateba.can_shoot_through_enemy = true
		self.mateba.can_shoot_through_wall = false
		self.mateba.can_shoot_through_shield = true
		
		------------
		-- RIFLES --
		------------
		-- EAGLE HEAVY
		self.scar.can_shoot_through_shield = true
		
		-- GEWEHR 3
		self.g3.can_shoot_through_shield = true
		
		-- M308
		self.new_m14.can_shoot_through_shield = true

	end
end