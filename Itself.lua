local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Izzy Hub | Grow A Garden",
    LoadingTitle = "Loading Izzy Hub...",
    LoadingSubtitle = "Sexy Multi-Tab UI",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "IzzyHubConfigs",
       FileName = "GardenConfig"
    },
    KeySystem = false
})

-- Tab 1: Spawn Pet
local PetTab = Window:CreateTab("Spawn Pet", 4483362458)
PetTab:CreateSection("Pet Info")

local petName = ""
local petAge = 0
local petWeight = 0

PetTab:CreateInput({
    Name = "Pet Name",
    PlaceholderText = "Type pet name here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        petName = text
    end,
})

PetTab:CreateInput({
    Name = "Pet Age",
    PlaceholderText = "Type pet age here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        petAge = tonumber(text) or 0
    end,
})

PetTab:CreateInput({
    Name = "Pet Weight",
    PlaceholderText = "Type pet weight here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        petWeight = tonumber(text) or 0
    end,
})

PetTab:CreateButton({
    Name = "Spawn Pet",
    Callback = function()
        -- Research shows Grow A Garden uses ReplicatedStorage RemoteEvents for spawn, example:
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local PetSpawnEvent = ReplicatedStorage:WaitForChild("SpawnPetEvent") -- example name, change if needed

        if PetSpawnEvent then
            PetSpawnEvent:FireServer(petName, petAge, petWeight)
            Rayfield:Notify({
                Title = "Pet Spawned!",
                Content = "Your pet "..petName.." is on the way! 🐾",
                Duration = 3
            })
        else
            warn("SpawnPetEvent not found!")
        end
    end,
})

-- Tab 2: Spawn Seed
local SeedTab = Window:CreateTab("Spawn Seed", 4483362458)
SeedTab:CreateSection("Seed Info")

local seedName = ""
local seedQuantity = 1

SeedTab:CreateInput({
    Name = "Seed Name",
    PlaceholderText = "Type seed name here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        seedName = text
    end,
})

SeedTab:CreateInput({
    Name = "Quantity",
    PlaceholderText = "How many seeds?",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        seedQuantity = tonumber(text) or 1
    end,
})

SeedTab:CreateButton({
    Name = "Spawn Seed",
    Callback = function()
        -- Example spawn seed remote event
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local SeedSpawnEvent = ReplicatedStorage:FindFirstChild("SpawnSeedEvent") or ReplicatedStorage:FindFirstChild("SeedSpawn")
        
        if SeedSpawnEvent then
            SeedSpawnEvent:FireServer(seedName, seedQuantity)
            Rayfield:Notify({
                Title = "Seed Spawned!",
                Content = seedQuantity.." "..seedName.." seed(s) spawned!",
                Duration = 3
            })
        else
            warn("SpawnSeedEvent not found!")
        end
    end,
})

-- Tab 3: Spawn Egg
local EggTab = Window:CreateTab("Spawn Egg", 4483362458)
EggTab:CreateSection("Egg Info")

local eggType = ""
local eggQuantity = 1

EggTab:CreateInput({
    Name = "Egg Type",
    PlaceholderText = "Type egg type here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        eggType = text
    end,
})

EggTab:CreateInput({
    Name = "Quantity",
    PlaceholderText = "How many eggs?",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        eggQuantity = tonumber(text) or 1
    end,
})

EggTab:CreateButton({
    Name = "Spawn Egg",
    Callback = function()
        -- Example spawn egg remote event
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local EggSpawnEvent = ReplicatedStorage:FindFirstChild("SpawnEggEvent") or ReplicatedStorage:FindFirstChild("EggSpawn")
        
        if EggSpawnEvent then
            EggSpawnEvent:FireServer(eggType, eggQuantity)
            Rayfield:Notify({
                Title = "Egg Spawned!",
                Content = eggQuantity.." "..eggType.." egg(s) spawned!",
                Duration = 3
            })
        else
            warn("SpawnEggEvent not found!")
        end
    end,
})

-- Destroy GUI Button on every tab (optional, you can add once in one tab)
Window:CreateTab("Settings", 4483362458):CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
    end,
})
