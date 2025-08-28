--========================================================
-- ANGAMING HUB (FULL VERSION)
--========================================================
repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "ANGAMING HUB | Blox Fruits",
   LoadingTitle = "ANGAMING HUB",
   LoadingSubtitle = "By ANGAMING",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AngamingHub",
      FileName = "Config"
   },
   Discord = {
      Enabled = true,
      Invite = "discord.gg/angaminghub",
      RememberJoins = true
   },
   KeySystem = false
})

--========================================================
-- 📌 AUTO FARM TAB
--========================================================
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)

FarmTab:CreateToggle({Name="Auto Farm Level", Flag="AutoFarmLevel", CurrentValue=false, Callback=function(v) _G.AutoFarmLevel=v end})
FarmTab:CreateToggle({Name="Fast Attack", Flag="FastAttack", CurrentValue=false, Callback=function(v) _G.FastAttack=v end})
FarmTab:CreateToggle({Name="Fly On Top Mobs", Flag="FlyOnTop", CurrentValue=false, Callback=function(v) _G.FlyOnTop=v end})
FarmTab:CreateToggle({Name="Auto Farm Boss", Flag="AutoFarmBoss", CurrentValue=false, Callback=function(v) _G.AutoFarmBoss=v end})
FarmTab:CreateToggle({Name="Auto Farm Chest", Flag="AutoFarmChest", CurrentValue=false, Callback=function(v) _G.AutoFarmChest=v end})
FarmTab:CreateToggle({Name="Auto Farm Mastery", Flag="AutoFarmMastery", CurrentValue=false, Callback=function(v) _G.AutoFarmMastery=v end})
FarmTab:CreateToggle({Name="Farm Sea Beast", Flag="AutoSeaBeast", CurrentValue=false, Callback=function(v) _G.AutoSeaBeast=v end})
FarmTab:CreateToggle({Name="Farm Elite Hunter", Flag="AutoElite", CurrentValue=false, Callback=function(v) _G.AutoElite=v end})
FarmTab:CreateToggle({Name="Farm Cake Prince", Flag="AutoCakePrince", CurrentValue=false, Callback=function(v) _G.AutoCakePrince=v end})

--========================================================
-- 📌 RAID TAB
--========================================================
local RaidTab = Window:CreateTab("Raids", 4483362458)

RaidTab:CreateToggle({Name="Auto Raid Fruit", Flag="AutoRaid", CurrentValue=false, Callback=function(v) _G.AutoRaid=v end})
RaidTab:CreateToggle({Name="Auto Awaken Skill", Flag="AutoAwaken", CurrentValue=false, Callback=function(v) _G.AutoAwaken=v end})
RaidTab:CreateToggle({Name="Auto Next Island", Flag="AutoNextIsland", CurrentValue=false, Callback=function(v) _G.AutoNextIsland=v end})

--========================================================
-- 📌 DEVIL FRUITS TAB
--========================================================
local FruitTab = Window:CreateTab("Devil Fruits", 4483362458)

FruitTab:CreateToggle({Name="Fruit Sniper", Flag="FruitSniper", CurrentValue=false, Callback=function(v) _G.FruitSniper=v end})
FruitTab:CreateToggle({Name="Auto Store Fruit", Flag="AutoStoreFruit", CurrentValue=false, Callback=function(v) _G.AutoStoreFruit=v end})
FruitTab:CreateToggle({Name="Auto Grab Fruit", Flag="AutoGrabFruit", CurrentValue=false, Callback=function(v) _G.AutoGrabFruit=v end})
FruitTab:CreateToggle({Name="Auto Random Fruit", Flag="AutoRandomFruit", CurrentValue=false, Callback=function(v) _G.AutoRandomFruit=v end})
FruitTab:CreateToggle({Name="Auto Summer Fruit", Flag="AutoSummerFruit", CurrentValue=false, Callback=function(v) _G.AutoSummerFruit=v end})

