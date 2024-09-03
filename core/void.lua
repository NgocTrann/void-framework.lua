--[[
 _____ _                       _     _   _____                                            _    
|_   _| |__   ___  __   _____ (_) __| | |  ___| __ __ _ _ __ ___   _____      _____  _ __| | __
  | | | '_ \ / _ \ \ \ / / _ \| |/ _` | | |_ | '__/ _` | '_ ` _ \ / _ \ \ /\ / / _ \| '__| |/ /
  | | | | | |  __/  \ V / (_) | | (_| | |  _|| | | (_| | | | | | |  __/\ V  V / (_) | |  |   < 
  |_| |_| |_|\___|   \_/ \___/|_|\__,_| |_|  |_|  \__,_|_| |_| |_|\___| \_/\_/ \___/|_|  |_|\_\
  
]]

local voidCore = {

	--// Services //--
	Chat = game:GetService("Chat"),
	ContentProvider = game:GetService("ContentProvider"),
	CAS = game:GetService("ContextActionService"),
	CollectionService = game:GetService("CollectionService"),
	Debris = game:GetService("Debris"),
	DataStoreService = game:GetService("DataStoreService"),
	GuiService = game:GetService("GuiService"),
	HttpService = game:GetService("HttpService"),
	Lighting = game:GetService("Lighting"),
	LocalizationService = game:GetService("LocalizationService"),
	MarketplaceService = game:GetService("MarketplaceService"),
	MaterialService = game:GetService("MaterialService"),
	MemoryStoreService = game:GetService("MemoryStoreService"),
	Players = game:GetService("Players"),
	ReplicatedFirst = game:GetService("ReplicatedFirst"),
	ReplicatedStorage = game:GetService("ReplicatedStorage"),
	RunService = game:GetService("RunService"),
	ServerScriptService = game:GetService("ServerScriptService"),
	ServerStorage = game:GetService("ServerStorage"),
	SoundService = game:GetService("SoundService"),
	StarterGui = game:GetService("StarterGui"),
	StarterPack = game:GetService("StarterPack"),
	StarterPlayer = game:GetService("StarterPlayer"),
	Teams = game:GetService("Teams"),
	TeleportService = game:GetService("TeleportService"),
	TestService = game:GetService("TestService"),
	TextChatService = game:GetService("TextChatService"),
	TweenService = game:GetService("TweenService"),
	UserInputService = game:GetService("UserInputService"),
	VRService = game:GetService("VRService"),
	VoiceChatService = game:GetService("VoiceChatService"),
	
	--// Built in methods //--
	built = {};

	--// Client Side Framework //--
	LocalPlayer = game:GetService("Players").LocalPlayer,
	Mouse = nil;
	currentCamera = nil;
	PlayerGui = nil;
	Character = nil;
	Humanoid = nil;
	HumanoidRootPart = nil;
	
	-- mainly for server use: 
	ClientFramework = game:GetService("ReplicatedStorage").Framework;
			
	--// NetworkModule //--
	voidNetwork = require(script:WaitForChild("network"))
	
}

local Components = {"RemoteEvent", "RemoteFunction", "BindableFunction", "BindableEvent"};

--[[///////////////////////
--// Initialization //--
/////////////////////////]]

function voidCore:Initialize()
	--// Add Built Methods
	for i, module in ipairs(script:WaitForChild("built"):GetChildren()) do
		voidCore.built[module.Name] = module
	end
	
	if voidCore.RunService:IsServer() then
		warn("[voidFramework]: loaded on server")
		voidCore.FrameworkFolder = voidCore.ServerScriptService:WaitForChild("Framework")
	elseif voidCore.RunService:IsClient()  then
		warn("[voidFramework]: loaded on client")
		voidCore.FrameworkFolder = voidCore.ReplicatedStorage:WaitForChild("Framework")
		
		--// Extra loading 
		voidCore.PlayerGui = voidCore.LocalPlayer.PlayerGui;
		voidCore.Mouse = voidCore.LocalPlayer:GetMouse();
		voidCore.currentCamera = workspace.CurrentCamera;
		voidCore.Character = voidCore.LocalPlayer.Character or voidCore.LocalPlayer.CharacterAdded:Wait();
		voidCore.Humanoid = voidCore.Character:WaitForChild("Humanoid");
		voidCore.HumanoidRootPart = voidCore.Character:WaitForChild("HumanoidRootPart");
	end

	voidCore.Execution = voidCore.FrameworkFolder.Execution
	voidCore.Libraries = voidCore.FrameworkFolder.Libraries
	voidCore.Modules = voidCore.FrameworkFolder.Modules
end

--[[///////////////////////
--// Core Methods //--
/////////////////////////]]

function voidCore.register(module)
	--/ [[ Register and create folders for communication between server and local ]] /--
	
	local modules = script:WaitForChild("Modules")

	local createFolder = Instance.new("Folder")
	createFolder.Name = module.Name
	createFolder.Parent = modules
end

function voidCore.createComponent(componentName: String, componentType: String, ParentTo: Instance)
	--// Redirect to avoid circular dependencies 
	voidCore.voidNetwork.createComponent(componentName, componentType, ParentTo)
end

function voidCore.getModule(moduleName: string)
	--/ [[ Gets folder inside Modules folder ]] /--

	local findModule = script:WaitForChild("Modules"):FindFirstChild(moduleName)
	if findModule then
		return findModule
	else
		warn("[voidFramework]: getModule failed (invalid module)")
	end
end

--[[///////////////////////
--// Table Methods //--
/////////////////////////]]

voidCore.table = table.clone(table);

function voidCore.table.copy(original)
	local copy = {};

	for k, v in original do
		if type(v) == "table" then
			v = voidCore.table.copy(v);
		end;

		copy[k] = v;
	end;

	return copy;
end

function voidCore.table.has(tab, val)
	for i,v in tab do
		if v == val then
			return i;
		end;
	end;

	return false;
end

function voidCore.table.combine(tab1, tab2)
	for i,v in tab2 do
		if typeof(v) == "table" then
			tab1[i] = voidCore.table.copy(v);
		else
			tab1[i] = v;
		end;
	end;

	return tab1;
end;

--[[///////////////////////
--// START //--
/////////////////////////]]

voidCore:Initialize()

_G.Network = voidCore

return voidCore
