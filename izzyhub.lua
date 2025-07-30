-- Izzy Hub Loader
local msg = Instance.new("Message", workspace)
msg.Text = "Izzy is loading...😉"
wait(2) -- pause for effect
msg:Destroy()

-- Load main script from Pastefy
loadstring(game:HttpGet("https://pastefy.app/izg1HqVu/raw"))()
