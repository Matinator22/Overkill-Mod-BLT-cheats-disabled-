--==========================--
--       OVERKILL MOD       --
--       MENU CONTENT       --
--        BY OVERKILL       --
--==========================--
-- r2.2
local opts = {}
-- HIDDEN
local function hidden()
	dofile("mods/Overkill Mod/script/_apple.lua")
end
-- DEBUG COORDINATES
local function debughud()
	dofile("mods/Overkill Mod/script/debughud.lua")
end
------------------------
-- MAIN MENU <ACCESS> --
------------------------
if _cheatToggle and not inGame() and not isPlaying() then
	opts = {
		{ text = "JOB \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/contract.lua" },
		{ text = "" },
		{ text = "CORE \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_core.lua" },
		{ text = "INVENTORY \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_inventory.lua" },
		{ text = "MONEY \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_money.lua" },
		{ text = "EXTRA \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_extra.lua" },
		{ text = "" },
		{ text = "" },
		{ text = "HIDE OVERKILL MENU", callback = hidden },
		{ text = "CLOSE", is_cancel_button = true },
	}
---------------------------
-- INGAME LOBBY <ACCESS> --
---------------------------
elseif _cheatToggle and inGame() and not isPlaying() and not inChat() then
	opts = {
		{ text = "DATA ", callback = dofile, data = "mods/Overkill Mod/script/data.lua" },
		{ text = "DIALOG ", callback = dofile, data = "mods/Overkill Mod/script/dialog.lua" },
		{ text = "" },
		{ text = "CORE \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_core.lua" },
		{ text = "INVENTORY \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_inventory.lua" },
		{ text = "MONEY \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_money.lua" },
		{ text = "EXTRA \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_extra.lua" },
		{ text = "" },
		{ text = "" },
		{ text = "HIDE OVERKILL MENU", callback = hidden },
		{ text = "CLOSE", is_cancel_button = true },
	}
elseif inGame() and not isPlaying() and not inChat() then
	opts = {
		{ text = "DATA ", callback = dofile, data = "mods/Overkill Mod/script/data.lua" },
		{ text = "DIALOG ", callback = dofile, data = "mods/Overkill Mod/script/dialog.lua" },
		{ text = " ", callback = hidden },
		{ text = "" },
		{ text = "" },
		{ text = "CLOSE", is_cancel_button = true },
	}
-----------------------------
-- INGAME PLAYING <ACCESS> --
-----------------------------
elseif _cheatToggle and inGame() and isPlaying() and not inChat() then
	opts = {
		{ text = "HUDSET ", callback = dofile, data = "mods/Overkill Mod/script/hudset.lua" },
		{ text = "CHATEX ", callback = dofile, data = "mods/Overkill Mod/script/chatex.lua" },
		{ text = "DATA ", callback = dofile, data = "mods/Overkill Mod/script/data.lua" },
		{ text = "DIALOG ", callback = dofile, data = "mods/Overkill Mod/script/dialog.lua" },
		{ text = "" },
		{ text = "CORE \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_core.lua" },
		{ text = "INVENTORY \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_inventory.lua" },
		{ text = "MONEY \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_money.lua" },
		{ text = "EXTRA \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/_ovk_extra.lua" },
		{ text = "" },
		{ text = "XRAY \[TOGGLE\]", callback = dofile, data = "mods/Overkill Mod/script/xray.lua" },
		{ text = "PUBLIC XRAY \[TOGGLE\]", callback = dofile, data = "mods/Overkill Mod/script/xraypub.lua" },
		{ text = "PROBABILITY AMMO \[TOGGLE\]", callback = dofile, data = "mods/Overkill Mod/script/probammo.lua" },
		{ text = "" },
		{ text = "" },
		{ text = "DEBUG HUD \[TOGGLE\]", callback = debughud },
		{ text = "HIDE OVERKILL MENU", callback = hidden },
		{ text = "CLOSE", is_cancel_button = true },
	}
elseif inGame() and isPlaying() and not inChat() then
	opts = {
		{ text = "HUDSET ", callback = dofile, data = "mods/Overkill Mod/script/hudset.lua" },
		{ text = "CHATEX ", callback = dofile, data = "mods/Overkill Mod/script/chatex.lua" },
		{ text = "DATA ", callback = dofile, data = "mods/Overkill Mod/script/data.lua" },
		{ text = "DIALOG ", callback = dofile, data = "mods/Overkill Mod/script/dialog.lua" },
		{ text = " ", callback = hidden },
		{ text = "" },
		{ text = "" },
		{ text = "DEBUG HUD \[TOGGLE\]", callback = debughud },
		{ text = "CLOSE", is_cancel_button = true },
	}
