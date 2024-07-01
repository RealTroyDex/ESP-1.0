local ESP = {}

local plr = game.Players.LocalPlayer
local plrs = {}

local players = game:GetService("Players")

function ESP.see()
    for _, v in pairs(players:GetPlayers()) do
        if v ~= plr then
            table.insert(plrs, v)
        end
    end
    
    for _, v in pairs(plrs) do
        print("Player: "..v)
    end
end

return ESP
