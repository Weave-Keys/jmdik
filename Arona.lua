local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua'))()
local Flags = Library.Flags
local myself = game.Players.LocalPlayer
local character = myself.Character or myself.CharacterAdded:Wait()
local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local consumableSpawns = workspace:WaitForChild("ConsumableSpawns")
local delay = 0.45
local AutoGems = false
local AutoBoss = false
local AntiAdmin = false
local AdminIds = {
    1669099177,
    1170766740,
    476619547,
    1827520657,
    1077484224,
    101215590,
    163196330,
    180019260,
    1653719164,
    1938362101,
    1756780636,
    223346455,
    3088024612,
    2798477868,
    1300222786,
    1908765681,
    125026259,
    1351421311,
    1453352451,
    1228715200,
    26144290,
    1731832970,
    91543795
}

local function AutoGems(AutoGemss)
    AutoGems = AutoGemss
    while AutoGems do
        wait(1)
        local ping = math.round(myself:GetNetworkPing() * 1000)
        if ping > 2000 then
            delay = 10
        elseif ping > 400 then
            delay = 2
        else
            delay = 0.45
        end
    
        for _, meshpart in pairs(workspace:GetDescendants()) do
            if meshpart:IsA("MeshPart") and (meshpart.Name == "GemModel" or meshpart.Name == "BigGemModel") and meshpart.Transparency == 0 and AutoGems == true then
                wait(delay)
                meshpart.CFrame = character.HumanoidRootPart.CFrame
                meshpart.Transparency = 1
            end
        end
    end    
end

local function AutoBoss(AutoBoss)

end

local function isUserAdmin(userId)
    for _, adminId in ipairs(AdminIds) do
        if userId == adminId then
            return true
        end
    end
    return false
end

local function AntiAdmin(AntiAdminn)
    AntiAdmin = AntiAdminn
    while AntiAdmin do 
        wait(1)
        if not myself then
            return
        end
    
        for _, player in ipairs(Players:GetPlayers()) do
            if isUserAdmin(player.UserId) then
                game:Shutdown()
            end
        end
    end
end

local Window = Library:Window({
    Text = "Arona"
})

local Tab = Window:Tab({
    Text = "Main"
})

local Section = Tab:Section({
    Text = "AutoFarms"
})


Section:Toggle({
    Text = "AutoGems",
    Callback = function(v)
        if v == true then 
            print("AutoGems Enabled")
            AutoGems(true)
        elseif v == false then 
            print("AutoGems Disabled")
            AutoGems = false
        end
    end
})

Section:Toggle({
    Text = "AutoBoss",
    Callback = function(v)
        if v == true then 
            print("AutoBoss Enabled")
            AutoBoss(true)
        elseif v == false then 
            print("AutoBoss Disabled")
            AutoBoss = false
        end
    end
})

Section:Toggle({
    Text = "AntiAdmin",
    Callback = function(v)
        if v == true then 
            print("AntiAdmin Enabled")
            AntiAdmin(true)
        elseif v == false then 
            print("AntiAdmin Disabled")
            AntiAdmin = false
        end
    end
})

Section:Slider({
    Text = "GemPickUpDelay",
    Default = 0.45,
    Minimum = 0.1,
    Maximum = 1,
    Callback = function(v)
        delay = v
    end
})
