local _G = require(game:GetService('ReplicatedStorage').void)

local clientTemplate = {

	serverTemplate = _G.getModule("serverTemplate")
}

function clientTemplate:VoidInit()
	--// Automatically executed 	
	print(" ["..script.Name.."]: Initialized")
end

function clientTemplate:VoidStart()
	--// Automatically executed after initializing 
	print(" ["..script.Name.."]: Started")
	
	--[[ 
		(Example Uses)
		print(_G.LocalPlayer)
		print(_G.built)
		print(_G.built.shiftlock)
		local shiftlockModule = require(_G.built.shiftlock)
		shiftlockModule:Activate(true)
	]]

	clientTemplate.serverTemplate.templateEvent:FireServer()
end

return clientTemplate
