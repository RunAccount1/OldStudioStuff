-- more god awful uis lawl

repeat task.wait() until game:IsLoaded()

local library = {tabs = 0, UIColor = Color3.fromRGB(126, 0, 0), GuiBind = Enum.KeyCode.Delete, notifCount = 0,}

function tweenColor(obj, clr1, clr2, Changing)
	game.TweenService:Create(obj, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Changing = clr1 }):Play(); task.wait(.3)
	game.TweenService:Create(obj, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Changing = clr2 }):Play(); task.wait(.3)
end

local GUI = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
GUI.ResetOnSpawn = false
GUI.Name = tostring(math.random())

function library:Notification(Type, Thing, Time)
	spawn(function()
		library.notifCount += 1
		
		local newNotif = Instance.new("TextLabel", GUI)
		newNotif.Size = UDim2.fromScale(0.25, 0.04)
		newNotif.Position = UDim2.fromScale(0.75, 0.95 - (library.notifCount / 10))
		newNotif.BorderSizePixel = 0
		newNotif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		newNotif.BackgroundTransparency = 0.4
		newNotif.TextColor3 = Color3.fromRGB(255,255,255)
		newNotif.TextSize = 17
		
		if Type == "Toggle" then
			newNotif.Text = Thing.. " has been toggled"
		else
			newNotif.Text = Thing
		end
		
		local newBox = Instance.new("Frame", newNotif)
		newBox.Size = UDim2.fromScale(1, 0.15)
		newBox.Position = UDim2.fromScale(0,-.15)
		newBox.BorderSizePixel = 0
		newBox.BackgroundColor3 = library.UIColor
		
		game.TweenService:Create(newBox, TweenInfo.new(Time), {
			Size = UDim2.fromScale(0, .15)
		}):Play()
		
		task.wait(Time)
		
		game.TweenService:Create(newNotif, TweenInfo.new(1), {
			Position = UDim2.fromScale(1.1,1.1)
		}):Play()
		
		library.notifCount -= 1
	end)
end

function library:MakeTab(tab)
	local name = tab.Name

	local Text = Instance.new("TextLabel", GUI)
	Text.Position = UDim2.fromScale(0.1 + (library.tabs / 8), 0.1)
	Text.Size = UDim2.fromScale(0.095, 0.04)
	Text.BorderSizePixel = 0
	Text.Font = Enum.Font.Roboto
	Text.TextColor3 = library.UIColor
	Text.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Text.Text = name
	Text.Name = name
	Text.TextSize = 17
	Text.Active = true
	Text.Draggable = true

	local Modules = Instance.new("Frame", Text)
	Modules.Position = UDim2.fromScale(0,1)
	Modules.Size = UDim2.fromScale(1, 7)	
	Modules.BorderSizePixel = 0
	Modules.BackgroundTransparency = 1
	Modules.Name = "Modules"

	local sort = Instance.new("UIListLayout", Modules)

	game.UserInputService.InputBegan:Connect(function(k, gpe)
		if gpe then return end
		if k.KeyCode == library.GuiBind then
			Text.Visible = not Text.Visible
		end
	end)

	library.tabs += 1
end

