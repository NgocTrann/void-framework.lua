--// [Void Framework] //--

local network = {
	Components = {"RemoteEvent", "RemoteFunction", "BindableFunction", "BindableEvent"};
	
}

function network.ExecuteModules(Directory: Folder)
	
	--/ [[ Handles Executing & Ordering of modules  ]] /--
	
	--// Load module
	local function loadModule(module)
		local requiredModule

		if game:GetService("RunService"):IsServer() == false then
			requiredModule = require(module:Clone())
		else
			requiredModule = require(module)
		end
		
		--// Check for framework methods
		
		if requiredModule.Components ~= nil then
			for componentName, componentType in pairs(requiredModule.Components) do
				network.loadComponents(componentName, componentType, module)
			end
		end
		
		if type(requiredModule["VoidInit"]) == "function" then 
			requiredModule:VoidInit()
		end
		
		if type(requiredModule["VoidStart"]) == "function" then 
			requiredModule:VoidStart()
		end
		
		
	end
	
	--// Execute with order
	local function ExecuteFolder(search: String)
		local ExecutionOrderTable = {}
		local UnknownExecutionTable = {} -- Does not have an order (defaulted to last)

		for index, module in ipairs(Directory[search]:GetChildren()) do
			local findOrder = module:GetAttribute("ExecutionOrder")
			if findOrder then
				ExecutionOrderTable[module] = findOrder
			else
				table.insert(UnknownExecutionTable, module)
			end
		end

		table.sort(ExecutionOrderTable)

		for module in pairs(ExecutionOrderTable) do
			loadModule(module)
		end

		for module in pairs(UnknownExecutionTable) do
			loadModule(module)
		end

		return ExecutionOrderTable
	end

	ExecuteFolder("Libraries")
	ExecuteFolder("Modules")
	ExecuteFolder("Execution")
end

function network.loadComponents(componentName: String, componentType: String, module: ModuleScript)
	if table.find(network.Components, componentType) ~= nil then
		local component = Instance.new(componentType)
		component.Name = componentName
		
		--// [Parent to accessible folder inside framework (void)] //--
		component.Parent = script.Parent:WaitForChild("Modules"):FindFirstChild(module.Name)
		require(module).Components[componentName] = component;
		print("Finished")
	else
		warn("[voidFramework]: invalid component type!")
	end
end

function network.createComponent(componentName: String, componentType: String, ParentTo: Instance)
	--/ [[ Handles cases where script/code is not using void framework ]] /--

	if table.find(network.Components, componentType) then
		local component = Instance.new(componentType)
		component.Name = componentName
		if ParentTo ~= nil then
			component.Parent = script.Parent:WaitForChild("Modules"):FindFirstChild(ParentTo)
		else
			--// There is no created folder for component
			local createFolder = Instance.new("Folder")
			createFolder.Name = componentName
			createFolder = script.Parent:WaitForChild("Modules")

			component.Parent = createFolder
		end
	end
end



return network
