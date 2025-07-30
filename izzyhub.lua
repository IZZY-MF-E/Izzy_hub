-- Izzy Hub Loader
local msg = Instance.new("Message", workspace)
msg.Text = "Izzy is loading...😉"
wait(4) -- pause for effect

msg.Text = "tiktok @itz_me_iz"
wait(2)

msg.Text = "here it is💋"
wait(1.5)

msg:Destroy()

-- Load main script from Pastefy
-- Atlas Script for Grow a Garden (No Key)
local Atlas = loadstring(game:HttpGet("https://raw.githubusercontent.com/AtlasExecutor/Atlas/main/Atlas.lua"))()

-- Steal Pet/Fruit
Atlas:StealPetOrFruit(function(target)
    local player = game.Players.LocalPlayer
    local targetPet = target.Character.Pet
    if targetPet then
        targetPet.Parent = player.Character
    end
end)

-- Spawn Pet (Server-Side, Visible to Others)
Atlas:SpawnPet("RarePet", {
    VisibleToAll = true,
    Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
})

-- Dupe Pet
Atlas:DupePet(function(pet)
    local newPet = pet:Clone()
    newPet.Parent = game.Workspace.Pets
end)

Atlas:Execute()
