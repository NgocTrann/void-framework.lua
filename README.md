--[[
 _____ _                       _     _   _____                                            _    
|_   _| |__   ___  __   _____ (_) __| | |  ___| __ __ _ _ __ ___   _____      _____  _ __| | __
  | | | '_ \ / _ \ \ \ / / _ \| |/ _` | | |_ | '__/ _` | '_ ` _ \ / _ \ \ /\ / / _ \| '__| |/ /
  | | | | | |  __/  \ V / (_) | | (_| | |  _|| | | (_| | | | | | |  __/\ V  V / (_) | |  |   < 
  |_| |_| |_|\___|   \_/ \___/|_|\__,_| |_|  |_|  \__,_|_| |_| |_|\___| \_/\_/ \___/|_|  |_|\_\
  
]]


--[[


	// [ !Disclaimer: Client side modules/code does not need to register or create components ] //

	-- Execution Order for Folders: 1. Libraries, 2. Modules, and 3. Execution.
	
	-- Within each folder each module has a ExecutionOrder Attribute:
	-- This allows for certain modules to be executed before others
	
		--// Execution Order //--
	
	1. Libraries
	- Contains code that are used by other programs/modules
	- pre-written data or templates
	
	2. Modules
	- Executable code that can be used by other modules
	- contains functions, classes, and other code that can be used by other modules
	
	3. ExecutionFolder
	- Contains main game scripts
	
		--// Module Directory //--

	To access Execution, Libraries, Modules use the following code: 
	- _G.Execution
	- _G.Libraries
	- _G.Libraries
	Each are directed to their respective folders, for example if _G.Libraries were to be executed on the server the code would-
	be directed to game.serverscripterservice.Framework.Libararies. 
	the same would work through client. 
	
	-- methods (main methods /important ones only)
	
	1. void (module script)
		Register(): Registers each module script to create a individual folder for communication between client & server
		createComponent(): Redirection & creation of component to avoid issues with circulation
		
	2. network (module script)
		ExecuteModules(): Executes modules in order following information stated above (execution order included)
		LoadComponents(): Loads all components (events, functions) into a created folder through register()
		
		
	--// Example Uses //--

	- Client
		print(_G.LocalPlayer)
		print(_G.built)
		print(_G.built.shiftlock)
		local shiftlockModule = require(_G.built.shiftlock)
		shiftlockModule:Activate(true)
	
	- Server
		self.Components.templateEvent.OnServerEvent:Connect(templateFunction)
		self.Components.templateEvent:FireAll()

]]
