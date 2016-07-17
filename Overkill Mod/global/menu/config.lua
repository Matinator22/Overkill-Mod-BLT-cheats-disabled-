_G.ovkmenu = _G.ovkmenu or {}
ovkmenu._path = ModPath .. "global/menu/"
ovkmenu._data_path = ModPath .. "global/ovk_save.txt"
ovkmenu._data = {} 

function ovkmenu:Save()
	local file = io.open( self._data_path, "w+" )
	if file then
		file:write( json.encode( self._data ) )
		file:close()
	end
end

function ovkmenu:Load()
	local file = io.open( self._data_path, "r" )
	if file then
		self._data = json.decode( file:read("*all") )
		file:close()
	end
end

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_ovkmenu", function( loc )
	loc:load_localization_file( ovkmenu._path .. "loc/en.txt")
end)

Hooks:Add( "MenuManagerInitialize", "MenuManagerInitialize_ovkmenu", function( menu_manager )

	MenuCallbackHandler.callback_fastmask = function(self, item)
		ovkmenu._data.fastmask = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_firemode = function(self, item)
		ovkmenu._data.firemode = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_autorepair = function(self, item)
		ovkmenu._data.autorepair = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_xpheat = function(self, item)
		ovkmenu._data.xpheat = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_laserColor_options = function(self, item)
		ovkmenu._data.laserColor = item:value()
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_flashColor_options = function(self, item)
		ovkmenu._data.flashColor = item:value()
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_flashRange_options = function(self, item)
		ovkmenu._data.flashRange = item:value()
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_dlc = function(self, item)
		ovkmenu._data.dlc = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_skin = function(self, item)
		ovkmenu._data.skin = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_spoof_options = function(self, item)
		ovkmenu._data.spoof = item:value()
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_stats = function(self, item)
		ovkmenu._data.stats = item:value()
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_rpk_vf = function(self, item)
		ovkmenu._data.rpk_vf = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_m249_vf = function(self, item)
		ovkmenu._data.m249_vf = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_buzz_vf = function(self, item)
		ovkmenu._data.buzz_vf = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_par_vf = function(self, item)
		ovkmenu._data.par_vf = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	MenuCallbackHandler.callback_bren_vf = function(self, item)
		ovkmenu._data.bren_vf = (item:value() == "on" and true or false)
		ovkmenu:Save()
	end
	
	ovkmenu:Load()
	MenuHelper:LoadFromJsonFile( ovkmenu._path .. "menu.txt", ovkmenu, ovkmenu._data )
end )