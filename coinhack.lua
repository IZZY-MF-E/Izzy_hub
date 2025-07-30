--[[ 
Retail Tycoon Coin Hack by Isra 🔥
Features: 
- 100k Coin Add Button
- Anti-Ban (Randomized Changes + Delays)
- Draggable GUI
]]--

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CoinHackGui"
ScreenGui.Parent = game.CoreGui

-- Create Frame
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 220, 0, 90)
Frame.Active = true
Frame.Draggable = true

-- Create Button
local Button = Instance.new("TextButton")
Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 20
Button.Text = "💸 Add 100k Coins"
Button.Size = UDim2.new(1, 0, 1, 0)

-- Anti-ban randomizer function
local function safeAddCoins(amount)
    local player = game.Players.LocalPlayer
    local stats = player:FindFirstChild("leaderstats") or player
    local money = stats:FindFirstChild("Money")

    if money and (money:IsA("IntValue") or money:IsA("NumberValue")) then
        -- Randomize increments to avoid detection
        local chunks = math.random(3, 6) -- split into 3-6 parts
        local chunkAmount = math.floor(amount / chunks)

        for i = 1, chunks do
            money.Value = money.Value + chunkAmount
            wait(math.random(0.2, 0.5)) -- random delay
        end
    else
        warn("Money variable not found.")
    end
end

-- Button Click Event
Button.MouseButton1Click:Connect(function()
    Button.Text = "💸 Hacking Coins..."
    safeAddCoins(100000) -- Add 100k safely
    Button.Text = "💸 100k Coins Added!"
    wait(1)
    Button.Text = "💸 Add 100k Coins"
end)
