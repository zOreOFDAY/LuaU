-- Usa a variável global "Forca" se ela estiver definida, senão usa 185
local forceF = Forca or 185

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

------------------------------------------------------------------
-- 1. Exibir mensagem temporária "Made By oRee Scripter"
------------------------------------------------------------------
local tempGui = Instance.new("ScreenGui")
tempGui.Parent = playerGui

local tempLabel = Instance.new("TextLabel")
tempLabel.Size = UDim2.new(0, 300, 0, 50)
tempLabel.Position = UDim2.new(0.5, -150, 0.1, 0)
tempLabel.BackgroundTransparency = 1
tempLabel.TextColor3 = Color3.new(1, 1, 1)  -- branco
tempLabel.TextScaled = true
tempLabel.Text = "Made By oRee Scripter"
tempLabel.Parent = tempGui

delay(3, function()
    tempGui:Destroy()
end)

------------------------------------------------------------------
-- 2. Atualizar textos em PlayerGui > Style > BG:
--    "StyleTxt" para "Jose Rapido" (cor roxa)
--    "Desc" para "Eu Sou Rapido E Calvo" (cor roxa)
------------------------------------------------------------------
local function updateStyleTexts()
    local styleGui = playerGui:FindFirstChild("Style")
    if styleGui then
        local bg = styleGui:FindFirstChild("BG")
        if bg then
            local styleTxt = bg:FindFirstChild("StyleTxt")
            if styleTxt and styleTxt:IsA("TextLabel") then
                styleTxt.Text = "Jose Rapido"
                styleTxt.TextColor3 = Color3.fromRGB(128, 0, 128)  -- roxo
            end
            local desc = bg:FindFirstChild("Desc")
            if desc and desc:IsA("TextLabel") then
                desc.Text = "Eu Sou Rapido E Calvo"
                desc.TextColor3 = Color3.fromRGB(128, 0, 128)  -- roxo
            end
        end
    end
end

spawn(function()
    while wait(1) do
        updateStyleTexts()
    end
end)

------------------------------------------------------------------
-- 3. Duplicar o botão "1" para criar "4", "5", "6" e "7" em Abilities,
--    definindo o texto dos botões e do Label "Keybind" para: "Z", "F", "Y" e "H"
-- Caminho: PlayerGui > InGameUI > Bottom > Abilities
------------------------------------------------------------------
local function duplicateAbilityButtons()
    local inGameUI = playerGui:FindFirstChild("InGameUI")
    if inGameUI then
        local bottomUI = inGameUI:FindFirstChild("Bottom")
        if bottomUI then
            local abilitiesUI = bottomUI:FindFirstChild("Abilities")
            if abilitiesUI then
                local originalButton = abilitiesUI:FindFirstChild("1")
                if originalButton then
                    local newButtons = {
                        {name = "4", keybind = "Z"},
                        {name = "5", keybind = "F"},
                        {name = "6", keybind = "Y"},
                        {name = "7", keybind = "H"}
                    }
                    for _, info in ipairs(newButtons) do
                        local clone = originalButton:Clone()
                        clone.Name = info.name
                        if clone:IsA("TextButton") then
                            clone.Text = info.keybind
                        end
                        local keybindLabel = clone:FindFirstChild("Keybind")
                        if keybindLabel and keybindLabel:IsA("TextLabel") then
                            keybindLabel.Text = info.keybind
                        end
                        clone.Parent = abilitiesUI
                    end
                else
                    warn("Botão original '1' não encontrado em Abilities!")
                end
            end
        end
    end
end

duplicateAbilityButtons()

------------------------------------------------------------------
-- 4. Função auxiliar para aplicar um dash com efeito de partículas roxas
------------------------------------------------------------------
local function dash(character, velocity, duration)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        -- Efeito de partículas roxas
        local pe = Instance.new("ParticleEmitter")
        pe.Color = ColorSequence.new(Color3.fromRGB(128, 0, 128))
        pe.LightEmission = 0.7
        pe.Rate = 100
        pe.Lifetime = NumberRange.new(0.2, 0.4)
        pe.Speed = NumberRange.new(0, 0)
        pe.Parent = hrp
        delay(duration, function()
            if pe then pe:Destroy() end
        end)
        -- Dash com BodyVelocity
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = velocity
        bv.MaxForce = Vector3.new(1e5, 0, 1e5)
        bv.P = 1000
        bv.Parent = hrp
        delay(duration, function()
            if bv then bv:Destroy() end
        end)
    end
end

------------------------------------------------------------------
-- 5. Registrar keybinds para habilidades: Z, F, Y e H
------------------------------------------------------------------
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if input.KeyCode == Enum.KeyCode.Z then
        -- Botão Z:
        -- Dash para frente com alta força
        dash(character, hrp.CFrame.LookVector * 100, 0.25)
        -- Pulo alto: aumenta temporariamente o JumpPower para um pulo mais forte
        local originalJumpPower = humanoid.JumpPower
        humanoid.JumpPower = 120
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        humanoid.Jump = true
        -- Reverte o JumpPower após um breve delay
        delay(0.2, function()
            humanoid.JumpPower = originalJumpPower
        end)
        -- Ao aterrissar, realiza outro dash com força reduzida
        local landedConnection
        landedConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Landed or newState == Enum.HumanoidStateType.Running then
                dash(character, hrp.CFrame.LookVector * 50, 0.25)
                landedConnection:Disconnect()
            end
        end)

    elseif input.KeyCode == Enum.KeyCode.F then
        -- Botão F: Chute utilizando a força definida (forceF) e depois apagar o cabelo de todo mundo
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://73458422902325"  -- AnimationId definido
        local animTrack = humanoid:LoadAnimation(anim)
        animTrack:Play()
        
        wait(0.4)
        
        local args = {
            [1] = forceF,  -- força definida via variável global "Forca" (ou 185 padrão)
            [4] = Vector3.new(-0.9431575536727905, -0.006543041206896305, 0.33228161931037903)
        }
        ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
            :WaitForChild("BallService"):WaitForChild("RE"):WaitForChild("Shoot")
            :FireServer(unpack(args))
        
        -- Apagar o cabelo de TODOS os jogadores
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _, item in ipairs(plr.Character:GetChildren()) do
                    if item:IsA("Accessory") and string.find(item.Name, "Hair") then
                        item:Destroy()
                    end
                end
            end
        end

    elseif input.KeyCode == Enum.KeyCode.Y then
        -- Botão Y:
        -- Dash para o lado e depois para frente.
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            dash(character, (hrp.CFrame.LookVector + (-hrp.CFrame.RightVector)).Unit * 80, 0.15)
            wait(0.15)
            dash(character, hrp.CFrame.LookVector * 100, 0.25)
        elseif UserInputService:IsKeyDown(Enum.KeyCode.D) then
            dash(character, (hrp.CFrame.LookVector + (hrp.CFrame.RightVector)).Unit * 80, 0.15)
            wait(0.15)
            dash(character, hrp.CFrame.LookVector * 100, 0.25)
        else
            dash(character, hrp.CFrame.LookVector * 100, 0.25)
        end

    elseif input.KeyCode == Enum.KeyCode.H then
        -- Botão H: Deixa a bola ancorada por 2 segundos
        local ball = workspace:FindFirstChild("Football")
        if ball and ball:IsA("BasePart") then
            ball.Anchored = true
            wait(2)
            ball.Anchored = false
        else
            warn("Bola não encontrada no Workspace!")
        end
    end
end)
