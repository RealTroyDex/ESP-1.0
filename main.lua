local ESP = {}

local pls = {}

function ESP.add_table()
    local plr = game.Players.LocalPlayer
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= plr then
            ESP.add_player(v)
        end
    end
end

function ESP.add_player(plr)
    print("Added table to: " .. plr.Name)
    local char = plr.Character or plr:FindFirstChildWhichIsA("Model")
    if char then
        local hl = Instance.new("Highlight", char:FindFirstChild("HumanoidRootPart"))
        hl.FillColor = Color3.new(1, 0, 0)
        hl.Adornee = char
        pls[plr] = {
            dead = false,
            Highlight = hl
        }
    end

    plr.CharacterAdded:Connect(function(char)
        local hl = pls[plr] and pls[plr].Highlight
        if hl then
            hl.Parent = char:FindFirstChild("HumanoidRootPart")
            hl.Adornee = char
            print("Re-attached highlight to: " .. plr.Name)
        else
            local newHL = Instance.new("Highlight", char:FindFirstChild("HumanoidRootPart"))
            newHL.FillColor = Color3.new(1, 0, 0)
            newHL.Adornee = char
            pls[plr] = {
                Highlight = newHL
            }
            print("Making highlight for: " .. plr.Name)
        end
    end)
end

ESP.add_table()

game:GetService("Players").PlayerAdded:Connect(function(plr)
    ESP.add_player(plr)
end)

game:GetService("Players").PlayerRemoving:Connect(function(plr)
    local plrData = pls[plr]
    if plrData then
        plrData.Highlight:Destroy()
        pls[plr] = nil
        print("Removed highlight for: " .. plr.Name)
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    for plr, plrData in pairs(pls) do
        if plrData.Highlight.Parent == nil then
            local char = plr.Character or plr:FindFirstChildWhichIsA("Model")
            if char then
                plrData.Highlight.Parent = char:FindFirstChild("HumanoidRootPart")
                plrData.Highlight.Adornee = char
                print("Reattached highlight to: " .. plr.Name)
            end
        end
    end
end)

return ESP
