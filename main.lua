local ESP = {}

local plr = game.Players.LocalPlayer

local players = game:GetService("Players")

local plrs = {}

function ESP.addplayers(printable)

    if printable == nil then
        print('Argument at function "ESP.see()" is missing.')
    end

    
    for _, v in pairs(players:GetPlayers()) do
        if v ~= plr and table.find(plrs, v) == nil then
            table.insert(plrs, v)
        end
    end
    
    if printable then
        for _, v in pairs(plrs) do
            print("Player added to table: "..v)
        end
    end
end

function ESP.remove(player, printable)
    for i,v in pairs(plrs) do
        if table.find(plrs, player) ~= nil then
            table.remove(plrs, i)
        end
    end
end

function ESP.onJoin(player)
    if player then
        addplayers(true)
    end
end

players.PlayerAdded:Connect(function(player)
    if player then
        ESP.onJoin(player)
    end
end)

players.PlayerRemoving:Connect(function(player)
    ESP.remove(player, true)
end)

return ESP
