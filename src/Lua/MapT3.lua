--timers

local tempeststrike = 0
local tempesttimer = 256*TICRATE
local drain = 0
local draintimer = 7088

addHook("MapLoad", do
		tempeststrike = 0
		tempesttimer = 256*TICRATE
		drain = 0
		draintimer = 7088
end)

--Sets gametime to 4:15 after a 1 second delay from the level loading
--(Basically making the total survive time last 4:16)

local function realtime()
	COM_BufInsertText(server, "ze_survtime 255")
end

--Resets a player's score to 0 if they get an impossible score.
--(Thanks linedef 427 for not doing your job)

addHook("PlayerThink", function(player)

	if player.score > 500000 and gamemap == 787 or player.score < 0 and gamemap == 787 then player.score = 0 end
end)

--Drains a player's score as long as Tempest Guage is in efffect

addHook("PlayerThink", function(player)

	if (player.ctfteam == 2) and tempeststrike == 1 and drain == 1 and gamemap == 787 then
		player.score = $-50 
		draintimer = 1*TICRATE
		drain = 0 end
end)

--Kills the player if they have a score of 0

addHook("PlayerThink", function(player)

	if (player.ctfteam == 2) and tempeststrike == 1 and player.score == 0 and gamemap == 787 then
		P_DamageMobj(player.mo, nil, nil, 1, DMG_INSTAKILL) end
end)

--Ticks the timers down

addHook("ThinkFrame", do
		if tempeststrike == 0 and gamemap == 787 or tempeststrike == 1 and gamemap == 787
		   tempesttimer = $-1
	end
       if tempesttimer == 1872 and tempeststrike == 0 and gamemap == 787 then
		  tempeststrike = 1
          chatprint("\x85\Don't let your score fall to zero!")
	end
end)

addHook("ThinkFrame", do
		if drain == 0 and gamemap == 787
		   draintimer = $-1
	end
       if draintimer == 0 and drain == 0 and gamemap == 787 then
		  drain = 1
	end
end)

--Stops Tempest Guage

addHook("ThinkFrame", do
       if tempesttimer == 0 and tempeststrike == 1 and gamemap == 787 then
		  tempeststrike = 2
          chatprint("\x82\Song: Tempestissimo (Uncut Edition) by T+Pazolite")
	end
end)

--Objective Message

addHook("ThinkFrame", do
		if tempesttimer == 236*TICRATE and gamemap == 787 then
			chatprint("\x8A\Collect as much score as you can before the tempest \x85\strikes")
	end
end)

--Flavor Text
addHook("ThinkFrame", do
		if tempesttimer == 251*TICRATE and gamemap == 787 then
			chatprint("\x86\The path here was blazed by the worst recollections of mankind")
	end
end)

addHook("LinedefExecute", realtime, "RSTIME")