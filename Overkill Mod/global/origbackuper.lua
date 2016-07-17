--====================--
--       BACKUP       --
--     by Baldwin     --
--====================--
--	PURPOSE: EZ BACKUP AND RESTORE FUNCTIONS.
--	INSTRUCTIONS: CREATE NEW CLASS, USE... new_backuper = new_backuper or Backuper:new('new_backuper')
--	Use new_backuper:backup('function_name') to backup function. Function returns original function and cannot be overriden once backuped
--	Use new_backuper:restore('function_name') to restore the function
--	Use new_backuper:restore_all() to restore all functions, backuped by new_backuper
------------------------
Backuper = Backuper or class()
---------------------
-- BACKUP INITIATE --
---------------------
function Backuper:init(class_name)
	self._name = class_name
	self._originals = {}
	self._hacked = {}
end

function Backuper:backup(stuff_string,name) --Original function name!
	if self._originals[name] or self._originals[stuff_string] then
		return self._originals[name] or self._originals[stuff_string]
	end

	local execute, serr = loadstring(self._name..'._originals[\"'..(name or stuff_string)..'\"] = '..stuff_string)

	local success, err = pcall(execute)

	--m_log_vs("Tables:", self._originals[name], self._originals[stuff_string])
	if success then
		return self._originals[name] or self._originals[stuff_string]
	else
	end
end

-------------------
-- BACKUP HIJACK --
-------------------
-- This will allow to hijack single function with different multiple functions!
-- As the 1st argument here will be array containing original function as 1st argument and then array of hijacked functions, 2nd argument reserved for your needs in order to structure calls (by default it passes number 1 as a sign of that function was called first).
-- NOTE: Avoid using this at all costs! If you see any functions hijacked using this, better find other way of hijacking it!
function Backuper:hijack_adv(fstr, new_function)
	if not self._hacked[fstr] then
		self:backup(fstr)
		self._hacked[fstr] = {}
		local exec, serr = loadstring(fstr..' = function(...) local tb = { '..self._name..'._originals[\''..fstr..'\'] } \
			for _,func in ipairs('..self._name..'._hacked[\''..fstr..'\']) do table.insert(tb, func) end	\
				return '..self._name..'._hacked[\''..fstr..'\'][1](  tb, 1, ... )  end')
		
		local s,res = pcall(exec)
	end
	table.insert(self._hacked[fstr], new_function)
	return new_function
	--return #self._hacked[fstr]
end

-- This will pop hijacked function from array
-- If table is empty, then original function being restored
function Backuper:unhijack_adv(fstr, new_func)
	for index,func in pairs(self._hacked[fstr]) do
		if func == new_func then
			table.remove(self._hacked[fstr], index)
		end
	end
	if #self._hacked[fstr] == 0 then
		self:restore(fstr)
	end
end

-------------------------
-- BACKUP EXPERIMENTAL --
-------------------------
-- Experimental feature! I will not move all functions into this. This will hijack function with new_function. When hacked function being executed, new_function recieve original function as 1st argument, then other arguments. So now when you hijack class function, new_function should look like this: function(orig, self, ...) methods end Personally I suggest to use it only when you need to hijack advanced function, that require original function execution aswell.
function Backuper:hijack(function_string, new_function)
	if self._hacked[function_string] then
		self:restore(function_string)
	end
	self:backup(function_string)
	self._hacked[function_string] = new_function
	local exec, serr = loadstring(function_string..' = function(...) return '..self._name..'._hacked[\''..function_string..'\']('..self._name..'._originals[\''..function_string..'\'], ... ) end')
	local s,res = pcall(exec)
	if s then
		return self._hacked[function_string]
	else
	end
end

function Backuper:restore(stuff_string, name)
	local n = self._originals[name] or self._originals[stuff_string]
	if n then
		local exec, serr = loadstring(stuff_string..' = '..self._name..'._originals[\"'..stuff_string..'\"]')
		local success, err = pcall(exec)
		if success then
			self._originals[stuff_string] = nil
			self._hacked[stuff_string] = nil
		else
		end
	end
end

function Backuper:restore_all() --Currently works only, if stuff_string was used as key
	for n,_ in pairs(self._originals) do
		local exec, serr = loadstring(n..' = '..self._name..'._originals[\"'..n..'\"]')
		
		local success, err = pcall(exec)
		if success then
			self._originals[n] = nil
			self._hacked[n] = nil
		else
		end
	end
end

function Backuper:destroy()
	self:restore_all()
end