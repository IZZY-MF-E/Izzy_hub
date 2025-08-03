local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Grow A Garden Menu",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Rayfield UI",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "RayfieldConfigs",
       FileName = "GardenMenu"
    },
    KeySystem = false
})

-- Tab
local MainTab = Window:CreateTab("Main", 4483362458) 
MainTab:CreateSection("Basic Controls")

-- WalkSpeed Slider
MainTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 200},
   Increment = 5,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Fly Toggle (simple)
MainTab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
       if Value then
           local Player = game.Players.LocalPlayer
           local Humanoid = Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid")
           if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Physics) end
           Player.Character:FindFirstChildOfClass("HumanoidRootPart").Anchored = false
           print("Fly ON")
       else
           print("Fly OFF")
       end
   end,
})

-- Destroy GUI
MainTab:CreateButton({
   Name = "Destroy Menu",
   Callback = function()
       Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "Grow A Garden",
   Content = "Menu Loaded Successfully!",
   Duration = 3
})
