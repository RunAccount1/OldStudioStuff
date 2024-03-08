--tried to remake v2 ui and ill just call it v3 lol

local gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
gui.ResetOnSpawn = false
gui.Name = "|"

local utils = {
	getPlr = function()
		return game.Players.LocalPlayer
	end,
	getHumanoidRootPart = function()
		return game.Players.LocalPlayer.Character.PrimaryPart
	end,
	random = function()
		return tostring(math.random())
	end,
	runCode = function(v)
		pcall(function()
			task.spawn(function()
				v()
			end)
		end)
	end,
	onGround = function()
		return game.Players.LocalPlayer.Character.Humanoid.FloorMaterial ~= Enum.Material.Air
	end,
	hookKeys = function(key, func)
		if game.UserInputService:IsKeyDown(key) then
			func()
		end
	end,
}

local library = {
	tabCount = 0,
	UIColor = {
		[1] = Color3.fromRGB(115, 0, 255),
		[2] = Color3.fromRGB(93, 0, 207),
		[3] = Color3.fromRGB(62, 0, 138),
	},
}

library.CreateTab = function(tab)
	local name = tab.Name

	local textLabel = Instance.new('TextLabel', gui)
	textLabel.Position = UDim2.fromScale(.1 + (library.tabCount / 8), .1)
	textLabel.Size = UDim2.fromScale(.1, .05)
	textLabel.Text = name
	textLabel.Name = name
	textLabel.BorderSizePixel = 0
	textLabel.BackgroundColor3 = Color3.fromRGB(50,50,50)
	textLabel.TextColor3 = Color3.fromRGB(255,255,255)

	local frame = Instance.new('Frame', textLabel)
	frame.Position = UDim2.fromScale(0, -.125)
	frame.Size = UDim2.fromScale(1, .125)
	frame.BorderSizePixel = 0
	frame.BackgroundColor3 = Color3.fromRGB(255,255,255)

	task.spawn(function()
		repeat task.wait()
			frame.BackgroundColor3 = library.UIColor[1]
		until false
	end)

	local modules = Instance.new('Frame', textLabel)
	modules.Position = UDim2.fromScale(0, 1)
	modules.Size = UDim2.fromScale(1, 5)
	modules.BorderSizePixel = 0
	modules.BackgroundTransparency = 1
	modules.Name = 'modules'

	local sortModules = Instance.new('UIListLayout', modules)

	game.UserInputService.InputBegan:Connect(function(k, g)
		if g then return end
		if k == nil then return end
		if k.KeyCode == Enum.KeyCode.RightShift then
			textLabel.Visible = not textLabel.Visible
		end
	end)

	library.tabCount += 1
end

