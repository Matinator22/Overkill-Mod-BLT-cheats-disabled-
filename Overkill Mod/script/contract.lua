--========================--
--      OVERKILL MOD      --
-- JOB SPAWNER BY Dotcom7 --
--========================--
-- r2.2
-----------------------------
-- CONTRACT SPAWN FUNCTION --
-----------------------------
local function add_jobs(data)
local difficulty_id = tweak_data:difficulty_to_index( data.difficulty )
	table.insert( managers.crimenet._presets, { job_id = data.job_id, difficulty_id = difficulty_id, difficulty = data.difficulty, chance = 1 } ) 
end
--------------------
-- MISSION LEVELS --
--------------------
local normal_missions = 
{ 
	"alex",
	"arena",
	"arm_cro",
	"arm_fac",
	"arm_for",
	"arm_hcm",
	"arm_par",
	"arm_und",
	"big",
	"branchbank_deposit",
	"branchbank_cash",
	"cage",
	"cane",
	"crojob1",
	"crojob2",
	"dinner",
	"election_day",
	"family",
	"firestarter",
	"four_stores",
	"framing_frame",
	"gallery",
	"hox",
	"hox_3",
	"jewelry_store",
	"kenaz",
	"kosugi",
	"mallcrasher",
	"mia",
	"mus",
	"nail",
	"nightclub",
	"pbr",
	"pbr2",
	"pines",
	"rat",
	"red2",
	"roberts",
	"shoutout_raid",
	"watchdogs"
}		
local pro = 
{
	"alex_prof",
	"branchbank_prof",
	"branchbank_gold_prof",
	"election_day_prof",
	"firestarter_prof",
	"framing_frame_prof",
	"hox_prof",
	"mia_prof",
	"ukrainian_job_prof",
	"watchdogs_prof",
	"welcome_to_the_jungle_prof"
}
local other_missions = {unpack(normal_missions)} for I = 1,#pro do 
	other_missions[#normal_missions+I] = pro[I] 
end
-----------------------
-- CRIME.NET MANAGER --
-----------------------
local c = managers.crimenet
--------------------------
-- DIFFICULTY FUNCTIONS --
--------------------------
local function cnsetsh()
	c._NEW_JOB_MIN_TIME = 0.3 c._NEW_JOB_MAX_TIME = 0.4 c._presets = {} c._active_jobs = {} c._MAX_ACTIVE_JOBS = 50 
end

local function normalran(difficulty) 
	cnsetsh()
	add_jobs({ job_id = normal_missions[math.random(1, #normal_missions)], difficulty = difficulty}) 
end

local function otherran(difficulty) 
	cnsetsh()
	add_jobs({ job_id = other_missions[math.random(1, #other_missions)], difficulty = difficulty}) 
end

local function normal(difficulty) 
	cnsetsh() 
	for i, normal_missions in ipairs(normal_missions) do 
		add_jobs({ job_id = normal_missions, difficulty = difficulty }) 
	end 
end

local function other(difficulty) 
	cnsetsh() 
	for i, other_missions in ipairs(other_missions) do 
		add_jobs({ job_id = other_missions, difficulty = difficulty }) 
	end 
end

local function reset()
    c._active = false c._presets = nil c._NEW_JOB_MIN_TIME = 1.5 c._NEW_JOB_MAX_TIME = 3.5 c._MAX_ACTIVE_JOBS = 10
    c._mass_spawn_timer = 0.03999999910593 c._active_job_time = 25 end
----------------
-- RANDOMIZER --
----------------
local dash = { "... Add missions to Crime.net.", "... You had one job!", "... Slow and steady wins the race. FALSE, fast always.", "... Looking for a heist? Experience required.", "...  And let me say, \'May the Force be with you.\'", "... If you know you fucked up, just say it Jerry.", "... Ay bro watcha doin\' there?", "... What comes around is all around.", "... Did you know this spawns heists you don\'t even own?", "... It\'s like a game. Repetitive. Even a little tedious after more than an hour.", "... When faced with a decision this important, I consult magic 8 ball.", "... HI! I\'M MR MEESEEKS! LOOK AT ME!", "... Oh no. I\'m late to class, bitch.", "... If you don't start a heist now, we'll die here." }
local rng = math.random( #dash )
------------------------
-- CONTRACT ROOT MENU --
------------------------
root = function()
local data = {
	{ text = "NORMAL MISSIONS", callback = normal, data = "normal" },
	{ text = "HARD MISSIONS", callback = other, data = "hard" },
	{ text = "VERY HARD MISSIONS", callback = other, data = "overkill" },
	{ text = "OVERKILL MISSIONS", callback = other, data = "overkill_145" },
	{ text = "DEATHWISH MISSIONS", callback = other, data = "overkill_290" },
	{},
	{ text = "NORMAL MISSION \[RANDOMIZE\]", callback = normalran, data = "normal" },
	{ text = "HARD MISSION \[RANDOMIZE\]", callback = otherran, data = "hard" },
	{ text = "VERY HARD MISSION \[RANDOMIZE\]", callback = otherran, data = "overkill" },
	{ text = "OVERKILL MISSION \[RANDOMIZE\]", callback = otherran, data = "overkill_145" },
	{ text = "DEATHWISH MISSION \[RANDOMIZE\]", callback = otherran, data = "overkill_290" },
	{},
	{ text = "CLEAR SPAWNED MISSIONS \[REFRESH\]", callback = reset },
	{}
	}
show_sorted_dialog("JOB SPAWNER BY DOTCOM7", ""..dash[rng], data, nil)
end
-------------------
-- MENU DIRECTOR --
-------------------
if not inGame() then
	root() end