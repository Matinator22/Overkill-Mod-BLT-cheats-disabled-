--==========================--
--      OVERKILL MOD        --
--   EXTRA FUNCTIONS MENU   --
--      BY OVERKILL         --
--==========================--
-- r2.2
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
	----------------------------
	-- ENABLEINTERACT UTILITY --
	----------------------------
	local function EnableInteract()
		Toggle.EnableInteract = not Toggle.EnableInteract
		-- DISABLE
		if not Toggle.EnableInteract then
			backuper:restore('BaseInteractionExt._has_required_upgrade')
			backuper:restore('BaseInteractionExt._has_required_deployable')
			backuper:restore('BaseInteractionExt.can_interact')
			backuper:restore('PlayerManager.remove_equipment')
			return
		end
		-- ENABLE
		backuper:backup('BaseInteractionExt._has_required_upgrade')
		function BaseInteractionExt:_has_required_upgrade(movement_state) return true end
		backuper:backup('BaseInteractionExt._has_required_deployable')
		function BaseInteractionExt:_has_required_deployable() return true end
		backuper:backup('BaseInteractionExt.can_interact')
		function BaseInteractionExt:can_interact(player) return true end
		backuper:backup('PlayerManager.remove_equipment')
		function PlayerManager:remove_equipment(equipment_id) end
	end
	------------------
	-- HOST WRAPPER --
	------------------
	if isHost() then
		-------------------
		-- FRIENDLY FIRE --
		-------------------
		function ffon()
		Toggle.ffon = not Toggle.ffon
			if not Toggle.ffon then
				backuper:restore('PlayerDamage.is_friendly_fire')
				managers.mission._fading_debug_output:script().log(" DISABLED ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" FRIENDLY FIRE : ", Color("a7ddf4"))
				return
			end
			backuper:backup('PlayerDamage.is_friendly_fire')
			function PlayerDamage:is_friendly_fire(unit) return false end
			managers.mission._fading_debug_output:script().log(" ENABLED ", Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" FRIENDLY FIRE : ", Color("a7ddf4"))
		end
		--------------------
		-- CLOAKER ARREST --
		--------------------
		function clkrArrest()
		Toggle.clkrArrest = not Toggle.clkrArrest
			if not Toggle.clkrArrest then
				backuper:restore('PlayerMovement.on_SPOOCed')
				backuper:restore('TeamAIMovement:on_SPOOCed')
				managers.mission._fading_debug_output:script().log("CLOAKER KICKS RESTORED", Color("FFE29D"))
				return
			end
			backuper:backup('PlayerMovement.on_SPOOCed')
			function PlayerMovement:on_SPOOCed(enemy_unit)
				if managers.player:has_category_upgrade("player", "counter_strike_spooc") and self._current_state.in_melee and self._current_state:in_melee() then
					self._current_state:discharge_melee()
					return "countered"
				end
				if self._unit:character_damage()._god_mode then
					return
				end
				if self._current_state_name == "standard" or self._current_state_name == "carry" or self._current_state_name == "bleed_out" or self._current_state_name == "tased" then
					managers.player:set_player_state( "arrested" )
					-- managers.achievment:award(tweak_data.achievement.finally.award)
					-- return true
				end	
			end
			backuper:backup('TeamAIMovement:on_SPOOCed')
			function TeamAIMovement:on_SPOOCed( enemy_unit )
				if self._unit:character_damage()._god_mode then
					return
				end
				if self._unit:brain():set_logic( "surrender" ) then
					return
				end
				if self._unit:network():send( "arrested" ) then
					return
				end
				if self._unit:character_damage():on_arrested() then
					return
				end
			end
			managers.mission._fading_debug_output:script().log("CLOAKER KICKS REPLACED WITH CUFFS", Color("FFE29D"))
		end
		-------------
		-- COUNTER --
		-------------
		function clkCounterAI()
		Toggle.clkCounterAI = not Toggle.clkCounterAI
			if not Toggle.clkCounterAI then
				backuper:restore('TeamAIMovement.on_SPOOCed')
				managers.mission._fading_debug_output:script().log(" COUNTER CLOAKER DISABLED ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" TEAM AI : ", Color("a7ddf4"))
				return
			end
			if TeamAIMovement then
				backuper:backup('TeamAIMovement.on_SPOOCed')
				function TeamAIMovement:on_SPOOCed(enemy_unit)
					return "countered"
				end
			end
			managers.mission._fading_debug_output:script().log(" COUNTER CLOAKER ENABLED ", Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" TEAM AI : ", Color("a7ddf4"))
		end
		---------------------------
		-- GRAB COURIER PACKAGES --
		---------------------------
		function initCourier()
			InteractData({'gage_assignment'})
			managers.mission._fading_debug_output:script().log("COURIER PACKAGES RETRIEVED", Color("FFE29D"))
		end
		----------------------
		-- DOORS LOCKPICKED --
		----------------------
		-- ADDED GRIN CASINO LOCKER
		function initLockpick()
			local locksmith = {}
			local id
			for _,v in pairs(managers.interaction._interactive_units) do
				if v.interaction then
					id = string.sub(v:interaction()._unit:name():t(), 1, 10)
					if id == "@IDe653b95" or id == "@ID18a7cac" or id == "@IDa25106d"
					or id == "@IDb025e83" or id == "@ID08a3353" or id == "@ID851f323"
					or id == "@ID8e70272" or id == "@ID1d283db" or id == "@ID5a95fe8"
					or id == "@ID622b34c" or id == "@ID1e56fe5" or id == "@IDa096513"
					or id == "@IDcfb8d38" or id == "@IDb68beff" or id == "@IDcfb8d38"
					or id == "@ID31ccfa0" or id == "@IDe653b95" or id == "@IDd40d72e"
					or id == "@IDcffcea3" or id == "@ID559c3e4" or id == "@IDcfffc73"
					or id == "@IDbcd14bd" or id == "@ID5eb73ed" or id == "@IDd98f48a"
					or id == "@ID30a21bb" or id == "@ID6283ee0" or id == "@IDd99d699" 
					or id == "@IDea4c3c2" then
					table.insert(locksmith, v:interaction())
					end
				end
			end
			for _,v in pairs(locksmith) do v:interact(managers.player:player_unit()) end
			managers.mission._fading_debug_output:script().log("DOORS LOCKPICKED", Color("FFE29D"))
		end
		-----------------
		-- OPEN CRATES --
		-----------------
		function initCrate()
			EnableInteract()
			InteractData({'crate_loot', 'crate_loot_crowbar', 'crate_weapon_crowbar', 'crate_loot_close'})
			EnableInteract()
			managers.mission._fading_debug_output:script().log("CRATES OPENED", Color("FFE29D"))
		end
		---------------
		-- OPEN ATMS --
		---------------
		function initATM()
			EnableInteract()
			InteractData({'requires_ecm_jammer_atm', 'invisible_interaction_open'})
			EnableInteract()
			managers.mission._fading_debug_output:script().log("ATMS OPENED", Color("FFE29D"))
		end
		-------------------
		-- BOARD WINDOWS --
		-------------------
		function initBoard()
			EnableInteract()
			InteractData({'need_boards', 'stash_planks'})
			EnableInteract()
			managers.mission._fading_debug_output:script().log("WINDOWS BOARDED", Color("FFE29D"))
		end
		------------
		-- SET C4 --
		------------
		function initC4()
			EnableInteract()
			InteractData({'c4_bag', 'shape_charge_plantable', 'c4_consume'})
			EnableInteract()
			managers.mission._fading_debug_output:script().log("C4 SET", Color("FFE29D"))
		end
		---------------
		-- SET FLARE --
		---------------
		function initFlare()
			EnableInteract()
			InteractData({'place_flare', 'ignite_flare'})
			EnableInteract()
			managers.mission._fading_debug_output:script().log("FLARE IGNITED", Color("FFE29D"))
		end
		---------------
		-- SET STRAP --
		---------------
		function initStrap()
			EnableInteract()
			InteractData({'hold_place_strap'})
			EnableInteract()
			managers.mission._fading_debug_output:script().log("STRAP PLACED", Color("FFE29D"))
		end
		----------------
		-- VAULT DOOR --
		----------------
		function initVault()
			if managers.job:current_level_id() == 'red2' then
				for _, script in pairs(managers.mission:scripts()) do
					for id, element in pairs(script:elements()) do
						for _, trigger in pairs(element:values().trigger_list or {}) do
							if trigger.notify_unit_sequence == 'open_door' then
							element:on_executed()
							end
						end
					end
				end
			else
				for _,unit in pairs(World:find_units_quick('all')) do
					if unit:damage() and unit:damage():has_sequence('timer_done') then
						unit:damage():run_sequence_simple('timer_done')
						managers.network:session():send_to_peers_synched('run_mission_door_device_sequence', unit, 'timer_done')
					end	
				end
			end
			managers.player:local_player():sound():say("keypad_correct_code", false, true)
			managers.mission._fading_debug_output:script().log("VAULT OPENED", Color("FFE29D"))
		end
		---------------
		-- OVERDRILL --
		---------------
		function initOverdrill()
		Toggle.initOverdrill = not Toggle.initOverdrill
			if Toggle.initOverdrill then
				if managers.job:current_level_id() == "red2" and not managers.groupai:state():whisper_mode() and Global.game_settings.difficulty == "overkill_290" and isHost() then
					for _, script in pairs(managers.mission:scripts()) do
						for id, element in pairs(script:elements()) do
							for _, trigger in pairs(element:values().trigger_list or {}) do
								if trigger.notify_unit_sequence == "light_on" then
									element:on_executed()
									managers.mission._fading_debug_output:script().log(" SCRIPT ACTIVATED ", Color("97d04d") )
									managers.mission._fading_debug_output:script().log(" OVERDRILL : ", Color("a7ddf4"))
								end
							end
						end
					end
				else
					managers.mission._fading_debug_output:script().log(" CONDITIONS : HOSTING A LOBBY ON DEATHWISH LOUD ", tweak_data.system_chat_color) 
					managers.mission._fading_debug_output:script().log(" OVERDRILL : CONDITIONS ARE NOT MET! ", Color("a7ddf4")) 
				end
				Toggle.initOverdrill = false
			end
		end
		----------------
		-- BANKFILLER --
		----------------
		function initBankFill()
			for _,unit in pairs( World:find_units_quick("all") ) do
				if unit:damage() and unit:damage():has_sequence('enable_special') then
					unit:damage():run_sequence_simple('enable_special')
					managers.network:session():send_to_peers_synched("run_mission_door_device_sequence", unit, 'enable_special')
				end	
			end
			managers.mission._fading_debug_output:script().log("DEPOSITS FILLED", Color("FFE29D"))
		end
		-------------------
		-- BANKBUSTER v3 --
		-------------------
		function initBankBust()
		local depositboxes = {}
			for _,v in pairs(managers.interaction._interactive_units) do
				if v.interaction then
					local id = string.sub(v:interaction()._unit:name():t(), 1, 10)
					if id == "@ID7999172" -- HARVEST BANK
					or id == "@IDe4bc870" or id == "@ID51da6d6" or id == "@ID8d8c766"
					or id == "@ID50aac55" or id == "@ID5dcd177" -- ARMOURED TRANSPORT
					or id == "@IDa95e021" -- THE BIG BANK
					or id == "@IDe93c9b2" then -- GO BANK
						table.insert(depositboxes, v:interaction())
					end	
				end
			end
			for _,v in pairs(depositboxes) do
				v:interact(managers.player:player_unit())
			end
			managers.mission._fading_debug_output:script().log("DEPOSITS OPENED", Color("FFE29D"))
		end
		-----------------
		-- ARREST HOST --
		-----------------
		function arrestHost()
			managers.player:set_player_state("arrested")
		end
		-----------------------
		-- INCAPACITATE HOST --
		-----------------------
		function downHost()
			managers.player:set_player_state("incapacitated")
		end
		---------------
		-- LOCK HOST --
		---------------
		-- REMOVE FROM GROUPAI CRIMINALS LIST
		function lockHost()
			local player = managers.player:local_player()
			managers.player:force_drop_carry()
			managers.statistics:downed({death = true})
			IngameFatalState.on_local_player_dead()
			game_state_machine:change_state_by_name("ingame_waiting_for_respawn")
			player:character_damage():set_invulnerable(true)
			player:character_damage():set_health(0)
			player:base():_unregister()
			player:base():set_slot(player, 0)
		end
		--------------------
		-- JAILBREAK HOST --
		--------------------
		function jailbreakHost()
			if game_state_machine:current_state_name() == "ingame_waiting_for_respawn" and not alive(managers.player:player_unit()) then
				IngameWaitingForRespawnState:_begin_game_enter_transition()
			end	
		end
		------------------
		-- JAILBREAK AI --
		------------------
		-- SOURCE CREDIT: OVERKILL
		function jailbreakAI()
		local jbai = 0
		local spawn_on_unit = managers.player:player_unit()
			for id, data in pairs(managers.criminals._characters) do
			unit = data.unit
			bot = data.data.ai
			name = data.name 
			taken = data.taken 
				if unit ~= null and bot and not alive(unit) then
					managers.trade:remove_from_trade(name)
					managers.groupai:state():spawn_one_teamAI(false, name, spawn_on_unit)
					jbai = jbai + 1
				end
			end
			if jbai > 0 then
				managers.mission._fading_debug_output:script().log(" RELEASED : "..jbai, Color("97d04d"))
				managers.mission._fading_debug_output:script().log(" JAILBREAK AI : ", Color("a7ddf4"))
				managers.player:local_player():sound():say("cash_loot_drop_drill_reveal", false, true)
			else
				managers.mission._fading_debug_output:script().log(" NONE IN CUSTODY ", Color("ea984f"))
				managers.mission._fading_debug_output:script().log(" JAILBREAK AI : ", Color("a7ddf4"))
			end
		end
		------------------
		-- JAIL TEAM AI --
		------------------
		-- SOURCE CREDIT: OVERKILL
		function lockAI()
		local jai = 0
			for id, data in pairs(managers.criminals._characters) do
			unit = data.unit
			name = data.name
			bot = data.data.ai
				if bot and alive(unit) then
				local crim_data = managers.criminals:character_data_by_name(name)
					if crim_data then
						managers.hud:set_mugshot_custody(crim_data.mugshot_id)
					end
				unit:set_slot(name, 0)
				jai = jai + 1
				end
			end
			managers.mission._fading_debug_output:script().log(" LOCKED UP : "..jai, Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" JAIL AI : ", Color("a7ddf4"))
			managers.player:local_player():sound():say("cash_loot_drop_reveal", false, true)
		end
		-----------------------
		-- JAILBREAK PLAYERS --
		-----------------------
		function jailbreakTeam(id)
			local peer = managers.network:session():peer(id)
			if peer and peer:id() ~= managers.network:session():local_peer():id() then
				if Network:is_client() then
					managers.network:session():server_peer():send("request_spawn_member")
				else	
					IngameWaitingForRespawnState.request_player_spawn(id)
				end	
			end	
		end
		---------------------
		-- ARREST TEAMMATE --
		---------------------
		function arrestTeam(id)
			for pl_key, pl_record in pairs(managers.groupai:state():all_player_criminals()) do
				if pl_record.status ~= "dead" then
					local unit = managers.groupai:state():all_player_criminals()[pl_key].unit
					if unit:network():peer():id() == id then
						unit:network():send_to_unit({"sync_player_movement_state", unit, "arrested", 0, unit:id()})
					end
				end	
			end	
		end
		---------------------------
		-- INCAPACITATE TEAMMATE --
		---------------------------
		function downTeam(id)
			for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
				if pl_record.status ~= "dead" then
					local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
					if unit:network():peer():id() == id then
						unit:network():send_to_unit( { "sync_player_movement_state", unit, "incapacitated", 0, unit:id() } )
					end
				end
			end
		end
		-------------------
		-- JAIL TEAMMATE --
		-------------------
		function lockTeam(id)
			for _,u_data in pairs(managers.groupai:state():all_player_criminals()) do
				local player = u_data.unit
				local player_id = player:network():peer():id()
				if id == player_id or id == -1 then
					player:network():send("sync_player_movement_state", "dead", 0, player:id())
					player:network():send_to_unit({"spawn_dropin_penalty", true, nil, 0, nil, nil})
					managers.groupai:state():on_player_criminal_death(player:network():peer():id())
				end	
			end	
		end
		--------------------------
		-- TELEPORT TO TEAMMATE --
		--------------------------
		function portKey(id)
		local pos
			for pl_key, pl_record in pairs( managers.groupai:state():all_player_criminals() ) do
				if pl_record.status ~= "dead" then
					local unit = managers.groupai:state():all_player_criminals()[ pl_key ].unit
					if unit:network():peer():id() == id then
						pos = unit:position()
					end	
				end	
			end
			if pos then
				managers.player:warp_to(pos, managers.player:player_unit():rotation())
			end	
		end
		---------------------
		-- MAKE CIVS DANCE --
		---------------------
		function civDance()
			local poses = {"cf_sp_dance_slow", "cf_sp_dance_sexy", "cf_sp_pole_dancer_expert", "cf_sp_pole_dancer_basic"}
			for k,v in pairs(managers.enemy:all_civilians()) do
				local act = {type = "act", variant = poses[math.random(4)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)		
			end
			managers.mission._fading_debug_output:script().log(" DANCING ", Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" CIVILIANS : ", Color("a7ddf4"))
		end
		------------------------
		-- MAKE CIVS SMOKE UP --
		------------------------
		function civSmoke()
			local poses = {"cm_sp_smoking_left1", "cf_sp_smoking_var1", "cm_sp_smoking_right1", "cmf_so_smoke"}
			for k,v in pairs(managers.enemy:all_civilians()) do
				local act = {type = "act", variant = poses[math.random(4)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)
			end	
			managers.mission._fading_debug_output:script().log(" SMOKING ", Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" CIVILIANS : ", Color("a7ddf4"))
		end
		--------------------
		-- CABLE TIE CIVS --
		--------------------
		function civCable()
			EnableInteract()
			InteractData({"requires_cable_ties", 'intimidate'})
			EnableInteract()
			managers.mission._fading_debug_output:script().log(" CABLE TIED ", Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" CIVILIANS : ", Color("a7ddf4"))
		end
		---------------------------
		-- MAKE CIVS CALL POLICE --
		---------------------------
		function civCall()
			local poses = {"cmf_so_answer_phone", "cmf_so_call_police", "cf_sp_sms_phone_var1", "cm_sp_phone1", "cm_sp_phone2"}
			for k,v in pairs(managers.enemy:all_civilians()) do
				local act = {type = "act", variant = poses[math.random(5)], body_part = 1, align_sync = true}
				v.unit:movement():action_request(act)
			end
			managers.mission._fading_debug_output:script().log(" CALLING POLICE ", Color("97d04d"))
			managers.mission._fading_debug_output:script().log(" CIVILIANS : ", Color("a7ddf4"))
		end
		------------------
		-- DISABLE CAMS --
		------------------
		function disableCam()
			Toggle.disableCam = not Toggle.disableCam
			if not Toggle.disableCam then
				for _,unit in pairs(GroupAIStateBase._security_cameras) do
					unit:base():set_update_enabled(true)
				end
				managers.mission._fading_debug_output:script().log("CAMERAS RESTORED", Color("FFE29D"))
				return
			end
			for _,unit in pairs(GroupAIStateBase._security_cameras) do
				unit:base():set_update_enabled(false)
			end
			managers.mission._fading_debug_output:script().log("CAMERAS DISABLED", Color("FFE29D"))
		end
		--------------------
		-- DISABLE PAGERS --
		--------------------
		function disablePager()
			Toggle.disablePager = not Toggle.disablePager
			if not Toggle.disablePager then
				backuper:restore('CopLogicInactive._set_interaction')
				backuper:restore('CopLogicIntimidated._chk_begin_alarm_pager')
				managers.mission._fading_debug_output:script().log("PAGERS RESTORED", Color("FFE29D"))
				return
			end
			backuper:backup('CopLogicIntimidated._chk_begin_alarm_pager')
			function CopLogicIntimidated._chk_begin_alarm_pager(data) 
			end
			backuper:backup('CopLogicInactive._set_interaction')
			function CopLogicInactive._set_interaction(data, my_data)
			data.unit:unit_data().has_alarm_pager = false
			end
			managers.mission._fading_debug_output:script().log("PAGERS DISABLED", Color("FFE29D"))
		end
		--------------------------
		-- DISABLE PANIC BUTTON --
		--------------------------
		function disablePanic()	
			Toggle.disablePanic = not Toggle.disablePanic
			if not Toggle.disablePanic then
				backuper:restore('CopMovement.action_request')
				managers.mission._fading_debug_output:script().log("PANIC BUTTON RESTORED", Color("FFE29D"))
				return
			end
				local _actionRequest = backuper:backup('CopMovement.action_request')
			function CopMovement:action_request(action_desc)
				if action_desc.variant == "run" or action_desc.variant == "e_so_alarm_under_table" or action_desc.variant == "cmf_so_press_alarm_wall"
				or action_desc.variant == "cmf_so_press_alarm_table" or action_desc.variant == "cmf_so_call_police" or action_desc.variant == "arrest_call" then
					return false
				end
				return _actionRequest(self, action_desc)
			end
			managers.mission._fading_debug_output:script().log("PANIC BUTTON DISABLED", Color("FFE29D"))
		end
		--------------------
		-- DISABLE PHONES --
		--------------------
		function disableCall()
			Toggle.disableCall = not Toggle.disableCall
			if not Toggle.disableCall then
				backuper:restore('GroupAIStateBase.on_police_called')
				backuper:restore('CivilianLogicFlee.clbk_chk_call_the_police')
				managers.mission._fading_debug_output:script().log("PHONES RESTORED", Color("FFE29D"))
				return
			end
			backuper:backup('GroupAIStateBase.on_police_called')
			function GroupAIStateBase:on_police_called(called_reason) end
				
			backuper:backup('CivilianLogicFlee.clbk_chk_call_the_police')
			function CivilianLogicFlee.clbk_chk_call_the_police(ignore_this, data) end
			managers.mission._fading_debug_output:script().log("PHONES DISABLED", Color("FFE29D"))
		end
		----------------------
		-- DISABLE FIREARMS --
		----------------------
		function disableCop()
			Toggle.disableCop = not Toggle.disableCop
			if not Toggle.disableCop then
				backuper:restore('CopMovement.set_allow_fire')
				backuper:restore('CopMovement.set_allow_fire_on_client')
				managers.mission._fading_debug_output:script().log("FIREARMS RESTORED", Color("FFE29D"))
				return
			end
			local _setAllowFire = backuper:backup('CopMovement.set_allow_fire')
			function CopMovement:set_allow_fire(state)
				if state == false then
					_setAllowFire(self, state)
				end
			end
			local _setAllowFireClient = backuper:backup('CopMovement.set_allow_fire_on_client')
			function CopMovement:set_allow_fire_on_client(state, unit)
				if state == false then
					_setAllowFireClient(self, state, unit)
				end
			end
			managers.mission._fading_debug_output:script().log("FIREARMS JAMMED", Color("FFE29D"))
		end
		----------------------
		-- RANDOMIZED ALARM --
		----------------------
		function rngAlarm()
			if Toggle.disableCam then
			Toggle.disableCam = false
				for _,unit in pairs(GroupAIStateBase._security_cameras) do
					unit:base():set_update_enabled(true)
				end
			end
			if Toggle.disablePager then
			Toggle.disablePager = false
			backuper:restore('CopLogicInactive._set_interaction')
			backuper:restore('CopLogicIntimidated._chk_begin_alarm_pager')
			end
			if Toggle.disablePanic then
			Toggle.disablePanic = false
			backuper:restore('CopMovement.action_request')
			end
			if Toggle.disableCall then
			Toggle.disableCall = false
			backuper:restore('GroupAIStateBase.on_police_called')
			backuper:restore('CivilianLogicFlee.clbk_chk_call_the_police')
			end
			if Toggle.disableCop then
			Toggle.disableCop = false
			backuper:restore('CopMovement.set_allow_fire')
			backuper:restore('CopMovement.set_allow_fire_on_client')
			end
		local blame = {"civ_alarm", "cop_computer", "mot_criminal", "sys_blackmailer", "sys_gensec", "sys_csgo_gunfire" }
		local trigger = math.random( #blame )
		managers.groupai:state():on_police_called(blame[trigger])
		managers.mission._fading_debug_output:script().log("ALARM TRIGGERED", Color("FFE29D"))
		end
		--------------------------------
		-- SHUTDOWN ENEMY AI (TOGGLE) --
		--------------------------------
		function shutdownAI()
		Toggle.shutdownAI = not Toggle.shutdownAI
			if not Toggle.shutdownAI then -- ENABLE AI
				-- RESTORE SPAWN AI FUNCTION
				backuper:restore('CopBrain.set_spawn_ai')
				backuper:restore('CopBrain.set_followup_objective')
				backuper:restore('CopBrain.set_logic')
				backuper:restore('CopBrain.set_init_logic')
				ChatMessage('DISABLED', 'SHUTDOWN ENEMY AI')
				for u_key, u_data in pairs(managers.enemy:all_enemies()) do
					u_data.unit:brain():set_active(true)
				end
				--[[
				for u_key, u_data in pairs(managers.enemy:all_civilians()) do
					u_data.unit:brain():set_active(true)
				end
				]]
				for u_key, unit in pairs(SecurityCamera.cameras) do
					unit:base()._detection_interval = 0.1
				end
			else -- DISABLE AI
				ChatMessage('ENABLED', 'SHUTDOWN ENEMY AI')
				ChatMessage('CIVILIANS WILL NOT BE DISABLED TO ALLOW HOSTAGE MOVEMENT', 'WARNING')
				for u_key, u_data in pairs(managers.enemy:all_enemies()) do
					u_data.unit:brain():set_active(false)
				end
				--[[
				for u_key, u_data in pairs(managers.enemy:all_civilians()) do
					u_data.unit:brain():set_active(false)
				end
				]]
				for u_key, unit in pairs(SecurityCamera.cameras) do
					unit:base():_destroy_all_detected_attention_object_data()
					unit:base():_send_net_event(1)
					unit:base()._detection_interval = 1000000
				end
				-- BACKUP SPAWN AI FUNCTION
				backuper:backup('CopBrain.set_spawn_ai')
				-- SET DEFAULT SPAWN AI TO INACTIVE
				function CopBrain:set_spawn_ai(spawn_ai)
					spawn_ai.init_state = "inactive"
					self._spawn_ai = spawn_ai
					self:set_update_enabled_state(true)
					self:set_logic("inactive")
					if spawn_ai.stance then
						self._unit:movement():set_stance(spawn_ai.stance)
					end
					if spawn_ai.objective then
						self:set_objective(spawn_ai.objective)
					end	
				end
				-- BUGFIX: IF OBJECTIVE == NIL, ABORT (DO NOT UNDO THIS FUNCTION)
				backuper:backup('CopBrain.set_followup_objective')
				function CopBrain:set_followup_objective(followup_objective)
					if not self._logic_data.objective then
						return
					end
					local old_followup = self._logic_data.objective.followup_objective
					self._logic_data.objective.followup_objective = followup_objective
					if followup_objective and followup_objective.interaction_voice then
						self._unit:network():send("set_interaction_voice", followup_objective.interaction_voice)
					elseif old_followup and old_followup.interaction_voice then
						self._unit:network():send("set_interaction_voice", "")
					end	
				end
				-- PATCH (BY BALDWIN)
				function patch_ai()
				local patched_logic = function( o, self, ... )
				local r = o(self, ...)
					self:set_active( false )
					return r
				end
				local backuper = backuper
				local hijack = backuper.hijack
					hijack(backuper, 'CopBrain.set_logic', patched_logic)
					hijack(backuper, 'CopBrain.set_init_logic', patched_logic)
				end
			end	
		end
		----------------------------
		-- ULTIMATE KILL DELIVERY --
		----------------------------
		function ultimatekill()
			local function destroy_unit(unit)
				if unit:character_damage():pickup() and unit:character_damage():pickup()  ~= "ammo" then
					unit:character_damage():drop_pickup()
				end
			World:delete_unit(unit)
			end
			for u_key, u_data in pairs(managers.enemy:all_enemies()) do
				destroy_unit(u_data.unit)
			end
			for u_key, u_data in pairs(managers.enemy:all_civilians()) do
				destroy_unit(u_data.unit)
			end
			for _, cam_unit in ipairs(SecurityCamera.cameras) do
				if cam_unit:enabled() then
					cam_unit:base():set_detection_enabled(false)
				end
			end
			managers.mission._fading_debug_output:script().log("BOOYAKASHA!", Color.Violet)
		end
		function orbitalstrike()
			DelayedCalls:Add("_MSG_COUNT_1", 1, function() managers.player:local_player():sound():say("alarm_countdown_ticking_down_10sec", false, true) managers.mission._fading_debug_output:script().log("ARRIVING IN : 10", Color.AntiqueWhite) end)
			DelayedCalls:Add("_MSG_COUNT_2", 11, function() ultimatekill() managers.player:local_player():sound():say("blast_door_explosion", false, true) end)
			DelayedCalls:Add("_MSG_COUNT_3", 15, function() ultimatekill() managers.player:local_player():sound():say("blast_door_explosion", false, true) end)
			DelayedCalls:Add("_MSG_COUNT_4", 19, function() ultimatekill() managers.player:local_player():sound():say("blast_door_explosion", false, true) end)
			DelayedCalls:Add("_MSG_COUNT_5", 20, function() managers.mission._fading_debug_output:script().log("BOMBARDMENT SUCCESS : ", Color("FFE29D")) end)
			DelayedCalls:Add("_MSG_COUNT_6", 21, function() managers.mission._fading_debug_output:script().log("TARGETED UNITS ERASED", tweak_data.system_chat_color) end)
			showHint('LAUNCH CONFIRMED')
			managers.player:local_player():sound():say("bar_vault_touchscreen_finished", false, true)
		end
	----------------------
	-- END HOST WRAPPER --
	----------------------
	end
	------------
	-- ALARMS --
	------------
	function alarmFire()
		Toggle.alarmFire = not Toggle.alarmFire
		if not Toggle.alarmFire then
		managers.player:local_player():sound():say("alarm_fire_stop", false, true)
		managers.mission._fading_debug_output:script().log(' FIRE ALARM : OFF ', Color("2ebdf5") )
			return
		end
		managers.player:local_player():sound():say("alarm_fire", false, true)
		managers.mission._fading_debug_output:script().log(' FIRE ALARM : ON ', Color("2ebdf5") )
	end
	function alarmKosugi()
		Toggle.alarmKosugi = not Toggle.alarmKosugi
		if not Toggle.alarmKosugi then
		managers.player:local_player():sound():say("alarm_kosugi_off", false, true)
		managers.mission._fading_debug_output:script().log(' RAID ALARM : OFF ', Color("2ebdf5") )
			return
		end
		managers.player:local_player():sound():say("alarm_kosugi_on_slow_fade", false, true)
		managers.mission._fading_debug_output:script().log(' RAID ALARM : ON ', Color("2ebdf5") )
	end
	function alarmMuseum()
		Toggle.alarmMuseum = not Toggle.alarmMuseum
		if not Toggle.alarmMuseum then
		managers.player:local_player():sound():say("alarm_museum_off", false, true)
		managers.mission._fading_debug_output:script().log(' MUSEUM ALARM : OFF ', Color("2ebdf5") )
			return
		end
		managers.player:local_player():sound():say("alarm_museum_on_slow_fade", false, true)
		managers.mission._fading_debug_output:script().log(' MUSEUM ALARM : ON ', Color("2ebdf5") )
	end
	function alarmHitec()
		Toggle.alarmHitec = not Toggle.alarmHitec
		if not Toggle.alarmHitec then
		managers.player:local_player():sound():say("hitec_lotec_alarm_off", false, true)
		managers.mission._fading_debug_output:script().log(' HITEC ALARM : OFF ', Color("2ebdf5") )
			return
		end
		managers.player:local_player():sound():say("hitec_lotec_alarm_slow_fade", false, true)
		managers.mission._fading_debug_output:script().log(' HITEC ALARM : ON ', Color("2ebdf5") )
	end
	function alarmJewel()
		Toggle.alarmJewel = not Toggle.alarmJewel
		if not Toggle.alarmJewel then
		managers.player:local_player():sound():say("jewelry_alarm_off", false, true)
		managers.mission._fading_debug_output:script().log(' JEWELRY ALARM : OFF ', Color("2ebdf5") )
			return
		end
		managers.player:local_player():sound():say("jewelry_alarm_on_slow_fade", false, true)
		managers.mission._fading_debug_output:script().log(' JEWELRY ALARM : ON ', Color("2ebdf5") )
	end
	---------------
	-- SOUNDBANK --
	---------------
	function msc_stop()
		managers.player:local_player():sound():say("Stop_all_music", false, true)
		if Toggle.alarmFire then
		Toggle.alarmFire = false
		end
		if Toggle.alarmKosugi then
		Toggle.alarmKosugi = false
		end
		if Toggle.alarmMuseum then
		Toggle.alarmMuseum = false
		end
		if Toggle.alarmHitec then
		Toggle.alarmHitec = false
		end
		if Toggle.alarmJewel then
		Toggle.alarmJewel = false
		end
	end
	function msc_post_stop()
		managers.music:post_event("stop_all_music")
	end
	function msc_achievo()
		managers.player:local_player():sound():say("Achievement_challenge", false, true)
	end
	function msc_infamous()
		managers.player:local_player():sound():say("infamous_player_join_stinger", false, true)
	end
	function msc_nightclub()
		managers.player:local_player():sound():say("diegetic_club_music", false, true)
	end
	function msc_rockclub()
		managers.player:local_player():sound():say("diegetic_club_rock_music", false, true)
	end
	function msc_shopping()
		managers.player:local_player():sound():say("lets_go_shopping_menu", false, true)
	end
	function msc_flames()
		managers.player:local_player():sound():say("jukebox_the_flames_of_love", false, true)
	end
	function msc_ode()
		managers.player:local_player():sound():say("ode_all_avidita", false, true)
	end
	function msc_giveall()
		managers.player:local_player():sound():say("pth_i_will_give_you_my_all", false, true)
	end
	function msc_ourtime()
		managers.player:local_player():sound():say("this_is_our_time", false, true)
	end
	function msc_news()
		managers.player:local_player():sound():say("pth_breaking_news", false, true)
	end
	function msc_ambinstr()
		managers.player:local_player():sound():say("criminals_ambition_instrumental", false, true)
	end
	function msc_amb()
		managers.player:local_player():sound():say("criminals_ambition", false, true)
	end
	function msc_drifting()
		managers.player:local_player():sound():say("drifting", false, true)
	end
	function msc_wildone()
		managers.player:local_player():sound():say("im_a_wild_one", false, true)
	end
	function msc_xmas_badboy()
		managers.player:local_player():sound():say("xmas13_ive_been_a_bad_boy", false, true)
	end
	function msc_xmas_payday()
		managers.player:local_player():sound():say("xmas13_a_merry_payday_christmas", false, true)
	end
	function msc_xmas_hastobe()
		managers.player:local_player():sound():say("xmas13_if_it_has_to_be_christmas_american_version", false, true)
	end
	-------------------
	-- TELEPORTATION --
	-------------------
	function pbr2Plane()
	local location = Vector3(351.991, -4634.66, 46203.6)
		if ( ovkMap == "pbr2" ) then
			managers.player:warp_to(location, managers.player:player_unit():position())
			managers.player:set_player_state("standard")
		else
			managers.mission._fading_debug_output:script().log(" MAP NOT APPROVED ", Color("FFE29D"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
		end
	end
	function bigRoof()
	local location = Vector3(3980, 10, 386)
		if ( ovkMap == "big" ) then
			managers.player:warp_to(location, managers.player:player_unit():position())
		else
			managers.mission._fading_debug_output:script().log(" MAP NOT APPROVED ", Color("FFE29D"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
		end
	end
	function cageShow()
	local location = Vector3(-1742, 530, -14)
		if ( ovkMap == "cage" ) then
			managers.player:warp_to(location, managers.player:player_unit():position())
		else
			managers.mission._fading_debug_output:script().log(" MAP NOT APPROVED ", Color("FFE29D"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
		end
	end
	function jollyWall()
	local location = Vector3(11630, 7055, 146)
		if ( ovkMap == "jolly" ) then
			managers.player:warp_to(location, managers.player:player_unit():position())
		else
			managers.mission._fading_debug_output:script().log(" MAP NOT APPROVED ", Color("FFE29D"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
		end
	end
	function nailTube()
	local location = Vector3(-11135, 1340, -3341)
		if ( ovkMap == "nail" ) then
			managers.player:warp_to(location, managers.player:player_unit():position())
		else
			managers.mission._fading_debug_output:script().log(" MAP NOT APPROVED ", Color("FFE29D"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
		end
	end
	function watchDog_1()
	local location = Vector3(-2250, -1564, 56)
		if ( ovkMap == "watchdogs_1" ) then
			managers.player:warp_to(location, managers.player:player_unit():position())
		else
			managers.mission._fading_debug_output:script().log(" MAP NOT APPROVED ", Color("FFE29D"))
			managers.mission._fading_debug_output:script().log(" ACCESS DENIED ", tweak_data.system_chat_color)
		end
	end
----------------------
-- END GAME WRAPPER --
----------------------
end
----------------
-- RANDOMIZER --
----------------
local iota = { "... All for one and more for Bo.", "... What?! Is it forbidden?!", "... Players love it.", "... Players seem to be loving it.", "... Stat boosts are completely fine because it helps the team.", "... the outcome was never really in doubt.", "... It's that time of the month again.", "... The secret is admiring without desiring.", "... Oh moi goosh guise check out mah skins.", "... Guns, \'Murica, tits, and explosions. Maybe this game needs more tits.", "... I'm your eyes when you must steal.", "... Palms are sweaty. Knees weak arms are heavy...", "... Well, at least one person cared. But I am not that one person.", "... There will be a day when I care. BUT THAT IS NOT THIS DAY.", "... It was me, the author of all your pain. - Bo", "... Motherfuckin\' money.", "... I\'m your dream, make you real.", "... I'll smoke it with you bro. We'll go to the loony bin together.", "... goddamit, you had ONE JOB!", "... It\'s a crime of passion, not a disgruntled gamer. Everyone here is extremely gruntled.", "... I\'m sorry, I had a very different understanding as to what \'prima nocte\' meant.", "... There are five stages to grief. Denial, anger, bargaining, depression and acceptance. If I can get them depressed, then I\'ll have done my job.", "... Anyone in the world can write anything they want about any subject, so you know you are getting the best possible information. - Benjamin Franklin", "... Oh, this is gonna work out great because communicating with players is a very important part of the job, and we haven\'t been there in months.", "... Sometimes what brings the kids together is hating the lunch lady. Ashley is that lunch lady.", "... A toast to the victims of microtransactions.", "... Now introducing a new safe, schrödinger. Add some uncertainty in your life!", "... 4-8-15-16-23-42", "... You\'re not gonna believe this, because it usually never happens, but I made a mistake.", "... What the !@#$ is going on?", "... Don\'t be trippin dog we got you.", "... That\'s what she said.", "... We're either really stupid or really evil.", "... Your failures are your own, old man! I say, FOLLOW THROOOUGH!", "... WHY\'D YOU EVEN ROPE ME INTO THIS?!", "... Don\'t look at me that guy over there roped ME into this.", "... Some of us have better things to do than read forum threads, Jerry!", "... Oh no. I\'m late to class, bitch.", "... funding our other projects with your money from Payday 2." }
local rng = math.random( #iota )
------------------
-- JAIL OPTIONS --
------------------
jail_menu = function()
	if isHost() then
		jail_menu_A()
	else
		managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
		managers.mission._fading_debug_output:script().log(' JAIL OPTIONS : ', Color('ffc300') )
	end
end
jail_menu_A = function()
local data = {
	{},
	{ text = "\[JAILBREAK TEAM AI\]", callback = jailbreakAI },
	{ text = "\[LOCKUP TEAM AI\]", callback = lockAI },
	{},
	{ text = "" .. PlayerName(1) .. " " .. "\[MENU\]", callback = jailh1_A },
	{ text = "" .. PlayerName(2) .. " " .. "\[MENU\]", callback = jailp2_A },
	{ text = "" .. PlayerName(3) .. " " .. "\[MENU\]", callback = jailp3_A },
	{ text = "" .. PlayerName(4) .. " " .. "\[MENU\]", callback = jailp4_A },
	{}
	}
show_sorted_dialog("JAIL OPTIONS", "... trying to save your ass so you can save the world.", data, xtra_game)
end
-------------------
-- JAIL PLAYER 1 --
-------------------
jailh1_A = function()
local data = {
	{ text = "\[JAILBREAK HOST\]", callback = jailbreakHost },
	{},
	{ text = "\[ARREST\]", callback = arrestHost },
	{ text = "\[INCAPACITATE\]", callback = downHost },
	{ text = "\[LOCKUP\]", callback = lockHost },
	{}
	}
show_sorted_dialog("JAIL OPTIONS \[HOST\]", "... so say we all.", data, jail_menu)
end
-------------------
-- JAIL PLAYER 2 --
-------------------
jailp2_A = function()
local data = {
	{ text = "\[JAILBREAK P2\]", callback = jailbreakTeam, data = 2 },
	{},
	{ text = "\[ARREST\]", callback = arrestTeam, data = 2 },
	{ text = "\[INCAPACITATE\]", callback = downTeam, data = 2 },
	{ text = "\[LOCKUP\]", callback = lockTeam, data = 2 },
	{}
	}
show_sorted_dialog("JAIL OPTIONS \[PLAYER 2\]", "... so say we all.", data, jail_menu)
end
-------------------
-- JAIL PLAYER 3 --
-------------------
jailp3_A = function()
local data = {
	{ text = "\[JAILBREAK P3\]", callback = jailbreakTeam, data = 3 },
	{},
	{ text = "\[ARREST\]", callback = arrestTeam, data = 3 },
	{ text = "\[INCAPACITATE\]", callback = downTeam, data = 3 },
	{ text = "\[LOCKUP\]", callback = lockTeam, data = 3 },
	{}
	}
show_sorted_dialog("JAIL OPTIONS \[PLAYER 3\]", "... so say we all.", data, jail_menu)
end
-------------------
-- JAIL PLAYER 4 --
-------------------
jailp4_A = function()
local data = {
	{ text = "\[JAILBREAK P4\]", callback = jailbreakTeam, data = 4 },
	{},
	{ text = "\[ARREST\]", callback = arrestTeam, data = 4 },
	{ text = "\[INCAPACITATE\]", callback = downTeam, data = 4 },
	{ text = "\[LOCKUP\]", callback = lockTeam, data = 4 },
	{}
	}
show_sorted_dialog("JAIL OPTIONS \[PLAYER 4\]", "... so say we all.", data, jail_menu)
end
------------------
-- TEAM OPTIONS --
------------------
team_menu = function()
	if isHost() then
		team_menu_A()
	else
		managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
		managers.mission._fading_debug_output:script().log(' TEAM OPTIONS : ', Color('ffc300') )
	end
end
team_menu_A = function()
local data = {
	{ text = "FRIENDLY FIRE \[TOGGLE\]", callback = ffon },
	{},
	{ text = "CLOAKER CUFFS NOT KICK \[TOGGLE\]", callback = clkrArrest },
	{ text = "COUNTER CLOAKERS \[TEAM AI\] \[TOGGLE\]", callback = clkCounterAI },
	{},
	{}
	}
show_sorted_dialog("TEAM OPTIONS", "... have it your way.", data, xtra_game)
end
-------------------
-- TELEPORTATION --
-------------------
warp_menu = function()
	if isHost() then
		warp_menu_A()
	else
		warp_menu_B()
	end
end
warp_menu_A = function()
local data = {
	{ text = "AFTERSHOCK: THE C4 WALL \[TELEPORT\]", callback = jollyWall },
	{ text = "BIG BANK: ROOF TOP \[TELEPORT\]", callback = bigRoof },
	{ text = "BIRTH OF THE SKY: BOARD PLANE \[TELEPORT\]", callback = pbr2Plane },
	{ text = "CAR SHOP: SHOWCASE AREA \[TELEPORT\]", callback = cageShow },
	{ text = "LAB RATS: SECRET TUBE \[TELEPORT\]", callback = nailTube },
	{ text = "WATCHDOGS DAY 1: DRIVER SPOT \[TELEPORT\]", callback = watchDog_1 },
	{},
	{ text = "" .. PlayerName(2) .. " " .. "\[TELEPORT TO P2\]", callback = portKey, data = 2 },
	{ text = "" .. PlayerName(3) .. " " .. "\[TELEPORT TO P3\]", callback = portKey, data = 3 },
	{ text = "" .. PlayerName(4) .. " " .. "\[TELEPORT TO P4\]", callback = portKey, data = 4 },
	{},
	{}
	}
show_sorted_dialog("TELEPORTATION \[HOST\]", "... Where we\'re going, we don\'t need roads.", data, xtra_game)
end
warp_menu_B = function()
local data = {
	{ text = "AFTERSHOCK: THE C4 WALL \[TELEPORT\]", callback = jollyWall },
	{ text = "BIG BANK: ROOF TOP \[TELEPORT\]", callback = bigRoof },
	{ text = "BIRTH OF THE SKY: BOARD PLANE \[TELEPORT\]", callback = pbr2Plane },
	{ text = "CAR SHOP: SHOWCASE AREA \[TELEPORT\]", callback = cageShow },
	{ text = "LAB RATS: SECRET TUBE \[TELEPORT\]", callback = nailTube },
	{ text = "WATCHDOGS DAY 1: DRIVER SPOT \[TELEPORT\]", callback = watchDog_1 },
	{},
	{ text = "" .. PlayerName(1) .. " " .. "\[TELEPORT TO HOST\]", callback = portKey, data = 1 },
	{ text = "" .. PlayerName(2) .. " " .. "\[TELEPORT TO P2\]", callback = portKey, data = 2 },
	{ text = "" .. PlayerName(3) .. " " .. "\[TELEPORT TO P3\]", callback = portKey, data = 3 },
	{ text = "" .. PlayerName(4) .. " " .. "\[TELEPORT TO P4\]", callback = portKey, data = 4 },
	{},
	{}
	}
show_sorted_dialog("TELEPORTATION \[CLIENT\]", "... Where we\'re going, we don\'t need roads.", data, xtra_game)
end
-------------------
-- LOGIC OPTIONS --
-------------------
logic_menu = function()
	if isHost() then
		logic_menu_A()
	else
		managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
		managers.mission._fading_debug_output:script().log(' LOGIC OPTIONS : ', Color('ffc300') )
	end
end
logic_menu_A = function()
local data = {
	{ text = "DANCE DANCE \[CIVILIAN\]", callback = civDance },
	{ text = "SMOKING BREAK \[CIVILIAN\]", callback = civSmoke },
	{ text = "CALL POLICE \[CIVILIAN\]", callback = civCall },
	{},
	{ text = "CABLE TIE HOSTAGES \[CIVILIAN\]", callback = civCable },
	{},
	{ text = "DISABLE CAMERAS \[TOGGLE\]", callback = disableCam },
	{ text = "DISABLE PAGERS \[TOGGLE\]", callback = disablePager },
	{ text = "DISABLE PANIC BUTTON \[TOGGLE\]", callback = disablePanic },
	{ text = "DISABLE PHONES \[TOGGLE\]", callback = disableCall },
	{ text = "DISRUPT FIREARMS \[TOGGLE\]", callback = disableCop },
	{ text = "SHUTDOWN ENEMY AI \[TOGGLE\]", callback = shutdownAI },
	{},
	{ text = "TRIGGER ALARM \[RANDOM\]", callback = rngAlarm },
	{}
	}
show_sorted_dialog("LOGIC OPTIONS \[HOST\]", "... because I'm Batman.", data, xtra_game)
end
-----------------
-- MAP OPTIONS --
-----------------
map_menu = function()
	if isHost() and ( ovkMap == "red2" ) then
		map_menu_B()
	elseif isHost() then
		map_menu_A()
	else
		managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
		managers.mission._fading_debug_output:script().log(' MAP OPTIONS : ', Color('ffc300') )
	end
end
map_menu_A = function()
local data = {
	{ text = "ORBITAL BOMBARDMENT \[LAUNCH\]", callback = orbitalstrike },
	{ text = "COURIER PACKAGES \[RETRIEVE\]", callback = initCourier },
	{},
	{ text = "SET C4 \[INSTANT\]", callback = initC4 },
	{ text = "PLACE STRAP \[INSTANT\]", callback = initStrap },
	{ text = "IGNITE FLARE \[INSTANT\]", callback = initFlare },
	{ text = "BOARD WINDOWS \[INSTANT\]", callback = initBoard },
	{ text = "LOCKPICK DOORS \[INSTANT\]", callback = initLockpick },
	{},
	{ text = "OPEN ATMS \[INSTANT\]", callback = initATM },
	{ text = "OPEN CRATES \[INSTANT\]", callback = initCrate },
	{ text = "FILL DEPOSIT BOXES \[INSTANT\]", callback = initBankFill },
	{ text = "OPEN DEPOSIT BOXES \[INSTANT\]", callback = initBankBust },
	{ text = "OPEN BANKVAULT \[INSTANT\]", callback = initVault },
	{}
	}
show_sorted_dialog("MAP OPTIONS", "... your credibility just went Almir.", data, xtra_game)
end
map_menu_B = function()
local data = {
	{ text = "ORBITAL BOMBARDMENT \[LAUNCH\]", callback = orbitalstrike },
	{ text = "COURIER PACKAGES \[RETRIEVE\]", callback = initCourier },
	{},
	{ text = "SET C4 \[PRESS\]", callback = initC4 },
	{ text = "PLACE STRAP \[PRESS\]", callback = initStrap },
	{ text = "IGNITE FLARE \[PRESS\]", callback = initFlare },
	{ text = "BOARD WINDOWS \[PRESS\]", callback = initBoard },
	{ text = "LOCKPICK DOORS \[PRESS\]", callback = initLockpick },
	{},
	{ text = "OPEN ATMS \[PRESS\]", callback = initATM },
	{ text = "OPEN CRATES \[PRESS\]", callback = initCrate },
	{ text = "FILL DEPOSIT BOXES \[PRESS\]", callback = initBankFill },
	{ text = "OPEN DEPOSIT BOXES \[PRESS\]", callback = initBankBust },
	{ text = "OPEN BANKVAULT \[PRESS\]", callback = initVault },
	{},
	{ text = "FIRST WORLD BANK: OVERDRILL \[ACTIVATE\]", callback = initOverdrill },
	{}
	}
show_sorted_dialog("MAP OPTIONS", "... your credibility just went Almir.", data, xtra_game)
end
------------------
-- ALARM SOUNDS --
------------------
alarm_menu = function()
local data = {
	{ text = "FIRE ALARM \[TOGGLE\]", callback = alarmFire },
	{ text = "SHADOW RAID ALARM \[TOGGLE\]", callback = alarmKosugi },
	{ text = "MUSEUM ALARM \[TOGGLE\]", callback = alarmMuseum },
	{ text = "HITEC ALARM \[TOGGLE\]", callback = alarmHitec },
	{ text = "JEWEL ALARM \[TOGGLE\]", callback = alarmJewel },
	{}
	}
show_sorted_dialog("ALARM TROLLING", "... these internet descriptions are iffy.", data, xtra_game)
end
------------------
-- MUSIC SOUNDS --
------------------
music_menu = function()
local data = {
	{ text = "\[STOP SOUND EVENT\]", callback = msc_stop },
	{},
	{ text = "ACHIEVEMENT CHEER", callback = msc_achievo },
	{ text = "INFAMOUS THEME", callback = msc_infamous },
	{},
	{ text = "NIGHT CLUB", callback = msc_nightclub },
	{ text = "ROCK CLUB", callback = msc_rockclub },
	{ text = "FLAMES OF LOVE", callback = msc_flames },
	{ text = "ODE ALL AVIDITA", callback = msc_ode },
	{ text = "GIVE IT MY ALL", callback = msc_giveall },
	{ text = "THIS IS OUR TIME", callback = msc_ourtime },
	{ text = "CRIMINAL AMBITION INSTR.", callback = msc_ambinstr },
	{ text = "CRIMINAL AMBITION", callback = msc_amb },
	{ text = "DRIFTING", callback = msc_drifting },
	{ text = "I'M A WILD ONE", callback = msc_wildone },
	{ text = "BREAKING NEWS", callback = msc_news },
	{ text = "LET'S GO SHOPPING", callback = msc_shopping },
	{},
	{},
	{ text = "XMAS: I BEEN A BAD BOY", callback = msc_xmas_badboy },
	{ text = "XMAS: PAYDAY CHRISTMAS", callback = msc_xmas_payday },
	{ text = "XMAS: HAS TO BE CHRISTMAS", callback = msc_xmas_hastobe },
	{}
	}
show_sorted_dialog("MUSIC TROLLING", "... the power to blow people's minds!", data, xtra_game)
end
----------------
-- INTRO MENU --
----------------
xtra_intro = function()
	local data = {}
	show_sorted_dialog("OVERKILL EXTRA FUNCTIONS DISABLED", ""..iota[rng], data, nil)
end
----------------
-- LOBBY MENU --
----------------
xtra_lobby = function()
	local data = {}
	show_sorted_dialog("OVERKILL EXTRA FUNCTIONS DISABLED", ""..iota[rng], data, nil)
end
---------------
-- GAME MENU --
---------------
xtra_game = function()
	if isHost() then
		xtra_game_A()
	else
		xtra_game_B()
	end
end
xtra_game_A = function()
local data = {
	{ text = "MAP OPTIONS \[MENU\]", callback = map_menu },
	{ text = "JAIL OPTIONS \[MENU\]", callback = jail_menu },
	{ text = "TEAM OPTIONS \[MENU\]", callback = team_menu },
	{ text = "LOGIC OPTIONS \[MENU\]", callback = logic_menu },
	{},
	{ text = "TELEPORTATION \[MENU\]", callback = warp_menu },
	{},
	{ text = "ALARM TROLLING \[MENU\]", callback = alarm_menu },
	{ text = "MUSIC TROLLING \[MENU\]", callback = music_menu },
	{},
	{ text = "STOP SOUND EVENTS \[DEBUG\]", callback = msc_stop },
	{ text = "STOP GAME MUSIC \[DEBUG\]", callback = msc_post_stop },
	{},
	{}
	}
	show_sorted_dialog("OVERKILL EXTRA FUNCTIONS [HOST]", ""..iota[rng], data, nil)
end
xtra_game_B = function()
local data = {
	{},
	{ text = "TELEPORTATION \[MENU\]", callback = warp_menu },
	{},
	{ text = "ALARM TROLLING \[MENU\]", callback = alarm_menu },
	{ text = "MUSIC TROLLING \[MENU\]", callback = music_menu },
	{},
	{ text = "STOP SOUND EVENTS \[DEBUG\]", callback = msc_stop },
	{},
	{}
	}
	show_sorted_dialog("OVERKILL EXTRA FUNCTIONS [CLIENT]", ""..iota[rng], data, nil)
end
-------------------
-- MENU DIRECTOR --
-------------------
if not inGame() and _cheatToggle then
	xtra_intro()
elseif inGame() and not isPlaying() and _cheatToggle and not inChat() then
	xtra_lobby()
elseif inGame() and isPlaying() and _cheatToggle and not inChat() then
	xtra_game()
end