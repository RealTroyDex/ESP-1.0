local plr = game.Players.LocalPlayer

local players = game.Players:GetPlayers()

local ESP = {}

-- function to add players to the array
function ESP.add(player)
    if player then
        if player.Character and player ~= plr and player.Character:FindFirstChild("Highlight") == nil then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = player.Character
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.FillColor = Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(0, 0, 0)
            highlight.Parent = player.Character
        end
    end
end

function ESP.start()
    -- Initial start
    for _, v in pairs(players) do
        ESP.add(v)
        v.CharacterAdded:Connect(function()
            ESP.add(v)
        end)
    end
    -- connect the event when a player joins the game
    game.Players.PlayerAdded:Connect(function(player)
        ESP.add(player)
        -- connect this function (it triggers when the character dies, so adds the highlight again)
        player.CharacterAdded:Connect(function()
            ESP.add(player)
        end)
    end)
end

return ESP.start()