library.CreateButton = function(tab)
	local enabled = false
	local name = tab.Name
	local func = tab.Function
	local key = tab.KeyCode
	local theTab = tab.Tab
	local path = gui[theTab].modules

	local btn = Instance.new('TextButton', path)
	local dropdown = Instance.new('Frame', btn)
	local sortDropdown = Instance.new('UIListLayout', dropdown)

	local btnFunction = {
		Enabled = function()
			return enabled
		end,

		ToggleButton = function(v)
			if v then
				enabled = v
			else
				enabled = not enabled
			end
			spawn(function()
				func(enabled)
			end)
			if enabled then
				spawn(function()
					repeat
						game.TweenService:Create(btn, TweenInfo.new(.5), {
							BackgroundColor3 = library.UIColor[1]
						}):Play()
						task.wait()
					until not enabled
				end)
			else
				game.TweenService:Create(btn, TweenInfo.new(1), {
					BackgroundColor3 = Color3.fromRGB(75,75,75)
				}):Play()
			end
		end,

		newToggle = function(tab2)
			local enabled2 = false
			local name2 = tab2.Name
			local func2 = tab2.Function

			local btn2 = Instance.new('TextButton', dropdown)

			local btnFunction2 = {
				Enabled = function()
					return enabled2
				end,
				ToggleButton = function(v)
					if v then
						enabled2 = v
					else
						enabled2 = not enabled2
					end
					spawn(function()
						func2(enabled2)
					end)
					if enabled2 then
						spawn(function()
							repeat
								game.TweenService:Create(btn2, TweenInfo.new(.5), {
									BackgroundColor3 = library.UIColor[1]
								}):Play()
								task.wait()
							until not enabled
						end)
					else
						game.TweenService:Create(btn2, TweenInfo.new(.5), {
							BackgroundColor3 = Color3.fromRGB(75,75,75)
						}):Play()
					end
				end,
			}

			btn2.Position = UDim2.fromScale(0,0)
			btn2.Size = UDim2.fromScale(1, .15)
			btn2.AutoButtonColor = false
			btn2.BorderSizePixel = 0
			btn2.Name = name2
			btn2.Text = name2
			btn2.BackgroundColor3 = Color3.fromRGB(75,75,75)
			btn2.TextColor3 = Color3.fromRGB(255,255,255)

			btn2.MouseButton1Down:Connect(function()
				btnFunction2.ToggleButton()
			end)

			return btnFunction2
		end,

		newPicker = function(tab2)
			local enabled2 = false
			local name2 = tab2.Name
			local options = tab2.Options
			local state = {options[1]}
			local index = 1

			local btn2 = Instance.new('TextButton', dropdown)

			local btnFunction2 = {
				Option = function()
					return options[index]
				end,
			}

			btn2.Position = UDim2.fromScale(0,0)
			btn2.Size = UDim2.fromScale(1, .15)
			btn2.AutoButtonColor = false
			btn2.BorderSizePixel = 0
			btn2.Name = name2
			btn2.Text = name2.. " : "..options[1]
			btn2.BackgroundColor3 = Color3.fromRGB(75,75,75)
			btn2.TextColor3 = Color3.fromRGB(255,255,255)

			btn2.MouseButton1Down:Connect(function()
				index += 1
				if index > #options then
					index = 1
				end
				if tab2.Function then
					tab2.Function(options[index])
				end
				btn2.Text = name2 .. " : ".. options[index]
			end)

			return btnFunction2
		end,

		newTextBox = function(tab2)
			local name2 = tab2.Name
			local func2 = tab2.Function
			local Default = tab2.Default
			if Default == nil then
				Default = 0
			end
			local val = Default

			local textBox = Instance.new('TextBox', dropdown)

			local btnFunction2 = {
				RunCode = function(v)
					func2(textBox.Text)
					val = tonumber(textBox.Text)
				end,
				SetValue = function(v)
					val = v
				end,
				CheckVal = function()
					return val
				end,
			}

			textBox.Position = UDim2.fromScale(0,0)
			textBox.Size = UDim2.fromScale(1, .15)
			textBox.BorderSizePixel = 0
			textBox.Name = name2
			textBox.BackgroundColor3 = Color3.fromRGB(75,75,75)
			textBox.TextColor3 = Color3.fromRGB(255,255,255)
			textBox.Text = name2.. " : "..val

			textBox.FocusLost:Connect(function()
				btnFunction2.RunCode()
				textBox.Text = name2.." : "..val
			end)

			return btnFunction2
		end,
	}

	btn.Position = UDim2.fromScale(0,0)
	btn.Size = UDim2.fromScale(1, .15)
	btn.BorderSizePixel = 0
	btn.Text = name
	btn.Name = name
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.AutoButtonColor = false
	btn.BackgroundColor3 = Color3.fromRGB(75,75,75)

	dropdown.Position = UDim2.fromScale(0, 1)
	dropdown.Size = UDim2.fromScale(1, 5)
	dropdown.BorderSizePixel = 0
	dropdown.BackgroundTransparency = 1
	dropdown.Visible = false

	btn.MouseButton1Down:Connect(function()
		btnFunction.ToggleButton()
	end)

	btn.MouseButton2Down:Connect(function()
		for i,v in pairs(path:GetChildren()) do
			if v.Name == name then continue end
			if v:IsA("UIListLayout") then continue end
			v.Visible = not v.Visible
		end
		dropdown.Visible = not dropdown.Visible
	end)

	game.UserInputService.InputBegan:Connect(function(k, g)
		if g then return end
		if key == nil then return end
		if k.KeyCode == key then
			btnFunction.ToggleButton()
		end
	end)

	return btnFunction
end

library.CreateTab({ ["Name"] = 'Combat', })
library.CreateTab({ ["Name"] = 'Movement', })
library.CreateTab({ ["Name"] = 'Player', })
library.CreateTab({ ["Name"] = 'World', })
library.CreateTab({ ["Name"] = 'Visuals', })
