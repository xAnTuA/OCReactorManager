local config = {
	sysTransposerSide = 1
}

function config.errorCallback(traceback)
	-- your implementation here
	print(traceback)
end

return config
