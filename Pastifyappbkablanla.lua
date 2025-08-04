--[[
X9fJ29fjqwiuf#@!dkfj2k3j9fj2k3j9fjqwiufj2938urqwiufj2398urqiwufj29qwifj2398ufjqwiuf
qwjf29uqwifj29uqiwejf29uqwiufj29qwiufj29uqwiefj29uqiwefj29uqiwejf29uqwiefj29uqwiufjq
wifj29uqwiefj29uqwiefj29uqwiefj29uqwiefj29uqwiefj29uqwiefj29uqwiefj29uqwiefj29uqwief
...
(Imagine 150-200 lines of pure nonsense here)
...
]]

local a=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local b=game:GetService("Players")
local c=game:GetService("VirtualInputManager")
local d=game:GetService("Workspace")
local e=b.LocalPlayer or b.PlayerAdded:Wait()
local f=d:WaitForChild("Balls",9e9)
local g=false
local h=false
local i=11.5
local j=a:CreateWindow({Name="izzy_hub - Blade Ball",Icon=0,LoadingTitle="Izzy's Blade Mastery",LoadingSubtitle="By ISRA Buddy Grokky | Updated 8/4/2025",Theme="Default",DisableRayfieldPrompts=false,DisableBuildWarnings=false,ConfigurationSaving={Enabled=true,FolderName="izzy_hub_BladeBall",FileName="izzyHubConfig"},Discord={Enabled=false,Invite="",RememberJoins=true},KeySystem=false,KeySettings={Title="izzy_hub Key",Subtitle="Key System",Note="Contact Izzy for the key",FileName="izzyKey",SaveKey=true,GrabKeyFromSite=false,Key={"IzzyRocks"}}})
local k=j:CreateTab("Main Features",nil)
k:CreateToggle({Name="Auto Parry",CurrentValue=false,Flag="AutoParryToggle",Callback=function(l)
g=l
if not g then return end
local function m(n) return typeof(n)=="Instance" and n:IsA("BasePart") and n:IsDescendantOf(f) and n:GetAttribute("realBall")==true end
local function o() return e.Character and e.Character:FindFirstChild("Highlight") end
local function p() c:SendMouseButtonEvent(0,0,0,true,game,0) c:SendMouseButtonEvent(0,0,0,false,game,0) end
f.ChildAdded:Connect(function(n)
if not m(n) or not g then return end
local q=n.Position
local r=tick()
n:GetPropertyChangedSignal("Position"):Connect(function()
if o() then
local s=(n.Position - d.CurrentCamera.Focus.Position).Magnitude
local t=(q - n.Position).Magnitude
if (s/t) <= i then p() end
if (tick()-r>=1/60) then r=tick() q=n.Position end
end
end)
end)
end})
k:CreateToggle({Name="Manual Spam",CurrentValue=false,Flag="ManualSpamToggle",Callback=function(l)
h=l
if not h then return end
local function m(n) return typeof(n)=="Instance" and n:IsA("BasePart") and n:IsDescendantOf(f) and n:GetAttribute("realBall")==true end
local function o() return e.Character and e.Character:FindFirstChild("Highlight") end
local function p() c:SendMouseButtonEvent(0,0,0,true,game,0) c:SendMouseButtonEvent(0,0,0,false,game,0) end
f.ChildAdded:Connect(function(n)
if not m(n) or not h then return end
local q=n.Position
local r=tick()
n:GetPropertyChangedSignal("Position"):Connect(function()
if o() then
local s=(n.Position - d.CurrentCamera.Focus.Position).Magnitude
local t=(q - n.Position).Magnitude
if (s/t) <= i then p() end
if (tick()-r>=2/60) then r=tick() q=n.Position end
end
end)
end)
end})
k:CreateSlider({Name="Predict Strength",Range={5,20},Increment=0.5,CurrentValue=11.5,Flag="PredictStrength",Callback=function(l)
i=l
a:Notify({Title="Predict Strength",Content="Set to "..l,Duration=3})
end})
a:Notify({Title="izzy_hub",Content="Welcome to Izzy's Blade Ball Hub! Follow @itz_me_iz on TikTok!",Duration=6.5})
local u=k:CreateLabel("Credit to Gab | More features coming soon!",nil,Color3.fromRGB(255,255,255),false)
local v=j:CreateTab("TikTok",nil)
local w=v:CreateSection("Follow Izzy")
local x=v:CreateParagraph({Title="https://www.tiktok.com/@itz_me_iz",Content="Follow for updates and tricks!"})
e.CharacterAdded:Connect(function(y)
Character=y
HumanoidRootPart=Character:WaitForChild("HumanoidRootPart")
end)
