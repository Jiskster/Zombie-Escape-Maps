--Sets gametime to 4:16 and wait time to 0:10 from the level loading


-- i dont get this below 5/21/23 Jisk
local function realtime()
	--COM_BufInsertText(server, "ze_wait 10")
	--COM_BufInsertText(server, "ze_survtime 256")
end

addHook("LinedefExecute", realtime, "RSTIME")