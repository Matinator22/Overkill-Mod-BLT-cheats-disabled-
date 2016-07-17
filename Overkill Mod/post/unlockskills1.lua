--====================--
--    OVERKILL MOD    --
--====================--
-- r2.1
--============================--
-- FORCESKILL By sirgoodsmoke --
--============================--
-- lib/tweak_data/skilltreetweakdata (postrequire)
-- THESE SKILLS WILL REMAIN HIDDEN AND WILL NOT SHOW UP ON YOUR SKILL TREE.
-- REMOVE THE ' -- ' (UNCOMMENT) TO ENABLE THE SKILLS.
local old_init = SkillTreeTweakData.init
function SkillTreeTweakData:init()
old_init(self)
self.default_upgrades = {
	--==================================--
	-- DO NOT DELETE THESE SKILLS BELOW --
	--==================================--
	"cable_tie",
	"player_special_enemy_highlight",
	"player_hostage_trade",
	"player_sec_camera_highlight",
	"player_corpse_dispose",
	"player_corpse_dispose_amount_1",
	"player_civ_harmless_melee",
	"striker_reload_speed_default",
	"temporary_first_aid_damage_reduction",
	"temporary_passive_revive_damage_reduction_2",
	--================================--
	-- DO NOT DELETE THE SKILLS ABOVE --
	--================================--
	--=================================--
	-- ADD YOUR SKILLS BELOW THIS LINE --
	--=================================--
	-- BSC SMG SPECIALIST
	"smg_reload_speed_multiplier",
	
	-- BSC SHOTGUN CQB
	"shotgun_reload_speed_multiplier",
	
	-- ACD FULLY LOADED
	"player_pick_up_ammo_multiplier",
	"player_pick_up_ammo_multiplier_2",
	
	-- BSC PUMPING IRON
	"player_non_special_melee_multiplier",
	
	-- ACD PUMPING IRON
	"player_melee_damage_multiplier",
	
	-- BSC DEAD PRESIDENTS
	"player_small_loot_multiplier1",
	
	-- ACD DEAD PRESIDENTS
	"player_small_loot_multiplier2",
	
	-- BSC STOCKHOLM SYNDROME
	"player_civilian_reviver",
	
	-- BSC MARTIAL ARTS
	"player_melee_knockdown_mul",
	
	-- ACD MARTIAL ARTS
	"player_melee_damage_dampener",
	
	-- ACD COUNTERSTRIKE
	"player_counter_strike_spooc",
	
	-- ACD SIXTH SENSE
	"player_mask_off_pickup",
	
	-- MOVING TARGET
	"player_can_strafe_run",
	"player_can_free_run",
	
	-- SENTRY
	"sentry_gun_can_reload",
	"sentry_gun_shield",
	"sentry_gun_quantity_increase",
	"sentry_gun_damage_multiplier",
	"sentry_gun_armor_multiplier",

	-- ACD DARE DEVIL
	"player_on_zipline_dodge_chance"	
}
end