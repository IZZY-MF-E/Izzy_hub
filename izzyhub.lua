-- Izzy Hub Loader
local msg = Instance.new("Message", workspace)
msg.Text = "Izzy is loading...😉"
wait(4) -- pause for effect

msg.Text = "tiktok @itz_me_iz"
wait(2)

msg.Text = "here it is💋"
wait(1.5)

msg:Destroy()

shared.Type = 'Kill'



local cloneref = cloneref or function(obj)

    return obj

end



local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))

local playersService = cloneref(game:GetService('Players'))



local lplr = playersService.LocalPlayer

local Type = shared.Type



for i,v in playersService:GetPlayers() do

    if v ~= lplr and v.Character then

        replicatedStorage.Remotes.Troll:FireServer(v.Name, Type == 'Kill' and 3292459899 or 3292468890)

    end

end
