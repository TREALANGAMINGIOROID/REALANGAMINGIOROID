--=====================================================
-- 🌌 ANGAMING IOROID HUB - Full Rayfield UI
--=====================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- ⚙️ Config
getgenv().WalkSpeed = 16
getgenv().JumpPower = 50

-- 🌈 Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "🌌 ANGAMING IOROID HUB 🌌",
    LoadingTitle = "ANGAMING IOROID",
    LoadingSubtitle = "Powered by Rayfield",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "ANGAMING_IOROID",
       FileName = "Config"
    }
})
-------------------------------------------------
-- 🌾 Auto Farm Section
-------------------------------------------------
getgenv().AutoFarmLevel = false
getgenv().AutoQuest = false
getgenv().AutoFarmMastery = false
getgenv().AutoFarmChest = false
getgenv().AutoFarmEventItem = false
getgenv().AutoFarmBoss = false
getgenv().AutoFarmSeaBeast = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Hàm teleport
function toTarget(pos)
    local Char = LocalPlayer.Character
    if Char and Char:FindFirstChild("HumanoidRootPart") then
        local HRP = Char.HumanoidRootPart
        TweenService:Create(HRP, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = pos}):Play()
    end
end

-- Hàm đánh mob
function attackMob(mob)
    if mob and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
        toTarget(mob.HumanoidRootPart.CFrame * CFrame.new(0,10,0)) -- đứng trên đầu
        game:GetService("VirtualUser"):ClickButton1(Vector2.new())
    end
end

