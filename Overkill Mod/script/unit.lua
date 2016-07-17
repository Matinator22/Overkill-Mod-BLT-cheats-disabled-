------------------------------------
-- FOR KNOWLEDGEABLE USERS ONLY ----
------------------------------------
--===========================--
--       OVERKILL MOD        --
--           UNIT            --
--  (NOT READY FOR RELEASE)  --
--===========================--
-- r2.2 
if inGame() and not inChat() then
	---------------------
	-- UNIT ID SCANNER --
	---------------------
	-- SOURCE CREDIT: LAZYOZZY, BFLAT
	-- MEMO: With help from Ozzy, this is a scanner to help me gather unit IDs.
	-- By simply pointing at the loot item, it will show the unitID and name.
	local player_unit = managers.player:player_unit()
	local mvec_to = Vector3()
	mvector3.set(mvec_to, player_unit:camera():forward())
	mvector3.multiply(mvec_to, 20000)
	mvector3.add(mvec_to, player_unit:camera():position())
	local ray = World:raycast('ray', player_unit:camera():position(), mvec_to, 'slot_mask', World:make_slot_mask(14))
	if ray then
		local v = ray.unit
		if v then
			local file = io.open("mods/Overkill Mod/mission/unit/UnitID.txt", "a")
			managers.mission._fading_debug_output:script().log(""..tostring(v:carry_data():carry_id()), Color("a7ddf4"))
			ChatMessage( tostring( v:name() ) , '['..tostring(v:carry_data():carry_id())..']' )
			file:write(" [ "..tostring(v:carry_data():carry_id()).." ] "..' '.." [ "..tostring(v:name()).." ] ".."\n")
			file:close()
		end
	else
		managers.mission._fading_debug_output:script().log("NOTHING SCANNED", Color("a7ddf4"))
	end
end
-----------
-- NOTES --
-----------
--[[
-- A LOOP THAT ITERATES OVER A TABLE
for _,v in pairs(managers.interaction._interactive_units) do
	if v:interaction().tweak_data == 'carry_drop' then
		local carry_data = v:carry_data()
		if(carry_data) then
			local file = io.open("mods/Overkill Mod/mission/UnitID.txt", "a")
			file:write("["..tostring(carry_data:carry_id()).."]".."\n")
			file:close()
		end
	end
end
-- SHORTHAND METHOD --
local carry_id = carry_data._carry_id
carry_data:carry_id()
]]