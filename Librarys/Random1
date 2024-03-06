-- please dont ask why the ui code is god awful

repeat task.wait() until game:IsLoaded()

local notifsenabled = true
local lib = {}

function pname(x) return tostring(math.random()) end
function color(clr1, clr2, clr3) return Color3.fromRGB(clr1, clr2, clr3) end

local NovolineReal
NovolineReal = Instance.new("ScreenGui")
NovolineReal.ResetOnSpawn = false
NovolineReal.IgnoreGuiInset = true
NovolineReal.Name = tostring(math.random())
NovolineReal.Parent = game.Players.LocalPlayer.PlayerGui

local tabs = 0

function lib:Notify(desc, timer)
	spawn(function()
		local xd = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
		xd.ResetOnSpawn = false
		xd.IgnoreGuiInset = true
		xd.Name = tostring(math.random())
		local fr = Instance.new("TextLabel", xd)
		fr.Position = UDim2.fromScale(.01, .93)
		fr.Size = UDim2.fromScale(.21, .05)
		fr.BorderSizePixel = 0
		fr.TextColor3 = color(255,255,255)
		fr.BackgroundColor3 = color(60, 60, 60)
		fr.Transparency = .5
		fr.Text = desc
		task.wait(timer)
		for i=1,150 do
			fr.Position -= UDim2.fromScale(.005, 0)
			task.wait(.005)
		end
		fr:Remove()
	end)
end

function MakeTab(name)
	local Label = Instance.new("TextLabel", NovolineReal)
	Label.Name = name
	Label.Position = UDim2.fromScale(0.02 + (tabs * .12), 0.153)
	Label.Size = UDim2.fromScale(.1, .05)
	Label.TextColor3 = color(255,255,255)
	Label.BorderSizePixel = 0
	Label.BackgroundColor3 = color(30, 30, 30)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextSize = 15
	Label.Visible = false
	Label.TextScaled = false
	Label.Text = "  "..name
	Label.Active = true
	Label.Draggable = true
	tabs += 1
	local InvisFrame = Instance.new("Frame", Label)
	InvisFrame.Name = "InvisFrame"
	InvisFrame.Position = UDim2.fromScale(0, 1)
	InvisFrame.Size = UDim2.fromScale(1, 10)
	InvisFrame.Transparency = 1
	local uilayout = Instance.new("UIListLayout", InvisFrame)
	game.UserInputService.InputBegan:Connect(function(key, gpe)
		if gpe then return end
		if key.KeyCode == Enum.KeyCode.Delete then
			Label.Visible = not Label.Visible
			if notifsenabled then
				lib:Notify("Toggled UI!", 2)
			end
		end
	end)
end

local path = NovolineReal
function MakeButton(tab)
	local keyc = tab.Key
	local button = Instance.new("TextButton", path[tab.Tab].InvisFrame)
	button.Name = tab.Name
	button.Size = UDim2.fromScale(1, 0.08)
	button.BorderSizePixel = 0
	button.BackgroundColor3 = color(50, 50, 50)
	button.TextColor3 = color(255,255,255)
	button.Text = tab.Name
	local enabled = false
	local funcs
	funcs = {
		togglebtn = function(v)
			tab.Function(v)
		end,
	}
	button.MouseButton1Down:Connect(function()
		enabled = not enabled
		if enabled then
			button.BackgroundColor3 = color(155, 50, 255)
			funcs.togglebtn(true)
			if notifsenabled then
				lib:Notify("Toggled "..tab.Name.." true!", 5)
			end
		else
			button.BackgroundColor3 = color(50, 50, 50)
			funcs.togglebtn(false)
			if notifsenabled then
				lib:Notify("Toggled "..tab.Name.." false!", 5)
			end
		end
	end)
	game.UserInputService.InputBegan:Connect(function(key, gpe)
		if key.KeyCode == nil then return end
		if key.KeyCode == keyc then
			if enabled then
				button.BackgroundColor3 = color(155, 50, 255)
				funcs.togglebtn(true)
				if notifsenabled then
					lib:Notify("Toggled "..tab.Name.." true!", 5)
				end
			else
				button.BackgroundColor3 = color(50, 50, 50)
				funcs.togglebtn(false)
				if notifsenabled then
					lib:Notify("Toggled "..tab.Name.." false!", 5)
				end
			end
		end
	end)
	return funcs
end

MakeTab("Combat")
MakeTab("Blatant")
MakeTab("Render")
MakeTab("Mechanics")
