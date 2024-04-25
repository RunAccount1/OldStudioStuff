Players = game:GetService("Players")
Lighting = game:GetService("Lighting")
ReplicatedStorage = game:GetService("ReplicatedStorage")
UserInputService = game:GetService("UserInputService")
LocalPlayer = Players.LocalPlayer
Character = LocalPlayer.Character
Humanoid = Character.Humanoid
PrimaryPart = Character.PrimaryPart
PlayerGui = LocalPlayer.PlayerGui
PlayerScripts = LocalPlayer.PlayerScripts
Camera = workspace.Camera
CurrentCamera = workspace.CurrentCamera
RunService = game["Run Service"]
TweenService = game.TweenService

local library = {}
local utils = {}

utils.onGround = function()
	return Humanoid.FloorMaterial ~= Enum.Material.Air
end
utils.isMoving = function()
	return UserInputService:IsKeyDown("W") or UserInputService:IsKeyDown("A") or UserInputService:IsKeyDown("S") or UserInputService:IsKeyDown("D")
end

library.WindowCount = 0

library.Array = {}
library.Array.Background = true
library.Array.SortMode = "TextLength"
library.Array.BlurEnabled = false
library.Array.Bold = false
library.Array.BackgroundTransparency = 0.1
library.Array.TextTransparency = 0

library.Color = Color3.fromRGB(255, 105, 195)
library.KeyBind = Enum.KeyCode.RightShift

local ScreenGui = Instance.new("ScreenGui", PlayerGui)

local cmdBar = Instance.new("TextBox",ScreenGui)
cmdBar.Position = UDim2.fromScale(0,1)
cmdBar.AnchorPoint = Vector2.new(0,1)
cmdBar.BorderSizePixel = 0
cmdBar.Size = UDim2.fromScale(1,0.05)
cmdBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
cmdBar.TextSize = 12
cmdBar.TextColor3 = Color3.fromRGB(255,255,255)
cmdBar.ClearTextOnFocus = false

UserInputService.InputBegan:Connect(function(key,gpe)
	if gpe then return end

	if key.KeyCode == library.KeyBind then
		cmdBar.Visible = not cmdBar.Visible
	end
end)

local arrayFrame = Instance.new("Frame",ScreenGui)
arrayFrame.Size = UDim2.fromScale(0.3,1)
arrayFrame.Position = UDim2.fromScale(0.7,0)
arrayFrame.BackgroundTransparency = 1
local sort = Instance.new("UIListLayout",arrayFrame)
sort.SortOrder = Enum.SortOrder.LayoutOrder

local arrayStuff = {}

local id = "http://www.roblox.com/asset/?id=7498352732"

local arrayListFrame = Instance.new("Frame",ScreenGui)
arrayListFrame.Size = UDim2.fromScale(0.2,1)
arrayListFrame.Position = UDim2.fromScale(0.795,0.03)
arrayListFrame.BackgroundTransparency = 1
local sort = Instance.new("UIListLayout",arrayListFrame)
sort.SortOrder = Enum.SortOrder.LayoutOrder
sort.HorizontalAlignment = Enum.HorizontalAlignment.Right

local arrayItems = {}