-- Auto Farm Level
spawn(function()
    while task.wait(0.3) do
        if getgenv().AutoFarmLevel then
            for _,mob in pairs(workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    attackMob(mob)
                end
            end
        end
    end
end)

-- Auto Quest (giả lập nhận quest)
spawn(function()
    while task.wait(1) do
        if getgenv().AutoQuest then
            for _,npc in pairs(workspace.NPCs:GetChildren()) do
                if npc.Name:match("Quest") and npc:FindFirstChild("HumanoidRootPart") then
                    toTarget(npc.HumanoidRootPart.CFrame)
                    fireproximityprompt(npc.ProximityPrompt)
                    break
                end
            end
        end
    end
end)

-- Auto Farm Mastery (ưu tiên dùng skill để farm)
spawn(function()
    while task.wait(0.5) do
        if getgenv().AutoFarmMastery then
            for _,mob in pairs(workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    attackMob(mob)
                    -- dùng skill
                    ReplicatedStorage.Remotes.Combat:FireServer("Skill","Z")
                end
            end
        end
    end
end)

-- Auto Farm Chest (nhặt rương)
spawn(function()
    while task.wait(2) do
        if getgenv().AutoFarmChest then
            for _,chest in pairs(workspace:GetChildren()) do
                if chest.Name:match("Chest") and chest:IsA("Model") and chest:FindFirstChild("HumanoidRootPart") then
                    toTarget(chest.HumanoidRootPart.CFrame)
                    break
                end
            end
        end
    end
end)

-- Auto Farm Boss
spawn(function()
    while task.wait(1) do
        if getgenv().AutoFarmBoss then
            for _,mob in pairs(workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                    if mob.Humanoid.Health > 0 and mob:FindFirstChild("BossTag") then -- giả định boss có BossTag
                        attackMob(mob)
                    end
                end
            end
        end
    end
end)

-- Auto Farm Sea Beast (template, cần API riêng)
spawn(function()
    while task.wait(5) do
        if getgenv().AutoFarmSeaBeast then
            warn("Auto Farm Sea Beast: cần hook vào event spawn của Sea Beast!")
        end
    end
end)

-------------------------------------------------
-- 🌾 UI Toggles
-------------------------------------------------
FarmTab:CreateToggle({Name="Auto Farm Level", CurrentValue=false, Callback=function(v) getgenv().AutoFarmLevel=v end})
FarmTab:CreateToggle({Name="Auto Quest", CurrentValue=false, Callback=function(v) getgenv().AutoQuest=v end})
FarmTab:CreateToggle({Name="Auto Farm Mastery", CurrentValue=false, Callback=function(v) getgenv().AutoFarmMastery=v end})
FarmTab:CreateToggle({Name="Auto Farm Chest", CurrentValue=false, Callback=function(v) getgenv().AutoFarmChest=v end})
FarmTab:CreateToggle({Name="Auto Farm Event Item", CurrentValue=false, Callback=function(v) getgenv().AutoFarmEventItem=v end})
FarmTab:CreateToggle({Name="Auto Farm Boss", CurrentValue=false, Callback=function(v) getgenv().AutoFarmBoss=v end})
FarmTab:CreateToggle({Name="Auto Farm Sea Beast", CurrentValue=false, Callback=function(v) getgenv().AutoFarmSeaBeast=v end})

-------------------------------------------------
-- ⚔️ Combat Section
-------------------------------------------------
getgenv().Aimbot = false
getgenv().SilentAim = false
getgenv().AutoAimSkill = false
getgenv().KillAura = false
getgenv().FastAttack = false
getgenv().ESPPlayer = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- 🔹 Hàm tìm player gần nhất
function getClosestPlayer()
    local closest, dist = nil, math.huge
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local mag = (p.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if mag < dist then
                dist = mag
                closest = p
            end
        end
    end
    return closest
end

-- 🔹 Aimbot (camera xoay theo player gần nhất)
RunService.RenderStepped:Connect(function()
    if getgenv().Aimbot then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- 🔹 Silent Aim (hook raycast đến target)
local old; old = hookmetamethod(game,"__namecall",function(self,...)
    local args = {...}
    if getgenv().SilentAim and getnamecallmethod()=="FireServer" and tostring(self)=="RemoteEvent" then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            args[1] = target.Character.HumanoidRootPart.Position
            return old(self,unpack(args))
        end
    end
    return old(self,...)
end)

-- 🔹 Auto Aim Skill (spam skill)
spawn(function()
    while task.wait(1) do
        if getgenv().AutoAimSkill then
            local target = getClosestPlayer()
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, target.Character.HumanoidRootPart.Position)
                ReplicatedStorage.Remotes.Combat:FireServer("Skill","Z")
                ReplicatedStorage.Remotes.Combat:FireServer("Skill","X")
                ReplicatedStorage.Remotes.Combat:FireServer("Skill","C")
            end
        end
    end
end)

-- 🔹 Kill Aura
spawn(function()
    while task.wait(0.3) do
        if getgenv().KillAura then
            for _,p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (p.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                    if dist < 25 then
                        VirtualUser:ClickButton1(Vector2.new())
                    end
                end
            end
        end
    end
end)

-- 🔹 Fast Attack
spawn(function()
    while task.wait(0.05) do
        if getgenv().FastAttack then
            VirtualUser:ClickButton1(Vector2.new())
        end
    end
end)

-- 🔹 ESP Player
function createESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local billboard = Instance.new("BillboardGui", player.Character.HumanoidRootPart)
        billboard.Name = "ESP"
        billboard.Size = UDim2.new(0,200,0,50)
        billboard.AlwaysOnTop = true

        local text = Instance.new("TextLabel", billboard)
        text.Size = UDim2.new(1,0,1,0)
        text.Text = player.Name
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.new(1,0,0)
        text.TextScaled = true
    end
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if getgenv().ESPPlayer then
            task.wait(1)
            createESP(p)
        end
    end)
end)

spawn(function()
    while task.wait(1) do
        if getgenv().ESPPlayer then
            for _,p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not p.Character.HumanoidRootPart:FindFirstChild("ESP") then
                    createESP(p)
                end
            end
        end
    end
end)

-------------------------------------------------
-- ⚔️ UI Toggles
-------------------------------------------------
CombatTab:CreateToggle({Name="Aimbot", CurrentValue=false, Callback=function(v) getgenv().Aimbot=v end})
CombatTab:CreateToggle({Name="Silent Aim", CurrentValue=false, Callback=function(v) getgenv().SilentAim=v end})
CombatTab:CreateToggle({Name="Auto Aim Skill", CurrentValue=false, Callback=function(v) getgenv().AutoAimSkill=v end})
CombatTab:CreateToggle({Name="Kill Aura", CurrentValue=false, Callback=function(v) getgenv().KillAura=v end})
CombatTab:CreateToggle({Name="Fast Attack", CurrentValue=false, Callback=function(v) getgenv().FastAttack=v end})
CombatTab:CreateToggle({Name="ESP Player", CurrentValue=false, Callback=function(v) getgenv().ESPPlayer=v end})

-------------------------------------------------
-- 🗺️ Teleport Section
-------------------------------------------------
local LocalPlayer = game.Players.LocalPlayer
local HRP = function() return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") end

-- 🔹 Lưu tọa độ
TeleTab:CreateButton({
    Name="Save Position", 
    Callback=function() 
        if HRP() then 
            getgenv().SavePos = HRP().CFrame 
            warn("[Teleport] Saved position!") 
        end 
    end
})

-- 🔹 Quay lại tọa độ đã lưu
TeleTab:CreateButton({
    Name="Load Position", 
    Callback=function() 
        if getgenv().SavePos and HRP() then 
            HRP().CFrame = getgenv().SavePos 
            warn("[Teleport] Loaded position!") 
        end 
    end
})

-- 🔹 Danh sách đảo (ví dụ Sea 1)
local IslandList = {
    ["Starter"] = CFrame.new(1050, 20, 1650),
    ["Jungle"]  = CFrame.new(-1600, 20, 150),
    ["Desert"]  = CFrame.new(1150, 15, 4300),
    ["Sky"]     = CFrame.new(-4900, 715, -2600),
    ["Magma"]   = CFrame.new(-5000, 15, 8000)
}

TeleTab:CreateDropdown({
    Name="Teleport Island", 
    Options={"Starter","Jungle","Desert","Sky","Magma"}, 
    CurrentOption="Starter", 
    Callback=function(v) 
        if HRP() and IslandList[v] then
            HRP().CFrame = IslandList[v]
            warn("[Teleport] Teleported to "..v)
        else
            warn("[Teleport] Island not found")
        end
    end
})

-- 🔹 Teleport tới NPC gần nhất
TeleTab:CreateButton({
    Name="Teleport to NPC", 
    Callback=function()
        local closest,dist = nil,math.huge
        for _,obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and string.find(obj.Name:lower(),"npc") then
                local mag = (obj.HumanoidRootPart.Position - HRP().Position).magnitude
                if mag < dist then
                    dist = mag
                    closest = obj
                end
            end
        end
        if closest and HRP() then
            HRP().CFrame = closest.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
            warn("[Teleport] Teleported to NPC "..closest.Name)
        else
            warn("[Teleport] No NPC found")
        end
    end
})

-- 🔹 Teleport tới Shop gần nhất
TeleTab:CreateButton({
    Name="Teleport to Shop", 
    Callback=function()
        local closest,dist = nil,math.huge
        for _,obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and string.find(obj.Name:lower(),"shop") then
                local mag = (obj.HumanoidRootPart.Position - HRP().Position).magnitude
                if mag < dist then
                    dist = mag
                    closest = obj
                end
            end
        end
        if closest and HRP() then
            HRP().CFrame = closest.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
            warn("[Teleport] Teleported to Shop "..closest.Name)
        else
            warn("[Teleport] No Shop found")
        end
    end
})

-------------------------------------------------
-- 🍏 Devil Fruit Section
-------------------------------------------------
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- 🟢 Fruit Sniper (Auto Buy from Shop)
FruitTab:CreateToggle({
    Name="Fruit Sniper (Auto Buy)",
    CurrentValue=false,
    Callback=function(v)
        getgenv().FruitSniper = v
        task.spawn(function()
            while getgenv().FruitSniper do
                pcall(function()
                    -- Giả sử remote shop là "Shop:BuyFruit"
                    for _,fruit in pairs({"Bomb-Bomb","Light-Light","Flame-Flame","Ice-Ice"}) do
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFruit", fruit)
                    end
                end)
                task.wait(60) -- kiểm tra mỗi phút
            end
        end)
    end
})

-- 🟢 Fruit Finder (Notify when spawn in map)
FruitTab:CreateToggle({
    Name="Fruit Finder (Notify Spawn)",
    CurrentValue=false,
    Callback=function(v)
        getgenv().FruitFinder = v
        task.spawn(function()
            while getgenv().FruitFinder do
                pcall(function()
                    for _,obj in pairs(Workspace:GetChildren()) do
                        if obj:IsA("Tool") and string.find(obj.Name:lower(),"fruit") then
                            game.StarterGui:SetCore("SendNotification",{
                                Title="🍏 Fruit Spawned!",
                                Text=obj.Name.." found in map",
                                Duration=5
                            })
                        end
                    end
                end)
                task.wait(10)
            end
        end)
    end
})

-- 🟢 Auto Store Fruit
FruitTab:CreateToggle({
    Name="Auto Store Fruit",
    CurrentValue=false,
    Callback=function(v)
        getgenv().AutoStoreFruit = v
        task.spawn(function()
            while getgenv().AutoStoreFruit do
                pcall(function()
                    for _,tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if string.find(tool.Name:lower(),"fruit") then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool.Name)
                            warn("[Fruit] Stored "..tool.Name)
                        end
                    end
                end)
                task.wait(5)
            end
        end)
    end
})

-- 🟢 Auto Eat Fruit
FruitTab:CreateToggle({
    Name="Auto Eat Fruit",
    CurrentValue=false,
    Callback=function(v)
        getgenv().AutoEatFruit = v
        task.spawn(function()
            while getgenv().AutoEatFruit do
                pcall(function()
                    for _,tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if string.find(tool.Name:lower(),"fruit") then
                            LocalPlayer.Character.Humanoid:EquipTool(tool)
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("EatFruit", tool.Name)
                            warn("[Fruit] Ate "..tool.Name)
                        end
                    end
                end)
                task.wait(10)
            end
        end)
    end
})

-------------------------------------------------
-- 🛠️ Misc Section
-------------------------------------------------
local LocalPlayer = game.Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- 🔑 Redeem All Codes
MiscTab:CreateButton({
    Name="Redeem All Codes",
    Callback=function()
        local Codes = {
            "EXP_5B","RESET_5B","Sub2Fer999","Enyu_is_Pro",
            "Magicbus","JCWK","Starcodeheo","Bluxxy"
        }
        for _,code in pairs(Codes) do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code)
            end)
        end
        print("[Codes] Redeemed all codes!")
    end
})

