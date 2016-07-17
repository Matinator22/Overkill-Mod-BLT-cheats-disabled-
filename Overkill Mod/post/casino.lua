--=========================--
--      OVERKILL MOD       --
--  FORCE OFFSHORE CASINO  --
--       by Dotcom7        --
--=========================--
-- r2.1
if RequiredScript == "lib/tweak_data/guitweakdata" then
	if not casino then 
		casino = GuiTweakData.init 
	end
	function GuiTweakData:init()
		casino(self)
		table.insert(self.crime_net.special_contracts,{
		id = "casino",
		name_id = "menu_cn_casino",
		desc_id = "menu_cn_casino_desc",
		menu_node = "crimenet_contract_casino",
		x = 680,
		y = 905,
		icon = "guis/textures/pd2/crimenet_casino",
		unlock = "unlock_level",
		pulse = true,
		pulse_color = Color(204, 255, 209, 32) / 255 })
	end
end