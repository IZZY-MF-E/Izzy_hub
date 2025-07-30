--[[ Retail Tycoon Coin Hack - Fixed Version ]]
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 90)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Title Bar (for dragging)
local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.TextColor3 = Color3.fromRGB(255,255,255)
TitleBar.Text = "Izzy Hub - Coin Hack"
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 14
TitleBar.Parent = Frame

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 1, 0)
CloseBtn.Position = UDim2.new(1, -25, 0, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 1, 0)
MinBtn.Position = UDim2.new(1, -50, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.Parent = TitleBar
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Frame.Size = minimized and UDim2.new(0,220,0,25) or UDim2.new(0,220,0,90)
end)

-- Coin Button
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, 0, 1, -25)
Button.Position = UDim2.new(0, 0, 0, 25)
Button.Text = "💸 Add 100k Coins"
Button.BackgroundColor3 = Color3.fromRGB(0,200,0)
Button.TextColor3 = Color3.fromRGB(255,255,255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 20
Button.Parent = Frame

-- Dragging function
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Safe Coin Add (fix for most games)
local function addCoins(amount)
    local stats = player:FindFirstChild("leaderstats") or player
    local money = stats and stats:FindFirstChild("Money")
    if money and (money:IsA("IntValue") or money:IsA("NumberValue")) then
        money.Value = money.Value + amount
        Button.Text = "💸 +100k Added!"
        wait(1)
        Button.Text = "💸 Add 100k Coins"
    else
        Button.Text = "❌ Money not found!"
        wait(1)
        Button.Text = "💸 Add 100k Coins"
    end
end

Button.MouseButton1Click:Connect(function()
    addCoins(100000)
end)
