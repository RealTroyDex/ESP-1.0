-- Simple Roblox ESP Module

local ESP = {}

local plr = game.Players.LocalPlayer
local players = game:GetService("Players")
local plrs = {}

function ESP.addhighlight(player, teamcheck, showteam)
    if player.Character and player.Character:FindFirstChild("Highlight") == nil then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = player.Character
        
        if teamcheck and showteam and player.Team == plr.Team then
            highlight.FillColor = player.TeamColor.Color
        else
            highlight.FillColor = Color3.new(1, 0, 0)
        end

        highlight.OutlineColor = Color3.new(0, 0, 0)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = player.Character
    end
end

function ESP.addplayers(printable, teamcheck, showteam)
    if printable == nil then
        print('Argument at function "ESP.addplayers()" is missing.')
    end

    for _, v in pairs(players:GetPlayers()) do
        if v ~= plr and table.find(plrs, v) == nil then
            table.insert(plrs, v)
            ESP.addhighlight(v, teamcheck, showteam)
            
            v.CharacterAdded:Connect(function()
                ESP.addhighlight(v, teamcheck, showteam)
            end)
        end
    end
    
    if printable then
        for _, v in pairs(plrs) do
            print("Player added to table: " .. v.Name)
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
    ESP.addhighlight(player, teamcheck, showteam)
    
    player.CharacterAdded:Connect(function()
        ESP.addhighlight(player, teamcheck, showteam)
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
