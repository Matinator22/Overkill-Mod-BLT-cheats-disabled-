--===============================--
---   Waypoints - All in one!   ---
---     MULTI-STATE VERSION     ---
---         by Zephirot         ---
--===============================--
-- ADDITIONAL CREDITS: B1313, hejoro, 90e, Sirgoodsmoke, acepilot1023978, gir489
-- Fixed Diamond Puzzle "C2" (Error Exists Only in Multi-State Copy) - Bflat
local version = "11.2.5" 
local revision = "2.1"
-- CONFIG BOOLEANS BY gir489
local bShowDistance = false
local bShowThermite = false
local bShowSecuDoors = true
local bShowGagePackages = true
local bShowPlanks = true
local bShowSmallLoot = true
local bShowCrates = true
local bShowOnOffMessage = true
local bShowDrills = true
local bBeep = true

-- COLORS FOR WAYPOINTS
local alpha_value 	= 	200	-- (0->255)
local white 		= 	Color( 		   100, 255, 255, 255 )	/255
local bone_white 	= 	Color( alpha_value, 255, 238, 151 )	/255
local magenta 		= 	Color( alpha_value, 255, 000, 255 )	/255
local purple 		= 	Color( alpha_value, 154, 068, 220 )	/255
local matte_purple 	= 	Color( alpha_value, 107, 084, 144 )	/255
local pink 			= 	Color( alpha_value, 255, 122, 230 )	/255
local light_gray 	= 	Color( alpha_value, 191, 191, 191 )	/255
local gray 			= 	Color( alpha_value, 128, 128, 128 )	/255
local dark_gray 	= 	Color( alpha_value, 064, 064, 064 )	/255
local orange 		= 	Color( alpha_value, 255, 094, 015 )	/255
local light_brown 	= 	Color( alpha_value, 204, 115, 035 )	/255
local bright_yellow = 	Color( alpha_value, 255, 207, 076 )	/255
local brown 		= 	Color( alpha_value, 128, 070, 013 )	/255
local gold 			= 	Color( 		   255, 255, 215, 000 )	/255
local yellow 		= 	Color( alpha_value, 255, 255, 000 )	/255
local warm_yellow 	= 	Color( alpha_value, 250, 157, 007 )	/255
local red 			= 	Color( alpha_value, 255, 000, 000 )	/255
local blood_red 	= 	Color( alpha_value, 138, 017, 009 )	/255
local coral_red 	= 	Color( alpha_value, 213, 036, 053 )	/255
local dark_red 		= 	Color( alpha_value, 110, 015, 022 )	/255
local blue 			= 	Color( alpha_value, 000, 000, 255 )	/255
local gray_blue 	= 	Color( alpha_value, 012, 068, 084 )	/255
local navy_blue 	= 	Color( alpha_value, 040, 052, 086 )	/255
local matte_blue 	= 	Color( alpha_value, 056, 097, 168 )	/255
local light_blue 	= 	Color( alpha_value, 126, 198, 238 )	/255
local cobalt_blue 	= 	Color( alpha_value, 000, 093, 199 )	/255
local turquoise 	= 	Color( alpha_value, 000, 209, 157 )	/255
local cyan 			= 	Color( alpha_value, 000, 255, 255 )	/255
local green 		= 	Color( alpha_value, 000, 255, 000 )	/255
local lime_green 	= 	Color( alpha_value, 000, 166, 081 )	/255
local leaf_green 	= 	Color( alpha_value, 104, 191, 054 )	/255
local olive_green 	= 	Color( alpha_value, 072, 090, 050 )	/255
local dark_green 	= 	Color( alpha_value, 007, 061, 009 )	/255
local toxic_green 	= 	Color( alpha_value, 167, 248, 087 )	/255
	
-- INGAME CHECK
function inGame()
	if not game_state_machine then return false end
	return string.find(game_state_machine:current_state_name(), "game")
end
-- IS PLAYING CHECK
function isPlaying()
	if not BaseNetworkHandler then return false end
	return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
end
-- HOST CHECK
function isHost()
	if not Network then return false end
	return not Network:is_client()
end
-- CLIENT CHECK
function isClient()
	if not Network then return false end
	return Network:is_client()
end
-- BEEP
function beep()
	if managers and managers.menu_component and bBeep then
		managers.menu_component:post_event("menu_enter")
	end
end

function RefreshToggle()
	if _ToggleWayCheck > 0 then
		local xval = RenderSettings.resolution.x
		local yval = RenderSettings.resolution.y
		local txtsize = 10
		if xval >= 600 and xval < 800 then txtsize = 10 
		elseif xval >= 800 and xval < 1024 then txtsize = 15 
		elseif xval >= 1024 and xval < 1280 then txtsize = 20 
		elseif xval >= 1280 and xval < 1360 then txtsize = 25 
		elseif xval >= 1360 and xval < 1440 then txtsize = 30 
		elseif xval >= 1440 and xval < 1600 then txtsize = 35 
		elseif xval >= 1600 and xval < 1920 then txtsize = 40 
		elseif xval >= 1920 and xval < 2400 then txtsize = 30 
		else txtsize = 40 end
		if not _HDmsg then
		_HDmsg = {}
		_HDmsg.ws = Overlay:newgui():create_screen_workspace()
		_HDmsg.lbl = _HDmsg.ws:panel():text{ name="lbl_1", x = - (RenderSettings.resolution.x / 2.1) + 0.5 * RenderSettings.resolution.x, y = - (RenderSettings.resolution.y / 4) + 6.4/9 * RenderSettings.resolution.y, 
		text = "", font = tweak_data.menu.pd2_large_font, font_size = txtsize, color = Color.white:with_alpha(0.7), 
		layer = 1 }
		_HDmsg.lbl2 = _HDmsg.ws:panel():text{ name="lbl_2", x = - (RenderSettings.resolution.x / 2.1) + 0.5 * RenderSettings.resolution.x, y = - (RenderSettings.resolution.y / 4) + 6.1/9 * RenderSettings.resolution.y, 
		text = "", font=tweak_data.menu.pd2_large_font, font_size = txtsize, color = Color.white:with_alpha(0.7), 
		layer = 1 }
		_HDmsg.lbl:show()
		_HDmsg.lbl2:show()
		end
		-------------
		-- HUD MSG --
		-------------
		local data = ""
		local mess = ""
		--------------
		-- TOGGLE 1 --
		--------------
		if _ToggleWayCheck == 1 then
			local unit_list = World:find_units_quick( "all" )
			local count = 0
			for _,unit in ipairs( unit_list ) do
				if ( tostring(unit:name()) == "Idstring(@IDe8088e3bdae0ab9e@)" or	-- YELLOW PACKAGE
				tostring(unit:name()) == "Idstring(@ID05956ff396f3c58e@)" or		-- BLUE PACKAGE
				tostring(unit:name()) == "Idstring(@IDc90378ad89058c7d@)" or		-- PURPLE PACKAGE
				tostring(unit:name()) == "Idstring(@ID96504ebd40f8cf98@)" or		-- RED PACKAGE
				tostring(unit:name()) == "Idstring(@IDb3cc2abe1734636c@)" ) then 	-- GREEN PACKAGE
					count = count + 1
				end
			end
			data = "GAGE MODS"
			mess = "[1/9] PACKAGES : "..tostring(count)
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		--------------
		-- TOGGLE 2 --
		--------------
		elseif _ToggleWayCheck == 2 then
			local ncard = 0
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if ((id:sub(1,9) == 'hudz_civ_') 
				or (id:sub(1,9) == 'hudz_cop_') 
				or (id:sub(1,10) == 'hudz_card_')) then
					ncard = ncard + 1
				end
			end
			data = "SECURITY"
			mess = "[2/9] KEYCARDS : "..tostring(ncard)
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		--------------
		-- TOGGLE 3 --
		--------------
		elseif _ToggleWayCheck == 3 then
			local cam = 0
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,9)== 'hudz_cam_' then
					cam = cam + 1
				end
			end
			data = "SECURITY"
			mess = "[3/9] CAMERAS : "..tostring(cam)
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		--------------
		-- TOGGLE 4 --
		--------------
		elseif _ToggleWayCheck == 4 then 
			local nwpn = 0 local ncoke = 0
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,9)== 'hudz_wpn_' then
					nwpn = nwpn + 1
				end
			end
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,10)== 'hudz_coke_' then
					ncoke = ncoke + 1
				end
			end
			data = "PRODUCTS"
			mess = "[4/9] WEAPONS : "..nwpn.."\nCOCAINE : "..ncoke
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		--------------
		-- TOGGLE 5 --
		--------------
		elseif _ToggleWayCheck == 5 then 
			local nplank = 0
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,9)== 'hudz_plk_' then
					nplank = nplank + 1
				end
			end
			data = "BARRICADES"
			mess = "[5/9] BOARDS : "..tostring(nplank)
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		--------------
		-- TOGGLE 6 --
		--------------
		elseif _ToggleWayCheck == 6 then
			local ncrate = 0 local ncrow = 0
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,11)== 'hudz_crate_' then
					ncrate = ncrate + 1
				end
			end
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,10)== 'hudz_crow_' then
					ncrow = ncrow + 1
				end
			end
			data = "CACHE"
			mess = "[6/9] CRATES : "..ncrate.."\nCROWBARS : "..ncrow
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		--------------
		-- TOGGLE 7 --
		--------------
		elseif _ToggleWayCheck == 7 then
			if (managers.job:current_level_id() == 'framing_frame_1' or managers.job:current_level_id() == 'gallery') then
				local gnd = 0
				local wall = 0
				for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
					id = tostring(id)
					if id:sub(1,9)== 'hudz_ptn_' then
						wall = wall + 1
					end
				end
				for k, v in pairs(managers.interaction._interactive_units) do
					if (v:interaction().tweak_data == 'painting_carry_drop') then
						gnd = gnd + 1
					end
				end
				local art = wall + gnd
				data = "ART GALLERY"
				mess = "[7/9] PAINTINGS : "..tostring(art)
			elseif (managers.job:current_level_id() == "framing_frame_3") then
				data = "FRAMING FRAME"
				mess = "[7/9] INTEL"
			elseif (managers.job:current_level_id() == "jolly") then
				data = "AFTERSHOCK"
				mess = "[7/9] MAP LAYOUT"
			elseif (managers.job:current_level_id() == "arm_for") then
				data = "ARMORED TRANSPORT"
				mess = "[7/9] TURRET UNITS"
			elseif (managers.job:current_level_id() == "pbr") then
				local ncrate = 0
				for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
					id = tostring(id)
					if id:sub(1,11)== 'hudz_crate_' then
						ncrate = ncrate + 1
					end
				end
				data = "BENEATH THE MOUNTAIN"
				mess = "[7/9] SHIPPING CRATES : "..ncrate
			elseif (managers.job:current_level_id() == "big") then
				data = "BENEVOLENT BANK"
				mess = "[7/9] COMPUTER"
			elseif (managers.job:current_level_id() == "welcome_to_the_jungle_1") then
				data = "BIG OIL: OLD SHACK"
				mess = "[7/9] INTEL"
			elseif (managers.job:current_level_id() == "welcome_to_the_jungle_2") then
				data = "BIG OIL: VIVALDI HOUSE"
				mess = "[7/9] SERVER ROOM"
			elseif (managers.job:current_level_id() == "pbr2") then
				data = "BIRTH OF THE SKY"
				mess = "[7/9] MAP LAYOUT"
			elseif (managers.job:current_level_id() == "cage") then
				data = "CAR SHOP"
				mess = "[7/9] COMPUTER"
			elseif (managers.job:current_level_id() == "alex_1" or managers.job:current_level_id() == "rat") then
				local chem = 0
				for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
					id = tostring(id)
					if ((id:sub(1,11) == 'hudz_coke1_') 
					or (id:sub(1,11) == 'hudz_coke2_') 
					or (id:sub(1,11) == 'hudz_coke3_')) then
						chem = chem + 1
					end
				end
				data = "COOK OFF"
				mess = "[7/9] CHEMICALS : "..tostring(chem)
			elseif (managers.job:current_level_id() == "mus") then
				data = "DIAMOND MUSEUM"
				mess = "[7/9] SECURITY PLANS"
			elseif (managers.job:current_level_id() == "family") then
				data = "DIAMOND STORE"
				mess = "[7/9] KEYPAD"
			elseif (managers.job:current_level_id() == "election_day_1" and isHost()) then
				data = "ELECTION DAY"
				mess = "[7/9] TRUCK"
			elseif (managers.job:current_level_id() == "election_day_1" and isClient()) then
				data = "ELECTION DAY"
				mess = "[7/9] COMPUTER"
			elseif (managers.job:current_level_id() == "election_day_3_skip1") then
				data = "ELECTION DAY"
				mess = "[7/9] SERVER"
			elseif (managers.job:current_level_id() == "firestarter_2") then
				data = "FIRESTARTER: FBI BRANCH"
				mess = "[7/9] SECURITY BOX"
			elseif (managers.job:current_level_id() == "nail") then
				local dum = 0 
				for k, v in pairs(managers.interaction._interactive_units) do
					if (v:interaction().tweak_data == 'carry_drop') then
						dum = dum + 1
					end
				end
				data = "LAB RATS"
				mess = "[7/9] DONACDUM : "..tostring(dum)
			elseif (managers.job:current_level_id() == "alex_2") then
				data = "RATS: METH TRADE"
				mess = "[7/9] SAFE"
			elseif (managers.job:current_level_id() == "kosugi") then
				data = "SHADOW RAID"
				mess = "[7/9] SAMURAI ARMOR"
			elseif (managers.job:current_level_id() == "dinner") then
				data = "SLAUGHTERHOUSE"
				mess = "[7/9] MAP LAYOUT"
			elseif (managers.job:current_level_id() == "ukrainian_job") then
				data = "UKRANIAN JOB"
				mess = "[7/9] TIARA"
			else
				data = "DATA"
				mess = "[7/9] WAYPOINT"
			end
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		--------------
		-- TOGGLE 8 --
		--------------
		elseif _ToggleWayCheck == 8 then
			data = "FORTUNE"
			mess = "[8/9] MONEY"
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		--------------
		-- TOGGLE 9 --
		--------------
		elseif _ToggleWayCheck == 9 then
			data = "GENERAL"
			mess = "[9/9] MAP LAYOUT"
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		---------------
		-- TOGGLE 10 --
		---------------
		elseif _ToggleWayCheck == 10 then
			data = "TEST"
			mess = "[10/10] BLANK"
			_HDmsg.lbl2:set_text(data)
			_HDmsg.lbl:set_text(mess)
		end
	end
end

