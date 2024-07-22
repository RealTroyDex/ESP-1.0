-- Made by TroyDex

-- Improved Roblox ESP Module

local ESP = {}

local plr = game.Players.LocalPlayer
local players = game:GetService("Players")
local plrs = {}

local function addhighlight(player, teamcheck, showteam)
    if player.Character then
        local highlight = player.Character:FindFirstChild("Highlight")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Adornee = player.Character
            highlight.OutlineColor = Color3.new(0, 0, 0)
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = player.Character
        end
        
        if teamcheck and showteam and player.Team then
            highlight.FillColor = player.TeamColor.Color
        else
            highlight.FillColor = Color3.new(1, 0, 0)
        end
    end
end

function ESP.addplayers(printable, teamcheck, showteam)
    if printable == nil then
        print('Argument at function "ESP.addplayers()" is missing.')
    end

    for _, player in pairs(players:GetPlayers()) do
        if player ~= plr and not table.find(plrs, player) then
            table.insert(plrs, player)
            addhighlight(player, teamcheck, showteam)
            
            player.CharacterAdded:Connect(function()
                addhighlight(player, teamcheck, showteam)
            end)
        end
    end
    
    if printable then
        for _, player in pairs(plrs) do
            print("Player added to table: " .. player.Name)
        end
    end
end

function ESP.remove(player, printable)
    for i, v in pairs(plrs) do
        if v == player then
            table.remove(plrs, i)
            break
        end
    end
    if printable then
        print("Player removed from table: " .. player.Name)
    end
end

function ESP.onJoin(player, teamcheck, showteam)
    addhighlight(player, teamcheck, showteam)
    
    player.CharacterAdded:Connect(function()
        addhighlight(player, teamcheck, showteam)
    end)
end

function ESP.main(printable, teamcheck, showteam)
    ESP.addplayers(printable, teamcheck, showteam)
    
    players.PlayerAdded:Connect(function(player)
        ESP.onJoin(player, teamcheck, showteam)
    end)
    
    players.PlayerRemoving:Connect(function(player)
        ESP.remove(player, printable)
    end)
end

return ESP
