-- Made by TroyDex

-- Simple Roblox ESP Module

local ESP = {}

local plr = game.Players.LocalPlayer
local players = game:GetService("Players")
local plrs = {}

local function addhighlight(plr)
    if plr.Character and plr.Character:FindFirstChild("Highlight") == nil then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = plr.Character
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.OutlineColor = Color3.new(0, 0, 0)
        highlight.AlwaysOnTop = true
        highlight.Parent = plr.Character
    end
end

function ESP.addplayers(printable)
    if printable == nil then
        print('Argument at function "ESP.addplayers()" is missing.')
    end

    for _, v in pairs(players:GetPlayers()) do
        if v ~= plr and table.find(plrs, v) == nil then
            table.insert(plrs, v)
            addhighlight(v)
            
            v.CharacterAdded:Connect(function()
                addhighlight(v)
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

function ESP.onJoin(player)
    addhighlight(player)
    
    player.CharacterAdded:Connect(function()
        addhighlight(player)
    end)
end

function ESP.main(printable)
    ESP.addplayers(printable)
    
    players.PlayerAdded:Connect(function(player)
        ESP.onJoin(player)
    end)
    
    players.PlayerRemoving:Connect(function(player)
        ESP.remove(player, printable)
    end)
end

return ESP
