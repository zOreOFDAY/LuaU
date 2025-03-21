local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Football = workspace:FindFirstChild("Football")

local LOOK_VECTOR_MULTIPLIER = 200
local RIGHT_VECTOR_MULTIPLIER = 50
local isJuking = false

local TelekinesisUI = Instance.new("ScreenGui")
TelekinesisUI.Name = "TelekinesisUI"
TelekinesisUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local TelekinesisButton = Instance.new("TextButton")
TelekinesisButton.Size = UDim2.new(0.22, 0, 0.12, 0)
TelekinesisButton.Position = UDim2.new(0.4, 0, 0.75, 0)
TelekinesisButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TelekinesisButton.Text = "Telekinesis (F)"
TelekinesisButton.TextScaled = true
TelekinesisButton.Font = Enum.Font.GothamBold
TelekinesisButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TelekinesisButton.BorderSizePixel = 2
TelekinesisButton.Active = true
TelekinesisButton.AutoButtonColor = false
TelekinesisButton.Parent = TelekinesisUI

local MadeByLabel = Instance.new("TextLabel")
MadeByLabel.Size = UDim2.new(1, 0, 0.3, 0)
MadeByLabel.Position = UDim2.new(0, 0, 0.75, 0)
MadeByLabel.BackgroundTransparency = 1
MadeByLabel.Text = "Made by oRee Scripter"
MadeByLabel.TextScaled = true
MadeByLabel.Font = Enum.Font.Gotham
MadeByLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
MadeByLabel.Parent = TelekinesisButton

local TempLabel = Instance.new("TextLabel")
TempLabel.Size = UDim2.new(0.3, 0, 0.05, 0)
TempLabel.Position = UDim2.new(0.35, 0, 0.65, 0)
TempLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TempLabel.BackgroundTransparency = 0.3
TempLabel.Text = "Made by oRee Scripter"
TempLabel.TextScaled = true
TempLabel.Font = Enum.Font.GothamBold
TempLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TempLabel.Parent = TelekinesisUI

-- Remove o TempLabel após 5 segundos
task.spawn(function()
    task.wait(5)
    TempLabel:Destroy()
end)

-- Função para arrastar o botão
local dragging = false
local dragStart
local startPos

local function onInputBegan(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = TelekinesisButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end

local function onInputChanged(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        TelekinesisButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

TelekinesisButton.InputBegan:Connect(onInputBegan)
TelekinesisButton.InputChanged:Connect(onInputChanged)

local function Telekinesis()
    if isJuking or not Football then 
        return 
    end
    isJuking = true

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = Football

    task.wait(1)
    local direction = (Football.Position - Character.HumanoidRootPart.Position).unit
    local rightVector = Character.HumanoidRootPart.CFrame.RightVector
    local multiplier = (rightVector:Dot(direction) > 0) and -1 or 1
    bodyVelocity.Velocity = rightVector * multiplier * RIGHT_VECTOR_MULTIPLIER

    task.wait(0.3)
    local lookVectorVelocity = Character.HumanoidRootPart.CFrame.LookVector * LOOK_VECTOR_MULTIPLIER
    bodyVelocity.Velocity = lookVectorVelocity

    task.wait(0.5)
    bodyVelocity:Destroy()
    isJuking = false
end

TelekinesisButton.MouseButton1Click:Connect(Telekinesis)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F then
        Telekinesis()
    end
end)
