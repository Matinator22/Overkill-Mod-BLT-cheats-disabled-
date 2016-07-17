------------------------------------
-- FOR KNOWLEDGEABLE USERS ONLY ----
------------------------------------
--=======================--
--     OVERKILL MOD      --
--         DATA          --
--=======================--
-- r2.1
if inGame() and not inChat() then
	----------
	-- FILE --
	----------
	local mission = tostring(managers.job:current_level_id())
	local file = io.open("mods/Overkill Mod/mission/data/"..mission..".txt", "w")
	-------------
	-- MSG TXT --
	-------------
	DATAMINE = not (DATAMINE or false)
	if DATAMINE then
		managers.mission._fading_debug_output:script().log(' PLEASE PRESS AGAIN ... ', Color("97d04d") )
		managers.mission._fading_debug_output:script().log(' DATA : '..mission..'\.txt',  tweak_data.system_chat_color)
	else
		managers.mission._fading_debug_output:script().log(' FILE SAVED TO MISSION FOLDER! ', Color.Orange )
		managers.mission._fading_debug_output:script().log(' DATA : '..mission..'\.txt',  tweak_data.system_chat_color)
		beep()
	end
	--------------------
	-- FUNCTION PRINT --
	--------------------
	local function print_w (t, file,  indent)
	local indent = indent or ''
	--io.write('- ',type(t),'\n') -- RETURNS WHAT TYPE IT IS
		if type(t) == "table" then -- TYPE TABLE
		--io.write("- run table...\n")
			for key,value in pairs(t) do
				if key == "_mission_script" then
					return
				end -- PREVENT LOOPING OUTPUT FROM MISSION ELEMENTS
				file:write(indent,'[',tostring(key),']')
				if type(value)== "table" then
					file:write(':\n') print_w(value, file, indent .. "\t")
				else
					file:write(' = ',tostring(value),'\n')
				end
			end
			file:write('\n')
		elseif (type(t)) == "string" then -- TYPE STRING
			file:write('Mission level: ',tostring(t),'\n\n')
		elseif (type(t)) == "number" then -- TYPE NUMBER
			file:write('Objects: ',tostring(t),' detected','\n')
		else
			file:write(tostring(t),'\n') -- SEPARATES THE PRINT_W OUTPUT BY 2 LINES
		end
	end
	--------------------------
	-- FUNCTION INTERACTION --
	--------------------------
	function BaseInteractionExt:interact_distance()
		local looper = 0
		local intNew = true
		while looper <= intObjects do
			if inTable[looper] == self.tweak_data then
				intNew = false
			end
			looper = looper + 1
		end
		if intNew and intObjects < 10000 then
			intObjects = intObjects + 1
			io.stdout:write(self.tweak_data .. "\n")
			inTable[intObjects] = self.tweak_data
		end
		return tweak_data.interaction.INTERACT_DISTANCE
	end
	--------------------------
	-- GATHER INTERACTABLES --
	--------------------------
	print_w(mission, file)
	print_w(intObjects, file)
	print_w(inTable, file)
	intObjects = 0
	inTable = { }
	-----------------------------
	-- GATHER MISSION ELEMENTS --
	-----------------------------
	if not DATAMINE then
		local tableA = managers.mission:script("default")
		file:write("Mission Level: "..tostring(managers.job:current_level_id().."\n"))
		file:write("[default]\n\t")
		for k, v in pairs (tableA) do
			local val = tostring(k) 
			if tostring(v):sub(1,5) == 'table' then
				file:write("["..tostring(k).."]".."\n")
			else
				file:write("["..tostring(k).."]")
				file:write(" = ")
				file:write(tostring(v))
				file:write("\n")
			end
			if val:sub(1,9) == '_elements' and val:sub(1,15) ~= '_element_groups' then
				for k1, v1 in pairs (v) do
					local val1 = tostring(k1)
					if tostring(v1):sub(1,5) == 'table' then
						file:write("\t\t".."["..tostring(k1).."]".."\n")
					else
						file:write("\t\t")
						file:write("["..tostring(k1).."]")
						file:write(" = ")
						file:write(tostring(v1))
						file:write("\n")
					end
					if val1 ~= 'nil' then
						for k2, v2 in pairs (v1) do
							local val2 = tostring(k2)
							if tostring(v2):sub(1,5) == 'table' then
								file:write("\t\t\t".."["..tostring(k2).."]".."\n")
							else
								file:write("\t\t\t")
								file:write("["..tostring(k2).."]")
								file:write(" = ")
								file:write(tostring(v2))
								file:write("\n")
							end
							if val2:sub(1,6) == '_value' then
								for k3, v3 in pairs (v2) do
									local val3 = tostring(k3)
									if tostring(v3):sub(1,5) == 'table' then
										file:write("\t\t\t\t".."["..tostring(k3).."]".."\n")
									else
										file:write("\t\t\t\t")
										file:write("["..tostring(k3).."]")
										file:write(" = ")
										file:write(tostring(v3))
										file:write("\n")
									end
									if val3:sub(1,12) == 'trigger_list' or val3:sub(1,11) == 'on_executed' or val3:sub(1,8) == 'elements' then
										if val3:sub(1,11) == 'on_executed' and tostring(managers.mission:script("default")._elements[k1]._values.on_executed[1]) == 'nil' then
											file:write("\t\t\t\t\tnil\n")
										end
										for k4, v4 in pairs (v3) do
											local val4 = tostring(v4)                                                
											if tostring(v4):sub(1,5) == 'table' then
												file:write("\t\t\t\t\t".."["..tostring(k4).."]".."\n")
											else
												file:write("\t\t\t\t\t")
												file:write("["..tostring(k4).."]")
												file:write(" = ")
												file:write(tostring(v4))
												file:write("\n")
											end
											if val4:sub(1,5) == 'table' then
												for k5, v5 in pairs (v4) do
													file:write("\t\t\t\t\t\t")
													file:write("["..tostring(k5).."]")
													file:write(" = ")
													file:write(tostring(v5))
													file:write("\n")
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		file:close()
	end
end