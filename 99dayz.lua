--// Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

--// Variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local GodmodeEnabled = false
local FreezeMonstersEnabled = false
local InfiniteResourcesEnabled = false

--// Rayfield Window
local Window = Rayfield:CreateWindow({
    Name = "izzy_hub - 99 Nights in the Forest",
    LoadingTitle = "Izzy's Survival Domination",
    LoadingSubtitle = "by Grok | Updated 8/4/2025",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "izzy_hub_99Nights",
        FileName = "Config"
    }
})

--// Main Tab
local MainTab = Window:CreateTab("Main Mods", 4483362458)

--// Godmode Toggle
MainTab:CreateToggle({
    Name = "Godmode",
    CurrentValue = false,
    Callback = function(Value)
        GodmodeEnabled = Value
        if Character and Character:FindFirstChild("Humanoid") then
            local humanoid = Character.Humanoid
            if Value then
                humanoid.Name = "Humanoid"
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
        end
    end
})

--// Freeze Monsters Toggle
MainTab:CreateToggle({
    Name = "Freeze Monsters",
    CurrentValue = false,
    Callback = function(Value)
        FreezeMonstersEnabled = Value
        local monsters = Workspace:FindFirstChild("Monsters")
        if monsters then
            for _, mob in pairs(monsters:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") then
                    mob.HumanoidRootPart.Anchored = Value
                end
            end
        end
    end
})

--// Infinite Resources Toggle
MainTab:CreateToggle({
    Name = "Infinite Resources",
    CurrentValue = false,
    Callback = function(Value)
        InfiniteResourcesEnabled = Value
        if Value then
            local remote = ReplicatedStorage:FindFirstChild("GiveResource")
            if remote and remote:IsA("RemoteEvent") then
                remote:FireServer("Wood", 9999)
                remote:FireServer("Stone", 9999)
                Rayfield:Notify({
                    Title = "Resources Granted",
                    Content = "Added 9999 Wood and Stone!",
                    Duration = 3
                })
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "GiveResource event not found!",
                    Duration = 3
                })
            end
        end
    end
})

--// Character Update
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    if GodmodeEnabled and Character:FindFirstChild("Humanoid") then
        local humanoid = Character.Humanoid
        humanoid.Name = "Humanoid"
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
end)

--// Monster Update (for dynamic spawning)
Workspace.ChildAdded:Connect(function(child)
    if child.Name == "Monsters" and FreezeMonstersEnabled then
        for _, mob in pairs(child:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") then
                mob.HumanoidRootPart.Anchored = true
            end
        end
    end
end)

--// Instructions Label
MainTab:CreateLabel("Instructions: Toggle features to dominate 99 Nights! Check console (F9) for errors.")
