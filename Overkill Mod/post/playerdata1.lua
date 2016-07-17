--============================--
--        OVERKILL MOD        --
--        PLAYER TWEAK        --
--============================--
-- lib/tweak_data/playertweakdata
if RequiredScript == 'lib/tweak_data/playertweakdata' then
	local old_init = PlayerTweakData.init
	function PlayerTweakData:init(tweak_data)
		old_init(self, tweak_data)
		--=============================--
		-- DO NOT EDIT ABOVE THIS LINE --
		--=============================--
		-----------------------------
		-- BIPOD FOV ZOOM SETTINGS --
		-----------------------------
		-- DEPLOY LMG AND IT WILL ZOOM
		-- DEFAULT FOV 50
		self.stances.mg42.bipod.FOV = 20
		self.stances.m249.bipod.FOV = 20
		self.stances.rpk.bipod.FOV = 20
		self.stances.hk21.bipod.FOV = 20
		self.stances.par.bipod.FOV = 20
	end 
end