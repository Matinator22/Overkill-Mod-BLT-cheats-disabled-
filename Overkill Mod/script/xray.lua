-- X-RAY v0.5 (ENEMIES, CAMS, CIVILIANS WITH KEYCARD, ENEMIES WITH KEYCARD ONLY!)
-- @B1313 (ENEMIES AND CAMS ONLY, CLIENT CAMERA CODE PORTION, FIXING CLIENT DELAY, FIXING/IMPROVING PUBLIC X-RAY TOGGLE)
-- @hejoro (ADDING CONTOUR CLEANUP, ADDING CIVILIAN/ENEMIES KEYCARD PORTION, FIXING SHADOW RAID BUG [ALL GUARDS NOW SHOW UP])
-- @LazyOzzy (CONTOUR CLEANUP, PROVIDING CLIENT CAMERA CODE)
-- @Slynderdale (ORIGINAL CODE, EXPLAINING PUBLIC X-RAY TOGGLE)
-- @Yanrishatum (ORIGINAL CODE)
local ColorList = {
		civpickup       = 'FFFF00', -- YELLOW
		enepickup       = '660066', -- PURPLE
		civilian		= '40E0D0', -- TURQUOISE
		civilian_female	= '48d1cc', -- 
}
function getUnitColor(unit)
	local unitType = unit:base()._tweak_table
	if unit:base().has_civpickup then unitType = 'civpickup' end
	if unit:base().has_enepickup then unitType = 'enepickup' end
	if not ColorList[unitType] then return nil end
	return Color(ColorList[unitType] and ColorList[unitType] or ColorList['default'])
