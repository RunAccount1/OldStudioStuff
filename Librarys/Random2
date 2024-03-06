-- XD what is this lib bro its so bad

ts = game.TweenService

local logogui3 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
logogui3.ResetOnSpawn = false
logogui3.IgnoreGuiInset = true
logogui3.Archivable = true
logogui3.Name = tostring(math.random())

local tabamount = 1
local newTab = function(v1,v2)
	local lab2new = Instance.new("TextLabel", logogui3)
	lab2new.Name = v1
	lab2new.Position = UDim2.fromScale(0.02 * (tabamount * 5.5), .3)
	lab2new.Size = UDim2.fromScale(.1, .04)
	lab2new.Active = true
	lab2new.Draggable = true
	lab2new.Text = v1
	lab2new.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
	lab2new.BorderSizePixel = 0
	lab2new.TextColor3 = Color3.fromRGB(255,255,255)
	lab2new.Transparency = 0
	local newframe = Instance.new("Frame", lab2new)
	newframe.Name = "newframe"
	newframe.Position = UDim2.fromScale(0, 1)
	newframe.BorderSizePixel = 0
	newframe.Size = UDim2.fromScale(1, 6)
	newframe.BackgroundTransparency = 1
	local listlay = Instance.new("UIListLayout", newframe)
	listlay.SortOrder = Enum.SortOrder.Name
	tabamount += 1
	game.UserInputService.InputBegan:Connect(function(key, gpe)
		if gpe then return end
		if key.KeyCode == Enum.KeyCode.Delete then
			if lab2new.Transparency == 1 then
				local ts1 = ts:Create(lab2new, TweenInfo.new(.7), {Transparency = 0})
				ts1:Play()
				for i,v in pairs(newframe:GetChildren()) do
					if v:IsA("UIListLayout") then continue end
					local ts2 = ts:Create(v, TweenInfo.new(.7), {Transparency = 0})
					ts2:Play()
				end
			else
				local ts1 = ts:Create(lab2new, TweenInfo.new(.7), {Transparency = 1})
				ts1:Play()
				for i,v in pairs(newframe:GetChildren()) do
					if v:IsA("UIListLayout") then continue end
					local ts2 = ts:Create(v, TweenInfo.new(.7), {Transparency = 1})
					ts2:Play()
				end
			end
		end
	end)
end

local newButton = function(v)
	local keyc = v.KeyBind
	local lab4new = Instance.new("TextButton", logogui3[v.Tab].newframe)
	lab4new.Position = UDim2.fromScale(0,0)
	lab4new.Size = UDim2.fromScale(1, .13)
	lab4new.Text = "  "..v.Name
	lab4new.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
	lab4new.BorderSizePixel = 0
	lab4new.TextColor3 = Color3.fromRGB(255,255,255)
	lab4new.Transparency = 0
	lab4new.AutoButtonColor = false
	
	local optionBox = Instance.new("Frame", lab4new)
	optionBox.Position = UDim2.fromScale(1.01,0)
	optionBox.Size = UDim2.fromScale(0.7, 2)
	optionBox.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
	optionBox.BorderSizePixel = 0
	optionBox.Transparency = 0
	optionBox.Visible = false
	local layout = Instance.new("UIListLayout", optionBox)
	
	local Enabled = false
	local buttonFuncs = {
		ToggleBtn = function()
			Enabled = not Enabled
			if Enabled == true then
				array.addnewArray(v.Name, v.ExtraText, Enum.Font.Arial)
				ts:Create(lab4new, TweenInfo.new(.7), {BackgroundColor3 = Color3.fromRGB(170, 170, 170)}):Play()
			else
				array.removeArray(v.Name)
				ts:Create(lab4new, TweenInfo.new(.7), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}):Play()
			end
			v.Function(Enabled)
		end,
		createToggle = function(tab)
			local callback = tab.Function
			local name = tab.Name
			local enabled2 = tab.Default

			local button3 = Instance.new("TextButton", optionBox)
			button3.Position = UDim2.fromScale(0,0)
			button3.Size = UDim2.fromScale(1, 0.4)
			button3.Text = "  "..name
			button3.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
			button3.BorderSizePixel = 0
			button3.TextColor3 = Color3.fromRGB(255,255,255)
			button3.Transparency = 0
			button3.AutoButtonColor = false

			button3.MouseButton1Down:Connect(function()
				enabled2 = not enabled2
				callback(enabled2)

				if enabled2 == true then
					local ts1 = ts:Create(button3, TweenInfo.new(.7), {BackgroundColor3 = Color3.fromRGB(170, 170, 170)})
					ts1:Play()
				else
					local ts1 = ts:Create(button3, TweenInfo.new(.7), {BackgroundColor3 = Color3.fromRGB(120, 120, 120)})
					ts1:Play()
				end
			end)
		end,
		createTextbox = function(tab)
			local callback = tab.Function
			local name = tab.Name

			local textbox1 = Instance.new("TextBox", optionBox)
			textbox1.Position = UDim2.fromScale(0,0)
			textbox1.Size = UDim2.fromScale(1, 0.4)
			textbox1.Text = "  "..name
			textbox1.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
			textbox1.BorderSizePixel = 0
			textbox1.TextColor3 = Color3.fromRGB(255,255,255)
			textbox1.Transparency = 0

			textbox1.FocusLost:Connect(function()
				callback(textbox1.Text)
			end)
		end,
	}
	
	lab4new.MouseButton1Down:Connect(function()
		buttonFuncs.ToggleBtn()
	end)
	
	game.UserInputService.InputBegan:Connect(function(key, gpe)
		if gpe then return end
		if key.KeyCode == keyc then
			buttonFuncs.ToggleBtn()
		end
	end)
	
	lab4new.MouseButton2Down:Connect(function()
		optionBox.Visible = not optionBox.Visible
	end)
	return buttonFuncs
end

newTab("Combat")
newTab("Movement")
newTab("Render")
newTab("Utility")
newTab("Scripts")
