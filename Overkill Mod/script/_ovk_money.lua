--=================================--
--          OVERKILL MOD           --
--   THE PANTY DROPPER FUNCTIONS   --
--          BY OVERKILL            --
--=================================--
-- r2.1
if not inGame() then
	-------------------------------
	-- THEPANTYDROPPER FUNCTIONS --
	-------------------------------
	function pantydropper_add(tier)
		if tier == 1 then
			managers.money : _add_to_total(5000000)
			managers.mission._fading_debug_output:script().log("DEPOSITED 1 MILLION CASH + 4 MILLION OFFSHORE", Color("2ebdf5") )
			managers.mission._fading_debug_output:script().log("CRIME.NET : ", tweak_data.system_chat_color )
		elseif tier == 2 then
			managers.money : _add_to_total(50000000)
			managers.mission._fading_debug_output:script().log("DEPOSITED 10 MILLION CASH + 40 MILLION OFFSHORE", Color("2ebdf5") )
			managers.mission._fading_debug_output:script().log("CRIME.NET : ", tweak_data.system_chat_color )
		elseif tier == 3 then
			managers.money : _add_to_total(500000000)
			managers.mission._fading_debug_output:script().log("DEPOSITED 100 MILLION CASH + 400 MILLION OFFSHORE", Color("2ebdf5") )
			managers.mission._fading_debug_output:script().log("CRIME.NET : ", tweak_data.system_chat_color )
		elseif tier == 4 then
			managers.money : _add_to_total(1000000, {no_offshore = true})
			managers.mission._fading_debug_output:script().log("DEPOSITED 1 MILLION CASH", Color("2ebdf5") )
			managers.mission._fading_debug_output:script().log("CRIME.NET : ", tweak_data.system_chat_color )
		elseif tier == 5 then
			managers.money : _add_to_total(10000000, {no_offshore = true})
			managers.mission._fading_debug_output:script().log("DEPOSITED 10 MILLION CASH", Color("2ebdf5") )
			managers.mission._fading_debug_output:script().log("CRIME.NET : ", tweak_data.system_chat_color )
		else
			managers.mission._fading_debug_output:script().log(" -- ERROR -- ", Color.DarkRed )
		end
		beep()
	end
	function pantydropper_reset()
		managers.money:reset()
		managers.mission._fading_debug_output:script().log("REMOVED ALL CASH", Color("2ebdf5") )
		managers.mission._fading_debug_output:script().log("CRIME.NET : ", tweak_data.system_chat_color )
	end
	
elseif inGame() then
	-----------------------------
	-- MICROTRANSACTION LESSON --
	-----------------------------
	function fail()
		DelayedCalls:Add("FAIL_ACTION_1", 1, function() managers.mission._fading_debug_output:script().log("ROLLING ...",tweak_data.system_chat_color ) beep() end)
		DelayedCalls:Add("FAIL_ACTION_2", 5, function() managers.mission._fading_debug_output:script().log("YOU LOSE! DEDUCTED 1000 SPENDING CASH", Color("97d04d")) managers.money : _deduct_from_total(1000) beep() end)
		DelayedCalls:Add("FAIL_ACTION_3", 9, function() managers.mission._fading_debug_output:script().log("GOOD DAY!", Color("ea984f")) beep() end)
	end
	function undefined()
		DelayedCalls:Add("UNDEFINED_ACTION_1", 1, function() managers.mission._fading_debug_output:script().log("ROLLING ...", tweak_data.system_chat_color ) beep() end)
		DelayedCalls:Add("UNDEFINED_ACTION_2", 5, function() managers.mission._fading_debug_output:script().log("YOU LOSE! DEDUCTED 500 SPENDING CASH", Color("97d04d")) managers.money : _deduct_from_total(500) beep() end)
		DelayedCalls:Add("UNDEFINED_ACTION_3", 9, function() managers.mission._fading_debug_output:script().log("GOOD DAY!", Color("ea984f")) beep() end)
	end
	function pass()
		DelayedCalls:Add("PASS_ACTION_1", 1, function() managers.mission._fading_debug_output:script().log("ROLLING ...", tweak_data.system_chat_color ) beep() end)
		DelayedCalls:Add("PASS_ACTION_2", 5, function() managers.mission._fading_debug_output:script().log("YOU WIN! ADDED 1000 SPENDING CASH", Color("97d04d")) managers.money : _add_to_total(1000, {no_offshore = true}) beep() end)
		DelayedCalls:Add("PASS_ACTION_3", 9, function() managers.mission._fading_debug_output:script().log("GOOD DAY!", Color("ea984f")) beep() end)
	end