--========================================================
-- 📌 PLAYER TAB
--========================================================
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateToggle({Name="ESP Player", Flag="ESPPlayer", CurrentValue=false, Callback=function(v) _G.ESPPlayer=v end})
PlayerTab:CreateToggle({Name="ESP Fruit", Flag="ESPFruit", CurrentValue=false, Callback=function(v) _G.ESPFruit=v end})
PlayerTab:CreateToggle({Name="ESP Chest", Flag="ESPChest", CurrentValue=false, Callback=function(v) _G.ESPChest=v end})
PlayerTab:CreateToggle({Name="ESP Flower", Flag="ESPFlower", CurrentValue=false, Callback=function(v) _G.ESPFlower=v end})
PlayerTab:CreateToggle({Name="Kill Player (PvP)", Flag="KillPlayer", CurrentValue=false, Callback=function(v) _G.KillPlayer=v end})
PlayerTab:CreateToggle({Name="Aimbot Skill", Flag="AimbotSkill", CurrentValue=false, Callback=function(v) _G.AimbotSkill=v end})

--========================================================
-- 📌 MISC TAB
--========================================================
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateToggle({Name="Auto Haki", Flag="AutoHaki", CurrentValue=false, Callback=function(v) _G.AutoHaki=v end})
MiscTab:CreateToggle({Name="Auto Cursed Dual Katana", Flag="AutoCDK", CurrentValue=false, Callback=function(v) _G.AutoCDK=v end})
MiscTab:CreateToggle({Name="Auto Race V4", Flag="AutoRaceV4", CurrentValue=false, Callback=function(v) _G.AutoRaceV4=v end})
MiscTab:CreateToggle({Name="Auto Soul Guitar", Flag="AutoSoulGuitar", CurrentValue=false, Callback=function(v) _G.AutoSoulG=v end})
MiscTab:CreateToggle({Name="Auto Shark Anchor", Flag="AutoSharkAnchor", CurrentValue=false, Callback=function(v) _G.AutoShark=v end})
MiscTab:CreateToggle({Name="FPS Boost", Flag="FPSBoost", CurrentValue=false, Callback=function(v) _G.FPSBoost=v end})
MiscTab:CreateToggle({Name="White Screen", Flag="WhiteScreen", CurrentValue=false, Callback=function(v) _G.WhiteScreen=v end})

--========================================================
-- 📌 SHOP TAB
--========================================================
local ShopTab = Window:CreateTab("Shop", 4483362458)

ShopTab:CreateToggle({Name="Auto Buy Haki", Flag="AutoBuyHaki", CurrentValue=false, Callback=function(v) _G.AutoBuyHaki=v end})
ShopTab:CreateToggle({Name="Auto Buy Sword", Flag="AutoBuySword", CurrentValue=false, Callback=function(v) _G.AutoBuySword=v end})
ShopTab:CreateToggle({Name="Auto Buy Accessory", Flag="AutoBuyAcc", CurrentValue=false, Callback=function(v) _G.AutoBuyAcc=v end})
ShopTab:CreateToggle({Name="Auto Buy Fruit", Flag="AutoBuyFruit", CurrentValue=false, Callback=function(v) _G.AutoBuyFruit=v end})

--========================================================
-- 📌 EVENT TAB
--========================================================
local EventTab = Window:CreateTab("Event", 4483362458)

EventTab:CreateToggle({Name="Auto Farm Fishing Event", Flag="AutoFishingEvent", CurrentValue=false, Callback=function(v) _G.AutoFishingEvent=v end})
EventTab:CreateToggle({Name="Auto Farm Lightning Event", Flag="AutoLightningEvent", CurrentValue=false, Callback=function(v) _G.AutoLightningEvent=v end})

--========================================================
-- 📌 CODES TAB
--========================================================
local CodesTab = Window:CreateTab("Codes", 4483362458)

CodesTab:CreateButton({
   Name = "Redeem All Codes",
   Callback = function()
       local Codes = {
           "Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK","Starcodeheo","Bluxxy",
           "fudd10_v2","Sub2OfficialNoobie","TheGreatAce","Sub2Daigrock","Axiore",
           "TantaiGaming","StrawHatMaine","Sub2UncleKizaru","Bignews",
           "SUB2GAMERROBOT_EXP1","kittgaming","Sub2CaptainMaui","CHANDLER",
           "SECRET_ADMIN","ADMIN_TROLL"
       }
       for _,v in pairs(Codes) do
           pcall(function()
               game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v)
           end)
       end
       Rayfield:Notify({Title="Redeem Codes", Content="Đã nhập toàn bộ code thành công!", Duration=6.5, Image=4483362458})
   end
})