if inGame() and isPlaying() and not inChat() then
	if not _ToggleWayCheck then _ToggleWayCheck = 0 end
	_ToggleWayCheck = _ToggleWayCheck + 1	
	_keyboard_used = _keyboard_used or false
	_engine_used = _engine_used or false
	_intel_used = _intel_used or false
	bo_boxes = bo_boxes or {}
	SecBox1 = SecBox1
	SecBox2 = SecBox2
	correct_id = correct_id or nil
	engine_pos = engine_pos or nil
	values = values or nil
	_checking_bags = _checking_bags or false
	_box1_used = _box1_used or false
	_box2_used = _box2_used or false
	_drill1_used = _drill1_used or false
	_drill2_used = _drill2_used or false
	_drill3_used = _drill3_used or false
	_tiara_used = _tiara_used or false
	_bbserv_used = _bbserv_used or false
	_FF3_used = _FF3_used or false
	_gps_used = _gps_used or false
	_comp_used = _comp_used or false
	_bomb_ok = _bomb_ok or false
	_bomb_pos = _bomb_pos or nil
	_bomb_used = _bomb_used or 0
	_uldatabase_found = _uldatabase_found or false
	_path_tile = _path_tile or 0
	_path_terminated = _path_terminated or false
	_hack_ok = _hack_ok or false
	_path_created = _path_created or 99999
	_script_activated = _script_activated or 0
	tabclk = tabclk or {}
	clientBox = clientBox or {}
	clientSucceed = clientSucceed or 0
	cm = managers.controller
	nb = nb or 0
	lp = lp or false
	if not _HDmsg then
		_HDmsg = {}
		_HDmsg.ws = Overlay:newgui():create_screen_workspace()
		local xval = RenderSettings.resolution.x
		local yval = RenderSettings.resolution.y
		local txtsize = 10
		if xval >= 600 and xval < 800 then txtsize = 10 
		elseif xval >= 800 and xval < 1024 then txtsize = 15 
		elseif xval >= 1024 and xval < 1280 then txtsize = 20 
		elseif xval >= 1280 and xval < 1360 then txtsize = 25 
		elseif xval >= 1360 and xval < 1440 then txtsize = 30 
		elseif xval >= 1440 and xval < 1600 then txtsize = 35 
		elseif xval >= 1600 and xval < 1920 then txtsize = 40 
		elseif xval >= 1920 and xval < 2400 then txtsize = 30 
		else txtsize = 40 end
		_HDmsg.lbl = _HDmsg.ws:panel():text{ name="lbl_1", x = - (RenderSettings.resolution.x / 2.1) + 0.5 * RenderSettings.resolution.x, y = - (RenderSettings.resolution.y / 4) + 6.4/9 * RenderSettings.resolution.y, 
		text = "", font = tweak_data.menu.pd2_large_font, font_size = txtsize, color = light_blue:with_alpha(0.7), 
		layer = 1 }
		_HDmsg.lbl2 = _HDmsg.ws:panel():text{ name="lbl_2", x = - (RenderSettings.resolution.x / 2.1) + 0.5 * RenderSettings.resolution.x, y = - (RenderSettings.resolution.y / 4) + 6.1/9 * RenderSettings.resolution.y, 
		text = "DATA", font=tweak_data.menu.pd2_large_font, font_size = txtsize, color = Color("FFE29D"):with_alpha(0.7), layer = 1 }
		_HDmsg.lbl3 = _HDmsg.ws:panel():text{ name="lbl_3", x = - (RenderSettings.resolution.x / 2.1) + 0.5 * RenderSettings.resolution.x, y = - (RenderSettings.resolution.y / 4) + 6.7/9 * RenderSettings.resolution.y, 
		text = "", font=tweak_data.menu.pd2_large_font, font_size = txtsize, color = Color.white:with_alpha(0.7), 
		layer = 1 }
		_HDmsg.lbl4 = _HDmsg.ws:panel():text{ name="lbl_4", x = - (RenderSettings.resolution.x / 2.1) + 0.5 * RenderSettings.resolution.x, y = - (RenderSettings.resolution.y / 4) + 6.9/9 * RenderSettings.resolution.y, 
		text = "", font=tweak_data.menu.pd2_large_font, font_size = txtsize, color = orange:with_alpha(0.7), 
		layer = 1 }
		_HDmsg.lbl:show()
		_HDmsg.lbl2:show()
		_HDmsg.lbl3:show()
		_HDmsg.lbl4:show()
	end
	keyboard = Input:keyboard()
	if keyboard:pressed() ~= nil then
		beep()
		_script_activated = os.clock()
	end
	-- SPEED UP WAYPOINT DISPLAY
	managers.hud.__update_waypoints = managers.hud.__update_waypoints or managers.hud._update_waypoints
	function HUDManager:_update_waypoints( t, dt ) 
		local result = self:__update_waypoints(t,dt) 
		for id,data in pairs( self._hud.waypoints ) do 
			id = tostring(id) 
			data.move_speed = 0.01 
			local LSD  = Color(1,math.sin(140 * os.clock() + 0) / 2 + 0.5, math.sin(140 * os.clock() + 60) / 2 + 0.5, math.sin(140 * os.clock() + 120) / 2 + 0.5)
			local FIRE = Color(1,math.sin(135 * os.clock() + 0) / 2 + 1.5, math.sin(140 * os.clock() + 60) / 2 + 0.5, 0)
			----------- COLORED WAYPOINTS ---------------
			if id:sub(1,10) == 'hudz_base_' or id:sub(1,9) == 'hudz_box_' then
				data.bitmap:set_color( white )
			end
			-- KEYS
			if id:sub(1,9) == 'hudz_key_' then
				data.bitmap:set_color( yellow )
			end
			-- KEYCARD CIV
			if id:sub(1,9) == 'hudz_civ_' then
				data.bitmap:set_color( purple )
			end
			-- KEYCARD COP
			if id:sub(1,9) == 'hudz_cop_' then
				data.bitmap:set_color( cobalt_blue )
			end
			-- KEYCARD FLOOR
			if id:sub(1,10) == 'hudz_card_' then
				data.bitmap:set_color( yellow )
			end
			-- POWER BOX
			if id:sub(1,9) == 'hudz_pwr_' then
				data.bitmap:set_color( yellow )
			end
			-- ATM
			if id:sub(1,9) == 'hudz_atm_' then
				data.bitmap:set_color( light_blue )
			end
			-- CAMERA
			if id:sub(1,9) == 'hudz_cam_' then
				data.bitmap:set_color( light_blue )
			end
			-- CASH LOOT
			if id:sub(1,10) == 'hudz_cash_' then
				data.bitmap:set_color( dark_green )
			end
			-- COKE
			if id:sub(1,10) == 'hudz_coke_' then
				data.bitmap:set_color( LSD )
			end
			-- CRATE
			if id:sub(1,11) == 'hudz_crate_' then
				data.bitmap:set_color( white )
			end
			-- CROWBAR
			if id:sub(1,10) == 'hudz_crow_' then
				data.bitmap:set_color( white )
			end
			-- DOOR
			if id:sub(1,10) == 'hudz_door_' then
				data.bitmap:set_color( cyan )
			end
			if id:sub(1,10) == 'hudz_Robj_' then
				data.bitmap:set_color( light_blue )
			end
			if id:sub(1,10) == 'hudz_Wobj_' then
				data.bitmap:set_color( blood_red )
			end
			-- GOLD/JEWEL
			if id:sub(1,10) == 'hudz_gold_' then
				data.bitmap:set_color( gold )
			end
			-- LSD
			if id:sub(1,9) == 'hudz_lsd_' then
				data.bitmap:set_color( LSD )
			end
			-- METH
			if id:sub(1,10) == 'hudz_meth_' then
				data.bitmap:set_color( LSD )
			end
			-- MONEY (BAG)
			if id:sub(1,11) == 'hudz_cashB_' then
				data.bitmap:set_color( green )
			end
			-- PACKAGE
			if id:sub(1,10) == 'hudz_pkgY_' then
				data.bitmap:set_color( yellow )
			elseif id:sub(1,10) == 'hudz_pkgB_' then
				data.bitmap:set_color( blue )
			elseif id:sub(1,10) == 'hudz_pkgP_' then
				data.bitmap:set_color( magenta )
			elseif id:sub(1,10) == 'hudz_pkgR_' then
				data.bitmap:set_color( red )
			elseif id:sub(1,10) == 'hudz_pkgG_' then
				data.bitmap:set_color( green )
			end
			-- PAINTING
			if id:sub(1,9) == 'hudz_ptn_' then
				data.bitmap:set_color( purple )
			end
			-- PLANK
			if id:sub(1,9) == 'hudz_plk_' then
				data.bitmap:set_color( light_brown )
			end
			-- METHLAB
			if id:sub(1,11) == 'hudz_coke1_' then
				data.bitmap:set_color( white )
			elseif id:sub(1,11) == 'hudz_coke2_' then
				data.bitmap:set_color( green )
			elseif id:sub(1,11) == 'hudz_coke3_' then
				data.bitmap:set_color( yellow )
			end
			-- THERMITE & GASCAN
			if id:sub(1,10) == 'hudz_fire_' then
				data.bitmap:set_color( FIRE )
			end
			-- WEAPON
			if id:sub(1,9) == 'hudz_wpn_' then
				data.bitmap:set_color( magenta )
			end
		end
		return result
	end
	
	function RefreshTest()
		if inGame() and isPlaying() then
			Color.orange = Color("FF8800")
			-- CLEAR ALL CREATED WAYPOINTS
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,5) == 'hudz_' then
					managers.hud:remove_waypoint( id )
				end
			end
			if _ToggleWayCheck > 0 then
				local level = managers.job:current_level_id()
				-- CREATE NEW WAYPOINTS FOR REMAINING ITEMS
				for k,v in pairs(managers.interaction._interactive_units) do
	------ 1 ------
					if _ToggleWayCheck == 1 then
						------------------
						-- GAGE PACKAGE --
						------------------
						if v:interaction().tweak_data == 'gage_assignment' and bShowGagePackages then
							if managers.job:current_level_id() == 'hox_2' and v:interaction():interact_position() == Vector3(-200, -200, 4102.5) then
							else
								 --[[Yellow]]
								if tostring(v:name()) == "Idstring(@IDe8088e3bdae0ab9e@)" then
									managers.hud:add_waypoint('hudz_pkgY_'..k, { icon = 'interaction_christmas_present', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.yellow, blend_mode = "add" })
								 --[[Blue]]
								elseif tostring(v:name()) == "Idstring(@ID05956ff396f3c58e@)" then
									managers.hud:add_waypoint('hudz_pkgB_'..k, { icon = 'interaction_christmas_present', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.blue, blend_mode = "add" })
								 --[[Purple]]
								elseif tostring(v:name()) == "Idstring(@IDc90378ad89058c7d@)" then
									managers.hud:add_waypoint('hudz_pkgP_'..k, { icon = 'interaction_christmas_present', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.purple, blend_mode = "add" })
								--[[Red]]
								elseif tostring(v:name()) == "Idstring(@ID96504ebd40f8cf98@)" then
									managers.hud:add_waypoint('hudz_pkgR_'..k, { icon = 'interaction_christmas_present', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
								 --[[Green]]
								elseif tostring(v:name()) == "Idstring(@IDb3cc2abe1734636c@)" then
									managers.hud:add_waypoint('hudz_pkgG_'..k, { icon = 'interaction_christmas_present', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
								else
									managers.hud:add_waypoint('hudz_base_'..k, { icon = 'interaction_christmas_present', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							end
						end
	------ 2 ------
					elseif _ToggleWayCheck == 2 then
						-------------
						-- KEYCARD --
						-------------
						if v:interaction().tweak_data == 'pickup_keycard' then
							if managers.job:current_level_id() == 'roberts' and v:position() == Vector3(250, 6750, -64.2354) then
							elseif managers.job:current_level_id() == 'big' and v:position() == Vector3(3000, -3500, 949.99) then
							elseif managers.job:current_level_id() == 'firestarter_2' and v:position() == Vector3(-1800, -3600, 400) then
							else
								managers.hud:add_waypoint('hudz_card_'..k, { icon = 'equipment_bank_manager_key', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, Color.yellow, blend_mode = "add" })
							end
						end
						-- CIVS WITH KEYCARDS
						for u_key,u_data in pairs(managers.enemy:all_civilians()) do
							local player_pos = Vector3(0,0,0)  -- managers.player:player_unit():camera():position()
							local unit_pos = u_data.unit:movement():m_head_pos()
							if isHost() and (u_data.unit.contour and alive(u_data.unit)) and u_data.unit:character_damage():pickup() then
								local ray = World:raycast("ray", player_pos, unit_pos, "slot_mask", managers.slot:get_mask( "AI_visibility" ), "ray_type", "ai_vision", "ignore_unit", { u_data.unit } )
								if (ray and ray.unit) then
									local cHealth = u_data.unit:character_damage() and u_data.unit:character_damage()._health
									if cHealth then
										local full = u_data.unit:character_damage()._HEALTH_INIT
										local supp = u_data.unit:character_damage()._suppression_data
										if full and (cHealth > 0.6) and not (managers.job:current_level_id() == "jolly") then
											-- ALIVE
											managers.hud:add_waypoint('hudz_civ_'..tostring(unit_pos), { icon = 'equipment_bank_manager_key', distance = bShowDistance, position = unit_pos, no_sync = true, present_timer = 0, state = "present", radius = 1000, color = purple, blend_mode = "add" })
										else
											-- DEAD
										end
									end
								end
							end
						end
						-- COPS WITH KEYCARDS
						for u_key, u_data in pairs(managers.enemy:all_enemies()) do
							local player_pos = Vector3(0,0,0) -- managers.player:player_unit():camera():position()
							local unit_pos = u_data.unit:movement():m_head_pos()
							if isHost() and u_data.unit.contour and alive(u_data.unit) and u_data.unit:character_damage():pickup() and u_data.unit:character_damage():pickup() ~= "ammo" then
								local ray = World:raycast("ray", player_pos, unit_pos, "slot_mask", managers.slot:get_mask( "AI_visibility" ), "ray_type", "ai_vision", "ignore_unit", { u_data.unit } )
								if (ray and ray.unit) then
									local cHealth = u_data.unit:character_damage() and u_data.unit:character_damage()._health
									if cHealth then
										local full = u_data.unit:character_damage()._HEALTH_INIT
										local supp = u_data.unit:character_damage()._suppression_data
										if full and (cHealth > 0.6) then
											-- ALIVE
											managers.hud:add_waypoint('hudz_cop_'..tostring(unit_pos), { icon = 'equipment_bank_manager_key', distance = bShowDistance, position = unit_pos, no_sync = true, present_timer = 0, state = "present", radius = 1000, color = cobalt_blue, blend_mode = "add" })
										else
											-- DEAD
										end
									end
								end
							end
						end
						-- BIG BANK KEYS
						if managers.job:current_level_id() == 'big' and (v:interaction().tweak_data == 'invisible_interaction_open' or v:interaction().tweak_data == 'take_keys') then
							managers.hud:add_waypoint('hudz_key_'..k, { icon = 'equipment_chavez_key', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-- FIRST WORLD BANK : POWER BOX
						if managers.job:current_level_id() == 'red2' and (v:interaction().tweak_data == 'invisible_interaction_open' or v:interaction().tweak_data == 'rewire_electric_box') then
							managers.hud:add_waypoint('hudz_pwr_'..k, { icon = 'wp_powersupply', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
	------ 3 ------
					elseif _ToggleWayCheck == 3 then
						------------
						-- CAMERA --
						------------
						if v:interaction().tweak_data == 'sc_tape_loop' then
							managers.hud:add_waypoint('hudz_cam_'..k, { icon = 'wp_target', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.blue, blend_mode = "add" })
						end
	------ 4 ------
					elseif _ToggleWayCheck == 4 then
						--------------------
						-- WEAPONS & COKE --
						--------------------
						-- WEAPONS
						if (v:interaction().tweak_data == 'weapon_case' or v:interaction().tweak_data == 'take_weapons') then
							managers.hud:add_waypoint('hudz_wpn_'..k, { icon = 'ak', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						-- COKE
						elseif v:interaction().tweak_data == 'gen_pku_cocaine' then
							managers.hud:add_waypoint('hudz_coke_'..k, { icon = 'wp_vial', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
	------ 5 ------
					elseif _ToggleWayCheck == 5 then
						-----------------------
						-- PLANKS AND BOARDS --
						-----------------------
						-- PLANKS
						if v:interaction().tweak_data == 'stash_planks_pickup' and bShowPlanks then
							managers.hud:add_waypoint('hudz_plk_'..k, { icon = 'equipment_planks', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						-- BOARDS
						elseif v:interaction().tweak_data == 'pickup_boards' and bShowPlanks then
							managers.hud:add_waypoint('hudz_plk_'..k, { icon = 'equipment_planks', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
	------ 6 ------
					elseif _ToggleWayCheck == 6 then
						---------------------
						-- CROWBAR & CRATE --
						---------------------
						if not (managers.job:current_level_id() == 'pbr' or managers.job:current_level_id() == 'pbr2') then
							if v:interaction().tweak_data == 'gen_pku_crowbar' then
								managers.hud:add_waypoint('hudz_crow_'..k, { icon = 'equipment_crowbar', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							elseif v:interaction().tweak_data == 'crate_loot_crowbar' and bShowCrates then
								managers.hud:add_waypoint('hudz_crate_'..k, { icon = 'pd2_lootdrop', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							elseif v:interaction().tweak_data == 'crate_loot' and bShowCrates then
								managers.hud:add_waypoint('hudz_crate_'..k, { icon = 'pd2_lootdrop', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
	------ 7 ------
					elseif _ToggleWayCheck == 7 then
						----------------
						-- AFTERSHOCK --
						----------------
						if managers.job:current_level_id() == 'jolly' then
							if v:interaction().tweak_data == 'gen_int_saw' then 
								managers.hud:add_waypoint('hudz_lsd_'..k, { icon = 'pd2_defend', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
							elseif v:interaction().tweak_data == 'hold_pku_knife' then 
								managers.hud:add_waypoint('hudz_lsd_'..k, { icon = 'pd2_question', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
							end
							for u_key,u_data in pairs(managers.enemy:all_civilians()) do
							local player_pos = Vector3(0,0,0)  -- managers.player:player_unit():camera():position()
							local unit_pos = u_data.unit:movement():m_head_pos()
								if isHost() and (u_data.unit.contour and alive(u_data.unit)) and u_data.unit:character_damage():pickup() then
									local ray = World:raycast("ray", player_pos, unit_pos, "slot_mask", managers.slot:get_mask( "AI_visibility" ), "ray_type", "ai_vision", "ignore_unit", { u_data.unit } )
									if (ray and ray.unit) then
										local cHealth = u_data.unit:character_damage() and u_data.unit:character_damage()._health
										if cHealth then
											local full = u_data.unit:character_damage()._HEALTH_INIT
											local supp = u_data.unit:character_damage()._suppression_data
											if full and (cHealth > 0.6) and (managers.job:current_level_id() == "jolly") then
												-- ALIVE
												managers.hud:add_waypoint('hudz_civ_'..tostring(unit_pos), { icon = 'wp_trade', distance = bShowDistance, position = unit_pos, no_sync = true, present_timer = 0, state = "present", radius = 1000, color = purple, blend_mode = "add" })
											else
												-- DEAD
											end
										end
									end
								end
							end
						end
						------------------
						-- ALESSO HEIST --
						------------------
						if managers.job:current_level_id() == 'arena' then
							-- C4
							if v:interaction().tweak_data == 'hold_search_c4' then
								managers.hud:add_waypoint('hudz_Wobj_'..k, { icon = 'pd2_c4', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							-- EXTINGUISHER
							if v:interaction().tweak_data == 'hold_take_fire_extinguisher' then
								managers.hud:add_waypoint('hudz_fire_'..k, { icon = 'pd2_fire', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							-- CUTTER
							if v:interaction().tweak_data == 'hold_circle_cutter' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_cutter', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							-- NOT AVAIABLE 
							if v:interaction().tweak_data == 'are_turn_on_tv' 
							or v:interaction().tweak_data == 'button_infopad' 
							or v:interaction().tweak_data == 'driving_drive' 
							or v:interaction().tweak_data == 'mcm_panicroom_keycard' 
							or v:interaction().tweak_data == 'pick_lock_hard_no_skill_deactivated' 
							or v:interaction().tweak_data == 'push_button' then 
							end
						end
						-------------
						-- BIG OIL --
						-------------
						-- BIG OIL DAY 1 INTEL
						if v:interaction().tweak_data == 'hold_take_blueprints' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_loot', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						elseif v:interaction().tweak_data == 'take_confidential_folder' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_loot', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						elseif v:interaction().tweak_data == 'pickup_asset' then
							managers.hud:add_waypoint('hudz_key_'..k, { icon = 'equipment_chavez_key', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-- BIG OIL DAY 1 SAFE
						if managers.job:current_level_id() == "welcome_to_the_jungle_1" and v:interaction().tweak_data == 'drill' then
							managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'pd2_drill', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-- BIG OIL DAY 2 ENGINE + SERVER
						if managers.job:current_level_id() == 'welcome_to_the_jungle_2' then
							if isHost() then
								values =
								{
									["103703"] = "ENGINE_01",
									["103704"] = "ENGINE_02",
									["103705"] = "ENGINE_03",
									["103706"] = "ENGINE_04",
									["103707"] = "ENGINE_05",
									["103708"] = "ENGINE_06",
									["103709"] = "ENGINE_07",
									["103711"] = "ENGINE_08",
									["103714"] = "ENGINE_09",
									["103715"] = "ENGINE_10",
									["103716"] = "ENGINE_11",
									["103717"] = "ENGINE_12"
								}
								engine_pos =
								{
									['103703'] = Vector3(-1830,-2182,-313.49200439453),  			-- 1
									['103704'] = Vector3(-1200,-2050,-313.49200439453), 			-- 2
									['103705'] = Vector3(-1849,-1869,-313.49200439453), 			-- 3
									['103706'] = Vector3(-1200,-1735,-313.49200439453), 			-- 4
									['103707'] = Vector3(-1849,-1429,-313.49200439453), 			-- 5
									['103708'] = Vector3(-1200,-1415,-313.49200439453), 			-- 6
									['103709'] = Vector3(-175,-2025,-313.49200439453), 				-- 7
									['103711'] = Vector3(-24.999900817871,-1350,-313.49200439453), 	-- 8
									['103714'] = Vector3(-175,-1675,-313.49200439453), 				-- 9
									['103715'] = Vector3(35,-1733,-314),							-- 10
									['103716'] = Vector3(-175,-1350,-313.49200439453),				-- 11
									['103717'] = Vector3(25,-2050,-313.49200439453)					-- 12
								}
								local srooms =
								{
									["101865"] = "SERVER ROOM : 2ND FLOOR \nNEXT TO THE OFFICE",
									["101866"] = "SERVER ROOM : 2ND FLOOR \nABOVE THE GYM",
									["101915"] = "SERVER ROOM : GROUND FLOOR"
								}
								local keyboard_id =
								{
									["101865"] = "8efe34cd3f706348",
									["101866"] = "8efe34cd3f706348",
									["101915"] = "8efe34cd3f706348"
								}
								local bo_servers =
								{
									["101865"] = Vector3(-662, -2142, 475), -- Room 1
									["101866"] = Vector3(-2129, 391, 475),  -- Room 2
									["101915"] = Vector3(-384, -96, 75)     -- Room 3
								}
								local bo_keyboard = tostring(managers.mission:script("default")._elements[101916]._values.on_executed[1].id)			
								correct_id = tostring(managers.mission:script('default')._elements[103718]._values.on_executed[1].id)
								if lp == false then
									-- CHAT
									if _keyboard_used == false then
										managers.chat:_receive_message(1, "SERVER ROOM", srooms[tostring(managers.mission:script("default")._elements[101916]._values.on_executed[1].id)],  tweak_data.system_chat_color)
									end
									if _engine_used == false then
										managers.chat:_receive_message(1, "BIG OIL", values[tostring(managers.mission:script("default")._elements[103718]._values.on_executed[1].id)],  tweak_data.system_chat_color)
									end
									lp = true
								end
								-- WAYPOINT SERVER
								if _keyboard_used == false then
									managers.hud:add_waypoint('hudz_base_'..bo_keyboard, { icon = 'interaction_keyboard', distance = bShowDistance, position = bo_servers[bo_keyboard], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
								-- WAYPOINT	ENGINE
								if _engine_used == false then
									managers.hud:add_waypoint('hudz_Robj_'..correct_id, { icon = 'pd2_loot', distance = bShowDistance, position = engine_pos[correct_id], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = 'add' })
								end	
								if v:interaction().tweak_data == 'carry_drop' and _checking_bags then
									if v:carry_data():carry_id() == values[correct_id] then
										managers.hud:add_waypoint('hudz_Robj_'..correct_id..'b', { icon = 'pd2_loot', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
									end
								end
							end
						end
						--------------
						-- BIG BANK --
						--------------
						-- BIG BANK SERVER
						if managers.job:current_level_id() == 'big' and v:interaction().tweak_data == 'big_computer_server' then
							if _bbserv_used == false then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_computer', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
						end
						-- BIG BANK KEYBOARDS LOCATION
						if isHost() and managers.job:current_level_id() == 'big' and (v:interaction().tweak_data == 'big_computer_hackable' or v:interaction().tweak_data == 'big_computer_server') then
							local big1 = tostring(managers.mission:script("default")._elements[103246]._original_on_executed[1].id)
							local big1 = tostring(managers.mission:script("default")._elements[103246]._values.on_executed[1].id)
							local stfcmpts = {
								["103250"] = Vector3(2754, 1420, -923),
								["103229"] = Vector3(2083, 1412, -922.772),
								["103569"] = Vector3(1941, 1345, -922.772),
								["103604"] = Vector3(1589, 1419, -922.772),
								["103647"] = Vector3(2558, 1847, -922.772),
								["103709"] = Vector3(2448.08, 1849.07, -922.772),
								["103749"] = Vector3(1859.2, 1832.25, -922.772),
								["103788"] = Vector3(1732, 1812, -923),
								["103898"] = Vector3(1090, 1220, -522.772),
								["103916"] = Vector3(1293.46, 1221.04, -522.772),
								["103927"] = Vector3(1909, 1389, -522.762),
								["103948"] = Vector3(1917.69, 1583.79, -522.762),
								["103966"] = Vector3(2318, 1608, -522.762),
								["103984"] = Vector3(2319.79, 1407.8, -522.762),
								["104006"] = Vector3(2716, 1220, -522.772),
								["104024"] = Vector3(2895.76, 1782.56, -522.772),
								["104042"] = Vector3(2922, 1218.89, -522.772),
								["104080"] = nil,
								["104127"] = nil,
								["104315"] = nil
							}
							if tostring(stfcmpts[big1]) ~= 'nil' then
								managers.hud:add_waypoint('hudz_Robj_'..'big', { icon = 'interaction_keyboard', distance = bShowDistance, position = stfcmpts[big1], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						else
							if v:interaction().tweak_data == 'big_computer_hackable' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'interaction_keyboard', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
						--------------
						-- CAR SHOP --
						--------------
						if managers.job:current_level_id() == 'cage' then
							-- SECURITY_STATION_KEYBOARD
							if isHost() and (v:interaction().tweak_data == 'security_station_keyboard' or v:interaction().tweak_data == 'gage_assignment') and _comp_used == false then
								local cage1 = tostring(managers.mission:script("default")._elements[104929]._original_on_executed[1].id)
								local cage1 = tostring(managers.mission:script("default")._elements[104929]._values.on_executed[1].id)
								local cmpts = {
									["104797"] = Vector3(2465.98, 660.75, -149.996),
									["104804"] = Vector3(2615.98, 660.75, -149.996),
									["104811"] = Vector3(2890.98, 660.75, -149.996),
									["104818"] = Vector3(3040.98, 660.75, -149.996),
									["104826"] = Vector3(3045.98, 405.75, -149.996),
									["104833"] = Vector3(2887.98, 407.75, -149.996),
									["104841"] = Vector3(2615.98, 410.75, -149.996),
									["104848"] = Vector3(2465.98, 407.75, -149.996),
									["104857"] = Vector3(1077.98, 255.751, 250.004),
									["104866"] = Vector3(924.978, 255.75, 250.004),
									["104873"] = Vector3(617.978, 255.75, 250.004),
									["104880"] = Vector3(468.978, 255.749, 250.004),
									["104887"] = Vector3(423.024, 142.249, 250.004),
									["104899"] = Vector3(590.024, 142.25, 250.004),
									["104907"] = Vector3(880.024, 142.25, 250.004),
									["104919"] = Vector3(1049.02, 142.251, 250.004),
									["104927"] = Vector3(254.75, -1490.98, 249.503)
								}
								managers.hud:add_waypoint('hudz_Robj_'..'cage', { icon = 'wp_target', distance = bShowDistance, position = cmpts[cage1], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
						-------------------
						-- DIAMOND STORE --
						-------------------
						-- KEYPAD
						if managers.job:current_level_id() == "family" and v:interaction().tweak_data == 'numpad_keycard' then 
							managers.hud:add_waypoint('hudz_door_'..k, { icon = 'wp_powerbutton', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = cyan, blend_mode = "add" })
						end 
						------------------
						-- ELECTION DAY --
						------------------
						-- ELECTION DAY 1 COMPUTER LOCATION
						if managers.job:current_level_id() == 'election_day_1' and v:interaction().tweak_data == 'uload_database' then
							managers.hud:add_waypoint('hudz_uload'..k, { icon = 'pd2_computer', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-- ELECTION DAY 1 TRUCK
						if managers.job:current_level_id() == 'election_day_1' then
							if isHost() then
								local trucks =
								{
									["100636"] = "1",
									["100633"] = "2",
									["100637"] = "3",
									["100634"] = "4",
									["100639"] = "5",
									["100635"] = "6"
								}
								local truckid =
								{
									["100633"] = "3b0947a2434bdc93",
									["100634"] = "3b0947a2434bdc93",
									["100635"] = "3b0947a2434bdc93",
									["100636"] = "3b0947a2434bdc93",
									["100637"] = "3b0947a2434bdc93",
									["100639"] = "3b0947a2434bdc93"
								}
								local truck_vectors =
								{
									["100636"] = Vector3(150, -3900, 0), 		-- 1st
									["100633"] = Vector3(878.392, -3360.24, 0), -- 2nd
									["100637"] = Vector3(149.999, -2775, 0), 	-- 3rd
									["100634"] = Vector3(828.07, -2222.45, 0), 	-- 4th
									["100639"] = Vector3(149.998, -1625, 0), 	-- 5th
									["100635"] = Vector3(848.961, -1084.9, 0) 	-- 6th
								}
								local truckv = tostring(managers.mission:script("default")._elements[100631]._values.on_executed[1].id)
								-- WAYPOINT SERVER
								if _gps_used == false then
									managers.hud:add_waypoint('hudz_Robj_'..truckv, { icon = 'wp_target', distance = bShowDistance, position = truck_vectors[truckv], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							else
							end
						end
						-- ELECTION DAY 2 MACHINES
						if v:interaction().tweak_data == 'votingmachine2' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_computer', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-- ELECTION DAY 3 KEYBOARD
						if managers.job:current_level_id() == 'election_day_3_skip1' and v:interaction().tweak_data == 'security_station_keyboard' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'interaction_keyboard', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-----------------
						-- FIRESTARTER --
						-----------------
						-- FIRESTARTER DAY 2 SECURITY BOXES LOCATION
						if managers.job:current_level_id() == 'firestarter_2' and v:interaction().tweak_data == 'open_slash_close_sec_box' and managers.groupai:state():whisper_mode() then
							if isHost() then
								bo_boxes = {
									["105819"] = Vector3(-2710, -2830, 552),	-- Box 001
									["105794"] = Vector3(-1840, -3195, 552),	-- Box 002
									["105810"] = Vector3(-1540, -2195, 552),	-- Box 003
									["105824"] = Vector3(-1005, -3365, 552),	-- Box 004
									["105837"] = Vector3(-635, -1705, 552),		-- Box 005
									["105851"] = Vector3(-1095, -210, 152),		-- Box 006
									["106183"] = Vector3(-1230, 1510, 152),		-- Box 007
									["106529"] = Vector3(-1415, -795, 152),		-- Box 008
									["106543"] = Vector3(-1160, 395, 152),		-- Box 009
									["106556"] = Vector3(-5, 735, 152),			-- Box 010
									["106581"] = Vector3(1360, 5, 552),			-- Box 011
									["106594"] = Vector3(795, -898, 552),		-- Box 012
									["106607"] = Vector3(795, -3240, 552),		-- Box 013
									["106620"] = Vector3(1060, -2195, 552),		-- Box 014
									["106633"] = Vector3(204, 540, 578),		-- Box 015
									["106646"] = Vector3(-1085, -1205, 552),	-- Box 016
									["106659"] = Vector3(-2135, 395, 552),		-- Box 017
									["106672"] = Vector3(-2405, -840, 552),		-- Box 018
									["106685"] = Vector3(-2005, -1640, 552),	-- Box 019
									["106698"] = Vector3(-2715, -1595, 552),	-- Box 020
										["106711"] = Vector3(-500, -650, 1300),		-- Box 021
										["106724"] = Vector3(-400, -650, 1300),		-- Box 022
										["106737"] = Vector3(-300, -650, 1300),		-- Box 023		UNAVAILABLE
										["106750"] = Vector3(-200, -650, 1300),		-- Box 024
										["106763"] = Vector3(-100, -650, 1300),		-- Box 025
									["106776"] = Vector3(-635, -1205, 152),		-- Box 026
									["106789"] = Vector3(-1040, -95, 552),		-- Box 027
									["106802"] = Vector3(615, 395, 152),		-- Box 028
									["106815"] = Vector3(1890, -1805, 152),		-- Box 029
									["106828"] = Vector3(215, -1805, 152)		-- Box 030
								}
								SecBox1 = tostring(managers.mission:script("default")._elements[106836]._values.on_executed[1].id)
								SecBox2 = tostring(managers.mission:script("default")._elements[106836]._values.on_executed[2].id)
								if _box1_used == false then
									managers.hud:add_waypoint('hudz_Robj_'..SecBox1, { icon = 'interaction_wirecutter', distance = bShowDistance, position = bo_boxes[SecBox1], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
								if _box2_used == false then
									managers.hud:add_waypoint('hudz_Robj_'..SecBox2, { icon = 'interaction_wirecutter', distance = bShowDistance, position = bo_boxes[SecBox2], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							elseif isClient() then
								nb = nb + 1
								if clientBox[nb] ~= 0 then
									clientBox[nb] = v:position()
									-- managers.chat:_receive_message(1, "Box_Client"..nb, tostring(clientBox[nb]),  Color.green)
									managers.hud:add_waypoint('hudz_box_'..k, { icon = 'interaction_wirecutter', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							end
						end
						if nb == 5 then 
							nb = 0
						end
						-------------------
						-- FRAMING FRAME --
						-------------------
						-- FRAMING FRAME & GALLERY PAINTINGS
						if managers.job:current_level_id() == 'framing_frame_1' and v:interaction().tweak_data == 'hold_take_painting' then
						managers.hud:add_waypoint('hudz_ptn_'..k, { icon = 'interaction_diamond', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
						end
						if managers.job:current_level_id() == 'gallery' and v:interaction().tweak_data == 'hold_take_painting' then
						managers.hud:add_waypoint('hudz_ptn_'..k, { icon = 'interaction_diamond', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
						end
						-- FRAMING FRAME DAY 3 SERVERS LOCATION
						if managers.job:current_level_id() == "framing_frame_3" and (v:interaction().tweak_data == 'hold_take_server' or v:interaction().tweak_data == 'stash_server_pickup') then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_server', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						-- FRAMING FRAME DAY 3 COMPUTER LOCATION
						elseif v:interaction().tweak_data == 'use_computer' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'laptop_objective', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						-- FRAMING FRAME DAY 3 PHONE LOCATION
						elseif v:interaction().tweak_data == 'pickup_phone' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_phone', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						-- FRAMING FRAME DAY 3 TABLET LOCATION
						elseif v:interaction().tweak_data == 'pickup_tablet' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_hack_ipad', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-- FRAMING FRAME DAY 3 SERVER
						if managers.job:current_level_id() == 'framing_frame_3' then
							if isHost() then
								local servers =
								{
									["105507"] = "Server Room 1",
									["105508"] = "Server Room 2",
									["100650"] = "Server Room 3"
								}
								local keyboard =
								{
									["105507"] = "58cb6c4c6221c415",
									["105508"] = "58cb6c4c6221c415",
									["100650"] = "58cb6c4c6221c415"
								}
								local server_vectors =
								{
									["105507"] = Vector3(-3937.26, 5644.73, 3474.5), -- OFFICE
									["105508"] = Vector3(-3169.57, 4563.03, 3074.5), -- HALLWAY
									["100650"] = Vector3(-4920, 3737, 3074.5)    -- LIVING ROOM
								}
								local svectors = tostring(managers.mission:script("default")._elements[105506]._values.on_executed[1].id)
								-- WAYPOINT SERVER
								if _FF3_used == false then
									managers.hud:add_waypoint('hudz_base_'..svectors, { icon = 'interaction_keyboard', distance = bShowDistance, position = server_vectors[svectors], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							elseif isClient() then
							end
						end
						-------------------
						-- HOTLINE MIAMI --
						-------------------
						-- HOTLINE MIAMI DAY 1
						if managers.job:current_level_id() == 'mia_1' then
							if v:interaction().tweak_data == 'hold_take_gas_can' then
								managers.hud:add_waypoint('hudz_fire_'..k, { icon = 'equipment_thermite', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'hlm_roll_carpet' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_target', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
						end
						-- HOTLINE MIAMI DAY 2
						if managers.job:current_level_id() == 'mia_2' then
							if v:interaction().tweak_data == 'disarm_bomb' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_target', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'hold_hlm_open_circuitbreaker' or v:interaction().tweak_data == 'hold_remove_cover' or v:interaction().tweak_data == 'hold_cut_cable' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_powersupply', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'c4_mission_door' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_c4', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
						end
						---------------------
						-- HOXTON BREAKOUT --
						---------------------
						-- HOXTON BREAKOUT DAY 1
						if managers.job:current_level_id() == 'hox_1' and _comp_used == false then
							if isHost() then
								local hox1 = tostring(managers.mission:script("default")._elements[101519]._original_on_executed[1].id)
								local hox1 = tostring(managers.mission:script("default")._elements[101519]._values.on_executed[1].id)
								local srvrooms = {
									["101520"] = Vector3(9458.71, 5680, -2690),
									["101523"] = Vector3(12966.3, 8320, -2690),
									["101524"] = Vector3(9741.29, 8520, -2590),
									["101525"] = Vector3(11341.3, 8520, -2390),
									["101527"] = Vector3(8233.71, 5880, -2290),
									["101528"] = Vector3(9741.29, 8520, -2190),
									["101529"] = Vector3(11341.3, 8520, -1990),
									["101531"] = Vector3(8741.29, 8195, -1890),
									["101806"] = Vector3(10558.7, 6130, -1890),
									["101807"] = Vector3(12258.7, 4280, -2290)
								}
								if tostring(srvrooms[hox1]) ~= 'nil' then
									managers.hud:add_waypoint('hudz_Robj_'..'hox1', { icon = 'interaction_keyboard', distance = bShowDistance, position = srvrooms[hox1], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.yellow, blend_mode = "add" })
								end
							else
								if v:interaction().tweak_data == 'shaped_sharge' then
									managers.hud:add_waypoint('hudz_Wobj_'..k, { icon = 'interaction_keyboard', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.yellow, blend_mode = "add" })
								end
							end
						end
						-- HOX DAY 2
						if managers.job:current_level_id() == 'hox_2' then
							if v:interaction().tweak_data == 'firstaid_box'
							or v:interaction().tweak_data == 'invisible_interaction_open'
							then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_doctor_bag', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'grenade_crate' or v:interaction().tweak_data == 'ammo_bag' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_ammo_bag', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'hold_download_keys' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'interaction_keyboard', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'invisible_interaction_gathering' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_evidence', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
							-- FILES
							if v:interaction().tweak_data == 'search_files_false' then
								managers.hud:add_waypoint('hudz_Wobj_'..k, { icon = 'equipment_files', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
							end
							-- CORRECT FILE
							if v:interaction().tweak_data == 'invisible_interaction_searching' then
								managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'equipment_files', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'grab_server' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_server', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
						end
						--------------------
						-- HOXTON REVENGE --
						--------------------
						if managers.job:current_level_id() == 'hox_3' then
							if v:interaction().tweak_data == 'gen_pku_evidence_bag' then
								managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'equipment_evidence', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'mcm_fbi_taperecorder' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_talk', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'mcm_panicroom_keycard_1' then
								managers.hud:add_waypoint('hudz_door_'..k, { icon = 'wp_powerbutton', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'mcm_panicroom_keycard_2' then
								managers.hud:add_waypoint('hudz_door_'..k, { icon = 'wp_powerbutton', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'mcm_break_planks' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_planks', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'open_slash_close_sec_box' or v:interaction().tweak_data == 'hospital_security_cable' then
								managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'pd2_wirecutter', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'invisible_interaction_open' or v:interaction().tweak_data == 'rewire_electric_box' or v:interaction().tweak_data == 'use_server_device' then
								managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'wp_target', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'mcm_laptop' then
								managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'laptop_objective', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							local hox3 = tostring(managers.mission:script("default")._elements[101779]._values.on_executed[1].id)
							local phone_poles =
							{
								["101764"] = Vector3(3058.81, -103.151, -4),
								["101765"] = Vector3(3040.08, 1912.44, 1141),
								["101766"] = Vector3(-3563.02, 1813.98, -164.391),
								["101776"] = Vector3(-3041.99, -2321.82, -23.1596),
								["101780"] = Vector3(-236.471, -2545, 262.968)
							}
							managers.hud:add_waypoint('hudz_Robj_'..'hox3', { icon = 'pd2_phone', distance = bShowDistance, position = phone_poles[hox3], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.yellow, blend_mode = "add" })
						end
						--------------
						-- LAB RATS --
						--------------
						-- PLACEHOLDER
						if managers.job:current_level_id() == 'nail' then
							if v:interaction().tweak_data == 'alaska_plane' then
								managers.hud:add_waypoint('hudz_meth_'..k, { icon = 'equipment_sleeping_gas', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
						--------------
						-- MELTDOWN --
						--------------
						if managers.job:current_level_id() == 'shoutout_raid' then
							if v:interaction().tweak_data == 'driving_drive' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_ejection_seat', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'gen_pku_warhead_box' then
								managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'pd2_lootdrop', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'gen_pku_warhead' then
								managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'pd2_loot', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'gen_pku_crowbar' then
								managers.hud:add_waypoint('hudz_crow_'..k, { icon = 'equipment_crowbar', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
						end
						----------------------------------------
						-- POINT BREAK : BENEATH THE MOUNTAIN --
						----------------------------------------
						if managers.job:current_level_id() == 'pbr' then
							if v:interaction().tweak_data == 'crate_loot' and bShowCrates then
								managers.hud:add_waypoint('hudz_crate_'..k, { icon = 'pd2_defend', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
						------------------------------------
						-- POINT BREAK : BIRTH OF THE SKY --
						------------------------------------
						-- PLACEHOLDER
						if managers.job:current_level_id() == 'pbr2' then
							if v:interaction().tweak_data == 'hold_take_parachute' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_sleeping_gas', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'money_wrap' then
								managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'equipment_money_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'money_wrap_single_bundle' and bShowSmallLoot then
								managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
						----------
						-- RATS --
						----------
						-- RATS DAY 1
						if v:interaction().tweak_data == 'caustic_soda' then
							managers.hud:add_waypoint('hudz_coke1_'..k, { icon = 'pd2_methlab', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						elseif v:interaction().tweak_data == 'hydrogen_chloride' then
							managers.hud:add_waypoint('hudz_coke2_'..k, { icon = 'pd2_methlab', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						elseif v:interaction().tweak_data == 'muriatic_acid' then
							managers.hud:add_waypoint('hudz_coke3_'..k, { icon = 'pd2_methlab', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-- RATS DAY 2
						if managers.job:current_level_id() == 'alex_2' and not _intel_used then
							if isHost() then
								local values =
								{
									["103805"] = "Intel Revealer: Safe_01",
									["103806"] = "Intel Revealer: Safe_02",
									["103807"] = "Intel Revealer: Safe_03",		
									["103808"] = "Intel Revealer: Safe_04",
									["103809"] = "Intel Revealer: Safe_05",
									["103810"] = "Intel Revealer: Safe_06",
									["103811"] = "Intel Revealer: Safe_07",	
									["103812"] = "Intel Revealer: Safe_08",
									["103813"] = "Intel Revealer: Safe_09",
									["103814"] = "Intel Revealer: Safe_10",
									["103815"] = "Intel Revealer: Safe_11",
									["103816"] = "Intel Revealer: Safe_12",
									["103817"] = "Intel Revealer: Safe_13",
									["103818"] = "Intel Revealer: Safe_14",
									["103819"] = "Intel Revealer: Safe_15",
									["103820"] = "Intel Revealer: Safe_16"
								}
								local bo_safes = {
									["103805"] = Vector3(791, 1426, 50),
									["103806"] = Vector3(326, 1673, 50),
									["103807"] = Vector3(365, 2022, 103.2),	
									["103808"] = Vector3(560, 2175, 127.603),
									["103809"] = Vector3(2220, 1273, 82.103),
									["103810"] = Vector3(2079, 1013, 117.503),
									["103811"] = Vector3(2502, 1015, 50),
									["103812"] = Vector3(2332, 1100, 50),
									["103813"] = Vector3(3162, 2742, 82.1028),
									["103814"] = Vector3(2704, 2342, 114.325),
									["103815"] = Vector3(3400, 2662, 117.285),
									["103816"] = Vector3(2440, 2747, 50),
									["103817"] = Vector3(2474, 3414, 250),
									["103818"] = Vector3(3181, 3696, 250),
									["103819"] = Vector3(2625, 4003, 250),
									["103820"] = Vector3(2755, 3901, 250)
								}
								local bo_intel = tostring(managers.mission:script("default")._elements[103759]._values.on_executed[1].id)
								if _intel_used == false then
									managers.hud:add_waypoint('hudz_base_'..bo_intel, { icon = 'interaction_patientfile', distance = bShowDistance, position = bo_safes[bo_intel], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							elseif isClient() then
								-- 2 SAFES
								if (v:interaction().tweak_data == 'drill' or v:interaction().tweak_data == 'take_confidential_folder') then
									managers.hud:add_waypoint('hudz_base_'..k, { icon = 'interaction_patientfile', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							end
						end
						-----------------
						-- SHADOW RAID --
						-----------------
						-- SHADOW RAID SERVER
						if managers.job:current_level_id() == "kosugi" and v:interaction().tweak_data == 'hold_take_server' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_server', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						-- SHADOW RAID PAINTINGS/STATUE
						elseif managers.job:current_level_id() == "kosugi" and (v:interaction().tweak_data == 'hold_take_painting' or v:interaction().tweak_data == 'gen_pku_artifact_statue') then
							managers.hud:add_waypoint('hudz_ptn_'..k, { icon = 'pd2_loot', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						-- SHADOW RAID ARMOR
						elseif managers.job:current_level_id() == "kosugi" and v:interaction().tweak_data == 'samurai_armor' then
							managers.hud:add_waypoint('hudz_fire_'..k, { icon = 'wp_scrubs', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						-- SHADOW RAID SEWER THERMITE
						elseif managers.job:current_level_id() == "kosugi" and v:interaction().tweak_data == 'apply_thermite_paste' and bShowThermite then
							managers.hud:add_waypoint('hudz_fire_'..k, { icon = 'equipment_thermite', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						--------------------
						-- SLAUGHTERHOUSE --
						--------------------
						if managers.job:current_level_id() == 'dinner' then
							if v:interaction().tweak_data == 'pku_pig' then 
								managers.hud:add_waypoint('hudz_lsd_'..k, { icon = 'equipment_winch_hook', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
							elseif v:interaction().tweak_data == 'hold_take_gas_can' then
								managers.hud:add_waypoint('hudz_fire_'..k, { icon = 'equipment_thermite', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
							elseif v:interaction().tweak_data == 'money_wrap_single_bundle_active' and bShowSmallLoot then
								managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
						-----------------
						-- TRAIN HEIST --
						-----------------
						-- INTEL TRAIN HEIST
						if (managers.job:current_level_id() == 'arm_cro' or managers.job:current_level_id() == 'arm_fac' or managers.job:current_level_id() == 'arm_hcm' or managers.job:current_level_id() == 'arm_par' or managers.job:current_level_id() == 'arm_und') and v:interaction().tweak_data == 'take_confidential_folder_event' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'interaction_patientfile', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
						end
						-- TRAIN HEIST TURRET
						if managers.job:current_level_id() == "arm_for" and v:interaction().tweak_data == 'disassemble_turret' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_sentry', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
						end
						if managers.job:current_level_id() == "arm_for" then
							if isHost() then 
								local vault1 = tostring(managers.mission:script("default")._elements[104736]._values.on_executed[1].id)
								local vault2 = tostring(managers.mission:script("default")._elements[104737]._values.on_executed[1].id)
								local vault3 = tostring(managers.mission:script("default")._elements[104738]._values.on_executed[1].id)
								if _drill1_used == false then
									if vault1 == '104731' then
										managers.hud:add_waypoint('hudz_base_'..vault1, { icon = 'wp_target', distance = bShowDistance, position = Vector3(-2710, -1152, 666), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
									elseif vault1 == '104729' then
										managers.hud:add_waypoint('hudz_base_'..vault1, { icon = 'wp_target', distance = bShowDistance, position = Vector3(-1707, -1157, 667), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
									end
								end
								if _drill2_used == false then
									if vault2 == '104732' then
										managers.hud:add_waypoint('hudz_base_'..vault2, { icon = 'wp_target', distance = bShowDistance, position = Vector3(-192, -1152, 668), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
									elseif vault2 == '104733' then
										managers.hud:add_waypoint('hudz_base_'..vault2, { icon = 'wp_target', distance = bShowDistance, position = Vector3(794, -1161, 668), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
									end
								end
								if _drill3_used == false then
									if vault3 == '104734' then
										managers.hud:add_waypoint('hudz_base_'..vault3, { icon = 'wp_target', distance = bShowDistance, position = Vector3(2291, -1155, 667), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
									elseif vault3 == '104735' then
										managers.hud:add_waypoint('hudz_base_'..vault3, { icon = 'wp_target', distance = bShowDistance, position = Vector3(3308, -1151, 667), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
									end
								end
							end
						end
						-------------------------
						-- THE BOMB : DOCKYARD --
						-------------------------
						if managers.job:current_level_id() == 'crojob2' then
							-- COMPUTERS
							if v:interaction().tweak_data == 'uload_database' and _uldatabase_found == false then
								managers.hud:add_waypoint('hudz_uload'..k, { icon = 'pd2_computer', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							-- RIGHT POSITION OF THE BOMB
							if v:interaction().tweak_data == 'hold_pku_disassemble_cro_loot' and _bomb_ok == false then
								_bomb_pos = v:position()
								_bomb_ok = true
							end
							-- 4 POSITIONS OF THE BOMB + RIGHT POSITION
							if v:interaction().tweak_data == 'hold_pku_disassemble_cro_loot'
							and _bomb_ok == true and _bomb_used > 3 and _bomb_used <= 8
							then
								managers.hud:remove_waypoint('hudz_Robj_'..'bomb' )
								managers.hud:add_waypoint('hudz_Robj_'..k, { icon = 'wp_target', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'hold_open_bomb_case' and (_bomb_used == 4 or _bomb_used == 3) then
								if v:position() == _bomb_pos then
									managers.hud:add_waypoint('hudz_Robj_'..'bomb', { icon = 'wp_target', distance = bShowDistance, position = _bomb_pos, no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
								else
									managers.hud:add_waypoint('hudz_Wobj_'..k, { icon = 'wp_target', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
								end
							elseif v:interaction().tweak_data == 'hold_open_bomb_case' and _bomb_used > 3 then
								managers.hud:add_waypoint('hudz_Wobj_'..k, { icon = 'wp_target', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
							end
						end
						-----------------------
						-- THE BOMB : FOREST --
						-----------------------
						if managers.job:current_level_id() == 'crojob3' then
							-- CARGO DOOR
							if v:interaction().tweak_data == 'open_train_cargo_door' then
								managers.hud:add_waypoint('hudz_door_'..k, { icon = 'wp_door', distance = false, position = v:interaction():interact_position(), 
								no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
							-- LADDER
							if v:interaction().tweak_data == 'pick_lock_easy_no_skill' 
							or v:interaction().tweak_data == 'hold_remove_ladder' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_ladder', distance = true, position = v:interaction():interact_position(), 
								no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.green, blend_mode = "add" })
							end
							-- CHAINSAW
							if v:interaction().tweak_data == 'take_chainsaw' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_chainsaw', distance = true, position = v:interaction():interact_position(), 
								no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.red, blend_mode = "add" })
							end
							if v:interaction().tweak_data == 'use_chainsaw' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_chainsaw', distance = true, position = v:interaction():interact_position(), 
								no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.orange, blend_mode = "add" })
							end
						end
						------------------
						-- UKRANIAN JOB --
						------------------
						-- UKRAINIAN JOB POWER
						if v:interaction().tweak_data == 'circuit_breaker' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_powersupply', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-- UKRAINIAN JOB TIARA LOCATION
						if managers.job:current_level_id() == "ukrainian_job" and _tiara_used == false then
							if isHost() or isClient() then
								local unit_list = World:find_units_quick( "all" )
								for _,unit in ipairs( unit_list ) do
									if unit:base() and tostring(unit:name()) == "Idstring(@ID077636ce1f33c8d0@)" --[[TIARA]] then
										managers.hud:add_waypoint('hudz_Robj_'.._, { icon = 'pd2_loot', distance = bShowDistance, position = unit:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									end
								end
							end
						end
						----------------
						-- WHITE XMAS --
						----------------
						if managers.job:current_level_id() == 'pines' then
							-- XMAS PRESENTS
							if v:interaction().tweak_data == 'hold_open_xmas_present' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'interaction_christmas_present', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							-- COKE
							if v:interaction().tweak_data == 'gen_pku_cocaine_pure' then
								managers.hud:add_waypoint('hudz_coke_'..k, { icon = 'wp_vial', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
							-- ALMIR'S TOAST
							if v:interaction().tweak_data == 'gen_pku_sandwich' then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'pd2_loot', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
						--------------------
						-- DIAMOND MUSEUM --
						--------------------
						-- ELECTRIC BOX
						if managers.job:current_level_id() == 'mus' then
							if (v:interaction().tweak_data == 'invisible_interaction_open' or v:interaction().tweak_data == 'rewire_electric_box') and v:interaction():interact_position() ~= Vector3(6150, 549, -500) then
								managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_powersupply', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							-- GLASS
							elseif v:interaction().tweak_data == 'gen_pku_artifact' then
								managers.hud:add_waypoint('hudz_atm_'..k, { icon = 'interaction_diamond', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							-- ARTIFACTS
							elseif v:interaction().tweak_data == 'mus_pku_artifact' then
								managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							-- PAINTINGS
							elseif v:interaction().tweak_data == 'gen_pku_artifact_painting'
							and v:interaction():interact_position() ~= Vector3(-2271.7534179688, -2397.224609375, -221.53845214844)
							and v:interaction():interact_position() ~= Vector3(-1425, -2260, -633.00500488281) then
								managers.hud:add_waypoint('hudz_ptn_'..k, { icon = 'equipment_ticket', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							end
						end
						-----------------------------
						-- DIAMOND MUSEUM - PUZZLE --
						-----------------------------
						local tweak_puzzle = { 'mus_hold_open_display', 'rewire_electric_box' }
						local _path_ok = _script_activated - _path_created
						if _path_ok > 0 then
							_hack_ok = true
						else
							_hack_ok = false
						end
						if isHost() and (managers.job:current_level_id() == 'mus') and (v:interaction().tweak_data == tweak_puzzle[1] or tweak_puzzle[2]) then
							_path_terminated = false
							local tiles_all = 
							{
						-- FLOOR
								["133577"] = Vector3(6475, 700, -600),	-- a001
								["133578"] = Vector3(6475, 500, -600),	-- a002
								["133579"] = Vector3(6475, 300, -600),	-- a003
								["133580"] = Vector3(6475, 100, -600),	-- a004
								["133581"] = Vector3(6475, -100, -600),	-- a005
								["133582"] = Vector3(6475, -300, -600),	-- a006
						-- A --
								["133583"] = Vector3(6675, 700, -600),	-- b001		UP
								["133584"] = Vector3(6675, 500, -600),	-- b002		UP
								["133585"] = Vector3(6675, 300, -600),	-- b003		UP
								["133586"] = Vector3(6675, 100, -600),	-- b004		UP
								["133587"] = Vector3(6675, -100, -600),	-- b005		UP
								["133588"] = Vector3(6675, -300, -600),	-- b006		UP
						-- B --
								-- b001 : 133631
								["133638"] = Vector3(6675, 500, -600),	-- b002		RIGHT
								["133589"] = Vector3(6875, 700, -600),	-- c001		UP
								-- b002 : 133633
								["133640"] = Vector3(6675, 300, -600),	-- b003		RIGHT
								["133590"] = Vector3(6875, 500, -600),	-- c002		UP
								["133639"] = Vector3(6675, 700, -600),	-- b001		LEFT
								-- b003 : 133634
								["133591"] = Vector3(6875, 300, -600),	-- c003		UP
								["133642"] = Vector3(6675, 100, -600),	-- b004		RIGHT
								["133641"] = Vector3(6675, 500, -600),	-- b002		LEFT
								-- b004 : 133635
								["133592"] = Vector3(6875, 100, -600),	-- c004		UP
								["133643"] = Vector3(6675, 300, -600),	-- b003		LEFT
								["133645"] = Vector3(6675, -100, -600),	-- b005		RIGHT
								-- b005 : 133636
								["133593"] = Vector3(6875, -100, -600),	-- c005		UP
								["133647"] = Vector3(6675, -300, -600),	-- b006		RIGHT
								["133644"] = Vector3(6675, 100, -600),	-- b004		LEFT
								-- b006 : 133637
								["133594"] = Vector3(6875, -300, -600),	-- c005		UP
								["133646"] = Vector3(6675, -100, -600),	-- b005		LEFT
						-- C --
								-- c001 : 133650
								["133595"] = Vector3(7075, 700, -600),	-- d001		UP
								["133648"] = Vector3(6875, 500, -600),	-- c002		RIGHT
								-- c002 : 133653
								["133601"] = Vector3(7075, 500, -600),	-- d002		UP
								["133652"] = Vector3(6875, 300, -600),	-- c003		RIGHT
								["133649"] = Vector3(6875, 700, -600),	-- c001		LEFT
								-- c003 : 133656
								["133607"] = Vector3(7075, 300, -600),	-- d003		UP
								["133655"] = Vector3(6875, 100, -600),	-- c004		RIGHT
								["133651"] = Vector3(6875, 500, -600),	-- c002		LEFT
								-- c004 : 133659
								["133613"] = Vector3(7075, 100, -600),	-- d004		UP
								["133658"] = Vector3(6875, -100, -600),	-- c005		RIGHT
								["133654"] = Vector3(6875, 300, -600),	-- c003		LEFT
								-- c005 : 133662
								["133619"] = Vector3(7075, -100, -600),	-- d005		UP
								["133661"] = Vector3(6875, -300, -600),	-- c006		RIGHT
								["133657"] = Vector3(6875, 100, -600),	-- c004		LEFT
								-- c006 : 133663
								["133625"] = Vector3(7075, -300, -600),	-- d006		UP
								["133660"] = Vector3(6875, -100, -600),	-- c005		LEFT
						-- D --
								-- d001 : 133666
								["133596"] = Vector3(7275, 700, -600),	-- e001		UP
								["133664"] = Vector3(7075, 500, -600),	-- d002		RIGHT
								-- d002 : 133669
								["133602"] = Vector3(7275, 500, -600),	-- e002		UP
								["133667"] = Vector3(7075, 300, -600),	-- d003		RIGHT
								["133665"] = Vector3(7075, 700, -600),	-- d001		LEFT
								-- d003 : 133672
								["133608"] = Vector3(7275, 300, -600),	-- e003		UP
								["133670"] = Vector3(7075, 100, -600),	-- d004		RIGHT
								["133668"] = Vector3(7075, 500, -600),	-- d002		LEFT
								-- d004 : 133675
								["133614"] = Vector3(7275, 100, -600),	-- e004		UP
								["133673"] = Vector3(7075, -100, -600),	-- d005		RIGHT
								["133671"] = Vector3(7075, 300, -600),	-- d003		LEFT
								-- d005 : 133678
								["133620"] = Vector3(7275, -100, -600),	-- e005		UP
								["133676"] = Vector3(7075, -300, -600),	-- d006		RIGHT
								["133674"] = Vector3(7075, 100, -600),	-- d004		LEFT
								-- d006 : 133679
								["133626"] = Vector3(7275, -300, -600),	-- e006		UP
								["133677"] = Vector3(7075, -100, -600),	-- d005		LEFT
						-- E --
								-- e001 : 133680
								["133597"] = Vector3(7475, 700, -600),	-- f001		UP
								["133682"] = Vector3(7275, 500, -600),	-- e002		RIGHT
								-- e002 : 133683
								["133603"] = Vector3(7475, 500, -600),	-- f002		UP
								["133684"] = Vector3(7275, 300, -600),	-- e003		RIGHT
								["133681"] = Vector3(7275, 700, -600),	-- e001		LEFT
								-- e003 : 133686
								["133609"] = Vector3(7475, 300, -600),	-- f003		UP
								["133687"] = Vector3(7275, 100, -600),	-- e004		RIGHT
								["133685"] = Vector3(7275, 500, -600),	-- e002		LEFT
								-- e004 : 133689
								["133615"] = Vector3(7475, 100, -600),	-- f004		UP
								["133690"] = Vector3(7275, -100, -600),	-- e005		RIGHT
								["133688"] = Vector3(7275, 300, -600),	-- e003		LEFT
								-- e005 : 133692
								["133621"] = Vector3(7475, -100, -600),	-- f005		UP
								["133693"] = Vector3(7275, -300, -600),	-- e006		RIGHT
								["133691"] = Vector3(7275, 100, -600),	-- e004		LEFT
								-- e006 : 133695
								["133627"] = Vector3(7475, -300, -600),	-- f006		UP
								["133694"] = Vector3(7275, -100, -600),	-- e005		LEFT
						-- F --
								-- f001 : 133696
								["133598"] = Vector3(7675, 700, -600),	-- g001		UP
								["133698"] = Vector3(7475, 500, -600),	-- f002		RIGHT
								-- f002 : 133699
								["133604"] = Vector3(7675, 500, -600),	-- g002		UP
								["133700"] = Vector3(7475, 300, -600),	-- f003		RIGHT
								["133697"] = Vector3(7475, 700, -600),	-- f001		LEFT
								-- f003 : 133702
								["133610"] = Vector3(7675, 300, -600),	-- g003		UP
								["133703"] = Vector3(7475, 100, -600),	-- f004		RIGHT
								["133701"] = Vector3(7475, 500, -600),	-- f002		LEFT
								-- f004 : 133705
								["133616"] = Vector3(7675, 100, -600),	-- g004		UP
								["133706"] = Vector3(7475, -100, -600),	-- f005		RIGHT
								["133704"] = Vector3(7475, 300, -600),	-- f003		LEFT
								-- f005 : 133708
								["133622"] = Vector3(7675, -100, -600),	-- g005		UP
								["133709"] = Vector3(7475, -300, -600),	-- f006		RIGHT
								["133707"] = Vector3(7475, 100, -600),	-- f004		LEFT
								-- f006 : 133711
								["133628"] = Vector3(7675, -300, -600),	-- g006		UP
								["133710"] = Vector3(7475, -100, -600),	-- f005		LEFT
						-- G --
								-- g001 : 133712
								["133599"] = Vector3(7875, 700, -600),	-- h001		UP
								["133714"] = Vector3(7675, 500, -600),	-- g002		RIGHT
								-- g002 : 133715
								["133605"] = Vector3(7875, 500, -600),	-- h002		UP
								["133716"] = Vector3(7675, 300, -600),	-- g003		RIGHT
								["133713"] = Vector3(7675, 700, -600),	-- g001		LEFT
								-- g003 : 133718
								["133611"] = Vector3(7875, 300, -600),	-- h003		UP
								["133719"] = Vector3(7675, 100, -600),	-- g004		RIGHT
								["133717"] = Vector3(7675, 500, -600),	-- g002		LEFT
								-- g004 : 133721
								["133617"] = Vector3(7875, 100, -600),	-- h004		UP
								["133722"] = Vector3(7675, -100, -600),	-- g005		RIGHT
								["133720"] = Vector3(7675, 300, -600),	-- g003		LEFT
								-- g005 : 133724
								["133623"] = Vector3(7875, -100, -600),	-- h005		UP
								["133725"] = Vector3(7675, -300, -600),	-- g006		RIGHT
								["133723"] = Vector3(7675, 100, -600),	-- g004		LEFT
								-- g006 : 133727
								["133629"] = Vector3(7875, -300, -600),	-- h006		UP
								["133726"] = Vector3(7675, -100, -600),	-- g005		LEFT
						-- H --
								-- h001 : 133728
								["133600"] = Vector3(8075, 700, -600),	-- i001		UP
								["133730"] = Vector3(7875, 500, -600),	-- h002		RIGHT
								-- h002 : 133731
								["133606"] = Vector3(8075, 500, -600),	-- i002		UP
								["133732"] = Vector3(7875, 300, -600),	-- h003		RIGHT
								["133729"] = Vector3(7875, 700, -600),	-- h001		LEFT
								-- h003 : 133734
								["133612"] = Vector3(8075, 300, -600),	-- i003		UP
								["133735"] = Vector3(7875, 100, -600),	-- h004		RIGHT
								["133733"] = Vector3(7875, 500, -600),	-- h002		LEFT
								-- h004 : 133737
								["133618"] = Vector3(8075, 100, -600),	-- i004		UP
								["133738"] = Vector3(7875, -100, -600),	-- h005		RIGHT
								["133736"] = Vector3(7875, 300, -600),	-- h003		LEFT
								-- h005 : 133740
								["133624"] = Vector3(8075, -100, -600),	-- i005		UP
								["133741"] = Vector3(7875, -300, -600),	-- h006		RIGHT
								["133739"] = Vector3(7875, 100, -600),	-- h004		LEFT
								-- h006 : 133743
								["133630"] = Vector3(8075, -300, -600),	-- i006		UP
								["133742"] = Vector3(7875, -100, -600),	-- h005		LEFT
							}
							if _path_terminated == false then
								if _path_ok > 1 then
								local tile_1 = managers.mission:script("default")._elements[133576]._values.on_executed[1].id
								managers.hud:add_waypoint('hudz_base_'..'tile_1', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_1)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
								
								if _path_ok > 2 then
								local tile_2 = managers.mission:script("default")._elements[tile_1]._values.on_executed[1].id
								managers.hud:add_waypoint('hudz_base_'..'tile_2', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_2)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
								
								if _path_ok > 3 then
								local tile_3 = managers.mission:script("default")._elements[tile_2]._values.on_executed[1].id
								local tile_3b = managers.mission:script("default")._elements[tile_3]._values.on_executed[1].id
								if tile_3 == 133631 or tile_3 == 133633	or tile_3 == 133634 or tile_3 == 133635 or tile_3 == 133636 or tile_3 == 133637 or tile_3 == 133650
								or tile_3 == 133653 or tile_3 == 133656 or tile_3 == 133659 or tile_3 == 133662 or tile_3 == 133663 or tile_3 == 133666 or tile_3 == 133669
								or tile_3 == 133672 or tile_3 == 133675 or tile_3 == 133678 or tile_3 == 133679 or tile_3 == 133680 or tile_3 == 133683 or tile_3 == 133686
								or tile_3 == 133689 or tile_3 == 133692 or tile_3 == 133695 or tile_3 == 133696 or tile_3 == 133699 or tile_3 == 133702 or tile_3 == 133705
								or tile_3 == 133708 or tile_3 == 133711 or tile_3 == 133712 or tile_3 == 133715 or tile_3 == 133718 or tile_3 == 133721 or tile_3 == 133724
								or tile_3 == 133727 or tile_3 == 133728 or tile_3 == 133731 or tile_3 == 133734 or tile_3 == 133737 or tile_3 == 133740 or tile_3 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_3', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_3b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_3b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_3', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_3)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_3
								end
							  if _path_ok > 4 then
								local tile_4_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_4 = managers.mission:script("default")._elements[tile_4_0]._values.on_executed[1].id
								local tile_4b = managers.mission:script("default")._elements[tile_4]._values.on_executed[1].id
								if tile_4 == 133631 or tile_4 == 133633	or tile_4 == 133634 or tile_4 == 133635 or tile_4 == 133636 or tile_4 == 133637 or tile_4 == 133650
								or tile_4 == 133653 or tile_4 == 133656 or tile_4 == 133659 or tile_4 == 133662 or tile_4 == 133663 or tile_4 == 133666 or tile_4 == 133669
								or tile_4 == 133672 or tile_4 == 133675 or tile_4 == 133678 or tile_4 == 133679 or tile_4 == 133680 or tile_4 == 133683 or tile_4 == 133686
								or tile_4 == 133689 or tile_4 == 133692 or tile_4 == 133695 or tile_4 == 133696 or tile_4 == 133699 or tile_4 == 133702 or tile_4 == 133705
								or tile_4 == 133708 or tile_4 == 133711 or tile_4 == 133712 or tile_4 == 133715 or tile_4 == 133718 or tile_4 == 133721 or tile_4 == 133724
								or tile_4 == 133727 or tile_4 == 133728 or tile_4 == 133731 or tile_4 == 133734 or tile_4 == 133737 or tile_4 == 133740 or tile_4 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_4', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_4b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_4b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_4', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_4)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_4
								end
							  if _path_ok > 5 then
								local tile_5_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_5 = managers.mission:script("default")._elements[tile_5_0]._values.on_executed[1].id
								local tile_5b = managers.mission:script("default")._elements[tile_5]._values.on_executed[1].id
								if tile_5 == 133631 or tile_5 == 133633	or tile_5 == 133634 or tile_5 == 133635 or tile_5 == 133636 or tile_5 == 133637 or tile_5 == 133650
								or tile_5 == 133653 or tile_5 == 133656 or tile_5 == 133659 or tile_5 == 133662 or tile_5 == 133663 or tile_5 == 133666 or tile_5 == 133669
								or tile_5 == 133672 or tile_5 == 133675 or tile_5 == 133678 or tile_5 == 133679 or tile_5 == 133680 or tile_5 == 133683 or tile_5 == 133686
								or tile_5 == 133689 or tile_5 == 133692 or tile_5 == 133695 or tile_5 == 133696 or tile_5 == 133699 or tile_5 == 133702 or tile_5 == 133705
								or tile_5 == 133708 or tile_5 == 133711 or tile_5 == 133712 or tile_5 == 133715 or tile_5 == 133718 or tile_5 == 133721 or tile_5 == 133724
								or tile_5 == 133727 or tile_5 == 133728 or tile_5 == 133731 or tile_5 == 133734 or tile_5 == 133737 or tile_5 == 133740 or tile_5 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_5', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_5b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_5b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_5', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_5)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_5
								end
							  if _path_ok > 6 then
								local tile_6_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_6 = managers.mission:script("default")._elements[tile_6_0]._values.on_executed[1].id
								local tile_6b = managers.mission:script("default")._elements[tile_6]._values.on_executed[1].id
								if tile_6 == 133631 or tile_6 == 133633	or tile_6 == 133634 or tile_6 == 133635 or tile_6 == 133636 or tile_6 == 133637 or tile_6 == 133650
								or tile_6 == 133653 or tile_6 == 133656 or tile_6 == 133659 or tile_6 == 133662 or tile_6 == 133663 or tile_6 == 133666 or tile_6 == 133669
								or tile_6 == 133672 or tile_6 == 133675 or tile_6 == 133678 or tile_6 == 133679 or tile_6 == 133680 or tile_6 == 133683 or tile_6 == 133686
								or tile_6 == 133689 or tile_6 == 133692 or tile_6 == 133695 or tile_6 == 133696 or tile_6 == 133699 or tile_6 == 133702 or tile_6 == 133705
								or tile_6 == 133708 or tile_6 == 133711 or tile_6 == 133712 or tile_6 == 133715 or tile_6 == 133718 or tile_6 == 133721 or tile_6 == 133724
								or tile_6 == 133727 or tile_6 == 133728 or tile_6 == 133731 or tile_6 == 133734 or tile_6 == 133737 or tile_6 == 133740 or tile_6 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_6', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_6b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_6b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_6', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_6)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_6
								end
							  if _path_ok > 7 then
								local tile_7_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_7 = managers.mission:script("default")._elements[tile_7_0]._values.on_executed[1].id
								local tile_7b = managers.mission:script("default")._elements[tile_7]._values.on_executed[1].id
								if tile_7 == 133631 or tile_7 == 133633	or tile_7 == 133634 or tile_7 == 133635 or tile_7 == 133636 or tile_7 == 133637 or tile_7 == 133650
								or tile_7 == 133653 or tile_7 == 133656 or tile_7 == 133659 or tile_7 == 133662 or tile_7 == 133663 or tile_7 == 133666 or tile_7 == 133669
								or tile_7 == 133672 or tile_7 == 133675 or tile_7 == 133678 or tile_7 == 133679 or tile_7 == 133680 or tile_7 == 133683 or tile_7 == 133686
								or tile_7 == 133689 or tile_7 == 133692 or tile_7 == 133695 or tile_7 == 133696 or tile_7 == 133699 or tile_7 == 133702 or tile_7 == 133705
								or tile_7 == 133708 or tile_7 == 133711 or tile_7 == 133712 or tile_7 == 133715 or tile_7 == 133718 or tile_7 == 133721 or tile_7 == 133724
								or tile_7 == 133727 or tile_7 == 133728 or tile_7 == 133731 or tile_7 == 133734 or tile_7 == 133737 or tile_7 == 133740 or tile_7 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_7', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_7b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_7b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_7', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_7)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_7
								end
							  if _path_ok > 8 then
								local tile_8_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_8 = managers.mission:script("default")._elements[tile_8_0]._values.on_executed[1].id
								local tile_8b = managers.mission:script("default")._elements[tile_8]._values.on_executed[1].id
								if tile_8 == 133631 or tile_8 == 133633	or tile_8 == 133634 or tile_8 == 133635 or tile_8 == 133636 or tile_8 == 133637 or tile_8 == 133650
								or tile_8 == 133653 or tile_8 == 133656 or tile_8 == 133659 or tile_8 == 133662 or tile_8 == 133663 or tile_8 == 133666 or tile_8 == 133669
								or tile_8 == 133672 or tile_8 == 133675 or tile_8 == 133678 or tile_8 == 133679 or tile_8 == 133680 or tile_8 == 133683 or tile_8 == 133686
								or tile_8 == 133689 or tile_8 == 133692 or tile_8 == 133695 or tile_8 == 133696 or tile_8 == 133699 or tile_8 == 133702 or tile_8 == 133705
								or tile_8 == 133708 or tile_8 == 133711 or tile_8 == 133712 or tile_8 == 133715 or tile_8 == 133718 or tile_8 == 133721 or tile_8 == 133724
								or tile_8 == 133727 or tile_8 == 133728 or tile_8 == 133731 or tile_8 == 133734 or tile_8 == 133737 or tile_8 == 133740 or tile_8 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_8', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_8b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_8b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_8', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_8)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_8
								end
							  if _path_ok > 9 then
								local tile_9_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_9 = managers.mission:script("default")._elements[tile_9_0]._values.on_executed[1].id
								local tile_9b = managers.mission:script("default")._elements[tile_9]._values.on_executed[1].id
								if tile_9 == 133631 or tile_9 == 133633	or tile_9 == 133634 or tile_9 == 133635 or tile_9 == 133636 or tile_9 == 133637 or tile_9 == 133650
								or tile_9 == 133653 or tile_9 == 133656 or tile_9 == 133659 or tile_9 == 133662 or tile_9 == 133663 or tile_9 == 133666 or tile_9 == 133669
								or tile_9 == 133672 or tile_9 == 133675 or tile_9 == 133678 or tile_9 == 133679 or tile_9 == 133680 or tile_9 == 133683 or tile_9 == 133686
								or tile_9 == 133689 or tile_9 == 133692 or tile_9 == 133695 or tile_9 == 133696 or tile_9 == 133699 or tile_9 == 133702 or tile_9 == 133705
								or tile_9 == 133708 or tile_9 == 133711 or tile_9 == 133712 or tile_9 == 133715 or tile_9 == 133718 or tile_9 == 133721 or tile_9 == 133724
								or tile_9 == 133727 or tile_9 == 133728 or tile_9 == 133731 or tile_9 == 133734 or tile_9 == 133737 or tile_9 == 133740 or tile_9 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_9', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_9b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_9b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_9', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_9)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_9
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							  end end end end end end end end end
							end
							if _path_ok > 10 then
							if _path_terminated == false then
								local tile_10_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_10 = managers.mission:script("default")._elements[tile_10_0]._values.on_executed[1].id
								local tile_10b = managers.mission:script("default")._elements[tile_10]._values.on_executed[1].id
								if tile_10 == 133631 or tile_10 == 133633	or tile_10 == 133634 or tile_10 == 133635 or tile_10 == 133636 or tile_10 == 133637 or tile_10 == 133650
								or tile_10 == 133653 or tile_10 == 133656 or tile_10 == 133659 or tile_10 == 133662 or tile_10 == 133663 or tile_10 == 133666 or tile_10 == 133669
								or tile_10 == 133672 or tile_10 == 133675 or tile_10 == 133678 or tile_10 == 133679 or tile_10 == 133680 or tile_10 == 133683 or tile_10 == 133686
								or tile_10 == 133689 or tile_10 == 133692 or tile_10 == 133695 or tile_10 == 133696 or tile_10 == 133699 or tile_10 == 133702 or tile_10 == 133705
								or tile_10 == 133708 or tile_10 == 133711 or tile_10 == 133712 or tile_10 == 133715 or tile_10 == 133718 or tile_10 == 133721 or tile_10 == 133724
								or tile_10 == 133727 or tile_10 == 133728 or tile_10 == 133731 or tile_10 == 133734 or tile_10 == 133737 or tile_10 == 133740 or tile_10 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_10', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_10b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_10b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_10', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_10)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_10
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_11_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_11 = managers.mission:script("default")._elements[tile_11_0]._values.on_executed[1].id
								local tile_11b = managers.mission:script("default")._elements[tile_11]._values.on_executed[1].id
								if tile_11 == 133631 or tile_11 == 133633	or tile_11 == 133634 or tile_11 == 133635 or tile_11 == 133636 or tile_11 == 133637 or tile_11 == 133650
								or tile_11 == 133653 or tile_11 == 133656 or tile_11 == 133659 or tile_11 == 133662 or tile_11 == 133663 or tile_11 == 133666 or tile_11 == 133669
								or tile_11 == 133672 or tile_11 == 133675 or tile_11 == 133678 or tile_11 == 133679 or tile_11 == 133680 or tile_11 == 133683 or tile_11 == 133686
								or tile_11 == 133689 or tile_11 == 133692 or tile_11 == 133695 or tile_11 == 133696 or tile_11 == 133699 or tile_11 == 133702 or tile_11 == 133705
								or tile_11 == 133708 or tile_11 == 133711 or tile_11 == 133712 or tile_11 == 133715 or tile_11 == 133718 or tile_11 == 133721 or tile_11 == 133724
								or tile_11 == 133727 or tile_11 == 133728 or tile_11 == 133731 or tile_11 == 133734 or tile_11 == 133737 or tile_11 == 133740 or tile_11 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_11', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_11b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_11b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_11', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_11)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_11
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_12_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_12 = managers.mission:script("default")._elements[tile_12_0]._values.on_executed[1].id
								local tile_12b = managers.mission:script("default")._elements[tile_12]._values.on_executed[1].id
								if tile_12 == 133631 or tile_12 == 133633	or tile_12 == 133634 or tile_12 == 133635 or tile_12 == 133636 or tile_12 == 133637 or tile_12 == 133650
								or tile_12 == 133653 or tile_12 == 133656 or tile_12 == 133659 or tile_12 == 133662 or tile_12 == 133663 or tile_12 == 133666 or tile_12 == 133669
								or tile_12 == 133672 or tile_12 == 133675 or tile_12 == 133678 or tile_12 == 133679 or tile_12 == 133680 or tile_12 == 133683 or tile_12 == 133686
								or tile_12 == 133689 or tile_12 == 133692 or tile_12 == 133695 or tile_12 == 133696 or tile_12 == 133699 or tile_12 == 133702 or tile_12 == 133705
								or tile_12 == 133708 or tile_12 == 133711 or tile_12 == 133712 or tile_12 == 133715 or tile_12 == 133718 or tile_12 == 133721 or tile_12 == 133724
								or tile_12 == 133727 or tile_12 == 133728 or tile_12 == 133731 or tile_12 == 133734 or tile_12 == 133737 or tile_12 == 133740 or tile_12 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_12', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_12b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_12b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_12', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_12)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_12
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_13_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_13 = managers.mission:script("default")._elements[tile_13_0]._values.on_executed[1].id
								local tile_13b = managers.mission:script("default")._elements[tile_13]._values.on_executed[1].id
								if tile_13 == 133631 or tile_13 == 133633	or tile_13 == 133634 or tile_13 == 133635 or tile_13 == 133636 or tile_13 == 133637 or tile_13 == 133650
								or tile_13 == 133653 or tile_13 == 133656 or tile_13 == 133659 or tile_13 == 133662 or tile_13 == 133663 or tile_13 == 133666 or tile_13 == 133669
								or tile_13 == 133672 or tile_13 == 133675 or tile_13 == 133678 or tile_13 == 133679 or tile_13 == 133680 or tile_13 == 133683 or tile_13 == 133686
								or tile_13 == 133689 or tile_13 == 133692 or tile_13 == 133695 or tile_13 == 133696 or tile_13 == 133699 or tile_13 == 133702 or tile_13 == 133705
								or tile_13 == 133708 or tile_13 == 133711 or tile_13 == 133712 or tile_13 == 133715 or tile_13 == 133718 or tile_13 == 133721 or tile_13 == 133724
								or tile_13 == 133727 or tile_13 == 133728 or tile_13 == 133731 or tile_13 == 133734 or tile_13 == 133737 or tile_13 == 133740 or tile_13 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_13', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_13b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_13b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_13', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_13)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_13
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_14_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_14 = managers.mission:script("default")._elements[tile_14_0]._values.on_executed[1].id
								local tile_14b = managers.mission:script("default")._elements[tile_14]._values.on_executed[1].id
								if tile_14 == 133631 or tile_14 == 133633	or tile_14 == 133634 or tile_14 == 133635 or tile_14 == 133636 or tile_14 == 133637 or tile_14 == 133650
								or tile_14 == 133653 or tile_14 == 133656 or tile_14 == 133659 or tile_14 == 133662 or tile_14 == 133663 or tile_14 == 133666 or tile_14 == 133669
								or tile_14 == 133672 or tile_14 == 133675 or tile_14 == 133678 or tile_14 == 133679 or tile_14 == 133680 or tile_14 == 133683 or tile_14 == 133686
								or tile_14 == 133689 or tile_14 == 133692 or tile_14 == 133695 or tile_14 == 133696 or tile_14 == 133699 or tile_14 == 133702 or tile_14 == 133705
								or tile_14 == 133708 or tile_14 == 133711 or tile_14 == 133712 or tile_14 == 133715 or tile_14 == 133718 or tile_14 == 133721 or tile_14 == 133724
								or tile_14 == 133727 or tile_14 == 133728 or tile_14 == 133731 or tile_14 == 133734 or tile_14 == 133737 or tile_14 == 133740 or tile_14 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_14', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_14b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_14b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_14', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_14)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_14
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_15_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_15 = managers.mission:script("default")._elements[tile_15_0]._values.on_executed[1].id
								local tile_15b = managers.mission:script("default")._elements[tile_15]._values.on_executed[1].id
								if tile_15 == 133631 or tile_15 == 133633	or tile_15 == 133634 or tile_15 == 133635 or tile_15 == 133636 or tile_15 == 133637 or tile_15 == 133650
								or tile_15 == 133653 or tile_15 == 133656 or tile_15 == 133659 or tile_15 == 133662 or tile_15 == 133663 or tile_15 == 133666 or tile_15 == 133669
								or tile_15 == 133672 or tile_15 == 133675 or tile_15 == 133678 or tile_15 == 133679 or tile_15 == 133680 or tile_15 == 133683 or tile_15 == 133686
								or tile_15 == 133689 or tile_15 == 133692 or tile_15 == 133695 or tile_15 == 133696 or tile_15 == 133699 or tile_15 == 133702 or tile_15 == 133705
								or tile_15 == 133708 or tile_15 == 133711 or tile_15 == 133712 or tile_15 == 133715 or tile_15 == 133718 or tile_15 == 133721 or tile_15 == 133724
								or tile_15 == 133727 or tile_15 == 133728 or tile_15 == 133731 or tile_15 == 133734 or tile_15 == 133737 or tile_15 == 133740 or tile_15 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_15', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_15b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_15b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_15', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_15)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_15
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_16_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_16 = managers.mission:script("default")._elements[tile_16_0]._values.on_executed[1].id
								local tile_16b = managers.mission:script("default")._elements[tile_16]._values.on_executed[1].id
								if tile_16 == 133631 or tile_16 == 133633	or tile_16 == 133634 or tile_16 == 133635 or tile_16 == 133636 or tile_16 == 133637 or tile_16 == 133650
								or tile_16 == 133653 or tile_16 == 133656 or tile_16 == 133659 or tile_16 == 133662 or tile_16 == 133663 or tile_16 == 133666 or tile_16 == 133669
								or tile_16 == 133672 or tile_16 == 133675 or tile_16 == 133678 or tile_16 == 133679 or tile_16 == 133680 or tile_16 == 133683 or tile_16 == 133686
								or tile_16 == 133689 or tile_16 == 133692 or tile_16 == 133695 or tile_16 == 133696 or tile_16 == 133699 or tile_16 == 133702 or tile_16 == 133705
								or tile_16 == 133708 or tile_16 == 133711 or tile_16 == 133712 or tile_16 == 133715 or tile_16 == 133718 or tile_16 == 133721 or tile_16 == 133724
								or tile_16 == 133727 or tile_16 == 133728 or tile_16 == 133731 or tile_16 == 133734 or tile_16 == 133737 or tile_16 == 133740 or tile_16 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_16', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_16b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_16b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_16', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_16)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_16
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_17_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_17 = managers.mission:script("default")._elements[tile_17_0]._values.on_executed[1].id
								local tile_17b = managers.mission:script("default")._elements[tile_17]._values.on_executed[1].id
								if tile_17 == 133631 or tile_17 == 133633	or tile_17 == 133634 or tile_17 == 133635 or tile_17 == 133636 or tile_17 == 133637 or tile_17 == 133650
								or tile_17 == 133653 or tile_17 == 133656 or tile_17 == 133659 or tile_17 == 133662 or tile_17 == 133663 or tile_17 == 133666 or tile_17 == 133669
								or tile_17 == 133672 or tile_17 == 133675 or tile_17 == 133678 or tile_17 == 133679 or tile_17 == 133680 or tile_17 == 133683 or tile_17 == 133686
								or tile_17 == 133689 or tile_17 == 133692 or tile_17 == 133695 or tile_17 == 133696 or tile_17 == 133699 or tile_17 == 133702 or tile_17 == 133705
								or tile_17 == 133708 or tile_17 == 133711 or tile_17 == 133712 or tile_17 == 133715 or tile_17 == 133718 or tile_17 == 133721 or tile_17 == 133724
								or tile_17 == 133727 or tile_17 == 133728 or tile_17 == 133731 or tile_17 == 133734 or tile_17 == 133737 or tile_17 == 133740 or tile_17 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_17', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_17b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_17b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_17', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_17)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_17
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_18_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_18 = managers.mission:script("default")._elements[tile_18_0]._values.on_executed[1].id
								local tile_18b = managers.mission:script("default")._elements[tile_18]._values.on_executed[1].id
								if tile_18 == 133631 or tile_18 == 133633	or tile_18 == 133634 or tile_18 == 133635 or tile_18 == 133636 or tile_18 == 133637 or tile_18 == 133650
								or tile_18 == 133653 or tile_18 == 133656 or tile_18 == 133659 or tile_18 == 133662 or tile_18 == 133663 or tile_18 == 133666 or tile_18 == 133669
								or tile_18 == 133672 or tile_18 == 133675 or tile_18 == 133678 or tile_18 == 133679 or tile_18 == 133680 or tile_18 == 133683 or tile_18 == 133686
								or tile_18 == 133689 or tile_18 == 133692 or tile_18 == 133695 or tile_18 == 133696 or tile_18 == 133699 or tile_18 == 133702 or tile_18 == 133705
								or tile_18 == 133708 or tile_18 == 133711 or tile_18 == 133712 or tile_18 == 133715 or tile_18 == 133718 or tile_18 == 133721 or tile_18 == 133724
								or tile_18 == 133727 or tile_18 == 133728 or tile_18 == 133731 or tile_18 == 133734 or tile_18 == 133737 or tile_18 == 133740 or tile_18 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_18', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_18b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_18b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_18', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_18)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_18
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_19_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_19 = managers.mission:script("default")._elements[tile_19_0]._values.on_executed[1].id
								local tile_19b = managers.mission:script("default")._elements[tile_19]._values.on_executed[1].id
								if tile_19 == 133631 or tile_19 == 133633	or tile_19 == 133634 or tile_19 == 133635 or tile_19 == 133636 or tile_19 == 133637 or tile_19 == 133650
								or tile_19 == 133653 or tile_19 == 133656 or tile_19 == 133659 or tile_19 == 133662 or tile_19 == 133663 or tile_19 == 133666 or tile_19 == 133669
								or tile_19 == 133672 or tile_19 == 133675 or tile_19 == 133678 or tile_19 == 133679 or tile_19 == 133680 or tile_19 == 133683 or tile_19 == 133686
								or tile_19 == 133689 or tile_19 == 133692 or tile_19 == 133695 or tile_19 == 133696 or tile_19 == 133699 or tile_19 == 133702 or tile_19 == 133705
								or tile_19 == 133708 or tile_19 == 133711 or tile_19 == 133712 or tile_19 == 133715 or tile_19 == 133718 or tile_19 == 133721 or tile_19 == 133724
								or tile_19 == 133727 or tile_19 == 133728 or tile_19 == 133731 or tile_19 == 133734 or tile_19 == 133737 or tile_19 == 133740 or tile_19 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_19', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_19b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_19b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_19', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_19)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_19
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_20_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_20 = managers.mission:script("default")._elements[tile_20_0]._values.on_executed[1].id
								local tile_20b = managers.mission:script("default")._elements[tile_20]._values.on_executed[1].id
								if tile_20 == 133631 or tile_20 == 133633	or tile_20 == 133634 or tile_20 == 133635 or tile_20 == 133636 or tile_20 == 133637 or tile_20 == 133650
								or tile_20 == 133653 or tile_20 == 133656 or tile_20 == 133659 or tile_20 == 133662 or tile_20 == 133663 or tile_20 == 133666 or tile_20 == 133669
								or tile_20 == 133672 or tile_20 == 133675 or tile_20 == 133678 or tile_20 == 133679 or tile_20 == 133680 or tile_20 == 133683 or tile_20 == 133686
								or tile_20 == 133689 or tile_20 == 133692 or tile_20 == 133695 or tile_20 == 133696 or tile_20 == 133699 or tile_20 == 133702 or tile_20 == 133705
								or tile_20 == 133708 or tile_20 == 133711 or tile_20 == 133712 or tile_20 == 133715 or tile_20 == 133718 or tile_20 == 133721 or tile_20 == 133724
								or tile_20 == 133727 or tile_20 == 133728 or tile_20 == 133731 or tile_20 == 133734 or tile_20 == 133737 or tile_20 == 133740 or tile_20 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_20', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_20b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_20b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_20', { icon = 'infamy_icon', distance = false, position = tiles_all[tostring(tile_20)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_20
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							end
						end
	------ 8 ------
					elseif _ToggleWayCheck == 8 then
						-------------
						-- FORTUNE --
						-------------
						-- MONEY #1
						if v:interaction().tweak_data == 'money_wrap_updating' then
							managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'equipment_money_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						if not (managers.job:current_level_id() == "pbr2") then
							-- MONEY #2
							if v:interaction().tweak_data == 'money_wrap_single_bundle' and bShowSmallLoot then
								managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							elseif v:interaction().tweak_data == 'money_wrap_single_bundle_active' and bShowSmallLoot then
								managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							elseif v:interaction().tweak_data == 'cash_register' and bShowSmallLoot then
								if managers.job:current_level_id() == "jewelry_store" or managers.job:current_level_id() == "ukrainian_job" then
									if v:position() == Vector3(1844, 665, 117.732) then
									else
										managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									end
								else
									managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							elseif v:interaction().tweak_data == 'money_small' then
								managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'equipment_money_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							elseif v:interaction().tweak_data == 'money_wrap' then
								if managers.job:current_level_id() == "arm_for" then
									if v:position().z < -1500 then
									else
										managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'equipment_money_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									end
								elseif managers.job:current_level_id() == "welcome_to_the_jungle_1" then
									if v:position() == Vector3(9200, -4300, 100) then
									else
										managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'equipment_money_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									end
								elseif managers.job:current_level_id() == "family" then
									if v:position() == Vector3(1400, 200, 1100) then
									else
										managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'equipment_money_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									end
								elseif managers.job:current_level_id() == "mia_1" then
									if v:position() == Vector3(5400, 1400, -300) then
									else
										managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'equipment_money_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									end
								else
									managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'equipment_money_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							-- GOLD
							elseif v:interaction().tweak_data == 'gold_pile' then
								if managers.job:current_level_id() == "welcome_to_the_jungle_1" then
									if v:position() == Vector3(9200, -4400, 100) then
									else
										managers.hud:add_waypoint('hudz_gold_'..k, { icon = 'interaction_gold', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									end
								else
									managers.hud:add_waypoint('hudz_gold_'..k, { icon = 'interaction_gold', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							-- DIAMONDS/JEWELS
							elseif v:interaction().tweak_data == 'diamond_pickup' and bShowSmallLoot then
								if managers.job:current_level_id() == "ukrainian_job" and v:position().z > 0 then
									managers.hud:add_waypoint('hudz_gold_'..k, { icon = 'interaction_diamond', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								else
									managers.hud:add_waypoint('hudz_gold_'..k, { icon = 'interaction_diamond', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							elseif v:interaction().tweak_data == 'gen_pku_jewelry' then
								if managers.job:current_level_id() == "ukrainian_job" and v:position().z > 0 then
									managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'wp_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" } )
								else
									managers.hud:add_waypoint('hudz_cashB_'..k, { icon = 'wp_bag', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" } )
								end
							-- ATMS
							elseif v:interaction().tweak_data == 'requires_ecm_jammer_atm' then
								managers.hud:add_waypoint('hudz_atm_'..k, { icon = 'equipment_ecm_jammer', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							-- SAFE LOOT
							elseif v:interaction().tweak_data == 'safe_loot_pickup' and bShowSmallLoot then
								if managers.job:current_level_id() == "family" then
									if v:position().z > 1000 then
									else
										managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									end
								else
									managers.hud:add_waypoint('hudz_cash_'..k, { icon = 'interaction_money_wrap', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
								end
							end
						end
						-- TRAIN HEIST AMMO
						if managers.job:current_level_id() == "arm_for" and v:interaction().tweak_data == 'take_ammo' then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'equipment_sentry', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
	------ 9 ------
					elseif _ToggleWayCheck == 9 then
						-------------
						-- KEYCARD --
						-------------
						if v:interaction().tweak_data == 'pickup_keycard' then
							if managers.job:current_level_id() == 'roberts' and v:position() == Vector3(250, 6750, -64.2354) then
							elseif managers.job:current_level_id() == 'big' and v:position() == Vector3(3000, -3500, 949.99) then
							elseif managers.job:current_level_id() == 'firestarter_2' and v:position() == Vector3(-1800, -3600, 400) then
							else
								managers.hud:add_waypoint('hudz_card_'..k, { icon = 'equipment_bank_manager_key', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.yellow, blend_mode = "add" })
							end
						end
						-- CIV WITH KEYCARD
						for u_key,u_data in pairs(managers.enemy:all_civilians()) do
							local player_pos = Vector3(0,0,0)
							local unit_pos = u_data.unit:movement():m_head_pos()
							local vec = unit_pos - player_pos
							if isHost() and (u_data.unit.contour and alive(u_data.unit)) and u_data.unit:character_damage():pickup() then
								local max_angle = 360
								local ray = World:raycast("ray", player_pos, unit_pos, "slot_mask", managers.slot:get_mask( "AI_visibility" ), "ray_type", "ai_vision", "ignore_unit", { u_data.unit } )
								if (ray and ray.unit) then
									local cHealth = u_data.unit:character_damage() and u_data.unit:character_damage()._health
									if cHealth then
										local full = u_data.unit:character_damage()._HEALTH_INIT
										local supp = u_data.unit:character_damage()._suppression_data
										if full and (cHealth > 0) and not (managers.job:current_level_id() == "jolly") then
										-- ALIVE
											managers.hud:add_waypoint('hudz_civ_'..tostring(unit_pos), { icon = 'equipment_bank_manager_key', distance = bShowDistance, position = unit_pos, no_sync = true, present_timer = 0, state = "present", radius = 1000, color = purple, blend_mode = "add" })
										else
										-- DEAD
										end
									end
								end
							end
						end
						-- COP WITH KEYCARD
						for u_key, u_data in pairs(managers.enemy:all_enemies()) do
							local player_pos = Vector3(0,0,0)
							local unit_pos = u_data.unit:movement():m_head_pos()
							local vec = unit_pos - player_pos
							if isHost() and u_data.unit.contour and alive(u_data.unit) and u_data.unit:character_damage():pickup() and u_data.unit:character_damage():pickup() ~= "ammo" then
								local max_angle = 360
								local ray = World:raycast("ray", player_pos, unit_pos, "slot_mask", managers.slot:get_mask( "AI_visibility" ), "ray_type", "ai_vision", "ignore_unit", { u_data.unit } )
								if (ray and ray.unit) then
									local cHealth = u_data.unit:character_damage() and u_data.unit:character_damage()._health
									if cHealth then
										local full = u_data.unit:character_damage()._HEALTH_INIT
										local supp = u_data.unit:character_damage()._suppression_data
										if full and (cHealth > 0) then
											-- ALIVE
											managers.hud:add_waypoint('hudz_cop_'..tostring(unit_pos), { icon = 'equipment_bank_manager_key', distance = bShowDistance, position = unit_pos, no_sync = true, present_timer = 0, state = "present", radius = 1000, color = cobalt_blue, blend_mode = "add" })
										else
											-- DEAD
										end
									end
								end
							end
						end
						------------
						-- CAMERA --
						------------
						if v:interaction().tweak_data == 'sc_tape_loop' then
							managers.hud:add_waypoint('hudz_cam_'..k, { icon = 'wp_target', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.blue, blend_mode = "add" })
						end
						-----------------
						-- INGREDIENTS --
						-----------------
						if v:interaction().tweak_data == 'caustic_soda' then
							managers.hud:add_waypoint('hudz_coke1_'..k, { icon = 'pd2_methlab', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						elseif v:interaction().tweak_data == 'hydrogen_chloride' then
							managers.hud:add_waypoint('hudz_coke2_'..k, { icon = 'pd2_methlab', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						elseif v:interaction().tweak_data == 'muriatic_acid' then
							managers.hud:add_waypoint('hudz_coke3_'..k, { icon = 'pd2_methlab', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						--------------------
						-- COKE & WEAPONS --
						--------------------
						if v:interaction().tweak_data == 'gen_pku_cocaine' then
							managers.hud:add_waypoint('hudz_coke_'..k, { icon = 'wp_vial', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						if (v:interaction().tweak_data == 'weapon_case' or v:interaction().tweak_data == 'take_weapons') then
							managers.hud:add_waypoint('hudz_wpn_'..k, { icon = 'ak', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						---------------
						-- PAINTINGS --
						---------------
						if (managers.job:current_level_id() == 'framing_frame_1' or managers.job:current_level_id() == 'gallery') and v:interaction().tweak_data == 'hold_take_painting' then
							managers.hud:add_waypoint('hudz_ptn_'..k, { icon = 'interaction_diamond', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						if (managers.job:current_level_id() == 'kosugi' or managers.job:current_level_id() == 'kenaz') and v:interaction().tweak_data == 'hold_take_painting' then 
							managers.hud:add_waypoint('hudz_ptn_'..k, { icon = 'pd2_loot', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						--------------------
						-- BOARD & PLANKS --
						--------------------
						if v:interaction().tweak_data == 'stash_planks_pickup' and bShowPlanks then
							managers.hud:add_waypoint('hudz_plk_'..k, { icon = 'equipment_planks', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						elseif v:interaction().tweak_data == 'pickup_boards' and bShowPlanks then
							managers.hud:add_waypoint('hudz_plk_'..k, { icon = 'equipment_planks', distance = bShowDistance, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						------------
						-- SERVER --
						------------
						if (v:interaction().tweak_data == 'hold_take_server' or v:interaction().tweak_data == 'stash_server_pickup') then
							managers.hud:add_waypoint('hudz_base_'..k, { icon = 'wp_server', distance = bShowDistance, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
						end
						-----------------------------
						-- DIAMOND MUSEUM - PUZZLE --
						-----------------------------
						local tweak_puzzle = { 'mus_hold_open_display', 'rewire_electric_box' }
						local _path_ok = _script_activated - _path_created
						if _path_ok > 0 then
							_hack_ok = true
						else
							_hack_ok = false
						end
						if isHost() and managers.job:current_level_id() == 'mus' and (v:interaction().tweak_data == tweak_puzzle[1] or tweak_puzzle[2]) then
						_path_terminated = false
							local tiles_all = {
						-- FLOOR
								["133577"] = Vector3(6475, 700, -600),	-- a001
								["133578"] = Vector3(6475, 500, -600),	-- a002
								["133579"] = Vector3(6475, 300, -600),	-- a003
								["133580"] = Vector3(6475, 100, -600),	-- a004
								["133581"] = Vector3(6475, -100, -600),	-- a005
								["133582"] = Vector3(6475, -300, -600),	-- a006
						-- A --
								["133583"] = Vector3(6675, 700, -600),	-- b001		UP
								["133584"] = Vector3(6675, 500, -600),	-- b002		UP
								["133585"] = Vector3(6675, 300, -600),	-- b003		UP
								["133586"] = Vector3(6675, 100, -600),	-- b004		UP
								["133587"] = Vector3(6675, -100, -600),	-- b005		UP
								["133588"] = Vector3(6675, -300, -600),	-- b006		UP
						-- B --
								-- b001 : 133631
								["133638"] = Vector3(6675, 500, -600),	-- b002		RIGHT
								["133589"] = Vector3(6875, 700, -600),	-- c001		UP
								-- b002 : 133633
								["133640"] = Vector3(6675, 300, -600),	-- b003		RIGHT
								["133590"] = Vector3(6875, 500, -600),	-- c002		UP
								["133639"] = Vector3(6675, 700, -600),	-- b001		LEFT
								-- b003 : 133634
								["133591"] = Vector3(6875, 300, -600),	-- c003		UP
								["133642"] = Vector3(6675, 100, -600),	-- b004		RIGHT
								["133641"] = Vector3(6675, 500, -600),	-- b002		LEFT
								-- b004 : 133635
								["133592"] = Vector3(6875, 100, -600),	-- c004		UP
								["133643"] = Vector3(6675, 300, -600),	-- b003		LEFT
								["133645"] = Vector3(6675, -100, -600),	-- b005		RIGHT
								-- b005 : 133636
								["133593"] = Vector3(6875, -100, -600),	-- c005		UP
								["133647"] = Vector3(6675, -300, -600),	-- b006		RIGHT
								["133644"] = Vector3(6675, 100, -600),	-- b004		LEFT
								-- b006 : 133637
								["133594"] = Vector3(6875, -300, -600),	-- c005		UP
								["133646"] = Vector3(6675, -100, -600),	-- b005		LEFT
						-- C --
								-- c001 : 133650
								["133595"] = Vector3(7075, 700, -600),	-- d001		UP
								["133648"] = Vector3(6875, 500, -600),	-- c002		RIGHT
								-- c002 : 133653
								["133601"] = Vector3(7075, 500, -600),	-- d002		UP
								["133652"] = Vector3(6875, 300, -600),	-- c003		RIGHT
								["133649"] = Vector3(6875, 700, -600),	-- c001		LEFT
								-- c003 : 133656
								["133607"] = Vector3(7075, 300, -600),	-- d003		UP
								["133655"] = Vector3(6875, 100, -600),	-- c004		RIGHT
								["133651"] = Vector3(6875, 500, -600),	-- c002		LEFT
								-- c004 : 133659
								["133613"] = Vector3(7075, 100, -600),	-- d004		UP
								["133658"] = Vector3(6875, -100, -600),	-- c005		RIGHT
								["133654"] = Vector3(6875, 300, -600),	-- c003		LEFT
								-- c005 : 133662
								["133619"] = Vector3(7075, -100, -600),	-- d005		UP
								["133661"] = Vector3(6875, -300, -600),	-- c006		RIGHT
								["133657"] = Vector3(6875, 100, -600),	-- c004		LEFT
								-- c006 : 133663
								["133625"] = Vector3(7075, -300, -600),	-- d006		UP
								["133660"] = Vector3(6875, -100, -600),	-- c005		LEFT
						-- D --
								-- d001 : 133666
								["133596"] = Vector3(7275, 700, -600),	-- e001		UP
								["133664"] = Vector3(7075, 500, -600),	-- d002		RIGHT
								-- d002 : 133669
								["133602"] = Vector3(7275, 500, -600),	-- e002		UP
								["133667"] = Vector3(7075, 300, -600),	-- d003		RIGHT
								["133665"] = Vector3(7075, 700, -600),	-- d001		LEFT
								-- d003 : 133672
								["133608"] = Vector3(7275, 300, -600),	-- e003		UP
								["133670"] = Vector3(7075, 100, -600),	-- d004		RIGHT
								["133668"] = Vector3(7075, 500, -600),	-- d002		LEFT
								-- d004 : 133675
								["133614"] = Vector3(7275, 100, -600),	-- e004		UP
								["133673"] = Vector3(7075, -100, -600),	-- d005		RIGHT
								["133671"] = Vector3(7075, 300, -600),	-- d003		LEFT
								-- d005 : 133678
								["133620"] = Vector3(7275, -100, -600),	-- e005		UP
								["133676"] = Vector3(7075, -300, -600),	-- d006		RIGHT
								["133674"] = Vector3(7075, 100, -600),	-- d004		LEFT
								-- d006 : 133679
								["133626"] = Vector3(7275, -300, -600),	-- e006		UP
								["133677"] = Vector3(7075, -100, -600),	-- d005		LEFT
						-- E --
								-- e001 : 133680
								["133597"] = Vector3(7475, 700, -600),	-- f001		UP
								["133682"] = Vector3(7275, 500, -600),	-- e002		RIGHT
								-- e002 : 133683
								["133603"] = Vector3(7475, 500, -600),	-- f002		UP
								["133684"] = Vector3(7275, 300, -600),	-- e003		RIGHT
								["133681"] = Vector3(7275, 700, -600),	-- e001		LEFT
								-- e003 : 133686
								["133609"] = Vector3(7475, 300, -600),	-- f003		UP
								["133687"] = Vector3(7275, 100, -600),	-- e004		RIGHT
								["133685"] = Vector3(7275, 500, -600),	-- e002		LEFT
								-- e004 : 133689
								["133615"] = Vector3(7475, 100, -600),	-- f004		UP
								["133690"] = Vector3(7275, -100, -600),	-- e005		RIGHT
								["133688"] = Vector3(7275, 300, -600),	-- e003		LEFT
								-- e005 : 133692
								["133621"] = Vector3(7475, -100, -600),	-- f005		UP
								["133693"] = Vector3(7275, -300, -600),	-- e006		RIGHT
								["133691"] = Vector3(7275, 100, -600),	-- e004		LEFT
								-- e006 : 133695
								["133627"] = Vector3(7475, -300, -600),	-- f006		UP
								["133694"] = Vector3(7275, -100, -600),	-- e005		LEFT
						-- F --
								-- f001 : 133696
								["133598"] = Vector3(7675, 700, -600),	-- g001		UP
								["133698"] = Vector3(7475, 500, -600),	-- f002		RIGHT
								-- f002 : 133699
								["133604"] = Vector3(7675, 500, -600),	-- g002		UP
								["133700"] = Vector3(7475, 300, -600),	-- f003		RIGHT
								["133697"] = Vector3(7475, 700, -600),	-- f001		LEFT
								-- f003 : 133702
								["133610"] = Vector3(7675, 300, -600),	-- g003		UP
								["133703"] = Vector3(7475, 100, -600),	-- f004		RIGHT
								["133701"] = Vector3(7475, 500, -600),	-- f002		LEFT
								-- f004 : 133705
								["133616"] = Vector3(7675, 100, -600),	-- g004		UP
								["133706"] = Vector3(7475, -100, -600),	-- f005		RIGHT
								["133704"] = Vector3(7475, 300, -600),	-- f003		LEFT
								-- f005 : 133708
								["133622"] = Vector3(7675, -100, -600),	-- g005		UP
								["133709"] = Vector3(7475, -300, -600),	-- f006		RIGHT
								["133707"] = Vector3(7475, 100, -600),	-- f004		LEFT
								-- f006 : 133711
								["133628"] = Vector3(7675, -300, -600),	-- g006		UP
								["133710"] = Vector3(7475, -100, -600),	-- f005		LEFT
						-- G --
								-- g001 : 133712
								["133599"] = Vector3(7875, 700, -600),	-- h001		UP
								["133714"] = Vector3(7675, 500, -600),	-- g002		RIGHT
								-- g002 : 133715
								["133605"] = Vector3(7875, 500, -600),	-- h002		UP
								["133716"] = Vector3(7675, 300, -600),	-- g003		RIGHT
								["133713"] = Vector3(7675, 700, -600),	-- g001		LEFT
								-- g003 : 133718
								["133611"] = Vector3(7875, 300, -600),	-- h003		UP
								["133719"] = Vector3(7675, 100, -600),	-- g004		RIGHT
								["133717"] = Vector3(7675, 500, -600),	-- g002		LEFT
								-- g004 : 133721
								["133617"] = Vector3(7875, 100, -600),	-- h004		UP
								["133722"] = Vector3(7675, -100, -600),	-- g005		RIGHT
								["133720"] = Vector3(7675, 300, -600),	-- g003		LEFT
								-- g005 : 133724
								["133623"] = Vector3(7875, -100, -600),	-- h005		UP
								["133725"] = Vector3(7675, -300, -600),	-- g006		RIGHT
								["133723"] = Vector3(7675, 100, -600),	-- g004		LEFT
								-- g006 : 133727
								["133629"] = Vector3(7875, -300, -600),	-- h006		UP
								["133726"] = Vector3(7675, -100, -600),	-- g005		LEFT
						-- H --
								-- h001 : 133728
								["133600"] = Vector3(8075, 700, -600),	-- i001		UP
								["133730"] = Vector3(7875, 500, -600),	-- h002		RIGHT
								-- h002 : 133731
								["133606"] = Vector3(8075, 500, -600),	-- i002		UP
								["133732"] = Vector3(7875, 300, -600),	-- h003		RIGHT
								["133729"] = Vector3(7875, 700, -600),	-- h001		LEFT
								-- h003 : 133734
								["133612"] = Vector3(8075, 300, -600),	-- i003		UP
								["133735"] = Vector3(7875, 100, -600),	-- h004		RIGHT
								["133733"] = Vector3(7875, 500, -600),	-- h002		LEFT
								-- h004 : 133737
								["133618"] = Vector3(8075, 100, -600),	-- i004		UP
								["133738"] = Vector3(7875, -100, -600),	-- h005		RIGHT
								["133736"] = Vector3(7875, 300, -600),	-- h003		LEFT
								-- h005 : 133740
								["133624"] = Vector3(8075, -100, -600),	-- i005		UP
								["133741"] = Vector3(7875, -300, -600),	-- h006		RIGHT
								["133739"] = Vector3(7875, 100, -600),	-- h004		LEFT
								-- h006 : 133743
								["133630"] = Vector3(8075, -300, -600),	-- i006		UP
								["133742"] = Vector3(7875, -100, -600),	-- h005		LEFT
							}
							if _path_terminated == false then
							  if _path_ok > 1 then
								local tile_1 = managers.mission:script("default")._elements[133576]._values.on_executed[1].id
								managers.hud:add_waypoint('hudz_base_'..'tile_1', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_1)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							  if _path_ok > 2 then
								local tile_2 = managers.mission:script("default")._elements[tile_1]._values.on_executed[1].id
								managers.hud:add_waypoint('hudz_base_'..'tile_2', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_2)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
							  if _path_ok > 3 then
								local tile_3 = managers.mission:script("default")._elements[tile_2]._values.on_executed[1].id
								local tile_3b = managers.mission:script("default")._elements[tile_3]._values.on_executed[1].id
								if tile_3 == 133631 or tile_3 == 133633	or tile_3 == 133634 or tile_3 == 133635 or tile_3 == 133636 or tile_3 == 133637 or tile_3 == 133650
								or tile_3 == 133653 or tile_3 == 133656 or tile_3 == 133659 or tile_3 == 133662 or tile_3 == 133663 or tile_3 == 133666 or tile_3 == 133669
								or tile_3 == 133672 or tile_3 == 133675 or tile_3 == 133678 or tile_3 == 133679 or tile_3 == 133680 or tile_3 == 133683 or tile_3 == 133686
								or tile_3 == 133689 or tile_3 == 133692 or tile_3 == 133695 or tile_3 == 133696 or tile_3 == 133699 or tile_3 == 133702 or tile_3 == 133705
								or tile_3 == 133708 or tile_3 == 133711 or tile_3 == 133712 or tile_3 == 133715 or tile_3 == 133718 or tile_3 == 133721 or tile_3 == 133724
								or tile_3 == 133727 or tile_3 == 133728 or tile_3 == 133731 or tile_3 == 133734 or tile_3 == 133737 or tile_3 == 133740 or tile_3 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_3', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_3b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_3b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_3', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_3)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_3
								end
							  if _path_ok > 4 then
								local tile_4_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_4 = managers.mission:script("default")._elements[tile_4_0]._values.on_executed[1].id
								local tile_4b = managers.mission:script("default")._elements[tile_4]._values.on_executed[1].id
								if tile_4 == 133631 or tile_4 == 133633	or tile_4 == 133634 or tile_4 == 133635 or tile_4 == 133636 or tile_4 == 133637 or tile_4 == 133650
								or tile_4 == 133653 or tile_4 == 133656 or tile_4 == 133659 or tile_4 == 133662 or tile_4 == 133663 or tile_4 == 133666 or tile_4 == 133669
								or tile_4 == 133672 or tile_4 == 133675 or tile_4 == 133678 or tile_4 == 133679 or tile_4 == 133680 or tile_4 == 133683 or tile_4 == 133686
								or tile_4 == 133689 or tile_4 == 133692 or tile_4 == 133695 or tile_4 == 133696 or tile_4 == 133699 or tile_4 == 133702 or tile_4 == 133705
								or tile_4 == 133708 or tile_4 == 133711 or tile_4 == 133712 or tile_4 == 133715 or tile_4 == 133718 or tile_4 == 133721 or tile_4 == 133724
								or tile_4 == 133727 or tile_4 == 133728 or tile_4 == 133731 or tile_4 == 133734 or tile_4 == 133737 or tile_4 == 133740 or tile_4 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_4', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_4b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_4b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_4', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_4)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_4
								end
							  if _path_ok > 5 then
								local tile_5_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_5 = managers.mission:script("default")._elements[tile_5_0]._values.on_executed[1].id
								local tile_5b = managers.mission:script("default")._elements[tile_5]._values.on_executed[1].id
								if tile_5 == 133631 or tile_5 == 133633	or tile_5 == 133634 or tile_5 == 133635 or tile_5 == 133636 or tile_5 == 133637 or tile_5 == 133650
								or tile_5 == 133653 or tile_5 == 133656 or tile_5 == 133659 or tile_5 == 133662 or tile_5 == 133663 or tile_5 == 133666 or tile_5 == 133669
								or tile_5 == 133672 or tile_5 == 133675 or tile_5 == 133678 or tile_5 == 133679 or tile_5 == 133680 or tile_5 == 133683 or tile_5 == 133686
								or tile_5 == 133689 or tile_5 == 133692 or tile_5 == 133695 or tile_5 == 133696 or tile_5 == 133699 or tile_5 == 133702 or tile_5 == 133705
								or tile_5 == 133708 or tile_5 == 133711 or tile_5 == 133712 or tile_5 == 133715 or tile_5 == 133718 or tile_5 == 133721 or tile_5 == 133724
								or tile_5 == 133727 or tile_5 == 133728 or tile_5 == 133731 or tile_5 == 133734 or tile_5 == 133737 or tile_5 == 133740 or tile_5 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_5', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_5b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_5b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_5', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_5)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_5
								end
							  if _path_ok > 6 then
								local tile_6_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_6 = managers.mission:script("default")._elements[tile_6_0]._values.on_executed[1].id
								local tile_6b = managers.mission:script("default")._elements[tile_6]._values.on_executed[1].id
								if tile_6 == 133631 or tile_6 == 133633	or tile_6 == 133634 or tile_6 == 133635 or tile_6 == 133636 or tile_6 == 133637 or tile_6 == 133650
								or tile_6 == 133653 or tile_6 == 133656 or tile_6 == 133659 or tile_6 == 133662 or tile_6 == 133663 or tile_6 == 133666 or tile_6 == 133669
								or tile_6 == 133672 or tile_6 == 133675 or tile_6 == 133678 or tile_6 == 133679 or tile_6 == 133680 or tile_6 == 133683 or tile_6 == 133686
								or tile_6 == 133689 or tile_6 == 133692 or tile_6 == 133695 or tile_6 == 133696 or tile_6 == 133699 or tile_6 == 133702 or tile_6 == 133705
								or tile_6 == 133708 or tile_6 == 133711 or tile_6 == 133712 or tile_6 == 133715 or tile_6 == 133718 or tile_6 == 133721 or tile_6 == 133724
								or tile_6 == 133727 or tile_6 == 133728 or tile_6 == 133731 or tile_6 == 133734 or tile_6 == 133737 or tile_6 == 133740 or tile_6 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_6', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_6b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_6b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_6', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_6)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" }) 
									_path_tile = tile_6
								end
							  if _path_ok > 7 then
								local tile_7_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_7 = managers.mission:script("default")._elements[tile_7_0]._values.on_executed[1].id
								local tile_7b = managers.mission:script("default")._elements[tile_7]._values.on_executed[1].id
								if tile_7 == 133631 or tile_7 == 133633	or tile_7 == 133634 or tile_7 == 133635 or tile_7 == 133636 or tile_7 == 133637 or tile_7 == 133650
								or tile_7 == 133653 or tile_7 == 133656 or tile_7 == 133659 or tile_7 == 133662 or tile_7 == 133663 or tile_7 == 133666 or tile_7 == 133669
								or tile_7 == 133672 or tile_7 == 133675 or tile_7 == 133678 or tile_7 == 133679 or tile_7 == 133680 or tile_7 == 133683 or tile_7 == 133686
								or tile_7 == 133689 or tile_7 == 133692 or tile_7 == 133695 or tile_7 == 133696 or tile_7 == 133699 or tile_7 == 133702 or tile_7 == 133705
								or tile_7 == 133708 or tile_7 == 133711 or tile_7 == 133712 or tile_7 == 133715 or tile_7 == 133718 or tile_7 == 133721 or tile_7 == 133724
								or tile_7 == 133727 or tile_7 == 133728 or tile_7 == 133731 or tile_7 == 133734 or tile_7 == 133737 or tile_7 == 133740 or tile_7 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_7', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_7b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_7b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_7', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_7)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_7
								end
							  if _path_ok > 8 then
								local tile_8_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_8 = managers.mission:script("default")._elements[tile_8_0]._values.on_executed[1].id
								local tile_8b = managers.mission:script("default")._elements[tile_8]._values.on_executed[1].id
								if tile_8 == 133631 or tile_8 == 133633	or tile_8 == 133634 or tile_8 == 133635 or tile_8 == 133636 or tile_8 == 133637 or tile_8 == 133650
								or tile_8 == 133653 or tile_8 == 133656 or tile_8 == 133659 or tile_8 == 133662 or tile_8 == 133663 or tile_8 == 133666 or tile_8 == 133669
								or tile_8 == 133672 or tile_8 == 133675 or tile_8 == 133678 or tile_8 == 133679 or tile_8 == 133680 or tile_8 == 133683 or tile_8 == 133686
								or tile_8 == 133689 or tile_8 == 133692 or tile_8 == 133695 or tile_8 == 133696 or tile_8 == 133699 or tile_8 == 133702 or tile_8 == 133705
								or tile_8 == 133708 or tile_8 == 133711 or tile_8 == 133712 or tile_8 == 133715 or tile_8 == 133718 or tile_8 == 133721 or tile_8 == 133724
								or tile_8 == 133727 or tile_8 == 133728 or tile_8 == 133731 or tile_8 == 133734 or tile_8 == 133737 or tile_8 == 133740 or tile_8 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_8', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_8b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_8b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_8', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_8)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_8
								end
							  if _path_ok > 9 then
								local tile_9_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_9 = managers.mission:script("default")._elements[tile_9_0]._values.on_executed[1].id
								local tile_9b = managers.mission:script("default")._elements[tile_9]._values.on_executed[1].id
								if tile_9 == 133631 or tile_9 == 133633	or tile_9 == 133634 or tile_9 == 133635 or tile_9 == 133636 or tile_9 == 133637 or tile_9 == 133650
								or tile_9 == 133653 or tile_9 == 133656 or tile_9 == 133659 or tile_9 == 133662 or tile_9 == 133663 or tile_9 == 133666 or tile_9 == 133669
								or tile_9 == 133672 or tile_9 == 133675 or tile_9 == 133678 or tile_9 == 133679 or tile_9 == 133680 or tile_9 == 133683 or tile_9 == 133686
								or tile_9 == 133689 or tile_9 == 133692 or tile_9 == 133695 or tile_9 == 133696 or tile_9 == 133699 or tile_9 == 133702 or tile_9 == 133705
								or tile_9 == 133708 or tile_9 == 133711 or tile_9 == 133712 or tile_9 == 133715 or tile_9 == 133718 or tile_9 == 133721 or tile_9 == 133724
								or tile_9 == 133727 or tile_9 == 133728 or tile_9 == 133731 or tile_9 == 133734 or tile_9 == 133737 or tile_9 == 133740 or tile_9 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_9', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_9b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_9b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_9', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_9)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_9
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							  end end end end end end end end end
							end
							if _path_ok > 10 then
							if _path_terminated == false then
								local tile_10_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_10 = managers.mission:script("default")._elements[tile_10_0]._values.on_executed[1].id
								local tile_10b = managers.mission:script("default")._elements[tile_10]._values.on_executed[1].id
								if tile_10 == 133631 or tile_10 == 133633 or tile_10 == 133634 or tile_10 == 133635 or tile_10 == 133636 or tile_10 == 133637 or tile_10 == 133650
								or tile_10 == 133653 or tile_10 == 133656 or tile_10 == 133659 or tile_10 == 133662 or tile_10 == 133663 or tile_10 == 133666 or tile_10 == 133669
								or tile_10 == 133672 or tile_10 == 133675 or tile_10 == 133678 or tile_10 == 133679 or tile_10 == 133680 or tile_10 == 133683 or tile_10 == 133686
								or tile_10 == 133689 or tile_10 == 133692 or tile_10 == 133695 or tile_10 == 133696 or tile_10 == 133699 or tile_10 == 133702 or tile_10 == 133705
								or tile_10 == 133708 or tile_10 == 133711 or tile_10 == 133712 or tile_10 == 133715 or tile_10 == 133718 or tile_10 == 133721 or tile_10 == 133724
								or tile_10 == 133727 or tile_10 == 133728 or tile_10 == 133731 or tile_10 == 133734 or tile_10 == 133737 or tile_10 == 133740 or tile_10 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_10', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_10b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_10b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_10', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_10)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_10
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_11_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_11 = managers.mission:script("default")._elements[tile_11_0]._values.on_executed[1].id
								local tile_11b = managers.mission:script("default")._elements[tile_11]._values.on_executed[1].id
								if tile_11 == 133631 or tile_11 == 133633 or tile_11 == 133634 or tile_11 == 133635 or tile_11 == 133636 or tile_11 == 133637 or tile_11 == 133650
								or tile_11 == 133653 or tile_11 == 133656 or tile_11 == 133659 or tile_11 == 133662 or tile_11 == 133663 or tile_11 == 133666 or tile_11 == 133669
								or tile_11 == 133672 or tile_11 == 133675 or tile_11 == 133678 or tile_11 == 133679 or tile_11 == 133680 or tile_11 == 133683 or tile_11 == 133686
								or tile_11 == 133689 or tile_11 == 133692 or tile_11 == 133695 or tile_11 == 133696 or tile_11 == 133699 or tile_11 == 133702 or tile_11 == 133705
								or tile_11 == 133708 or tile_11 == 133711 or tile_11 == 133712 or tile_11 == 133715 or tile_11 == 133718 or tile_11 == 133721 or tile_11 == 133724
								or tile_11 == 133727 or tile_11 == 133728 or tile_11 == 133731 or tile_11 == 133734 or tile_11 == 133737 or tile_11 == 133740 or tile_11 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_11', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_11b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_11b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_11', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_11)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_11
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_12_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_12 = managers.mission:script("default")._elements[tile_12_0]._values.on_executed[1].id
								local tile_12b = managers.mission:script("default")._elements[tile_12]._values.on_executed[1].id
								if tile_12 == 133631 or tile_12 == 133633 or tile_12 == 133634 or tile_12 == 133635 or tile_12 == 133636 or tile_12 == 133637 or tile_12 == 133650
								or tile_12 == 133653 or tile_12 == 133656 or tile_12 == 133659 or tile_12 == 133662 or tile_12 == 133663 or tile_12 == 133666 or tile_12 == 133669
								or tile_12 == 133672 or tile_12 == 133675 or tile_12 == 133678 or tile_12 == 133679 or tile_12 == 133680 or tile_12 == 133683 or tile_12 == 133686
								or tile_12 == 133689 or tile_12 == 133692 or tile_12 == 133695 or tile_12 == 133696 or tile_12 == 133699 or tile_12 == 133702 or tile_12 == 133705
								or tile_12 == 133708 or tile_12 == 133711 or tile_12 == 133712 or tile_12 == 133715 or tile_12 == 133718 or tile_12 == 133721 or tile_12 == 133724
								or tile_12 == 133727 or tile_12 == 133728 or tile_12 == 133731 or tile_12 == 133734 or tile_12 == 133737 or tile_12 == 133740 or tile_12 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_12', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_12b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_12b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_12', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_12)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_12
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_13_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_13 = managers.mission:script("default")._elements[tile_13_0]._values.on_executed[1].id
								local tile_13b = managers.mission:script("default")._elements[tile_13]._values.on_executed[1].id
								if tile_13 == 133631 or tile_13 == 133633 or tile_13 == 133634 or tile_13 == 133635 or tile_13 == 133636 or tile_13 == 133637 or tile_13 == 133650
								or tile_13 == 133653 or tile_13 == 133656 or tile_13 == 133659 or tile_13 == 133662 or tile_13 == 133663 or tile_13 == 133666 or tile_13 == 133669
								or tile_13 == 133672 or tile_13 == 133675 or tile_13 == 133678 or tile_13 == 133679 or tile_13 == 133680 or tile_13 == 133683 or tile_13 == 133686
								or tile_13 == 133689 or tile_13 == 133692 or tile_13 == 133695 or tile_13 == 133696 or tile_13 == 133699 or tile_13 == 133702 or tile_13 == 133705
								or tile_13 == 133708 or tile_13 == 133711 or tile_13 == 133712 or tile_13 == 133715 or tile_13 == 133718 or tile_13 == 133721 or tile_13 == 133724
								or tile_13 == 133727 or tile_13 == 133728 or tile_13 == 133731 or tile_13 == 133734 or tile_13 == 133737 or tile_13 == 133740 or tile_13 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_13', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_13b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_13b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_13', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_13)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_13
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_14_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_14 = managers.mission:script("default")._elements[tile_14_0]._values.on_executed[1].id
								local tile_14b = managers.mission:script("default")._elements[tile_14]._values.on_executed[1].id
								if tile_14 == 133631 or tile_14 == 133633 or tile_14 == 133634 or tile_14 == 133635 or tile_14 == 133636 or tile_14 == 133637 or tile_14 == 133650
								or tile_14 == 133653 or tile_14 == 133656 or tile_14 == 133659 or tile_14 == 133662 or tile_14 == 133663 or tile_14 == 133666 or tile_14 == 133669
								or tile_14 == 133672 or tile_14 == 133675 or tile_14 == 133678 or tile_14 == 133679 or tile_14 == 133680 or tile_14 == 133683 or tile_14 == 133686
								or tile_14 == 133689 or tile_14 == 133692 or tile_14 == 133695 or tile_14 == 133696 or tile_14 == 133699 or tile_14 == 133702 or tile_14 == 133705
								or tile_14 == 133708 or tile_14 == 133711 or tile_14 == 133712 or tile_14 == 133715 or tile_14 == 133718 or tile_14 == 133721 or tile_14 == 133724
								or tile_14 == 133727 or tile_14 == 133728 or tile_14 == 133731 or tile_14 == 133734 or tile_14 == 133737 or tile_14 == 133740 or tile_14 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_14', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_14b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_14b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_14', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_14)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_14
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_15_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_15 = managers.mission:script("default")._elements[tile_15_0]._values.on_executed[1].id
								local tile_15b = managers.mission:script("default")._elements[tile_15]._values.on_executed[1].id
								if tile_15 == 133631 or tile_15 == 133633 or tile_15 == 133634 or tile_15 == 133635 or tile_15 == 133636 or tile_15 == 133637 or tile_15 == 133650
								or tile_15 == 133653 or tile_15 == 133656 or tile_15 == 133659 or tile_15 == 133662 or tile_15 == 133663 or tile_15 == 133666 or tile_15 == 133669
								or tile_15 == 133672 or tile_15 == 133675 or tile_15 == 133678 or tile_15 == 133679 or tile_15 == 133680 or tile_15 == 133683 or tile_15 == 133686
								or tile_15 == 133689 or tile_15 == 133692 or tile_15 == 133695 or tile_15 == 133696 or tile_15 == 133699 or tile_15 == 133702 or tile_15 == 133705
								or tile_15 == 133708 or tile_15 == 133711 or tile_15 == 133712 or tile_15 == 133715 or tile_15 == 133718 or tile_15 == 133721 or tile_15 == 133724
								or tile_15 == 133727 or tile_15 == 133728 or tile_15 == 133731 or tile_15 == 133734 or tile_15 == 133737 or tile_15 == 133740 or tile_15 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_15', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_15b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_15b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_15', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_15)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_15
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_16_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_16 = managers.mission:script("default")._elements[tile_16_0]._values.on_executed[1].id
								local tile_16b = managers.mission:script("default")._elements[tile_16]._values.on_executed[1].id
								if tile_16 == 133631 or tile_16 == 133633 or tile_16 == 133634 or tile_16 == 133635 or tile_16 == 133636 or tile_16 == 133637 or tile_16 == 133650
								or tile_16 == 133653 or tile_16 == 133656 or tile_16 == 133659 or tile_16 == 133662 or tile_16 == 133663 or tile_16 == 133666 or tile_16 == 133669
								or tile_16 == 133672 or tile_16 == 133675 or tile_16 == 133678 or tile_16 == 133679 or tile_16 == 133680 or tile_16 == 133683 or tile_16 == 133686
								or tile_16 == 133689 or tile_16 == 133692 or tile_16 == 133695 or tile_16 == 133696 or tile_16 == 133699 or tile_16 == 133702 or tile_16 == 133705
								or tile_16 == 133708 or tile_16 == 133711 or tile_16 == 133712 or tile_16 == 133715 or tile_16 == 133718 or tile_16 == 133721 or tile_16 == 133724
								or tile_16 == 133727 or tile_16 == 133728 or tile_16 == 133731 or tile_16 == 133734 or tile_16 == 133737 or tile_16 == 133740 or tile_16 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_16', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_16b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_16b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_16', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_16)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_16
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_17_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_17 = managers.mission:script("default")._elements[tile_17_0]._values.on_executed[1].id
								local tile_17b = managers.mission:script("default")._elements[tile_17]._values.on_executed[1].id
								if tile_17 == 133631 or tile_17 == 133633 or tile_17 == 133634 or tile_17 == 133635 or tile_17 == 133636 or tile_17 == 133637 or tile_17 == 133650
								or tile_17 == 133653 or tile_17 == 133656 or tile_17 == 133659 or tile_17 == 133662 or tile_17 == 133663 or tile_17 == 133666 or tile_17 == 133669
								or tile_17 == 133672 or tile_17 == 133675 or tile_17 == 133678 or tile_17 == 133679 or tile_17 == 133680 or tile_17 == 133683 or tile_17 == 133686
								or tile_17 == 133689 or tile_17 == 133692 or tile_17 == 133695 or tile_17 == 133696 or tile_17 == 133699 or tile_17 == 133702 or tile_17 == 133705
								or tile_17 == 133708 or tile_17 == 133711 or tile_17 == 133712 or tile_17 == 133715 or tile_17 == 133718 or tile_17 == 133721 or tile_17 == 133724
								or tile_17 == 133727 or tile_17 == 133728 or tile_17 == 133731 or tile_17 == 133734 or tile_17 == 133737 or tile_17 == 133740 or tile_17 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_17', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_17b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_17b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_17', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_17)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_17
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_18_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_18 = managers.mission:script("default")._elements[tile_18_0]._values.on_executed[1].id
								local tile_18b = managers.mission:script("default")._elements[tile_18]._values.on_executed[1].id
								if tile_18 == 133631 or tile_18 == 133633 or tile_18 == 133634 or tile_18 == 133635 or tile_18 == 133636 or tile_18 == 133637 or tile_18 == 133650
								or tile_18 == 133653 or tile_18 == 133656 or tile_18 == 133659 or tile_18 == 133662 or tile_18 == 133663 or tile_18 == 133666 or tile_18 == 133669
								or tile_18 == 133672 or tile_18 == 133675 or tile_18 == 133678 or tile_18 == 133679 or tile_18 == 133680 or tile_18 == 133683 or tile_18 == 133686
								or tile_18 == 133689 or tile_18 == 133692 or tile_18 == 133695 or tile_18 == 133696 or tile_18 == 133699 or tile_18 == 133702 or tile_18 == 133705
								or tile_18 == 133708 or tile_18 == 133711 or tile_18 == 133712 or tile_18 == 133715 or tile_18 == 133718 or tile_18 == 133721 or tile_18 == 133724
								or tile_18 == 133727 or tile_18 == 133728 or tile_18 == 133731 or tile_18 == 133734 or tile_18 == 133737 or tile_18 == 133740 or tile_18 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_18', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_18b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_18b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_18', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_18)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_18
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_19_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_19 = managers.mission:script("default")._elements[tile_19_0]._values.on_executed[1].id
								local tile_19b = managers.mission:script("default")._elements[tile_19]._values.on_executed[1].id
								if tile_19 == 133631 or tile_19 == 133633 or tile_19 == 133634 or tile_19 == 133635 or tile_19 == 133636 or tile_19 == 133637 or tile_19 == 133650
								or tile_19 == 133653 or tile_19 == 133656 or tile_19 == 133659 or tile_19 == 133662 or tile_19 == 133663 or tile_19 == 133666 or tile_19 == 133669
								or tile_19 == 133672 or tile_19 == 133675 or tile_19 == 133678 or tile_19 == 133679 or tile_19 == 133680 or tile_19 == 133683 or tile_19 == 133686
								or tile_19 == 133689 or tile_19 == 133692 or tile_19 == 133695 or tile_19 == 133696 or tile_19 == 133699 or tile_19 == 133702 or tile_19 == 133705
								or tile_19 == 133708 or tile_19 == 133711 or tile_19 == 133712 or tile_19 == 133715 or tile_19 == 133718 or tile_19 == 133721 or tile_19 == 133724
								or tile_19 == 133727 or tile_19 == 133728 or tile_19 == 133731 or tile_19 == 133734 or tile_19 == 133737 or tile_19 == 133740 or tile_19 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_19', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_19b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_19b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_19', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_19)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_19
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
							if _path_terminated == false then
								local tile_20_0 = managers.mission:script("default")._elements[_path_tile]._values.on_executed[1].id
								local tile_20 = managers.mission:script("default")._elements[tile_20_0]._values.on_executed[1].id
								local tile_20b = managers.mission:script("default")._elements[tile_20]._values.on_executed[1].id
								if tile_20 == 133631 or tile_20 == 133633 or tile_20 == 133634 or tile_20 == 133635 or tile_20 == 133636 or tile_20 == 133637 or tile_20 == 133650
								or tile_20 == 133653 or tile_20 == 133656 or tile_20 == 133659 or tile_20 == 133662 or tile_20 == 133663 or tile_20 == 133666 or tile_20 == 133669
								or tile_20 == 133672 or tile_20 == 133675 or tile_20 == 133678 or tile_20 == 133679 or tile_20 == 133680 or tile_20 == 133683 or tile_20 == 133686
								or tile_20 == 133689 or tile_20 == 133692 or tile_20 == 133695 or tile_20 == 133696 or tile_20 == 133699 or tile_20 == 133702 or tile_20 == 133705
								or tile_20 == 133708 or tile_20 == 133711 or tile_20 == 133712 or tile_20 == 133715 or tile_20 == 133718 or tile_20 == 133721 or tile_20 == 133724
								or tile_20 == 133727 or tile_20 == 133728 or tile_20 == 133731 or tile_20 == 133734 or tile_20 == 133737 or tile_20 == 133740 or tile_20 == 133743
								then
									managers.hud:add_waypoint('hudz_base_'..'tile_20', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_20b)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_20b
								else
									managers.hud:add_waypoint('hudz_base_'..'tile_20', { icon = 'equipment_bottle', distance = false, position = tiles_all[tostring(tile_20)], no_sync = true, present_timer = 0, state = "present", radius = 1000, color = Color.white, blend_mode = "add" })
									_path_tile = tile_20
								end
								if _path_tile == 133600	or _path_tile == 133606	or _path_tile == 133612	or _path_tile == 133618	or _path_tile == 133624	or _path_tile == 133630 then
									-- LAST TILE!
									_path_terminated = true
								end
							end
						end
					end
	------ 10 ------
					elseif _ToggleWayCheck == 10 then	
						---------------------
						-- TOGGLE CHECK 10 --
						---------------------
					---------------------------------
					-- END _ToggleWayCheck WRAPPER --
					---------------------------------
					end
					---------------------------------------------------------
					-- THE BOMB : DOCKYARD - SAVE THE POSITION OF THE BOMB --
					---------------------------------------------------------
					if (_ToggleWayCheck == 0 or _ToggleWayCheck > 0) and _bomb_ok == false then	
						if managers.job:current_level_id() == 'crojob2' and v:interaction().tweak_data == 'hold_pku_disassemble_cro_loot' then
							_bomb_pos = v:position()
							_bomb_ok = true
						end
					end
				end
				local i = 0
				for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
					id = tostring(id)
					if id:sub(1,5) == 'hudz_' then
						i = i + 1
					end
				end
				if i == 0 then
					_ToggleWayCheck = _ToggleWayCheck + 1
					if _ToggleWayCheck > 9 then
						_ToggleWayCheck = 0
						Overlay:gui():destroy_workspace( _HDmsg.ws)
						_HDmsg = nil
					end
					RefreshTest()
					return
				end
				RefreshToggle()
			end
		end
	end
	--------------------------
	-- INITIALIZE WAYPOINTS --
	--------------------------
	RefreshTest()
	-----------------------
	-- UNIT REMOVE CHECK --
	-----------------------
	-- WHEN AN ITEM IS REMOVED FROM THE GAME, ALSO REFRESH WAYPOINTS
	managers.interaction._remove_unit = managers.interaction._remove_unit or managers.interaction.remove_unit
	function ObjectInteractionManager:remove_unit( unit )
		local interacted = unit:interaction().tweak_data
		local result = self:_remove_unit(unit)
		local position = unit:position()
		local position2 = unit:interaction():interact_position()
		-----------------
		-- MAIN STATES --
		-----------------
		-- STATE 1: PACKAGE 
		if (_ToggleWayCheck == 1 or _ToggleWayCheck == 9) 
		and (interacted == 'gage_assignment') 
		-- STATE 2: KEYCARD 
        or (_ToggleWayCheck == 2 or _ToggleWayCheck == 9) 
		and (interacted == 'grenade_briefcase' 
		or interacted == 'hold_close_keycard' 
		or interacted == 'invisible_interaction_open' 
		or interacted == 'key' 
		or interacted == 'key_double' 
		or interacted == 'numpad_keycard' 
		or interacted == 'open_slash_close_act' 
		or interacted == 'pickup_keycard' 
		or interacted == 'rewire_electric_box' 
		or interacted == 'take_keys')
		-- STATE 3: SECURITY CAMERA
		or (_ToggleWayCheck == 3 or _ToggleWayCheck == 9) 
		and (interacted == 'sc_tape_loop')
		-- STATE 4: WEAPON & COKE 
        or (_ToggleWayCheck == 4 or _ToggleWayCheck == 9) 
		and (interacted == 'weapon_case' 
		or interacted == 'take_weapons' 
		or interacted == 'gen_pku_cocaine' 
		or interacted == 'gen_pku_cocaine_pure') 
		-- STATE 5: PLANK 
        or (_ToggleWayCheck == 5 or _ToggleWayCheck == 9) 
		and (interacted == 'stash_planks_pickup' 
		or interacted == 'pickup_boards')
		-- STATE 6: CROWBAR & CRATE 
        or (_ToggleWayCheck == 6 or _ToggleWayCheck == 9) 
		and (interacted == 'crate_loot' 
		or interacted == 'crate_loot_close' 
		or interacted == 'crate_loot_crowbar' 
		or interacted == 'gen_pku_crowbar')
		-- STATE 7: MIX 
		or (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (interacted == 'apply_thermite_paste' 
		or interacted == 'big_computer_hackable' 
		or interacted == 'big_computer_server' 
		or interacted == 'c4_mission_door' 
		or interacted == 'carry_drop' 
		or interacted == 'circuit_breaker' 
		or interacted == 'crate_loot' 
		or interacted == 'crate_loot_close' 
		or interacted == 'crate_loot_crowbar' 
		or interacted == 'disarm_bomb' 
		or interacted == 'disassemble_turret' 
		or interacted == 'gen_pku_artifact_painting' 
		or interacted == 'gen_pku_artifact_statue' 
		or interacted == 'gen_pku_warhead_box' 
		or interacted == 'gen_pku_warhead' 
		or interacted == 'hlm_roll_carpet' 
		or interacted == 'hold_cut_cable' 
		or interacted == 'hold_hlm_open_circuitbreaker' 
		or interacted == 'hold_pku_knife' 
		or interacted == 'hold_remove_cover' 
		or interacted == 'hold_take_gas_can' 
		or interacted == 'hold_take_painting' 
		or interacted == 'hold_take_parachute' 
		or interacted == 'hold_take_server' 
		or interacted == 'invisible_interaction_open' 
		or interacted == 'money_wrap' 
		or interacted == 'money_wrap_single_bundle_active' 
		or interacted == 'painting_carry_drop' 
		or interacted == 'pickup_asset' 
		or interacted == 'pickup_phone'	
		or interacted == 'pickup_tablet' 
		or interacted == 'pku_pig' 
		or interacted == 'stash_server_pickup' 
		or interacted == 'take_confidential_folder_event' 
		or interacted == 'uload_database' 
		or interacted == 'use_computer' 
		or interacted == 'votingmachine2')
		or (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (interacted == 'caustic_soda' 
		or interacted == 'hydrogen_chloride' 
		or interacted == 'muriatic_acid')
		or (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'alex_2')
		and (interacted == 'drill' 
		or interacted == 'take_confidential_folder') 
		or (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'welcome_to_the_jungle_1') 
		and (interacted == 'drill')
		-- STATE 8 : MONEY 
		or (_ToggleWayCheck == 8 or _ToggleWayCheck == 9) 
		and (interacted == 'gen_pku_jewelry' 
		or interacted == 'money_wrap' 
		or interacted == 'diamond_pickup' 
		or interacted == 'money_small' 
		or interacted == 'money_wrap_single_bundle' 
		or interacted == 'money_wrap_single_bundle_active' 
		or interacted == 'cash_register' 
		or interacted == 'gold_pile' 
		or interacted == 'requires_ecm_jammer_atm' 
		or interacted == 'invisible_interaction_open' 
		or interacted == 'safe_loot_pickup' 
		or interacted == 'gen_pku_artifact' 
		or interacted == 'mus_pku_artifact') then
			RefreshTest()
		end 
		--------------------------
		-- MISCELLANEOUS STATES --
		--------------------------
		-- STATE 7 : THE DIAMOND 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'mus')
		and (interacted == 'invisible_interaction_open' 
		or interacted == 'rewire_electric_box' 
		or interacted == 'gen_pku_artifact' 
		or interacted == 'mus_pku_artifact' 
		or interacted == 'gen_pku_artifact_painting' 
		or interacted == 'hack_suburbia' 
		or interacted == 'access_camera') then 
			RefreshTest() 
		end 
		-- STATE 7 : THE DIAMOND: PUZZLE
		if (managers.job:current_level_id() == 'mus')
		and (interacted == 'hack_electric_box') then 
			RefreshTest() 
			_path_created = os.clock() 
			managers.chat:_receive_message(1, "WARNING", "The path is currently being created. \nPlease wait few seconds before reactivating the script.", Color.orange) 
			RefreshTest() 
		end 
		-- STATE 7 : HOX 1 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'hox_1')
		and (interacted == 'security_station_keyboard') then
			RefreshTest()
		end
		-- STATE 7 : HOX 2 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'hox_2')
		and (interacted == 'firstaid_box' 
		or interacted == 'invisible_interaction_open' 
		or interacted == 'grenade_crate' 
		or interacted == 'ammo_bag' 
		or interacted == 'hold_download_keys' 
		or interacted == 'invisible_interaction_gathering' 
		or interacted == 'search_files_false' 
		or interacted == 'invisible_interaction_searching' 
		or interacted == 'grab_server')
		then
			RefreshTest()
		end
		-- STATE 7 : WHITE XMAS 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'pines')
		and (interacted == 'hold_open_xmas_present' 
		or interacted == 'gen_pku_cocaine_pure' 
		or interacted == 'gen_pku_sandwich') then
			RefreshTest()
		end
		-- STATE 7 : BIG OIL DAY 2 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'welcome_to_the_jungle_2')
		and (interacted == 'security_station_keyboard') then
			_keyboard_used = true
			RefreshTest()
		end
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'welcome_to_the_jungle_2')
		and (interacted == 'gen_pku_fusion_reactor' 
		or interacted == 'carry_drop') then
			if position == engine_pos[correct_id] then
				_engine_used = true
				_checking_bags = true
			end
			RefreshTest()
		end
		-- STATE 7 : RATS 2 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'alex_2')
		and (interacted == 'take_confidential_folder') then
			_intel_used = true
			RefreshTest()
		end
		-- STATE 7 : TIARA 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'ukrainian_job')
		and (interacted == 'tiara_pickup') then
			_tiara_used = true
			RefreshTest()
		end
		-- STATE 7 : TRAIN HEIST 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) 
		and (managers.job:current_level_id() == 'arm_for') 
		and (interacted == 'lance') then
			if position == Vector3(-1750, -1200, 685) 
			or position == Vector3(-2650, -1100, 685) then
			_drill1_used = true -- GREEN
			elseif position == Vector3(-150, -1100, 685) 
			or position == Vector3(750, -1200, 685) then
			_drill2_used = true -- ORANGE
			elseif position == Vector3(3250, -1200, 685) 
			or position == Vector3(2350, -1100, 685) then
			_drill3_used = true -- RED
			end
			RefreshTest()
		end
		-- STATE 7 : FRAMING FRAME DAY 3 SERVER ROOM 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) and (managers.job:current_level_id() == 'framing_frame_3') and (interacted == 'security_station_keyboard') then
			_FF3_used = true
			RefreshTest()
		end
		-- STAGE 7 : ELECTION DAY 1 TRUCK 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) and (managers.job:current_level_id() == 'election_day_1') and (interacted == 'hold_place_gps_tracker') then 
			_gps_used = true
			RefreshTest()
		end
		-- STATE 7 : FIRESTARTER DAY 2 
		if (_ToggleWayCheck == 7 or _ToggleWayCheck == 9) and (managers.job:current_level_id() == 'firestarter_2') then 
			if isHost() then 
				if interacted == 'hospital_security_cable' then
					tabclk[1] = os.clock() 
				elseif interacted == 'open_slash_close_sec_box' then
					tabclk[2] = os.clock() 
				end 
				if (tabclk[1] ~= nil and tabclk[2] ~= nil) or (tabclk[1] == nil and tabclk[2] ~= nil) then 
					if tabclk[1] == nil then tabclk[1] = 0 end -- TO PREVENT A NIL VALUE IF YOU WANT TO CUT THE FIRST CABLE
					local test = tabclk[2] - tabclk[1]
					if test < 0.5 and test > 0 or test < 0 and test > -0.5 then 
						-- CLOSING THE BOX
					else
						-- CUTTING THE CABLE OR OPENING THE BOX
						if interacted == 'hospital_security_cable'
							and position == bo_boxes[SecBox1]
								then
									_box1_used = true
									RefreshTest()
						elseif interacted == 'hospital_security_cable'
							and position == bo_boxes[SecBox2]
								then
									_box2_used = true
									RefreshTest()
						end
					end
				end
				if not managers.groupai:state():whisper_mode() then
					_box1_used = true
					_box2_used = true
					RefreshTest()
				end
			elseif isClient() then
				if not managers.groupai:state():whisper_mode() then
					_box1_used = true
					_box2_used = true
					RefreshTest()
				end
				if interacted == 'hospital_security_cable' then
					local vecX = position2.x
					local vecY = position2.y
					
					for k, v in pairs(clientBox) do
						if clientBox[k] ~= 0 then
							if
								(vecX < clientBox[k].x + 50 and vecX > clientBox[k].x - 50)
							and
								(vecY < clientBox[k].y + 50 and vecY > clientBox[k].y - 50)
							then
								clientBox[k] = 0
								clientSucceed = clientSucceed + 1
								RefreshTest()
							end
						end
						if clientSucceed == 2 then
							clientBox[1] = 0
							clientBox[2] = 0
							clientBox[3] = 0
							clientBox[4] = 0
							clientBox[5] = 0
							RefreshTest()
						end
					end
				end
			end
		end
		-- BIG BANK
		if (managers.job:current_level_id() == 'big')
		and (interacted == 'big_computer_server') 
		and _bbserv_used == false then
			_bbserv_used = true
			RefreshTest()
		end
		-- BOMB : DOCKYARD
		if (managers.job:current_level_id() == 'crojob2')
		and (interacted == 'hold_pku_disassemble_cro_loot') then
			RefreshTest()
		end
		-- BOMB : FOREST
		if (managers.job:current_level_id() == 'crojob3') then
			if (interacted == 'pick_lock_easy_no_skill' 
			or interacted == 'open_train_cargo_door' 
			or interacted == 'hold_remove_ladder' 
			or interacted == 'take_chainsaw' 
			or interacted == 'use_chainsaw') then
				RefreshTest()
			end
		end
		-- CAR SHOP
		if (managers.job:current_level_id() == 'cage') and (interacted == 'security_station_keyboard') then
			_comp_used = true
			RefreshTest()
		end
		-- HOX DAY 1
		if (managers.job:current_level_id() == 'hox_1') and (interacted == 'security_station_keyboard') then
			_comp_used = true
			RefreshTest()
		end
		-- HOX REVENGE
		if (managers.job:current_level_id() == 'hox_3')
		and (interacted == 'gen_pku_evidence_bag' 
		or interacted == 'mcm_fbi_taperecorder'
		or interacted == 'open_slash_close_sec_box' 
		or interacted == 'hospital_security_cable' 
		or interacted == 'mcm_panicroom_keycard_1'
		or interacted == 'mcm_panicroom_keycard_2' 
		or interacted == 'mcm_break_planks' 
		or interacted == 'mcm_laptop') then
			RefreshTest()
		end
		-- AFTERSHOCK
		if (managers.job:current_level_id() == 'jolly')
		and (interacted == 'pku_safe'
		or interacted == 'safe_carry_drop' 
		or interacted == 'gen_int_saw') then
			RefreshTest()
		end
		-- ARENA
		if (managers.job:current_level_id() == 'arena') 
		and (interacted == 'hack_suburbia' 
		or interacted == 'pick_lock_hard_no_skill_deactivated' 
		or interacted == 'driving_drive' 
		or interacted == 'hold_search_c4' 
		or interacted == 'hold_take_fire_extinguisher' 
		or interacted == 'money_wrap_updating' 
		or interacted == 'hold_circle_cutter' 
		or interacted == 'hold_search_c4') then
			RefreshTest()
		end
		---------------
		-- END STATE --
		---------------
		if game_state_machine:current_state_name() == "victoryscreen" 
		or string.find(game_state_machine:current_state_name(), "victoryscreen")
		or game_state_machine:current_state_name() == "gameoverscreen" 
		or string.find(game_state_machine:current_state_name(), "gameoverscreen") then
			_ToggleWayCheck = 0
			if not _HDmsg then
			else
				_HDmsg.lbl:set_text("")
				_HDmsg.lbl2:set_text("")
				_HDmsg.lbl3:set_text("")
				_HDmsg.lbl4:set_text("")
			end
		end
		return result
	end
	--------------------
	-- UNIT ADD CHECK --
	--------------------
	managers.interaction._add_unit = managers.interaction._add_unit or managers.interaction.add_unit
	function ObjectInteractionManager:add_unit( unit )
		local spawned = unit:interaction().tweak_data
		local result = self:_add_unit(unit)
		if (managers.job:current_level_id() == 'roberts')
		and (spawned == 'pickup_keycard' 
		or spawned == 'grenade_briefcase') then
			RefreshTest()
		elseif (spawned == 'pickup_keycard' 
		or spawned == 'grenade_briefcase') then
			RefreshTest()
		end
		if spawned == 'carry_drop' 
		or spawned == 'caustic_soda' 
		or spawned == 'diamond_pickup' 
		or spawned == 'disarm_bomb' 
		or spawned == 'gold_pile' 
		or spawned == 'gen_pku_artifact' 
		or spawned == 'gen_pku_artifact_statue' 
		or spawned == 'gen_pku_cocaine' 
		or spawned == 'gen_pku_cocaine_pure' 
		or spawned == 'gen_pku_jewelry' 
		or spawned == 'gen_pku_sandwich' 
		or spawned == 'grab_server' 
		or spawned == 'hlm_roll_carpet' 
		or spawned == 'hold_pku_knife' 
		or spawned == 'hold_take_gas_can' 
		or spawned == 'hold_take_painting' 
		or spawned == 'hold_take_parachute' 
		or spawned == 'hydrogen_chloride' 
		or spawned == 'invisible_interaction_open' 
		or spawned == 'money_wrap' 
		or spawned == 'money_wrap_single_bundle' 
		or spawned == 'money_wrap_single_bundle_active' 
		or spawned == 'muriatic_acid' 
		or spawned == 'painting_carry_drop' 
		or spawned == 'pku_barcode_brickell' 
		or spawned == 'pku_barcode_downtown' 
		or spawned == 'pku_barcode_edgewater' 
		or spawned == 'pku_barcode_opa_locka' 
		or spawned == 'pku_pig' 
		or spawned == 'rewire_electric_box' 
		or spawned == 'safe_carry_drop' 
		or spawned == 'safe_loot_pickup' 
		or spawned == 'take_confidential_folder_event' 
		or spawned == 'taking_meth_huge' 
		or spawned == 'votingmachine2' 
		then
			RefreshTest()
		end
		-- KEYCARD COP/CIV : REMOVE WAYPOINT OF THE UNIT WHEN KEYCARD IS DROPPED
		if spawned == 'pickup_keycard' then
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,9) == 'hudz_civ_' or id:sub(1,9) == 'hudz_cop_' then
					managers.hud:remove_waypoint( id )
				end
			end
			RefreshTest()
		end
		-- THE BOMB : DOCKYARD
		if spawned == 'hold_pku_disassemble_cro_loot' then
			RefreshTest()
			_bomb_used = _bomb_used + 1
		end
		if spawned == 'hold_call_captain' then
			for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
				id = tostring(id)
				if id:sub(1,10) == 'hudz_uload' then
					managers.hud:remove_waypoint( id )
				end
			end
			_uldatabase_found = true
		end
		-- THE BOMB : FOREST
		if spawned == 'take_chainsaw' 
		or spawned == 'use_chainsaw' then
			RefreshTest()
		end
		-- ARENA
		if spawned == 'hold_take_fire_extinguisher' 
		or spawned == 'hold_search_c4' then
			RefreshTest()
		end
		return result
	end
end