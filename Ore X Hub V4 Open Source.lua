-- Script By oRee Scripter
-- Ore X Hub V4 Open Source

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local mouse = player:GetMouse()

local oreHUB = nil
local kamuiTPButton = nil
local shinraTenseiButton = nil
local kamuiUPButton = nil
local speedHackButton = nil
local shinraKillButton = nil
local kamuiActivated = false
local shinraTenseiActivated = false
local kamuiUPActivated = false
local speedHackActivated = false
local shinraKillActivated = false


local function createKamuiTPBall(targetPosition)
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")


    local ball = Instance.new("Part")
    ball.Shape = Enum.PartType.Ball
    ball.Size = Vector3.new(2, 2, 2)
    ball.Position = targetPosition
    ball.Color = Color3.fromRGB(0, 0, 0)  
    ball.Anchored = true
    ball.CanCollide = false
    ball.Parent = workspace

    -- Animação de crescimento da bola
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local goal = {Size = Vector3.new(6, 6, 6)} 
    local tween = tweenService:Create(ball, tweenInfo, goal)
    tween:Play()

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(targetPosition) 

    game:GetService("Debris"):AddItem(ball, 0.5)
end

local function createKillBall()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local ball = Instance.new("Part")
    ball.Name = "KillBall"
    ball.Shape = Enum.PartType.Ball
    ball.Size = Vector3.new(50, 50, 50)
    ball.Position = humanoidRootPart.Position
    ball.Color = Color3.fromRGB(255, 255, 255)
    ball.Transparency = 0.5
    ball.Anchored = true
    ball.CanCollide = false
    ball.Parent = workspace

    ball.Touched:Connect(function(hit)
        if hit.Parent:FindFirstChild("Humanoid") then
            local humanoid = hit.Parent:FindFirstChild("Humanoid")
            if humanoid and hit.Parent ~= character then
                humanoid.Health = 0
            end
        end
    end)

    game:GetService("Debris"):AddItem(ball, 0.5)
end

local function createPartAbovePlayer()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local part = Instance.new("Part")
    part.Size = Vector3.new(10, 10, 10) 
    part.Position = humanoidRootPart.Position + Vector3.new(0, 100, 0) 
    part.Anchored = true 
    part.CanCollide = true 
    part.Color = Color3.fromRGB(0, 255, 0)  
    part.Parent = workspace  

    humanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 5, 0)  

    wait(10)
    part:Destroy() 
end

local function createKamuiTPButton(parent)
    kamuiTPButton = Instance.new("TextButton")
    kamuiTPButton.Size = UDim2.new(0.8, 0, 0.1, 0)
    kamuiTPButton.Position = UDim2.new(0.1, 0, 0.2, 0)
    kamuiTPButton.Text = "KamuiTP (G)"
    kamuiTPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    kamuiTPButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) 
    kamuiTPButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    kamuiTPButton.TextSize = 18
    kamuiTPButton.Font = Enum.Font.SourceSans
    kamuiTPButton.Parent = parent

    kamuiTPButton.MouseButton1Click:Connect(function()
        kamuiActivated = not kamuiActivated
        kamuiTPButton.BackgroundColor3 = kamuiActivated and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(70, 70, 70)
    end)
end

local function createShinraTenseiButton(parent)
    shinraTenseiButton = Instance.new("TextButton")
    shinraTenseiButton.Size = UDim2.new(0.8, 0, 0.1, 0)
    shinraTenseiButton.Position = UDim2.new(0.1, 0, 0.35, 0)
    shinraTenseiButton.Text = "Shinra Tensei (B)"
    shinraTenseiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    shinraTenseiButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) 
    shinraTenseiButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    shinraTenseiButton.TextSize = 18
    shinraTenseiButton.Font = Enum.Font.SourceSans
    shinraTenseiButton.Parent = parent

    shinraTenseiButton.MouseButton1Click:Connect(function()
        shinraTenseiActivated = not shinraTenseiActivated
        shinraTenseiButton.BackgroundColor3 = shinraTenseiActivated and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(70, 70, 70)
    end)
end

local function createKamuiUPButton(parent)
    kamuiUPButton = Instance.new("TextButton")
    kamuiUPButton.Size = UDim2.new(0.8, 0, 0.1, 0)
    kamuiUPButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    kamuiUPButton.Text = "KamuiUP (F)"
    kamuiUPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    kamuiUPButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    kamuiUPButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    kamuiUPButton.TextSize = 18
    kamuiUPButton.Font = Enum.Font.SourceSans
    kamuiUPButton.Parent = parent

    kamuiUPButton.MouseButton1Click:Connect(function()
        kamuiUPActivated = not kamuiUPActivated
        kamuiUPButton.BackgroundColor3 = kamuiUPActivated and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(70, 70, 70)
    end)