end
--=====================--
--     OVERKILL MOD    --
--         XRAY        --
--=====================--
-- r2.2
-------------------
-- SAVE SETTINGS --
-------------------
local ovkMap = managers.job:current_level_id()
------------------
-- GAME WRAPPER --
------------------
if inGame() and isPlaying() and not inChat() and _cheatToggle then
	if ovkMap == "cane" then
		managers.mission._fading_debug_output:script().log(' ACCESS DENIED ', Color('ffff66') )
		managers.mission._fading_debug_output:script().log(' GAME PROTECTION : ', Color('ffc300') )
	else
		-- SHOW FRAMING FRAME DAY 3 ITEMS
		_FinderItemtoggle_ = not _FinderItemtoggle_
		if _FinderItemtoggle_ then
			for k,v in pairs(managers.mission._scripts.default._elements) do
				if v._values and v._values.trigger_list and v._values.trigger_list[1] and (v._values.trigger_list[1].notify_unit_sequence == "state_outline_enabled" or
				v._values.trigger_list[1].notify_unit_sequence == "enable_outline") then
						v:on_executed()
				end
			end
		else
			for k,v in pairs(managers.mission._scripts.default._elements) do
				if v._values and v._values.trigger_list and v._values.trigger_list[1] and (v._values.trigger_list[1].notify_unit_sequence == "state_outline_disabled" or
				v._values.trigger_list[1].notify_unit_sequence == "disable_outline") then
						v:on_executed()
				end
			end
		end
		-- CONTOUR OVERRIDES
		if ContourExt then
			if not _nhUpdateColor then _nhUpdateColor = ContourExt._upd_color end
			function ContourExt:_upd_color()
				if toggleMark then
					local color = getUnitColor(self._unit)
					if color then
						self._materials = self._materials or self._unit:get_objects_by_type(Idstring("material"))
						for _, material in ipairs(self._materials) do
								material:set_variable(Idstring( "contour_color" ), color)
						end
						return
					end
				end
				_nhUpdateColor(self)
			end
			function ContourExt:setData(data)
				if not data or not type(data) == 'table' then return end
				for k, v in pairs(data) do self._unit:base()[k] = v end
			end
			function ContourExt:remove_all()
				while self._contour_list ~= nil do
					self:_remove(1)
				end
			end
			-- REMOVE CONTOURS ON DEATH FOR HOST
			if not _dieBase then _dieBase = CopDamage.die end
			function CopDamage:die( variant )
				if self._unit:contour() then
					self._unit:contour():remove_all()
				end
				_dieBase(self, variant)
			end
			-- REMOVE CONTOURS ON DEATH FOR CLIENT
			if not _huskDieBase then _huskDieBase = HuskCopDamage.die end
			function HuskCopDamage:die( variant )
				if self._unit:contour() then
					self._unit:contour():remove_all()
				end
				_huskDieBase(self, variant)
			end
			-- REMOVE CONTOURS FOR CAMERA DESTRUCTION
			if not _camDieBase then _camDieBase = ElementSecurityCamera.on_destroyed end
			function ElementSecurityCamera:on_destroyed()
				local camera_unit = self:_fetch_unit_by_unit_id( self._values.camera_u_id )
				if camera_unit:contour() then
						camera_unit:contour():remove_all()
				end
				_camDieBase(self)
			end
		end
		-------------------
		-- SET ALL MARKS --
		-------------------
		function markEnemies()
			if not toggleMark then return end
			-- MARK CIVILIANS
			for u_key,u_data in pairs(managers.enemy:all_civilians()) do
				if u_data.unit.contour and alive(u_data.unit) then
					if isHost() and u_data.unit:character_damage():pickup() then
						u_data.unit:contour():setData({has_civpickup = true})
						-- u_data.unit:contour():add( "mark_enemy", syncMark, 0 )
					end
					u_data.unit:contour():add( "mark_enemy", syncMark, 0 )
				end
			end
			-- MARK ENEMIES
			for u_key,u_data in pairs(managers.enemy:all_enemies()) do
				if u_data.unit.contour and alive(u_data.unit) then
					if isHost() and u_data.unit:character_damage():pickup() and u_data.unit:character_damage():pickup() ~= "ammo" then
						u_data.unit:contour():setData({has_enepickup = true})
					end
					u_data.unit:contour():add( "mark_enemy", syncMark, 0 )
				end
			end
			-- MARK CAMERAS
			if isHost() then
				for u_key, u_data in pairs( managers.groupai:state()._security_cameras ) do
					if u_data.contour then u_data:contour():add( "mark_unit", syncMark, 0 ) end
				end
			else
				for _, unit in ipairs( SecurityCamera.cameras ) do
					if unit and unit:contour() and unit:enabled() and unit:base() and not unit:base():destroyed() then
					unit:contour():add("mark_unit", syncMark, 0 )
					end
				end
			end
		end
		--------------------
		-- NETWORK UPDATE --
		--------------------
		function UnitNetworkHandler:mark_enemy( unit, marking_strength, sender )
		end
		if GameSetup then
			if not _gameUpdate then _gameUpdate = GameSetup.update end
			local _gameUpdateLastMark
			function GameSetup:update(t, dt)
				_gameUpdate(self, t, dt)
				if not _gameUpdateLastMark or t - _gameUpdateLastMark > 4 then
					_gameUpdateLastMark = t
					markData()
				end
			end
		end
		-------------------
		-- INITIATE MARK --
		-------------------
		function markData()
			markEnemies()
		end
		---------------------
		-- CLEAR ALL MARKS --
		---------------------
		function markClear()
			if not inGame() then return end
			-- CLEAR CAMERAS
			if isHost() then
				for u_key, u_data in pairs(managers.groupai:state()._security_cameras) do
					if u_data.contour then u_data:contour():remove( "mark_unit", syncMark ) end
				end
			else
				for _, unit in ipairs( SecurityCamera.cameras ) do
					unit:contour():remove( "mark_unit", syncMark )
				end
			end
			-- CLEAR CIVILIANS
			for u_key,u_data in pairs(managers.enemy:all_civilians()) do
				if u_data.unit.contour then u_data.unit:contour():remove( "mark_enemy", syncMark ) end
			end
			-- CLEAR ENEMIES
			for u_key,u_data in pairs(managers.enemy:all_enemies()) do
				if u_data.unit.contour then u_data.unit:contour():remove( "mark_enemy", syncMark ) end
			end
		end
		---------------------
		-- TOGGLE FUNCTION --
		---------------------
		function markToggle(toggleSync)
			if not inGame() then 
				return 
			end
			if toggleSync then
				syncMark = not syncMark
			else
				toggleMark = not toggleMark
				if not toggleMark then 
					beep() 
					markClear() 
				end
			end
			beep() 
			markData()
		end
		if not toggleMark then 
			toggleMark = false 
		end
		if not syncMark then 
			syncMark = false 
		end
		markToggle()
	end
----------------------
-- END GAME WRAPPER --
----------------------
end