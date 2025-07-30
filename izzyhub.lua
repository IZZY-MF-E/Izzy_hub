--[[ 
IZZY HUB ULTIMATE 🌌
Features: Full GUI, Fly, Noclip, Auto Farm, Teleports, ESP, Infinity Yield, etc.
Supports any game with leaderstats.
]]--

local plr = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- GUI MAIN
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "IzzyHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,400,0,350)
frame.Position = UDim2.new(0.3,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.Text = "IZZY HUB - GOD MODE"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- Close
local close = Instance.new("TextButton", title)
close.Size = UDim2.new(0,30,1,0)
close.Position = UDim2.new(1,-30,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Minimize
local mini = Instance.new("TextButton", title)
mini.Size = UDim2.new(0,30,1,0)
mini.Position = UDim2.new(1,-60,0,0)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(255,170,0)
mini.TextColor3 = Color3.new(1,1,1)
local min = false
mini.MouseButton1Click:Connect(function()
    min = not min
    if min then
        frame.Size = UDim2.new(0,400,0,30)
    else
        frame.Size = UDim2.new(0,400,0,350)
    end
end)

-- Dragging
local dragging, dragInput, dragStart, startPos
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- BUTTON MAKER
local function makeBtn(txt,y,callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1,-20,0,30)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(0,120,255)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.MouseButton1Click:Connect(callback)
end

-- Auto Farm
local autoFarm = false
makeBtn("🌱 Toggle Auto Farm", 40, function() autoFarm = not autoFarm end)

-- Fly
local flying = false
makeBtn("🪽 Toggle Fly", 80, function()
    flying = not flying
    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
    if flying and hrp then
        local gyro = Instance.new("BodyGyro", hrp)
        local vel = Instance.new("BodyVelocity", hrp)
        gyro.P = 9e4
        gyro.maxTorque = Vector3.new(9e9,9e9,9e9)
        vel.maxForce = Vector3.new(9e9,9e9,9e9)
        RS.Stepped:Connect(function()
            if flying then
                gyro.CFrame = workspace.CurrentCamera.CFrame
                vel.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
            else
                gyro:Destroy()
                vel:Destroy()
            end
        end)
    end
end)

-- Noclip
local noclip = false
makeBtn("🚪 Toggle Noclip", 120, function()
    noclip = not noclip
    RS.Stepped:Connect(function()
        if noclip and plr.Character then
            for _,v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

-- Speed Boost
makeBtn("⚡ Toggle Speed Boost", 160, function()
    plr.Character.Humanoid.WalkSpeed = 
        (plr.Character.Humanoid.WalkSpeed == 16) and 60 or 16
end)

-- Jump Boost
makeBtn("🌀 Toggle Jump Boost", 200, function()
    plr.Character.Humanoid.JumpPower = 
        (plr.Character.Humanoid.JumpPower == 50) and 150 or 50
end)

-- Swim Everywhere
makeBtn("🌊 Toggle Swim Everywhere", 240, function()
    plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
end)

-- Dance
makeBtn("💃 Start Dancing", 280, function()
    plr.Character.Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId="rbxassetid://3189773368"})):Play()
end)

-- Teleport
makeBtn("🏡 Teleport to Garden", 320, function()
    if workspace:FindFirstChild("GardenSpawn") then
        plr.Character:MoveTo(workspace.GardenSpawn.Position)
    end
end)

-- ESP Players
makeBtn("👀 Toggle Player ESP", 360, function()
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            local highlight = Instance.new("Highlight", p.Character)
            highlight.FillColor = Color3.new(1,0,0)
            highlight.OutlineColor = Color3.new(1,1,1)
        end
    end
end)

-- AUTO FARM LOOP
spawn(function()
    while true do
        if autoFarm then
            local stats = plr:FindFirstChild("leaderstats")
            if stats and stats:FindFirstChild("Coins") then
                stats.Coins.Value = stats.Coins.Value + 500
            end
        end
        wait(2)
    end
end)

-- ANTI AFK
for _,v in pairs(getconnections(plr.Idled)) do
    v:Disable()
end

-- INFINITY YIELD
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