-- 🌍 Server Hop
MiscTab:CreateToggle({
    Name="Server Hop",
    CurrentValue=false,
    Callback=function(v)
        getgenv().ServerHop = v
        if v then
            task.spawn(function()
                while getgenv().ServerHop do
                    pcall(function()
                        TeleportService:Teleport(game.PlaceId, LocalPlayer)
                    end)
                    task.wait(10)
                end
            end)
        end
    end
})

-- ⚡ FPS Boost
MiscTab:CreateToggle({
    Name="FPS Boost",
    CurrentValue=false,
    Callback=function(v)
        getgenv().FPSBoost = v
        if v then
            for _,obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    obj.Lifetime = NumberRange.new(0)
                elseif obj:IsA("Explosion") then
                    obj.Visible = false
                elseif obj:IsA("MeshPart") or obj:IsA("BasePart") then
                    obj.Material = Enum.Material.Plastic
                end
            end
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end
    end
})

-- 💤 Anti AFK
MiscTab:CreateToggle({
    Name="Anti AFK",
    CurrentValue=true,
    Callback=function(v)
        getgenv().AntiAFK = v
        if v then
            LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                task.wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

-- 🚪 No Clip
MiscTab:CreateToggle({
    Name="No Clip",
    CurrentValue=false,
    Callback=function(v)
        getgenv().NoClip = v
        RunService.Stepped:Connect(function()
            if getgenv().NoClip and LocalPlayer.Character then
                for _,part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
})

-- 🕊️ Fly
MiscTab:CreateToggle({
    Name="Fly",
    CurrentValue=false,
    Callback=function(v)
        getgenv().Fly = v
        task.spawn(function()
            while getgenv().Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
                local hrp = LocalPlayer.Character.HumanoidRootPart
                hrp.Velocity = Vector3.new(0,50,0) -- bay lên
                task.wait()
            end
        end)
    end
})

-- 🚶 WalkSpeed
MiscTab:CreateSlider({
    Name="WalkSpeed",
    Range={16,200}, Increment=1, Suffix=" WS",
    CurrentValue=16,
    Callback=function(v)
        getgenv().WalkSpeed = v
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
    end
})

-- 🦘 JumpPower
MiscTab:CreateSlider({
    Name="JumpPower",
    Range={50,500}, Increment=5, Suffix=" JP",
    CurrentValue=50,
    Callback=function(v)
        getgenv().JumpPower = v
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = v
        end
    end
})

-- 🛡️ Safe Zone
MiscTab:CreateToggle({
    Name="Safe Zone (PvP OFF)",
    CurrentValue=false,
    Callback=function(v)
        getgenv().SafeZone = v
        if v and LocalPlayer.Character then
            -- Ví dụ dịch chuyển đến đảo khởi đầu
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1100,50,1100)
        end
    end
})

-------------------------------------------------
-- 🎉 Event Section
-------------------------------------------------
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- 🎣 Auto Fishing Event
EventTab:CreateToggle({
    Name="Auto Fishing Event",
    CurrentValue=false,
    Callback=function(v)
        getgenv().AutoFishingEvent = v
        if v then
            task.spawn(function()
                while getgenv().AutoFishingEvent do
                    pcall(function()
                        -- ví dụ: tìm NPC Fishing hoặc vùng FishingEvent
                        for _,npc in pairs(workspace:GetDescendants()) do
                            if npc.Name == "FishingSpot" or npc.Name == "FishingEvent" then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = npc.CFrame + Vector3.new(0,5,0)
                                -- mô phỏng click để câu
                                game:GetService("ReplicatedStorage").Remotes.Fishing:FireServer("Start")
                                task.wait(5)
                                game:GetService("ReplicatedStorage").Remotes.Fishing:FireServer("Stop")
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

-- ⚡ Auto Lightning Event
EventTab:CreateToggle({
    Name="Auto Lightning Event",
    CurrentValue=false,
    Callback=function(v)
        getgenv().AutoLightningEvent = v
        if v then
            task.spawn(function()
                while getgenv().AutoLightningEvent do
                    pcall(function()
                        -- tìm object lightning rơi trong map
                        for _,obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and obj.Name == "LightningStrike" then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0,5,0)
                                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
                            end
                        end
                    end)
                    task.wait(0.5)
                end
            end)
        end
    end
})

-- 🎁 Auto Other Event Item
EventTab:CreateToggle({
    Name="Auto Other Event Item",
    CurrentValue=false,
    Callback=function(v)
        getgenv().AutoOtherEvent = v
        if v then
            task.spawn(function()
                while getgenv().AutoOtherEvent do
                    pcall(function()
                        -- ví dụ: tìm item event rơi trên map
                        for _,drop in pairs(workspace:GetChildren()) do
                            if drop:IsA("Tool") or drop.Name:match("Event") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = drop.Handle.CFrame
                                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, drop.Handle, 0)
                                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, drop.Handle, 1)
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

-------------------------------------------------
-- 🔥 Raid Section
-------------------------------------------------
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Lưu chip được chọn
getgenv().SelectRaidChip = "Flame"

RaidTab:CreateDropdown({
    Name="Select Raid Chip",
    Options={"Flame","Ice","Dark","Light","String"},
    CurrentOption="Flame",
    Callback=function(v)
        getgenv().SelectRaidChip = v
        print("Raid chip selected:", v)
    end
})

-- ⚔️ Auto Raid
RaidTab:CreateToggle({
    Name="Auto Raid",
    CurrentValue=false,
    Callback=function(v)
        getgenv().AutoRaid = v
        if v then
            task.spawn(function()
                while getgenv().AutoRaid do
                    pcall(function()
                        -- Bước 1: Mua chip
                        ReplicatedStorage.Remotes["Raids"]:InvokeServer("Buy", getgenv().SelectRaidChip)
                        task.wait(1)

                        -- Bước 2: Teleport vào Raid Island
                        if workspace:FindFirstChild("RaidIsland") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame =
                                workspace.RaidIsland.CFrame + Vector3.new(0,10,0)
                        end

                        -- Bước 3: Tự động đánh quái trong raid
                        for _,mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                                repeat
                                    LocalPlayer.Character.HumanoidRootPart.CFrame =
                                        mob.HumanoidRootPart.CFrame * CFrame.new(0,5,5)
                                    -- spam attack
                                    ReplicatedStorage.Remotes.Combat:FireServer("NormalAttack")
                                    task.wait(0.2)
                                until not getgenv().AutoRaid or mob.Humanoid.Health <= 0
                            end
                        end
                    end)
                    task.wait(3)
                end
            end)
        end
    end
})

-- 🌌 Auto Awaken Skill
RaidTab:CreateToggle({
    Name="Auto Awaken Skill",
    CurrentValue=false,
    Callback=function(v)
        getgenv().AutoAwakenSkill = v
        if v then
            task.spawn(function()
                while getgenv().AutoAwakenSkill do
                    pcall(function()
                        -- Khi raid xong sẽ có NPC Awaken Skill
                        local npc = workspace:FindFirstChild("AwakenNPC")
                        if npc and (LocalPlayer.Character.HumanoidRootPart.Position - npc.Position).magnitude < 15 then
                            ReplicatedStorage.Remotes["Awakening"]:FireServer("AwakenAll")
                            print("Awakening skills...")
                        end
                    end)
                    task.wait(2)
                end
            end)
        end
    end
})
