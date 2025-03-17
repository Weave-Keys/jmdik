local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Weave-Keys/jmdik/refs/heads/main/Ui2"))();
local Players = game:GetService("Players")
local myself = game.Players.LocalPlayer
local character = myself.Character or myself.CharacterAdded:Wait()
local workspace = game:GetService("Workspace")
local consumableSpawns = workspace:WaitForChild("ConsumableSpawns")
local bossModels = workspace.BossModels:GetChildren()
local GiveawayM =  myself.PlayerGui.UI.ItemLauncherFrame.ItemLauncher
local MinerPetInv = myself.PlayerGui.UI.MinerPetInventory
local PowerShop = myself.PlayerGui.UI.PowerShop
local InvestigationFrame = myself.PlayerGui.UI.InvestigationFrame
local FusionFrame = myself.PlayerGui.UI.FusionFrame
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

Window:Toggle("AutoBoss",function(v)
    AutoBoss = v;
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
             if meshpart:IsA("MeshPart") and (meshpart.Name == "GemModel" or meshpart.Name == "BigGemModel") and meshpart.Transparency == 0 and AutoGems == true then
                wait(delay)
                meshpart.CFrame = character.HumanoidRootPart.CFrame
                meshpart.Transparency = 1
             end
          end
       end
    end
end);
--AutoBoss Function
spawn(function()
    while wait(1) do
        if AutoBoss then
            for _, boss in ipairs(bossModels) do
                if boss.Name ~= "CupidsFire" and boss:FindFirstChild("Head") and boss:FindFirstChild("HitsLeft") and AutoBoss == true then
                    -- Loop teleport to the boss until HitsLeft is 0
                    local hitsLeft = boss.HitsLeft
                    while hitsLeft.Value > 0 and AutoBoss == true do
                        -- Teleport to the boss's position
                        character:MoveTo(boss.LeftLowerLeg.Position)
                        wait(0.05) -- Wait briefly between teleports
                    end
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
