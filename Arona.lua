local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Weave-Keys/jmdik/refs/heads/main/Ui2"))();
local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local consumableSpawns = workspace:WaitForChild("ConsumableSpawns")
local bossModels = workspace.BossModels:GetChildren()
local myself = game.Players.LocalPlayer
local character = myself.Character or myself.CharacterAdded:Wait()
local GiveawayM =  myself.PlayerGui.UI.ItemLauncherFrame.ItemLauncher
local MinerPetInv = myself.PlayerGui.UI.MinerPetInventory
local PowerShop = myself.PlayerGui.UI.PowerShop
local InvestigationFrame = myself.PlayerGui.UI.InvestigationFrame
local FusionFrame = myself.PlayerGui.UI.FusionFrame
local delay = 0.45
local AutoGems = false
local AutoShamrocks = false
local AutoBoss = false
local AutoAirDrop = false
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

local function isUserAdmin(userId)
    for _, adminId in ipairs(AdminIds) do
        if userId == adminId then
            return true
        end
    end
    return false
end

local Window = library:CreateWindow("Arona-AutoFarms");
local Window2 = library:CreateWindow("Arona-Misc");

Window:Toggle("AutoGems",function(v)
     AutoGems = v;
end);

Window:Toggle("AutoShamrocks",function(v)
    AutoShamrocks = v;
end);

Window:Toggle("AutoAirDrop",function(v)
    AutoAirDrop = v;
end);

Window:Toggle("AntiAdmin",function(v)
    AntiAdmin = v;
end);

Window2:Toggle("Show Giveaway Menu",function(v)
    GiveawayM.Visible = v;
end);

Window2:Toggle("Show MinerPetInventory",function(v)
    MinerPetInv.Visible = v;
end);

Window2:Toggle("Show PowerShop",function(v)
    PowerShop.Visible = v;
end);

Window2:Toggle("Show Investigation Menu",function(v)
    InvestigationFrame.Visible = v;
end);

Window2:Toggle("Show Fusion Menu",function(v)
    FusionFrame.Visible = v;
end);
-- AutoGems Function
spawn(function()
    while wait(1) do
        if AutoGems then
           local ping = math.round(myself:GetNetworkPing() * 1000)
           if ping > 2000 then
              delay = 10
           elseif ping > 400 then
              delay = 2
           else
              delay = 0.45
           end
    
        for _, meshpart in pairs(workspace:GetDescendants()) do
             if meshpart:IsA("MeshPart") and (meshpart.Name == "GemModel" or meshpart.Name == "BigGemModel") and meshpart.Transparency == 0 and AutoGems == true and meshpart.CFrame.Position.Y > 120 then
                wait(delay)
                meshpart.CFrame = character.HumanoidRootPart.CFrame
                meshpart.Transparency = 1
             end
          end
       end
    end
end);
--AntiAdmin Function
spawn(function()
    while wait(1) do
        if AntiAdmin then
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
end);

spawn(function()
    while wait(1) do
        if AutoShamrocks then
            local ping = math.round(myself:GetNetworkPing() * 1000)
            if ping > 2000 then
               delay = 10
            elseif ping > 400 then
               delay = 2
            else
               delay = 0.45
            end
     
         for _, meshpart in pairs(workspace:GetDescendants()) do
              if meshpart:IsA("MeshPart") and (meshpart.Name == "ShamrocksModel" or meshpart.Name == "BigShamrockModel") and meshpart.Transparency == 0 and AutoShamrocks == true and meshpart.CFrame.Position.Y > 120  then
                 wait(delay)
                 meshpart.CFrame = character.HumanoidRootPart.CFrame
                 meshpart.Transparency = 1
              end
           end
        end
    end
end);
spawn(function()
    while wait(1) do
        if AutoAirDrop then
            -- Save the current player location at the moment AutoAirDrop is enabled
            local lastLocation = character.HumanoidRootPart.CFrame
            
            -- Loop to continuously check for an airdrop while AutoAirDrop remains true
            while AutoAirDrop do
                -- Check if the Airdrops folder exists
                local airdropFolder = workspace:FindFirstChild("Airdrops")
                if airdropFolder then
                    -- Look for the Airdrop model inside the folder
                    local airdropModel = airdropFolder:FindFirstChild("Airdrop")
                    if airdropModel then
                        -- Ensure the airdrop model has a PrimaryPart; if not, try to set one
                        if not airdropModel.PrimaryPart then
                            local primaryPart = airdropModel:FindFirstChildWhichIsA("BasePart")
                            if primaryPart then
                                airdropModel.PrimaryPart = primaryPart
                            end
                        end
                        
                        if airdropModel.PrimaryPart then
                            -- Teleport the player to the airdrop's position
                            character.HumanoidRootPart.CFrame = airdropModel.PrimaryPart.CFrame
                            
                            -- Wait 10 seconds to allow time for looting/interaction
                            wait(7)
                            
                            -- Teleport the player back to their last saved location
                            character.HumanoidRootPart.CFrame = lastLocation
                            
                            -- Optionally, wait a few seconds before scanning again
                            wait(0.5)
                        end
                    end
                end
                wait(0.5)
            end
        end
    end
end);