function library:MakeButton(tab)
	local enabled = false

	local name = tab["Name"]
	local func = tab["Function"]
	local box = tab["Tab"]
	local keyc = tab["KeyBind"]
	local path = GUI[box].Modules
	local extratext = function()
		return tab.ExtraText
	end

	local Text = Instance.new("TextButton", path)
	local Dropdown = Instance.new("Frame", Text)
	local sortDropdown = Instance.new("UIListLayout", Dropdown)
	
	local funcs = {
		Enabled = function()
			return enabled
		end,
		Toggle = function(v)
			if v then
				enabled = v
			else
				enabled = not enabled
			end
			if enabled then
				Text.TextColor3 = library.UIColor
			else
				Text.TextColor3 = Color3.fromRGB(255,255,255)
			end
			func(enabled)
		end,
		newToggle = function(tab2)
			local enabled2 = false
			local name2 = tab2.Name
			local btnFunc2 = tab2.Function

			local Text2 = Instance.new("TextButton", Dropdown)
			Text2.Position = UDim2.fromScale(0,0)
			Text2.Size = UDim2.fromScale(1, .2)
			Text2.BorderSizePixel = 0
			Text2.Font = Enum.Font.Roboto
			Text2.TextColor3 = Color3.fromRGB(255,255,255)
			Text2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Text2.Text = name2
			Text2.Name = name2
			Text2.TextSize = 17
			Text2.AutoButtonColor = false

			local funcs2 = {
				Enabled = function()
					return enabled2
				end,
				Toggle = function(v)
					if v then
						enabled2 = v
					else
						enabled2 = not enabled2
					end
					if enabled2 then
						Text2.TextColor3 = library.UIColor
					else
						Text2.TextColor3 = Color3.fromRGB(255,255,255)
					end
					btnFunc2(enabled2)
				end,
			}

			Text2.MouseButton1Down:Connect(function()
				funcs2.Toggle()
			end)

			return funcs2
		end,
		newTextBox = function(tab2)
			local name2 = tab2.Name
			local btnFunc2 = tab2.Function
			local val = tab2.Default

			local Text2 = Instance.new("TextBox", Dropdown)
			Text2.Position = UDim2.fromScale(0,0)
			Text2.Size = UDim2.fromScale(1, .2)
			Text2.BorderSizePixel = 0
			Text2.Font = Enum.Font.Roboto
			Text2.TextColor3 = Color3.fromRGB(255,255,255)
			Text2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Text2.Text = name2.." : "..val
			Text2.Name = name2
			Text2.TextSize = 17

			local funcs2 = {
				RunCode = function(v)
					btnFunc2(Text2.Text)
					val = tonumber(Text2.Text)
				end,
				SetValue = function(v)
					val = v
				end,
			}

			Text2.FocusLost:Connect(function(v)
				funcs2.RunCode()
				Text2.Text = name.." : "..val
			end)

			return funcs2
		end,
	}
	
	Text.Position = UDim2.fromScale(0,0)
	Text.Size = UDim2.fromScale(1, 0.09)
	Text.BorderSizePixel = 0
	Text.Font = Enum.Font.Roboto
	Text.TextColor3 = Color3.fromRGB(255,255,255)
	Text.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Text.Text = name
	Text.Name = name
	Text.TextSize = 17
	Text.AutoButtonColor = false
	
	Dropdown.Position = UDim2.fromScale(0,1)
	Dropdown.Size = UDim2.fromScale(1, 5)
	Dropdown.BorderSizePixel = 0
	Dropdown.BackgroundTransparency = 1
	Dropdown.Name = name
	Dropdown.Visible = false
	
	Text.MouseButton2Down:Connect(function()
		Dropdown.Visible = not Dropdown.Visible
		for i,v in pairs(GUI[box].Modules:GetChildren()) do
			if v.Name == name then continue end
			if v:IsA("UIListLayout") then continue end
			v.Visible = not v.Visible
		end
	end)
	
	Text.MouseButton1Down:Connect(function()
		funcs.Toggle()
	end)
	
	game.UserInputService.InputBegan:Connect(function(key, gpe)
		if gpe then return end
		if keyc == nil then return end
		if key.KeyCode == keyc then
			funcs.Toggle()
		end
	end)
	return funcs
end

Combat = library:MakeTab({
	Name = "Combat",
})
Player = library:MakeTab({
	Name = "Player",
})
Movement = library:MakeTab({
	Name = "Movement",
})
Visuals = library:MakeTab({
	Name = "Visuals",
})
World = library:MakeTab({
	Name = "World",
})
Exploit = library:MakeTab({
	Name = "Exploit",
})
