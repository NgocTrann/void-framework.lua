local _G = require(game:GetService('ReplicatedStorage').void)

local serverTemplate = {
	--// Register Module into framework (Server Side Only)
	_G.register(script);
	
	--// Create Components  (Server Side Only)
	Components = {
		templateEvent = "RemoteEvent";
	};
	
}

local function templateFunction()
	print("Function Output")
end

function serverTemplate:VoidInit()
	--// Automatically executed 	
	print(" ["..script.Name.."]: Initialized")
end

function serverTemplate:VoidStart()
	--// Automatically executed after initializing 
	print(" ["..script.Name.."]: Started")
	
	self.Components.templateEvent.OnServerEvent:Connect(templateFunction)
end

return serverTemplate
