--[[ 
IZZY HUB with Floating Toggle + Scroll
Features: All previous hacks + proper hide/show toggle and movable UI
]]--

local plr = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- === MAIN SCREEN GUI ===
local screen = Instance.new("ScreenGui", game.CoreGui)
screen.Name = "IzzyHubUI"

-- === FLOATING TOGGLE BUTTON ===
local toggleBtn = Instance.new("TextButton", screen)
toggleBtn.Size = UDim2.new(0, 60, 0, 30)
toggleBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Text = "Hub"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
toggleBtn.Active = true

-- MAKE TOGGLE MOVABLE
local draggingT, dragInputT, dragStartT, startPosT
toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingT = true
        dragStartT = input.Position
        startPosT = toggleBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingT = false
            end
        end)
    end
end)
toggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInputT = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInputT and draggingT then
        local delta = input.Position - dragStartT
        toggleBtn.Position = UDim2.new(startPosT.X.Scale, startPosT.X.Offset + delta.X,
                                       startPosT.Y.Scale, startPosT.Y.Offset + delta.Y)
    end
end)

-- === MAIN HUB FRAME (SCROLLABLE) ===
local frame = Instance.new("Frame", screen)
frame.Size = UDim2.new(0, 400, 0, 350)
frame.Position = UDim2.new(0.3,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.Text = "IZZY HUB - GOD MODE"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- Close Button
local close = Instance.new("TextButton", title)
close.Size = UDim2.new(0, 30, 1, 0)
close.Position = UDim2.new(1, -30, 0, 0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() screen:Destroy() end)

-- SCROLL FRAME INSIDE
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, -30)
scroll.Position = UDim2.new(0,0,0,30)
scroll.CanvasSize = UDim2.new(0,0,2,0) -- expandable
scroll.ScrollBarThickness = 8
scroll.BackgroundTransparency = 1

-- MAKE MAIN HUB MOVABLE
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

-- TOGGLE FUNCTIONALITY (Show/Hide frame)
local visible = true
toggleBtn.MouseButton1Click:Connect(function()
    visible = not visible
    frame.Visible = visible
end)

-- === BUTTON CREATOR (Inside Scroll) ===
local yOffset = 10
local function addButton(text, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0,10,0,yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(0,120,255)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
    yOffset = yOffset + 40
    scroll.CanvasSize = UDim2.new(0,0,0,yOffset)
end

-- === FEATURES ===
local autoFarm = false
addButton("🌱 Toggle Auto Farm", function() autoFarm = not autoFarm end)

local flying = false
addButton("🪽 Toggle Fly", function()
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

local noclip = false
addButton("🚪 Toggle Noclip", function()
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

addButton("⚡ Toggle Speed Boost", function()
    plr.Character.Humanoid.WalkSpeed = (plr.Character.Humanoid.WalkSpeed == 16) and 60 or 16
end)

addButton("🌀 Toggle Jump Boost", function()
    plr.Character.Humanoid.JumpPower = (plr.Character.Humanoid.JumpPower == 50) and 150 or 50
end)

addButton("🌊 Toggle Swim Everywhere", function()
    plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
end)

addButton("💃 Start Dancing", function()
    plr.Character.Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId="rbxassetid://3189773368"})):Play()
end)

addButton("🏡 Teleport to Garden", function()
    if workspace:FindFirstChild("GardenSpawn") then
        plr.Character:MoveTo(workspace.GardenSpawn.Position)
    end
end)

addButton("👀 Toggle Player ESP", function()
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

-- ANTI-AFK
for _,v in pairs(getconnections(plr.Idled)) do
    v:Disable()
end

-- INFINITY YIELD ADMIN
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