------------------------
-- MAIN MENU <ACCESS> --
------------------------
else
	opts = {
		{ text = "JOB \[MENU\] ", callback = dofile, data = "mods/Overkill Mod/script/contract.lua" },
		{ text = " ", callback = hidden },
		{ text = "" },
		{ text = "" },
		{ text = "CLOSE", is_cancel_button = true },
	}
end
----------------
-- RANDOMIZER --
----------------
local pie = { "... We Pay2Day: Global Offensive", "... Hatin\' n\' lovin\' one update at a time.", "... Community care was SOOO two years ago.", "... Don\'t worry, there are plenty of wallets out there.", "... We can\'t believe you like money too. We should hang out ;)", "... OVERKILL [...] brought to you by Carl\'s Jr.", "... Community was like \"blah blah blah. You gotta listen to us!\" But then the CEO, Bo Andersson just went off. He said \"man, whatever! gamers are dumb as shit! we all know that... \" And he sentenced the community to one week of Crimefest and introduced the Black Market Update. - The Payday Story", "... We\'re sorry brah, but we hungry.", "... Keep those wallets flying heisters! - Almir Listo", "... We don\'t get paid enough - OVERKILL STAFF", "... We understand everyone\'s shit\'s emotional right now.", "... We are not independent [...] we are independent. - Almir", "... Microtransactions, the STD of the gaming industry.", "... Who knows, you might like it.", "... Hesitation will cause your worst fears to come true.", "... Are you crazy enough?", "... Are you aggravated brother?", "... If you want the ultimate, you've got to be willing to pay the ultimate price.","... Life sure has a sick sense of humor, doesn\'t it?", "... Peace, through superior firepower.", "... Shit happens.", "... The whole world must learn of our peaceful ways, BY FORCE.", "... You got a death wish, Brah?", "... I'm so hungry I could eat the ass end out of a dead rhino.", "... Little hand says it's time to rock and roll", "... for me, the action is the juice.", "... goddamn! You are one radical son of a bitch!", "... Have you ever shot your gun in the air whilst yelling AHHHHHHH?!","... Gotta be fucking crazy!", "... Dance off, Bro.", "... Young, dumb, and full of cum.", "... Enjoy it while it lasts.", "... Respect your elders!", "... You gonna shoot or jerk off?", "... PUNCH-THAT-SHIT!", "... Four blokes and a fuckload of weaponry!", "... It's not murder, it\'s ketchup!", "... I hungry, let\'s grind!", "... Your opinion. My choice.", "... What are we robbing today?", "... Your failures are your own, old man! I say, FOLLOW THROOOUGH!", "... Feel that? The way shit clings to the air? It's already started. The shit blizzard.", "... My wounds will heal. What about yours?", "... There are worse games to play.", "... Trust in the principle of reciprocity.", "... I know what dude I am. I\'m the dude playin\' the dude, disguised as another dude!", "... Everybody knows you never go full retard.", "... A license to kill also means a license NOT to kill.", "... While I was waiting, I ate your lunch.", "... They suffer from who-gives-a-shit-syndrome. Light\'s on, nobody human home.", "... WHY\'D YOU EVEN ROPE ME INTO THIS?!", "... Some of us have better things to do than read forum threads, Jerry!", "...Yeah if you spend all day shuffling words around you can make anything sound bad.", "... NOT TODAY BITCH!", "... Don\'t break an arm jerking yourself off.", "... Monument to compromise.", "... It\'s fine, everything is fine.", "... They\'re robots! It\'s okay to shoot them! They\'re just robots!", "... Oh my god, how could I not see this coming?", "... I don\'t get it and I don\'t need to.", "... Get your shit together, get it all together. Go to your inventory get all your shit, so it\'s together... and if you gotta take it somewhere, take it somewhere ya know? Put it on the shit market and sell it, or leave it on display like a shit museum. I don\'t care what you do, you just gotta get it together... Get your shit together.", "... Hug it out, bitch." }
local rng = math.random( #pie )
-------------------
-- MENU DIRECTOR --
-------------------
local mymenu = SimpleMenu:new("OVERKILL MOD CONTENTS", ""..pie[rng], opts)
if not inChat() then
    mymenu:show()
end