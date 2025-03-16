local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local myself = game.Players.LocalPlayer
local character = myself.Character or myself.CharacterAdded:Wait()
local workspace = game:GetService("Workspace")
local consumableSpawns = workspace:WaitForChild("ConsumableSpawns")
local Players = game:GetService("Players")
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
                myself:Kick("An admin is in the game.")
            end
        end
    end
end


local gui = Library:create{
    Theme = Library.Themes.Serika
}

local tab = gui:tab{
    Icon = "rbxassetid://7669965792",
    Name = "AKM"
}

tab:button({
    Name = "AutoGems",
    Callback = function()
        tab:prompt{
            Title = "AutoGems",
            Text = "Enable or Disable AutoGems",
            Buttons = {
                Enable = function()
				  print("AutoGems Enabled")
                  AutoGems(true)
				  
                end,
                  Disable = function()
                  print("AutoGems Disabled")
                  AutoGems = false
                end,
            }
        }
    end,
})
tab:button({
    Name = "AutoBoss",
    Callback = function()
        tab:prompt{
            Title = "AutoBoss",
            Text = "Enable or Disable AutoBoss",
            Buttons = {
                Enable = function()
				  print("AutoBoss Enabled")
                  AutoBoss(true)
				  
                end,
                  Disable = function()
                  print("AutoBoss Disabled")
				  AutoBoss = false
			      
                end,
            }
        }
    end,
})
tab:button({
    Name = "AntiAdmin    ",
    Callback = function()
        tab:prompt{
            Title = "AntiAdmin",
            Text = "Enable or Disable AntiAdmin",
            Buttons = {
                Enable = function()
				  print("AntiAdmin Enabled")
                  AntiAdmin(true)
				  
                end,
                  Disable = function()
                  print("AntiAdmin Disabled")
				  AntiAdmin = false
			      
                end,
            }
        }
    end,
})