end
----------------
-- RANDOMIZER --
----------------
local iota = { "... All for one and more for Bo.", "... What?! Is it forbidden?!", "... Players love it.", "... Players seem to be loving it.", "... Stat boosts are completely fine because it helps the team.", "... the outcome was never really in doubt.", "... It's that time of the month again.", "... The secret is admiring without desiring.", "... Oh moi goosh guise check out mah skins.", "... Guns, \'Murica, tits, and explosions. Maybe this game needs more tits.", "... I'm your eyes when you must steal.", "... Palms are sweaty. Knees weak arms are heavy...", "... Well, at least one person cared. But I am not that one person.", "... There will be a day when I care. BUT THAT IS NOT THIS DAY.", "... It was me, the author of all your pain. - Bo", "... Motherfuckin\' money.", "... I\'m your dream, make you real.", "... I'll smoke it with you bro. We'll go to the loony bin together.", "... goddamit, you had ONE JOB!", "... It\'s a crime of passion, not a disgruntled gamer. Everyone here is extremely gruntled.", "... I\'m sorry, I had a very different understanding as to what \'prima nocte\' meant.", "... There are five stages to grief. Denial, anger, bargaining, depression and acceptance. If I can get them depressed, then I\'ll have done my job.", "... Anyone in the world can write anything they want about any subject, so you know you are getting the best possible information. - Benjamin Franklin", "... Oh, this is gonna work out great because communicating with players is a very important part of the job, and we haven\'t been there in months.", "... Sometimes what brings the kids together is hating the lunch lady. Ashley is that lunch lady.", "... A toast to the victims of microtransactions.", "... Now introducing a new safe, schrödinger. Add some uncertainty in your life!", "... 4-8-15-16-23-42", "... You\'re not gonna believe this, because it usually never happens, but I made a mistake.", "... What the !@#$ is going on?", "... Don\'t be trippin dog we got you.", "... That\'s what she said.", "... We're either really stupid or really evil.", "... Your failures are your own, old man! I say, FOLLOW THROOOUGH!", "... WHY\'D YOU EVEN ROPE ME INTO THIS?!", "... Don\'t look at me that guy over there roped ME into this.", "... Some of us have better things to do than read forum threads, Jerry!", "... Oh no. I\'m late to class, bitch.", "... funding our other projects with your money from Payday 2." }
local rng = math.random( #iota )
----------------
-- GUARD MENU --
----------------
pantydrop_guard = function()
local data = {
	{ text = "I AM FUCKING SURE!", callback = pantydropper_reset },
	{}
	}
show_sorted_dialog("THE PANTY DROPPER FUNCTIONS", "ARE YOU REALLY SURE?", data, pantydrop_menu)
end
----------------
-- INTRO MENU --
----------------
pantydrop_menu = function()
local list = { "YES", "MAYBE", "I GUESS", "SURE", "I AM SURE", "WHY NOT", "UGH...", "FUCKITOL" }
local num = math.random( #list )
local data = {
	{ text = "1 MILLION CASH AND 4 MILLION OFFSHORE \[DEPOSIT\]", callback = pantydropper_add, data = 1 },
	{ text = "10 MILLION CASH AND 40 MILLION OFFSHORE \[DEPOSIT\]", callback = pantydropper_add, data = 2 },
	{ text = "100 MILLION CASH AND 400 MILLION OFFSHORE \[DEPOSIT\]", callback = pantydropper_add, data = 3 },
	{},
	{ text = "1 MILLION CASH : NO OFFSHORE \[DEPOSIT\]", callback = pantydropper_add, data = 4 },
	{ text = "10 MILLION CASH : NO OFFSHORE \[DEPOSIT\]", callback = pantydropper_add, data = 5 },
	{},
	{ text = "CLEAR ALL CASH? ".."\["..list[num].."\]", callback = pantydrop_guard },
	{}
	}
show_sorted_dialog("THE PANTY DROPPER FUNCTIONS", ""..iota[rng], data, nil)
end
---------------
-- GAME MENU --
---------------
-- THE HOUSE ALWAYS WINS
pantydrop_game = function()
	local gam = { fail, pass, undefined }
	local rng = math.random( #gam )
	local data = {
		{ text = "SURE, I GUESS SO", callback = gam[rng] },
		{ text = "FUCK YOU, OVERKILL!", callback = gam[rng] },
		{ text = "(DEAD SILENCE)", callback = gam[rng] },
		{ text = "NO THANK YOU", callback = gam[rng] },
		{ text = "WTF IS THIS SHIT", callback = gam[rng] },
	{}
	}
	show_sorted_dialog("WOULD YOU LIKE TO GIVE YOUR SUPPORT?", "With your help for just $2.49 a day. You can help save an OVERKILL employee.\n\n in the arms of an angel...\n fly away from here...\n from this dark cold hotel room...\n and the endlessness that you fear...\n you are pulled from the wreckage...\n of your silent reverie...\n you're in the arms of an angel...\n may you find some comfort here...\n so tired of the straight line...\n and everywhere you turn...\n there's vultures and thieves at your back...\n the storm keeps on twisting...\n you keep on building the lies...\n that you make up for all that you lack...\n in this sweet madness...\n oh this glorious sadness...\n that brings me to my knees...\n", data, nil)
end
-------------------
-- MENU DIRECTOR --
-------------------
if not inGame() and _cheatToggle then
	pantydrop_menu()
elseif inGame() and not isPlaying() and _cheatToggle and not inChat() then
	pantydrop_game()
elseif inGame() and isPlaying() and _cheatToggle and not inChat() then
	pantydrop_game()
end