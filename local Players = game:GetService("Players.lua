local Players = game:GetService("Players")

-- Function to spin the player
local function spinPlayer(player)
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    -- Spin the player in a loop
    while player and player.Parent do
        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0)
        wait(0.1)  -- Adjust the spin speed here
    end
end

-- Function to fling nearby players
local function flingNearbyPlayers(player)
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local radius = 15  -- Adjust this value to set the fling radius

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherCharacter = otherPlayer.Character
            if otherCharacter and otherCharacter:FindFirstChild("HumanoidRootPart") then
                local otherHumanoidRootPart = otherCharacter.HumanoidRootPart
                local distance = (humanoidRootPart.Position - otherHumanoidRootPart.Position).magnitude

                if distance < radius then
                    local direction = (otherHumanoidRootPart.Position - humanoidRootPart.Position).unit
                    otherHumanoidRootPart.Velocity = direction * 50  -- Adjust fling force here
                end
            end
        end
    end
end

-- Main loop to manage player spinning and flinging
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        spinPlayer(player) -- Start spinning the player when they respawn

        while player and player.Parent do
            flingNearbyPlayers(player) -- Continuously check for nearby players to fling
            wait(1) -- Check every second
        end
    end)
end)