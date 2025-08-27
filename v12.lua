--====================================================--
-- 🌟 ANGAMING IOROID HUB V12
-- Full script GUI cho Blox Fruits
--====================================================--

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ANGAMING_IOROID_HUB_V12"
ScreenGui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Text = "⚡ ANGAMING IOROID HUB V12"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

-- Close Button (nút X thoát menu)
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Parent = MainFrame
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Toggle Button (nút ☰ mở/đóng menu)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.Text = "☰"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = ScreenGui

local GuiVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    GuiVisible = not GuiVisible
    MainFrame.Visible = GuiVisible
end)

-- Toggle menu bằng phím RightShift
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Tabs
local Tabs = {"🔥 Auto Farm", "🐉 Boss/Raid", "🏝️ Teleport", "⚔️ Combat/PvP", "👤 Player/Misc", "👀 ESP"}
local TabButtons = {}
local TabFrames = {}

for i, name in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Text = name
    TabButton.Size = UDim2.new(0, 120, 0, 30)
    TabButton.Position = UDim2.new(0, 10, 0, 40 + (i-1)*35)
    TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Parent = MainFrame
    TabButtons[i] = TabButton

    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(0.7, 0, 0.7, 0)
    TabFrame.Position = UDim2.new(0.28, 0, 0.2, 0)
    TabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabFrame.Visible = false
    TabFrame.Parent = MainFrame
    TabFrames[i] = TabFrame

    TabButton.MouseButton1Click:Connect(function()
        for j, frame in ipairs(TabFrames) do
            frame.Visible = (j == i)
        end
    end)
end

---------------------------------------------------------
-- 🔥 AUTO FARM TAB
---------------------------------------------------------
local farmLabel = Instance.new("TextLabel")
farmLabel.Text = "⚡ Auto Farm Features:"
farmLabel.Size = UDim2.new(1, 0, 0, 25)
farmLabel.TextColor3 = Color3.fromRGB(255,255,0)
farmLabel.BackgroundTransparency = 1
farmLabel.Parent = TabFrames[1]

-- Example toggle
local farmButton = Instance.new("TextButton")
farmButton.Text = "Auto Farm Level (ON/OFF)"
farmButton.Size = UDim2.new(0, 200, 0, 30)
farmButton.Position = UDim2.new(0, 10, 0, 40)
farmButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.Parent = TabFrames[1]

---------------------------------------------------------
-- 🐉 BOSS/RAID TAB
---------------------------------------------------------
local bossLabel = Instance.new("TextLabel")
bossLabel.Text = "🐉 Boss & Raid Features:"
bossLabel.Size = UDim2.new(1, 0, 0, 25)
bossLabel.TextColor3 = Color3.fromRGB(0,255,255)
bossLabel.BackgroundTransparency = 1
bossLabel.Parent = TabFrames[2]

---------------------------------------------------------
-- 🏝️ TELEPORT TAB
---------------------------------------------------------
local tpLabel = Instance.new("TextLabel")
tpLabel.Text = "🏝️ Teleport Options"
tpLabel.Size = UDim2.new(1, 0, 0, 25)
tpLabel.TextColor3 = Color3.fromRGB(0,255,0)
tpLabel.BackgroundTransparency = 1
tpLabel.Parent = TabFrames[3]

---------------------------------------------------------
-- ⚔️ COMBAT / PVP TAB
---------------------------------------------------------
local combatLabel = Instance.new("TextLabel")
combatLabel.Text = "⚔️ PvP / Combat Options"
combatLabel.Size = UDim2.new(1, 0, 0, 25)
combatLabel.TextColor3 = Color3.fromRGB(255,0,0)
combatLabel.BackgroundTransparency = 1
combatLabel.Parent = TabFrames[4]

---------------------------------------------------------
-- 👤 PLAYER / MISC TAB
---------------------------------------------------------
local miscLabel = Instance.new("TextLabel")
miscLabel.Text = "👤 Player & Misc Options"
miscLabel.Size = UDim2.new(1, 0, 0, 25)
miscLabel.TextColor3 = Color3.fromRGB(255,255,255)
miscLabel.BackgroundTransparency = 1
miscLabel.Parent = TabFrames[5]

---------------------------------------------------------
-- 👀 ESP TAB
---------------------------------------------------------
local espLabel = Instance.new("TextLabel")
espLabel.Text = "👀 ESP / Visual Options"
espLabel.Size = UDim2.new(1, 0, 0, 25)
espLabel.TextColor3 = Color3.fromRGB(255,100,255)
espLabel.BackgroundTransparency = 1
espLabel.Parent = TabFrames[6]

print("✅ ANGAMING IOROID HUB V12 Loaded Successfully!")
