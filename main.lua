local event = require("event")
local activeEvents = {}
local reactorManager = require("reactorManager")
local config = require("config")

local function handleRedstoneChange(a,b,c,redstoneStrengh)
	if(redstoneStrengh == 15) then reactorManager.handleTick() end
end

local function main()
	local function handleUserInput(input)
		-- TODO: Implement to return important info like status, and add ability to manually control behaviour, like creating power vs breeding
		if not input then return false end
		print(input)
		return true
	end

	print("Reactor Manager has started")
	while true do
		io.write("Reactor Manager > ")
		if not handleUserInput(io.read()) then
			print("Send interupt signal")
			break
		end
	end
end

local function onClose(success, result)
	if not success then
		config.errorCallback(result)
	end

	print("Reactor Manager is closing")

	print("Unbinding events...")
	for _, id in pairs(activeEvents) do
		event.cancel(id)
	end

	print("Turning off reactors...")
	if reactorManager.emergencyShutdown() then
		print("Successfuly closed")
	else
		print("Failed to turn off reactors")
	end
end


activeEvents["redstone_changed"] = event.listen("redstone_changed",handleRedstoneChange)

onClose(pcall(main))
