-- Retail Tycoon 2 GUI Script
-- Full code example for Delta Executor / Mobile Exploits

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = library.CreateLib("Retail Tycoon 2 | Izzy Hub", "Ocean")

-- Main Tab
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Auto Farm")

Section:NewToggle("Auto Collect Money", "Automatically collects store earnings", function(state)
    if state then
        _G.CollectMoney = true
        while _G.CollectMoney do
            local args = {
                [1] = workspace.CollectMoney -- replace with proper path
            }
            game:GetService("ReplicatedStorage").CollectMoney:FireServer(unpack(args))
            wait(2)
        end
    else
        _G.CollectMoney = false
    end
end)

Section:NewToggle("Auto Restock", "Restock shelves automatically", function(state)
    if state then
        _G.AutoRestock = true
        while _G.AutoRestock do
            -- Replace with actual restock function
            print("Restocking shelves...")
            wait(2)
        end
    else
        _G.AutoRestock = false
    end
end)

-- Teleport Tab
local TeleportTab = Window:NewTab("Teleport")
local TPSection = TeleportTab:NewSection("Locations")

TPSection:NewButton("Teleport to Store", "Teleports you to your store", function()
    local player = game.Players.LocalPlayer
    if workspace:FindFirstChild("StoreSpawn") then
        player.Character.HumanoidRootPart.CFrame = workspace.StoreSpawn.CFrame
    end
end)

TPSection:NewButton("Teleport to Warehouse", "Teleports you to warehouse", function()
    local player = game.Players.LocalPlayer
    if workspace:FindFirstChild("Warehouse") then
        player.Character.HumanoidRootPart.CFrame = workspace.Warehouse.CFrame
    end
end)

-- Player Tab
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Player Mods")

PlayerSection:NewSlider("WalkSpeed", "Change speed", 200, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

PlayerSection:NewSlider("JumpPower", "Change jump power", 300, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

PlayerSection:NewButton("Fly", "Toggle fly mode", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/YSL3xKYU"))()
end)

-- Credits Tab
local Credits = Window:NewTab("Credits")
local CredSection = Credits:NewSection("Script by ripoffuser | Modified for Izzy Hub")

CredSection:NewButton("Join Discord", "Opens discord invite", function()
    setclipboard("https://discord.gg/example")
end)
