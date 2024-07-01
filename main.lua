local ESP = {}

local plr = game.Players.LocalPlayer

local players = game:GetService("Players")

function ESP.see(printable)

    if printable == nil then
        print('Argument at function "ESP.see()" is missing.')
    end

    local plrs = {}
    for _, v in pairs(players:GetPlayers()) do
        if v ~= plr then
            table.insert(plrs, v)
        end
    end
    
    if printable then
        for _, v in pairs(plrs) do
            print("Player: "..v)
        end
    end
end

return ESP
