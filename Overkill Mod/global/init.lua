--===============================--
--         OVERKILL MOD          --
--     GLOBAL INITIALIZATION     --
--          by B1313             --
--===============================--
-- r2.1
if not GlobalScriptInitialized then
GlobalScriptInitialized = true
-------------------
-- GLOBAL COLORS --
-------------------
Color.AliceBlue = Color('F0F8FF')
Color.AntiqueWhite = Color('FAEBD7')
Color.Aqua = Color('00FFFF')
Color.Aquamarine = Color('7FFFD4')
Color.Azure = Color('F0FFFF')
Color.Beige = Color('F5F5DC')
Color.Bisque = Color('FFE4C4')
Color.BlanchedAlmond = Color('FFEBCD')
Color.BlueViolet = Color('8A2BE2')
Color.Brown = Color('A52A2A')
Color.BurlyWood = Color('DEB887')
Color.CadetBlue = Color('5F9EA0')
Color.Chartreuse = Color('7FFF00')
Color.Chocolate = Color('D2691E')
Color.Coral = Color('FF7F50')
Color.CornflowerBlue = Color('6495ED')
Color.Cornsilk = Color('FFF8DC')
Color.Crimson = Color('DC143C')
Color.Cyan = Color('00FFFF')
Color.DarkBlue = Color('00008B')
Color.DarkCyan = Color('008B8B')
Color.DarkGoldenRod = Color('B8860B')
Color.DarkGray = Color('A9A9A9')
Color.DarkGreen = Color('006400')
Color.DarkKhaki = Color('BDB76B')
Color.DarkMagenta = Color('8B008B')
Color.DarkOliveGreen = Color('556B2F')
Color.DarkOrange = Color('FF8C00')
Color.DarkOrchid = Color('9932CC')
Color.DarkRed = Color('8B0000')
Color.DarkSalmon = Color('E9967A')
Color.DarkSeaGreen = Color('8FBC8F')
Color.DarkSlateBlue = Color('483D8B')
Color.DarkSlateGray = Color('2F4F4F')
Color.DarkTurquoise = Color('00CED1')
Color.DarkViolet = Color('9400D3')
Color.DeepPink = Color('FF1493')
Color.DeepSkyBlue = Color('00BFFF')
Color.DimGray = Color('696969')
Color.DodgerBlue = Color('1E90FF')
Color.FireBrick = Color('B22222')
Color.ForestGreen = Color('228B22')
Color.Fuchsia = Color('FF00FF')
Color.Gainsboro = Color('DCDCDC')
Color.Gold = Color('FFD700')
Color.GoldenRod = Color('DAA520')
Color.Gray = Color('808080')
Color.GreenYellow = Color('ADFF2F')
Color.HoneyDew = Color('F0FFF0')
Color.HotPink = Color('FF69B4')
Color.IndianRed = Color('CD5C5C')
Color.Indigo = Color('4B0082')
Color.Khaki = Color('F0E68C')
Color.Lavender = Color('E6E6FA')
Color.LavenderBlush = Color('FFF0F5')
Color.LawnGreen = Color('7CFC00')
Color.LemonChiffon = Color('FFFACD')
Color.LightBlue = Color('ADD8E6')
Color.LightCoral = Color('F08080')
Color.LightCyan = Color('E0FFFF')
Color.LightGoldenRodYellow = Color('FAFAD2')
Color.LightGray = Color('D3D3D3')
Color.LightGreen = Color('90EE90')
Color.LightPink = Color('FFB6C1')
Color.LightSalmon = Color('FFA07A')
Color.LightSeaGreen = Color('20B2AA')
Color.LightSkyBlue = Color('87CEFA')
Color.LightSlateGray = Color('778899')
Color.LightSteelBlue = Color('B0C4DE')
Color.LightYellow = Color('FFFFE0')
Color.Lime = Color('00FF00')
Color.LimeGreen = Color('32CD32')
Color.Linen = Color('FAF0E6')
Color.Magenta = Color('FF00FF')
Color.Maroon = Color('800000')
Color.MediumAquaMarine = Color('66CDAA')
Color.MediumBlue = Color('0000CD')
Color.MediumOrchid = Color('BA55D3')
Color.MediumPurple = Color('9370DB')
Color.MediumSeaGreen = Color('3CB371')
Color.MediumSlateBlue = Color('7B68EE')
Color.MediumSpringGreen = Color('00FA9A')
Color.MediumTurquoise = Color('48D1CC')
Color.MediumVioletRed = Color('C71585')
Color.MidnightBlue = Color('191970')
Color.MintCream = Color('F5FFFA')
Color.MistyRose = Color('FFE4E1')
Color.Moccasin = Color('FFE4B5')
Color.Navy = Color('000080')
Color.OldLace = Color('FDF5E6')
Color.Olive = Color('808000')
Color.OliveDrab = Color('6B8E23')
Color.Orange = Color('FFA500')
Color.OrangeRed = Color('FF4500')
Color.Orchid = Color('DA70D6')
Color.PaleGoldenRod = Color('EEE8AA')
Color.PaleGreen = Color('98FB98')
Color.PaleTurquoise = Color('AFEEEE')
Color.PaleVioletRed = Color('DB7093')
Color.PapayaWhip = Color('FFEFD5')
Color.PeachPuff = Color('FFDAB9')
Color.Peru = Color('CD853F')
Color.Pink = Color('FFC0CB')
Color.Plum = Color('DDA0DD')
Color.PowderBlue = Color('B0E0E6')
Color.RosyBrown = Color('BC8F8F')
Color.RoyalBlue = Color('4169E1')
Color.SaddleBrown = Color('8B4513')
Color.Salmon = Color('FA8072')
Color.SandyBrown = Color('F4A460')
Color.SeaGreen = Color('2E8B57')
Color.SeaShell = Color('FFF5EE')
Color.Sienna = Color('A0522D')
Color.Silver = Color('C0C0C0')
Color.SkyBlue = Color('87CEEB')
Color.SlateBlue = Color('6A5ACD')
Color.SlateGray = Color('708090')
Color.SpringGreen = Color('00FF7F')
Color.SteelBlue = Color('4682B4')
Color.Tan = Color('D2B48C')
Color.Teal = Color('008080')
Color.Thistle = Color('D8BFD8')
Color.Tomato = Color('FF6347')
Color.Turquoise = Color('40E0D0')
Color.Violet = Color('EE82EE')
Color.Wheat = Color('F5DEB3')
Color.YellowGreen = Color('9ACD32')
-----------------------
-- UTILITY FUNCTIONS --
-----------------------
if not _initcheck then
	-- TABLE FOR TOGGLE VARIABLES
	Toggle = Toggle or {}
	-- GLOBAL BACKUP
	backuper = backuper or Backuper:new("backuper")
	---------------------------
	-- GENERAL MANAGER CHECK --
	---------------------------
	if not managers then return end
	-------------------------
	-- MONEY MANAGER CHECK --
	-------------------------
	if not MoneyManager then return end
	----------------------------
	-- SIMPLEMENU by Harfatus --
	----------------------------
	if not SimpleMenu then
		SimpleMenu = class()
		function SimpleMenu:init(title, message, options)
			self.dialog_data = { title = title, text = message, button_list = {},
								 id = tostring(math.random(0,0xFFFFFFFF)) }
			self.visible = false
			for _,opt in ipairs(options) do
				local elem = {}
				elem.text = opt.text
				opt.data = opt.data or nil
				opt.callback = opt.callback or nil
				elem.callback_func = callback(self, self, "_do_callback",
											  { data = opt.data,
												callback = opt.callback})
				elem.cancel_button = opt.is_cancel_button or false
				if opt.is_focused_button then
					self.dialog_data.focus_button = #self.dialog_data.button_list+1
				end
				table.insert(self.dialog_data.button_list, elem)
			end
			return self
		end
		function SimpleMenu:_do_callback(info)
			if info.callback then
				if info.data then
					info.callback(info.data)
				else
					info.callback()
				end
			end
			self.visible = false
		end
		function SimpleMenu:show()
			if self.visible then
				return
			end
			self.visible = true
			managers.system_menu:show(self.dialog_data)
		end
		function SimpleMenu:hide()
			if self.visible then
				managers.system_menu:close(self.dialog_data.id)
				self.visible = false
				return
			end
		end
	end
	-------------------
	-- PATCHED INPUT --
	-------------------
	patched_update_input = patched_update_input or function (self, t, dt )
		if self._data.no_buttons then return end
		local dir, move_time
		local move = self._controller:get_input_axis( "menu_move" )
		if( self._controller:get_input_bool( "menu_down" )) then
			dir = 1
		elseif( self._controller:get_input_bool( "menu_up" )) then
			dir = -1
		end
		if dir == nil then
			if move.y > self.MOVE_AXIS_LIMIT then
				dir = 1
			elseif move.y < -self.MOVE_AXIS_LIMIT then
				dir = -1
			end
		end
		if dir ~= nil then
			if( ( self._move_button_dir == dir ) and self._move_button_time and ( t < self._move_button_time + self.MOVE_AXIS_DELAY ) ) then
				move_time = self._move_button_time or t
			else
				self._panel_script:change_focus_button( dir )
				move_time = t
			end
		end
		self._move_button_dir = dir
		self._move_button_time = move_time
		local scroll = self._controller:get_input_axis( "menu_scroll" )
		if( scroll.y > self.MOVE_AXIS_LIMIT ) then
			self._panel_script:scroll_up()
		elseif( scroll.y < -self.MOVE_AXIS_LIMIT ) then
			self._panel_script:scroll_down()
		end
	end
	managers.system_menu.DIALOG_CLASS.update_input = patched_update_input
	managers.system_menu.GENERIC_DIALOG_CLASS.update_input = patched_update_input
	-------------------------------------------
	-- SIMPLE MENU V3 [REQUIRES SIMPLE MENU] --
	-------------------------------------------
    SimpleMenuV3 = SimpleMenuV3 or class(SimpleMenu)
    function SimpleMenuV3:init(title, message, options, mode)
		self.mode = mode or 1 -- Modes: 0 no switch_back, 1 switch_back support
        self.dialog_data = { title = title, text = message, button_list = {}, id = tostring(math.random(0,0xFFFFFFFF)) }
        self.visible = false
        for _,opt in ipairs(options) do
            local elem = {}
            elem.text = opt.text
            opt.data = opt.data or nil
            opt.callback = opt.callback or nil
            elem.callback_func = callback(self, self, "_do_callback",{ data = opt.data, callback = opt.callback, come_back = opt.switch_back }) --Switch back can be function to execute after click aswell
            elem.cancel_button = opt.is_cancel_button or false
            if opt.is_focused_button then
                self.dialog_data.focus_button = #self.dialog_data.button_list+1
            end
            table.insert(self.dialog_data.button_list, elem)
        end
        return self
    end
	function SimpleMenuV3:show()
	-- IF ANOTHER DIALOG OPENS, CLOSE AND CREATE NEW DIALOG
		if SimpleMenuV3.__current_menu then
			SimpleMenuV3.__current_menu:hide(true)
		end
		self.super.show(self)
		SimpleMenuV3.__current_menu = self
	end
	function SimpleMenuV3:hide( conflict )
		if not conflict or not self.persisted then
			self.super.hide(self)
			-- IMITATE CANCEL BUTTON CLICK
			for _,btn in pairs(self.dialog_data.button_list) do
				if btn.cancel_button then
					btn.callback_func()
				end
			end
		SimpleMenuV3.__current_menu = nil
		end
	end
	function SimpleMenuV3:_do_callback(info)
		if info.callback then
			local err, res = pcall(info.callback, info.data)
		end
		if info.come_back and self.mode == 1 then
			if type(info.come_back) == 'function' then
				info.come_back()
			else
				self:show()
			end
		end
	end
    -------------------
	-- SORTED DIALOG --
	-------------------
	max_entries = 18 -- MAX AMMOUNT OF ENTRIES BEING ADDED INTO SINGLE DIALOG
    insert = table.insert
    show_sorted_dialog = function(title,text,data,fallback,mx,n)
        if not n or n < 1 then
            n = 1
        end
        local max_entries = mx or max_entries
        local t_data = { { text = 'Exit', cancel_button = true } }
		local s_data = { { text = '' } }
        if fallback then
            insert(t_data, { text = 'Return', callback = fallback })
        end
		if (#data - n >= max_entries) then -- SINCE n STARTS WITH 1
            insert(t_data, { text = 'Next Page', callback = function() show_sorted_dialog(title,text,data,fallback,mx,n+max_entries) end })
        end
        if n > 1 then
            insert(t_data, { text = 'Previous Page', callback = function() show_sorted_dialog(title,text,data,fallback,mx,n-max_entries) end })
        end
        insert(t_data, {})
        for i=n,(max_entries+(n-1) < #data) and max_entries+(n-1) or #data do
            insert(t_data, data[i])
        end
		insert(s_data, {})
        local menu = SimpleMenu:new(title, text, t_data)
        menu:show()
    end
	------------------
	-- SIMPLE INPUT --
	------------------
    if not SimpleInput then
        function managers.menu_component:force_create_chat()
            self._lobby_chat_gui_active = true
            if self._game_chat_gui then
                self:show_game_chat_gui()
                return
            end
            self:add_game_chat()
        end
        SimpleInput = SimpleInput or class()
        SimpleInput._visible = SimpleInput._visible or false
        SimpleInput._origFuncs = SimpleInput._origFuncs or { managers_chat_send_message = managers.chat.send_message,
                                                             ChatGui_create_input_panel = ChatGui._create_input_panel,
                                                             managers_menucomp_key_press_controller_support = managers.menu_component.key_press_controller_support,
                                                             managers_hudchat_on_focus = managers.hud and managers.hud._hud_chat._on_focus or nil,
                                                             managers_hudchat_receive_message = managers.hud and managers.hud._hud_chat.receive_message or nil
                                                           }
        function SimpleInput:init(opts)
            self.cblk = opts.cblk or function(...) end
            self.intro = opts.intro
            self.intro_color = opts.intro_color or Color.white
            self.prompt = opts.prompt
            self.isVisible = false
            self.chatWasVisible = false
        end
        function SimpleInput:_remove_hooks()
            managers.menu_component:close_chat_gui()
            managers.chat.send_message = SimpleInput._origFuncs.managers_chat_send_message
            ChatGui._create_input_panel = SimpleInput._origFuncs.ChatGui_create_input_panel
            managers.menu_component.key_press_controller_support = SimpleInput._origFuncs.managers_menucomp_key_press_controller_support
            if self.chatWasVisible then
                self.chatWasVisible = false
                if managers.hud then
                    managers.hud._hud_chat._on_focus = SimpleInput._origFuncs.managers_hudchat_on_focus
                    managers.hud._hud_chat.receive_message = SimpleInput._origFuncs.managers_hudchat_receive_message
                    managers.hud:set_chat_focus( false )
                else
                    managers.menu_component:_create_lobby_chat_gui()
                end
            end
        end
        function SimpleInput:_inject_hooks()
            if managers.menu_component._game_chat_gui or (managers.hud and managers.hud._hud_chat) then
                self.chatWasVisible = true
            end
            pcall(managers.menu_component.close_chat_gui, managers.menu_component)
            managers.chat.send_message = managers.chat.receive_message_by_name
            ChatGui._create_input_panel = self._create_input_panel
            managers.menu_component.key_press_controller_support = function(...) end
            managers.SimpleInput = self
            managers.menu_component:force_create_chat()
            managers.menu_component._game_chat_gui.receive_message = self._receive_message
            if managers.hud then
                managers.hud._hud_chat.receive_message = function (...) end
                managers.hud._hud_chat._on_focus = function(...) end
            end
            managers.menu_component._game_chat_gui:open_page()
        end
        function SimpleInput:show()
            if SimpleInput._visible then
                return
            end
            SimpleInput._visible = true
            self.isVisible = true
            self:_inject_hooks()
            if self.intro then
                local cblkTmp = managers.SimpleInput.cblk
                managers.SimpleInput.cblk = function(...) return { msg = self.intro, color = self.intro_color } end
                managers.menu_component._game_chat_gui:receive_message(nil, nil, nil, nil)
                managers.SimpleInput.cblk = cblkTmp
            end
        end
        function SimpleInput:hide()
            if not SimpleInput._visible then
                return
            end
            SimpleInput._visible = false
            self.isVisible = false
            self:_remove_hooks()
        end
        function SimpleInput:is_visible()
            return self.isVisible
        end
        function SimpleInput:_create_input_panel()
            self._input_panel = self._panel:panel( { alpha = 0, name = "input_panel", x = 0, h = 24, w = self._panel_width, layer = 1 } )
            self._input_panel:rect( { name = "focus_indicator", visible = false, color = Color.black:with_alpha( 0.2 ), layer = 0 } )
            local say = self._input_panel:text( { name = "say", text = managers.SimpleInput.prompt, font = tweak_data.menu.pd2_small_font, font_size = tweak_data.menu.pd2_small_font_size, x = 0, y = 0,
                                            align="left", halign="left", vertical="center", hvertical="center", blend_mode="normal",
                                            color = Color.white, layer = 1 } )
            local _,_,w,h = say:text_rect()
            say:set_size( w, self._input_panel:h() )
            local input_text = self._input_panel:text( { name = "input_text", text = "", font = tweak_data.menu.pd2_small_font, font_size = tweak_data.menu.pd2_small_font_size, x = 0, y = 0,
                                            align="left", halign="left", vertical="center", hvertical="center", blend_mode="normal",
                                            color = Color.white, layer = 1, wrap = true, word_wrap = false } )
            local caret = self._input_panel:rect( { name="caret", layer = 2, x = 0, y = 0, w = 0, h = 0, color = Color(0.05, 1, 1, 1) } )
            self._input_panel:rect( { name="input_bg", color=Color.black:with_alpha(0.5), layer = -1, valign = "grow", h = self._input_panel:h() } )
            self._input_panel:child( "input_bg" ):set_w( self._input_panel:w() - w )
            self._input_panel:child( "input_bg" ):set_x( w )

            self._input_panel:stop()
            self._input_panel:animate( callback( self, self, "_animate_hide_input" ) )
        end
        function SimpleInput:_receive_message(_, message, ... )
            if( not alive( self._panel ) ) then
                return
            end
            local status, output = pcall(managers.SimpleInput.cblk, message)
            if not status or not output then
                return
            end
            local output_panel = self._panel:child( "output_panel" )
            local scroll_panel = output_panel:child( "scroll_panel" )
            local x = 0
            local icon = output.icon
            local icon_bitmap
            if icon then
                local icon_texture, icon_texture_rect = tweak_data.hud_icons:get_icon_data( icon )
                icon_bitmap = scroll_panel:bitmap( { texture = icon_texture, texture_rect = icon_texture_rect, color = output.color or Color.white, y = 1 } )
                x = icon_bitmap:right()
            end
            local line = scroll_panel:text( { text = tostring(output.msg), font = output.font or tweak_data.menu.pd2_small_font,
                                            font_size = output.font_size or tweak_data.menu.pd2_small_font_size, x = x, y = 0,
                                            align="left", halign="left", vertical="top", hvertical="top", blend_mode="normal", wrap = true, word_wrap = true,
                                            color = output.color or Color.white, layer = 0 } )
            local total_len = utf8.len( line:text() )
            line:set_range_color( 0, total_len, output.color or Color.white )
            local _,_,w,h = line:text_rect()
            line:set_h( h )
            local line_bg = scroll_panel:rect( { color=Color.black:with_alpha(0.5), layer = -1, halign="left", hvertical="top" } )
            line_bg:set_h( h )
            table.insert( self._lines, { line, line_bg, icon_bitmap } )
            self:_layout_output_panel()
            if not self._focus then
                output_panel:stop()
                output_panel:animate( callback( self, self, "_animate_show_component" ), output_panel:alpha() )
                output_panel:animate( callback( self, self, "_animate_fade_output" ) )
            end
        end
    end
	--------------------------
	-- LOCALIZATION UTILITY --
	--------------------------
	-- USE LOCALIZATION FOR MENU AND TEXTS
    if not LocalizationUtility then
        function managers.menu_component:force_create_chat()
            self._lobby_chat_gui_active = true
            if self._game_chat_gui then
                self:show_game_chat_gui()
                return
            end
            self:add_game_chat()
        end
        LocalizationUtility = LocalizationUtility or class()
        LocalizationUtility._visible = LocalizationUtility._visible or false
        LocalizationUtility._origFuncs = LocalizationUtility._origFuncs or { managers_chat_send_message = managers.chat.send_message,
                                                             ChatGui_create_input_panel = ChatGui._create_input_panel,
                                                             managers_menucomp_key_press_controller_support = managers.menu_component.key_press_controller_support,
                                                             managers_hudchat_on_focus = managers.hud and managers.hud._hud_chat._on_focus or nil,
                                                             managers_hudchat_receive_message = managers.hud and managers.hud._hud_chat.receive_message or nil
                                                           }

        function LocalizationUtility:init(opts)
            self.cblk = opts.cblk or function(...) end
            self.data = opts.data
            self.intro = opts.intro
            self.intro_color = opts.intro_color or Color.white
            self.prompt = opts.prompt
            self.isVisible = false
            self.chatWasVisible = false
        end
        function LocalizationUtility:_remove_hooks()
            managers.menu_component:close_chat_gui()
            managers.chat.send_message = LocalizationUtility._origFuncs.managers_chat_send_message
            ChatGui._create_input_panel = LocalizationUtility._origFuncs.ChatGui_create_input_panel
            managers.menu_component.key_press_controller_support = LocalizationUtility._origFuncs.managers_menucomp_key_press_controller_support
            if self.chatWasVisible then
                self.chatWasVisible = false
                if managers.hud then
                    managers.hud._hud_chat._on_focus = LocalizationUtility._origFuncs.managers_hudchat_on_focus
                    managers.hud._hud_chat.receive_message = LocalizationUtility._origFuncs.managers_hudchat_receive_message
                    managers.hud:set_chat_focus( false )
                else
                    managers.menu_component:_create_lobby_chat_gui()
                end
            end
        end
        function LocalizationUtility:_inject_hooks()
            if managers.menu_component._game_chat_gui or (managers.hud and managers.hud._hud_chat) then
                self.chatWasVisible = true
            end
            pcall(managers.menu_component.close_chat_gui, managers.menu_component)
            managers.chat.send_message = managers.chat.receive_message_by_name
            ChatGui._create_input_panel = self._create_input_panel
            managers.menu_component.key_press_controller_support = function(...) end
            managers.LocalizationUtility = self
            managers.menu_component:force_create_chat()
            managers.menu_component._game_chat_gui.receive_message = self._receive_message
            if managers.hud then
                managers.hud._hud_chat.receive_message = function (...) end
                managers.hud._hud_chat._on_focus = function(...) end
            end
            managers.menu_component._game_chat_gui:open_page()
        end
        function LocalizationUtility:show()
            if LocalizationUtility._visible then
                return
            end
            LocalizationUtility._visible = true
            self.isVisible = true
            self:_inject_hooks()
            if self.intro then
                local cblkTmp = managers.LocalizationUtility.cblk
                managers.LocalizationUtility.cblk = function(...) return { msg = self.intro, color = self.intro_color } end
                managers.menu_component._game_chat_gui:receive_message(nil, nil, nil, nil)
                managers.LocalizationUtility.cblk = cblkTmp
            end
        end
        function LocalizationUtility:hide()
            if not LocalizationUtility._visible then
                return
            end
            LocalizationUtility._visible = false
            self.isVisible = false
            self:_remove_hooks()
        end
        function LocalizationUtility:is_visible()
            return self.isVisible
        end
        function LocalizationUtility:_create_input_panel()
            self._input_panel = self._panel:panel( { alpha = 0, name = "input_panel", x = 0, h = 24, w = self._panel_width, layer = 1 } )
            self._input_panel:rect( { name = "focus_indicator", visible = false, color = Color.black:with_alpha( 0.2 ), layer = 0 } )
            local say = self._input_panel:text( { name = "say", text = managers.LocalizationUtility.prompt, font = tweak_data.menu.pd2_small_font, font_size = tweak_data.menu.pd2_small_font_size, x = 0, y = 0,
                                            align="left", halign="left", vertical="center", hvertical="center", blend_mode="normal",
                                            color = Color.white, layer = 1 } )
            local _,_,w,h = say:text_rect()
            say:set_size( w, self._input_panel:h() )
            local input_text = self._input_panel:text( { name = "input_text", text = "", font = tweak_data.menu.pd2_small_font, font_size = tweak_data.menu.pd2_small_font_size, x = 0, y = 0,
                                            align="left", halign="left", vertical="center", hvertical="center", blend_mode="normal",
                                            color = Color.white, layer = 1, wrap = true, word_wrap = false } )
            local caret = self._input_panel:rect( { name="caret", layer = 2, x = 0, y = 0, w = 0, h = 0, color = Color(0.05, 1, 1, 1) } )
            self._input_panel:rect( { name="input_bg", color=Color.black:with_alpha(0.5), layer = -1, valign = "grow", h = self._input_panel:h() } )
            self._input_panel:child( "input_bg" ):set_w( self._input_panel:w() - w )
            self._input_panel:child( "input_bg" ):set_x( w )

            self._input_panel:stop()
            self._input_panel:animate( callback( self, self, "_animate_hide_input" ) )
        end
        function LocalizationUtility:_receive_message(_, message, ... )
            if( not alive( self._panel ) ) then
                return
            end
            local status, output = pcall(managers.LocalizationUtility.cblk, message, managers.LocalizationUtility.data)
            if not status or not output then
                return
            end
            local output_panel = self._panel:child( "output_panel" )
            local scroll_panel = output_panel:child( "scroll_panel" )
            local x = 0
            local icon = output.icon
            local icon_bitmap
            if icon then
                local icon_texture, icon_texture_rect = tweak_data.hud_icons:get_icon_data( icon )
                icon_bitmap = scroll_panel:bitmap( { texture = icon_texture, texture_rect = icon_texture_rect, color = output.color or Color.white, y = 1 } )
                x = icon_bitmap:right()
            end
            local line = scroll_panel:text( { text = tostring(output.msg), font = output.font or tweak_data.menu.pd2_small_font,
                                            font_size = output.font_size or tweak_data.menu.pd2_small_font_size, x = x, y = 0,
                                            align="left", halign="left", vertical="top", hvertical="top", blend_mode="normal", wrap = true, word_wrap = true,
                                            color = output.color or Color.white, layer = 0 } )
            local total_len = utf8.len( line:text() )
            line:set_range_color( 0, total_len, output.color or Color.white )
            local _,_,w,h = line:text_rect()
            line:set_h( h )
            local line_bg = scroll_panel:rect( { color=Color.black:with_alpha(0.5), layer = -1, halign="left", hvertical="top" } )
            line_bg:set_h( h )
            table.insert( self._lines, { line, line_bg, icon_bitmap } )
            self:_layout_output_panel()
            if not self._focus then
                output_panel:stop()
                output_panel:animate( callback( self, self, "_animate_show_component" ), output_panel:alpha() )
                output_panel:animate( callback( self, self, "_animate_fade_output" ) )
            end
        end
    end
	----------------
	-- MENU CHECK --
	----------------
	-- OPEN MENU
	function openmenu(menu)
		menu:show()
	end
	-- SHOW MENU
	function show_menu(menu)
		menu:show()
	end
	-- BEEP
	function beep()
		if managers and managers.menu_component then
			managers.menu_component:post_event("menu_enter")
		end
	end
	--------------------
	-- MESSAGE CHECKS --
	--------------------
	-- SHOW HINT
	function showHint(msg)
		if not managers or not managers.hud then return end
		managers.hud:show_hint({text = msg})
	end
	-- MIDTEXT
	function show_mid_text( msg, msg_title, show_secs )
		if managers and managers.hud then
			managers.hud:present_mid_text( { text = msg, title = msg_title, time = show_secs } )
		end
	end
	-- SHOW CHATMSG
	function ChatMessage(message, username)
		if not managers or not managers.chat or not message then return end
		if not username then username = managers.network.account:username() end
			managers.chat:receive_message_by_name(1, username, message)
	end
	-- SHOW SYSTEMMSG
	function SystemMessage(message)
		if not managers or not managers.chat or not message then return end
			managers.chat:_receive_message(1, managers.localization:to_upper_text( "menu_system_message" ), message, tweak_data.system_chat_color)
	end
	-- MSG USER
	function SendMessage(message, username)
		if not managers or not managers.chat or not message then return end
		if not username then username = managers.network.account:username() end
			managers.chat:send_message(1, username, message)
	end
	-- CONSOLE TEXT
	function Console( text )
		io.stderr:write(text .. "\n")
	end
	-------------------------
	-- GAME NETWORK CHECKS --
	-------------------------
	-- TITLESCREEN CHECK
	function inTitlescreen()
		if not game_state_machine then return false end
		return string.find(game_state_machine:current_state_name(), "titlescreen")
	end
	-- LOADING CHECK
	function isLoading()
		if not BaseNetworkHandler then
			return false
		end
		return BaseNetworkHandler._gamestate_filter.waiting_for_players[ game_state_machine:last_queued_state_name() ]
	end
	-- GAME CHECK
	function inGame()
		if not game_state_machine then return false end
		return string.find(game_state_machine:current_state_name(), "game")
	end
	-- CHAT CHECK
	function inChat()
		if managers.hud and managers.hud._chat_focus then
			return true
		end
	end
	-- SINGLEPLAYER CHECK
	function isSinglePlayer()
		return Global.game_settings.single_player or false
	end
	-- PLAYING CHECK
	function isPlaying()
		if not BaseNetworkHandler then
			return false
		end
		return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
	end
	-- SERVER CHECK
	function isServer()
		if not Network then
			return false
		end
		return Network:is_server()
	end
	-- HOST CHECK
	function isHost()
		if not Network then
			return false
		end
		return not Network:is_client()
	end
	-- CLIENT CHECK
	function isClient()
		if not Network then
			return false
		end
		return Network:is_client()
	end
	-- PLAYER ID CHECK
	function PlayerName(id)
		if managers.platform:presence() ~= "Playing" then
			return ""
		end
		local players = managers.groupai:state():all_player_criminals()
		for _,data in pairs(players) do
			local unit = data.unit
			if unit:network():peer():id() == id then
				return unit:base():nick_name()
			end	
		end
		return ""
	end
	------------------
	-- WEAPON CHECK --
	------------------
	function isPrimary(type)
		local primary = managers.blackmarket:equipped_primary()
		if primary then
			local category = tweak_data.weapon[ primary.weapon_id ].category
			if category == string.lower(type) then
				return true
			end
		end
		return false
	end
	function isSecondary(type)
		local secondary = managers.blackmarket:equipped_secondary()
		if secondary then
			local category = tweak_data.weapon[ secondary.weapon_id ].category
			if category == string.lower(type) then
				return true
			end
		end
		return false
	end
	function inSteelsight()
		local player = managers.player:local_player()
		local in_steelsight = false
		if player and alive( player ) then
			in_steelsight = player:movement() and player:movement():current_state() and player:movement():current_state():in_steelsight() or false
		end
		return in_steelsight
	end
	---------------------
	-- GAMEPLAY CHECKS --
	---------------------
	-- CUSTODY CHECK
	function inCustody()
		local player = managers.player:local_player()
		local in_custody = false
		if managers and managers.trade and alive( player ) then
			in_custody = managers.trade:is_peer_in_custody(managers.network:session():local_peer():id())
		end
		return in_custody
	end
	-- HOSTAGE CHECK
	function isHostage(unit)
		if unit and alive(unit) and
		((unit.brain and unit:brain().is_hostage and unit:brain():is_hostage()) or
		(unit.anim_data and (unit:anim_data().tied or unit:anim_data().hands_tied))) then
		return true
		end
	return false
	end
	---------------------
	-- CROSSHAIR CHECK --
	---------------------
	--  XHAIR POS
	function get_crosshair_pos(penetrate, from_pos, mvec_to)
		local ray = get_crosshair_ray(penetrate, from_pos, mvec_to)
		if not ray then return false end
		return ray.hit_position
	end
	-- XHAIR POS V2 (COLLISION HIT)
	function get_crosshair_pos_new()
		local player_unit = managers.player:player_unit()
		local mvec_to = Vector3()
			mvector3.set(mvec_to, player_unit:camera():forward())
			mvector3.multiply(mvec_to, 20000)
			mvector3.add(mvec_to, player_unit:camera():position())
			return World:raycast('ray', player_unit:camera():position(), mvec_to, 'slot_mask', managers.slot:get_mask('bullet_impact_targets'))
	end
	-- XHAIR POS V3 (THROUGH WALL)
	function get_crosshair_ray(penetrate, slotMask)
		if not slotMask then slotMask = "bullet_impact_targets" end
		local player = managers.player:player_unit()
		local fromPos = player:camera():position()
		local mvecTo = Vector3()
		mvector3.set(mvecTo, player:camera():forward())
		mvector3.multiply(mvecTo, 20000)
		mvector3.add(mvecTo, fromPos)
		local colRay = World:raycast("ray", fromPos, mvecTo, "slot_mask", managers.slot:get_mask(slotMask))
		if colRay and penetrate then
				local offset = Vector3()
					mvector3.set(offset, player:camera():forward())
					mvector3.multiply(offset, 100)
				mvector3.add(colRay.hit_position, offset)
		end
		return colRay
	end
	----------------
	-- TABLE DUMP --
	----------------
	function in_table( table, value )
		if table ~= nil then
			for i,x in pairs(table) do
				if x == value then
					return true
				end
			end
		end
		return false
	end
	-----------------------------
	-- SAFER VERSION OF DOFILE --
	-----------------------------
	if not orig__dofile then
		orig__dofile = dofile
		function dofile(...)
			local name = select(1, ...)
			if name then
				local check
				local exts = { '', '.lua', '.luac' }
				local i = 0
				repeat
				i = i + 1	
				check = io.open(name..exts[i], 'r')
				until check or i >= #exts
				if not check then
					return
				end
				check:close()
				return orig__dofile( name..exts[i] )
			end	
		end	
	end
_initcheck = true
end -- _initcheck END
end -- GlobalScriptInitialized END