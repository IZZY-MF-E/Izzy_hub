local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "IzzyHubRT"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 110)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BorderSizePixel = 0

-- Title Bar
local TitleBar = Instance.new("TextLabel", Frame)
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = Color3.fromRGB(45,45,45)
TitleBar.TextColor3 = Color3.fromRGB(255,255,255)
TitleBar.Text = "Izzy Hub - Retail Tycoon"
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 14

-- Close Button
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 25, 1, 0)
CloseBtn.Position = UDim2.new(1, -25, 0, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.new(0, 25, 1, 0)
MinBtn.Position = UDim2.new(1, -50, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(255,170,0)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Frame.Size = minimized and UDim2.new(0,250,0,25) or UDim2.new(0,250,0,110)
end)

-- Coin Count Label
local CoinLabel = Instance.new("TextLabel", Frame)
CoinLabel.Size = UDim2.new(1, 0, 0, 40)
CoinLabel.Position = UDim2.new(0,0,0,25)
CoinLabel.BackgroundColor3 = Color3.fromRGB(50,50,50)
CoinLabel.TextColor3 = Color3.fromRGB(255,255,255)
CoinLabel.Font = Enum.Font.GothamBold
CoinLabel.TextSize = 22
CoinLabel.Text = "Coins: Loading..."

-- Add Coins Button
local AddButton = Instance.new("TextButton", Frame)
AddButton.Size = UDim2.new(1, 0, 0, 40)
AddButton.Position = UDim2.new(0, 0, 0, 65)
AddButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
AddButton.TextColor3 = Color3.fromRGB(255,255,255)
AddButton.Font = Enum.Font.GothamBold
AddButton.TextSize = 20
AddButton.Text = "💸 Add 100k Coins"

-- Dragging setup
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

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Function to get coins
local function getCoins()
    local stats = player:FindFirstChild("leaderstats")
    if stats then
        local money = stats:FindFirstChild("Money")
        if money then
            return money.Value
        end
    end
    return 0
end

-- Update coin count label every second
spawn(function()
    while true do
        CoinLabel.Text = "Coins: ".. tostring(getCoins())
        wait(1)
    end
end)

-- Try to add coins locally (may not stick if server rejects)
AddButton.MouseButton1Click:Connect(function()
    local stats = player:FindFirstChild("leaderstats")
    if stats then
        local money = stats:FindFirstChild("Money")
        if money and (money:IsA("IntValue") or money:IsA("NumberValue")) then
            money.Value = money.Value + 100000
            AddButton.Text = "💸 Added 100k Coins!"
            wait(1)
            AddButton.Text = "💸 Add 100k Coins"
        else
            AddButton.Text = "❌ Money not found!"
            wait(1)
            AddButton.Text = "💸 Add 100k Coins"
        end
    else
        AddButton.Text = "❌ Stats not found!"
        wait(1)
        AddButton.Text = "💸 Add 100k Coins"
    end
end)
