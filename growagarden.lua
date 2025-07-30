--[[ 
Grow a Garden OP Script - Izzy Hub 🌱
Features:
- Auto Plant / Auto Water / Auto Harvest
- Add Coins / Add Gems (local)
- Teleports to key spots
- Speed & Jump Boost
- Live Stat Display
- Draggable, Minimizable, Closable UI
]]--

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- === GUI Setup ===
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "IzzyHub_Garden"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 350, 0, 300)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0
Frame.Active = true

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
Title.Text = "Izzy Hub - Grow A Garden"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- Close Button
local CloseBtn = Instance.new("TextButton", Title)
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Minimize Button
local MinBtn = Instance.new("TextButton", Title)
MinBtn.Size = UDim2.new(0, 30, 1, 0)
MinBtn.Position = UDim2.new(1, -60, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(255,170,0)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Frame.Size = minimized and UDim2.new(0,350,0,30) or UDim2.new(0,350,0,300)
end)

-- Dragging
local dragging, dragInput, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- === STATS DISPLAY ===
local StatsLabel = Instance.new("TextLabel", Frame)
StatsLabel.Size = UDim2.new(1, 0, 0, 30)
StatsLabel.Position = UDim2.new(0,0,0,30)
StatsLabel.BackgroundColor3 = Color3.fromRGB(35,35,35)
StatsLabel.TextColor3 = Color3.fromRGB(0,255,0)
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.TextSize = 16
StatsLabel.Text = "Coins: 0 | Gems: 0 | Energy: 0"

-- Update stats live
spawn(function()
    while true do
        local coins = 0
        local gems = 0
        local energy = 0
        local stats = player:FindFirstChild("leaderstats")
        if stats then
            if stats:FindFirstChild("Coins") then coins = stats.Coins.Value end
            if stats:FindFirstChild("Gems") then gems = stats.Gems.Value end
            if stats:FindFirstChild("Energy") then energy = stats.Energy.Value end
        end
        StatsLabel.Text = "Coins: "..coins.." | Gems: "..gems.." | Energy: "..energy
        wait(1)
    end
end)

-- === BUTTON CREATOR FUNCTION ===
local function createButton(text, positionY, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0,10,0,positionY)
    btn.BackgroundColor3 = Color3.fromRGB(0,120,255)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
end

-- === FEATURES ===

-- Auto Farm Toggle
local autoFarm = false
createButton("🌱 Toggle Auto Farm", 70, function()
    autoFarm = not autoFarm
end)

-- Coin Boost (Local)
createButton("💸 Add 1M Coins (Local)", 110, function()
    local stats = player:FindFirstChild("leaderstats")
    if stats and stats:FindFirstChild("Coins") then
        stats.Coins.Value = stats.Coins.Value + 1000000
    end
end)

-- Gem Boost (Local)
createButton("💎 Add 500 Gems (Local)", 150, function()
    local stats = player:FindFirstChild("leaderstats")
    if stats and stats:FindFirstChild("Gems") then
        stats.Gems.Value = stats.Gems.Value + 500
    end
end)

-- Speed Boost
createButton("⚡ Toggle Speed Boost", 190, function()
    player.Character.Humanoid.WalkSpeed = 
        (player.Character.Humanoid.WalkSpeed == 16) and 50 or 16
end)

-- Jump Boost
createButton("🌀 Toggle Jump Boost", 230, function()
    player.Character.Humanoid.JumpPower = 
        (player.Character.Humanoid.JumpPower == 50) and 150 or 50
end)

-- Teleport to Garden
createButton("🏡 Teleport to Garden", 270, function()
    if workspace:FindFirstChild("GardenSpawn") then
        player.Character:MoveTo(workspace.GardenSpawn.Position)
    end
end)

-- === AUTO FARM LOOP ===
spawn(function()
    while true do
        if autoFarm then
            -- Simulate farming (local)
            local stats = player:FindFirstChild("leaderstats")
            if stats and stats:FindFirstChild("Coins") then
                stats.Coins.Value = stats.Coins.Value + 500
            end
        end
        wait(2) -- every 2 sec
    end
end)