end
local function createSpeedHackButton(parent)
    speedHackButton = Instance.new("TextButton")
    speedHackButton.Size = UDim2.new(0.8, 0, 0.1, 0)    
    speedHackButton.Position = UDim2.new(0.1, 0, 0.65, 0)
    speedHackButton.Text = "SpeedHack (H)"
    speedHackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedHackButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        speedHackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedHackButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) 
    speedHackButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    speedHackButton.TextSize = 18
    speedHackButton.Font = Enum.Font.SourceSans
    speedHackButton.Parent = parent

    speedHackButton.MouseButton1Click:Connect(function()
        speedHackActivated = not speedHackActivated
        speedHackButton.BackgroundColor3 = speedHackActivated and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(70, 70, 70)
    end)
end

local function createShinraKillButton(parent)
    shinraKillButton = Instance.new("TextButton")
    shinraKillButton.Size = UDim2.new(0.8, 0, 0.1, 0)
    shinraKillButton.Position = UDim2.new(0.1, 0, 0.8, 0)
    shinraKillButton.Text = "Shinra Kill"
    shinraKillButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    shinraKillButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) 
    shinraKillButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    shinraKillButton.TextSize = 18
    shinraKillButton.Font = Enum.Font.SourceSans
    shinraKillButton.Parent = parent

    shinraKillButton.MouseButton1Click:Connect(function()
        shinraKillActivated = not shinraKillActivated
        shinraKillButton.BackgroundColor3 = shinraKillActivated and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(70, 70, 70)

        _G.KillAura = shinraKillActivated 

        if shinraKillActivated then
            while _G.KillAura do
                wait(0.1) 

                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") then
                        local ball = Instance.new("Part")
                        ball.Name = "KillBall"
                        ball.Shape = Enum.PartType.Ball
                        ball.Size = Vector3.new(5, 5, 5)
                        ball.Position = v.HumanoidRootPart.Position 
                        ball.Color = Color3.fromRGB(255, 255, 255) 
                        ball.Anchored = true
                        ball.CanCollide = false
                        ball.Parent = workspace

                        ball.Touched:Connect(function(hit)
                            if hit.Parent:FindFirstChild("Humanoid") then
                                local humanoid = hit.Parent:FindFirstChild("Humanoid")
                                if humanoid then
                                    humanoid.Health = 0 
                                end
                            end
                        end)

                        game:GetService("Debris"):AddItem(ball, 0.5)
                    end
                end
            end
        end
    end)
end

local function createOreHUB()
    oreHUB = Instance.new("ScreenGui")
    oreHUB.Name = "OreHUB"
    oreHUB.Parent = game.Players.LocalPlayer.PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
    mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(48, 0, 48) 
    mainFrame.BorderSizePixel = 2
    mainFrame.Parent = oreHUB

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0.1, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleBar.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Text = "Ore X Hub"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = titleBar

    local closeLabel = Instance.new("TextLabel")
    closeLabel.Size = UDim2.new(0.1, 0, 0.1, 0)
    closeLabel.Position = UDim2.new(1, -30, 1, -10)
    closeLabel.Text = "L (Fechar)"
    closeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeLabel.BackgroundTransparency = 1
    closeLabel.TextSize = 24
    closeLabel.Font = Enum.Font.SourceSansBold
    closeLabel.Parent = mainFrame

    -- Criar Botões
    createKamuiTPButton(mainFrame)
    createShinraTenseiButton(mainFrame)
    createKamuiUPButton(mainFrame)
    createSpeedHackButton(mainFrame)  
    createShinraKillButton(mainFrame) 
end

createOreHUB()

userInputService.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end

    if input.KeyCode == Enum.KeyCode.G then
        if kamuiActivated then
            local targetPosition = mouse.Hit.p
            createKamuiTPBall(targetPosition)
        end
    elseif input.KeyCode == Enum.KeyCode.B then
        if shinraTenseiActivated then
            createKillBall()
        end
    elseif input.KeyCode == Enum.KeyCode.F then
        if kamuiUPActivated then
            createPartAbovePlayer()
        end
    elseif input.KeyCode == Enum.KeyCode.H then
        if speedHackActivated then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local movementPath = workspace:WaitForChild("Characters"):WaitForChild(player.Name):FindFirstChild("Movement + Swim")
                if movementPath then
                    movementPath:Destroy()
                end
                humanoid.WalkSpeed = 250
            end
        else
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 50 
            end
        end
    elseif input.KeyCode == Enum.KeyCode.L then
        local mainFrame = oreHUB:FindFirstChild("Frame")
        if mainFrame then
            mainFrame.Visible = not mainFrame.Visible
        end
    end
end)
