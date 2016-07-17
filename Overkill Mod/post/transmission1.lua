--=====================================--
--            OVERKILL MOD             --
--       METH INGREDIENT DIALOG        --
--             by gir489               --
--=====================================--
-- lib/managers/DialogManager
-- r2.1
--------------------
-- DIALOG MANAGER --
--------------------
local kek = Color("ffff66")
local transmission_dialog = {}
transmission_dialog["pln_rt1_20"] = "ADD MURIATIC ACID"
transmission_dialog["pln_rt1_22"] = "ADD CAUSTIC SODA"
transmission_dialog["pln_rt1_24"] = "ADD HYDROGEN CHLORIDE"
transmission_dialog["pln_rat_stage1_20"] = "ADD MURIATIC ACID"
transmission_dialog["pln_rat_stage1_22"] = "ADD CAUSTIC SODA"
transmission_dialog["pln_rat_stage1_24"] = "ADD HYDROGEN CHLORIDE"
transmission_dialog["Play_pln_at1_gen_13"] = "INCOMING ESCAPE CHOPPER"
transmission_dialog["pln_esc_fixed_heli"] = "INCOMING ESCAPE CHOPPER"
transmission_dialog["Play_pln_at1_gen_11"] = "INCOMING ESCAPE VAN"
transmission_dialog["pln_esc_fixed_van"] = "INCOMING ESCAPE VAN"
transmission_dialog["Play_pln_at1_gen_12"] = "INCOMING ESCAPE BOAT"

local _queue_dialog_orig = DialogManager.queue_dialog
function DialogManager:queue_dialog(id, ...)
	if transmission_dialog[id] then
		managers.mission._fading_debug_output:script().log(' - '..transmission_dialog[id], kek)
	end
	return _queue_dialog_orig(self, id, ...)
end