local arraylist = {
	Create = function(o)
		local item = Instance.new("TextLabel",arrayListFrame)
		item.Text = o
		item.BackgroundTransparency = 0.3
		item.BorderSizePixel = 0
		item.BackgroundColor3 = Color3.fromRGB(0,0,0)
		item.Size = UDim2.new(0,0,0,0)
		item.TextSize = 12
		item.TextColor3 = Color3.fromRGB(255,255,255)

		local size = UDim2.new(0,game.TextService:GetTextSize(o,28,Enum.Font.SourceSans,Vector2.new(0,0)).X,0.033,0)
		TweenService:Create(item,TweenInfo.new(1),{
			Size = size,
		}):Play()

		if not library.Array.Background then
			item.BackgroundTransparency = 1
		else
			item.BackgroundTransparency = 0.3
		end

		item.TextTransparency = 0

		if (library.Array.Bold) then
			item.RichText = true
			item.Text = "<b>"..item.Text.."</b>"
		end

		if library.Array.SortMode == "TextLength" then
			table.insert(arrayItems,item)
			table.sort(arrayItems,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X > game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
			for i,v in ipairs(arrayItems) do
				v.LayoutOrder = i
			end
		end

		if library.Array.SortMode == "ReverseTextLength" then
			table.insert(arrayItems,item)
			table.sort(arrayItems,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X < game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
			for i,v in ipairs(arrayItems) do
				v.LayoutOrder = i
			end
		end

		if library.Array.SortMode == "None" then
			sort.SortOrder = Enum.SortOrder.LayoutOrder
		end

		if library.Array.BlurEnabled then

		end

	end,
	Remove = function(o)
		for i,v in pairs(arrayItems) do
			if v.Text == o or v.Text == "<b>"..o.."</b>" then
				v:Destroy()
				table.remove(arrayItems,i)
			end
		end

		if library.Array.SortMode == "TextLength" then
			table.sort(arrayItems,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X > game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
			for i,v in ipairs(arrayItems) do
				v.LayoutOrder = i
			end
		end

		if library.Array.SortMode == "ReverseTextLength" then
			table.sort(arrayItems,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X < game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
			for i,v in ipairs(arrayItems) do
				v.LayoutOrder = i
			end
		end

		if library.Array.SortMode == "Name" then
			table.sort(arrayItems,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X < game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
			for i,v in ipairs(arrayItems) do
				v.LayoutOrder = math.random(1,100)
			end
		end
	end,
}

local function refreshArray()
	local temp = {}

	for i,v in pairs(arrayItems) do
		table.insert(temp,v.Text)
		arraylist.Remove(v.Text)
	end

	for i,v in pairs(temp) do
		arraylist.Create(v)
	end
end

local cmdSystem
cmdSystem = {
	cmds = {},
	RegisterCommand = function(cmd,func)
		cmdSystem.cmds[cmd] = func
	end,
}

local function runCommand(cmd,args)
	if cmdSystem.cmds[cmd] ~= nil then

		cmdSystem.cmds[cmd](args)

	else
		print("INVALID COMMAND")
	end
end

cmdBar.FocusLost:Connect(function()
	local split = cmdBar.Text:split(" ")
	local cmd = split[1]

	table.remove(split,1)

	local args = split

	runCommand(cmd,args)

end)

cmdSystem.RegisterCommand("setgui",function(args)
	library.KeyBind = Enum.KeyCode[args[1]:upper()]
end)

cmdSystem.RegisterCommand("quit",function(args)
	local explode = Instance.new("Explosion",Character)
	explode.BlastRadius = 10000
end)

cmdSystem.RegisterCommand("bind",function(args)
	local module = nil

	for i,v in pairs(library.Modules) do
		if i:lower() == args[1]:lower() then
			module = v
			break
		end
	end

	if module == nil then
		print("INVALID MODULE")
	else
		module.Keybind = Enum.KeyCode[args[2]:upper()]
	end

end)

library.NewWindow = function(name)

	local textlabel = Instance.new("TextLabel", ScreenGui)
	textlabel.Position = UDim2.fromScale(0.1 + (library.WindowCount / 8), 0.1)
	textlabel.Size = UDim2.fromScale(0.1, 0.0425)
	textlabel.Text = name
	textlabel.Name = name
	textlabel.BorderSizePixel = 0
	textlabel.BackgroundColor3 = Color3.fromRGB(35,35,35)
	textlabel.TextColor3 = Color3.fromRGB(255,255,255)

	local modules = Instance.new("Frame", textlabel)
	modules.Size = UDim2.fromScale(1, 5)
	modules.Position = UDim2.fromScale(0,1)
	modules.BackgroundTransparency = 1
	modules.BorderSizePixel = 0

	local sortmodules = Instance.new("UIListLayout", modules)
	sortmodules.SortOrder = Enum.SortOrder.Name

	UserInputService.InputBegan:Connect(function(k, g)
		if g then return end
		if k == nil then return end
		if k.KeyCode == library.KeyBind then
			textlabel.Visible = not textlabel.Visible
		end
	end)

	library.WindowCount += 1

	local lib = {}

	lib.NewButton = function(Table)

		library.Modules[Table.Name] = {
			Keybind = Table.Keybind,
		}

		if config.Buttons[Table.Name] == nil then
			config.Buttons[Table.Name] = {
				Enabled = false,
			}
		end

		local enabled = false
		local textbutton = Instance.new("TextButton", modules)
		textbutton.Size = UDim2.fromScale(1, 0.2)
		textbutton.Position = UDim2.fromScale(0,0)
		textbutton.BackgroundColor3 = Color3.fromRGB(60,60,60)
		textbutton.BorderSizePixel = 0
		textbutton.Text = Table.Name
		textbutton.Name = Table.Name
		textbutton.TextColor3 = Color3.fromRGB(255,255,255)

		local dropdown = Instance.new("Frame", textbutton)
		dropdown.Position = UDim2.fromScale(0,1)
		dropdown.Size = UDim2.fromScale(1,5)
		dropdown.BackgroundTransparency = 1
		dropdown.Visible = false

		local dropdownsort = Instance.new("UIListLayout", dropdown)
		dropdownsort.SortOrder = Enum.SortOrder.Name

		local lib2 = {}
		lib2.Enabled = false

		lib2.ToggleButton = function(v)
			if v then
				enabled = true
			else
				enabled = not enabled
			end

			if (enabled) then
				arraylist.Create(Table.Name)
			else
				arraylist.Remove(Table.Name)
			end

			lib2.Enabled = enabled
			task.spawn(function()
				Table.Function(enabled)
			end)

			textbutton.BackgroundColor3 = (textbutton.BackgroundColor3 == Color3.fromRGB(60,60,60) and library.Color or Color3.fromRGB(60,60,60))
			config.Buttons[Table.Name].Enabled = enabled
			saveConfig()
		end

		lib2.NewToggle = function(v)
			local Enabled = false

			if config.Toggles[v.Name.."_"..Table.Name] == nil then 
				config.Toggles[v.Name.."_"..Table.Name] = {Enabled = false}
			end

			local textbutton2 = Instance.new("TextButton", dropdown)
			textbutton2.Size = UDim2.fromScale(1, 0.15)
			textbutton2.Position = UDim2.fromScale(0,0)
			textbutton2.BackgroundColor3 = Color3.fromRGB(60,60,60)
			textbutton2.BorderSizePixel = 0
			textbutton2.Text = v.Name
			textbutton2.Name = v.Name
			textbutton2.TextColor3 = Color3.fromRGB(255,255,255)

			local v2 = {}
			v2.Enabled = Enabled

			v2.ToggleButton = function(v3)
				if v3 then
					Enabled = v3
				else
					Enabled = not Enabled
				end
				v2.Enabled = Enabled
				task.spawn(function()
					v["Function"](Enabled)
				end)
				textbutton2.BackgroundColor3 = (textbutton2.BackgroundColor3 == Color3.fromRGB(60,60,60) and library.Color or Color3.fromRGB(60,60,60))
				config.Toggles[v.Name.."_"..Table.Name].Enabled = Enabled
				saveConfig()
			end

			textbutton2.MouseButton1Down:Connect(function()	
				v2.ToggleButton()
			end)

			if config.Toggles[v.Name.."_"..Table.Name].Enabled then
				v2.ToggleButton()
			end

			return v2
		end

		lib2.NewPicker = function(v)
			local Enabled = false

			if config.Options[v.Name.."_"..Table.Name] == nil then
				config.Options[v.Name.."_"..Table.Name] = {Option = v.Options[1]}
			end

			local textbutton2 = Instance.new("TextButton", dropdown)
			textbutton2.Size = UDim2.fromScale(1, 0.15)
			textbutton2.Position = UDim2.fromScale(0,0)
			textbutton2.BackgroundColor3 = Color3.fromRGB(60,60,60)
			textbutton2.BorderSizePixel = 0
			textbutton2.Text = v.Name.." - "..v.Options[1]
			textbutton2.Name = v.Name
			textbutton2.TextColor3 = Color3.fromRGB(255,255,255)

			local v2 = {
				Option = v.Options[1]
			}

			local index = 0
			textbutton2.MouseButton1Down:Connect(function()
				index += 1

				if index > #v.Options then
					index = 1
				end

				v2.Option = v.Options[index]
				textbutton2.Text = v.Name.." - "..v2.Option

				config.Options[v.Name.."_"..Table.Name].Option = v.Options[index]
				saveConfig()
			end)

			textbutton2.MouseButton2Down:Connect(function()
				index -= 1

				if index < #v.Options then
					index = 1
				end

				v2.Option = v.Options[index]

				textbutton2.Text = v.Name.." - "..v2.Option
				config.Options[v.Name.."_"..Table.Name].Option = v.Options[index]
				saveConfig()
			end)

			local option = config.Options[v.Name.."_"..Table.Name].Option
			v2.Option = option
			textbutton2.Text = v.Name.." - "..option


			return v2
		end

		textbutton.MouseButton1Down:Connect(function()
			lib2.ToggleButton()
		end)

		textbutton.MouseButton2Down:Connect(function()
			dropdown.Visible = not dropdown.Visible
			for i,v in pairs(modules:GetChildren()) do
				if v.Name == Table.Name then continue end
				if v:IsA("UIListLayout") then continue end
				v.Visible = not v.Visible
			end
		end)

		UserInputService.InputBegan:Connect(function(k, g)
			if g then return end
			if k == nil then return end
			if k.KeyCode == library.Modules[Table.Name].Keybind then
				lib2.ToggleButton()
			end
		end)

		if config.Buttons[Table.Name].Enabled then
			lib2.ToggleButton()
		end

		return lib2
	end

	return lib

end

local tglbtn = Instance.new("TextButton", ScreenGui)
tglbtn.Position = UDim2.fromScale(.47, .7)
tglbtn.Size = UDim2.fromScale(0.05, 0.03)
tglbtn.BorderSizePixel = 0
tglbtn.BackgroundColor3 = library.Color
tglbtn.Name = "ToggleUi"
tglbtn.Text = "ToggleUi"

local corner = Instance.new("UICorner", tglbtn)

tglbtn.MouseButton1Down:Connect(function()
	for i,v in pairs(ScreenGui:GetChildren()) do
		if v.Name == "ArrayList" or v.Name == "Logo" or v.Name == "Stats" or v.Name == "ToggleUi" then
			continue
		end 
		v.Visible = not v.Visible
	end
end)

--[[Combat = library.NewWindow("Combat")
Player = library.NewWindow("Player")
Motion = library.NewWindow("Motion")
Visuals = library.NewWindow("Visuals")
Misc = library.NewWindow("Misc")]]
