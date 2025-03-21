local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Ball -- originalmente “v7”
local ControlEnabled = false  -- originalmente “v8”
local SomeToggle = true         -- originalmente “v9”
local Speed = 70              -- originalmente “v10”, pois 99 - 29 = 70

-- Cria a interface
local ControlBallUI = Instance.new("ScreenGui")
ControlBallUI.Name = "ControlBallUI"
ControlBallUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ControlButton = Instance.new("TextButton")
-- Tamanho: UDim2.new(0.15, 0, 0.08, 0) → (1065 - (68 + 997)) = 0
-- Posição: UDim2.new(0.1, 0, 0.8, 0) → (1270.1 - (226 + 1044)) = 0.1 e (117.8 - (32 + 85)) = 0.8
ControlButton.Size = UDim2.new(0.15, 0, 0.08, 0)
ControlButton.Position = UDim2.new(0.1, 0, 0.8, 0)
ControlButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ControlButton.Text = "CONTROL"
ControlButton.TextScaled = true
ControlButton.Parent = ControlBallUI

local StopButton = Instance.new("TextButton")
-- Tamanho: UDim2.new(0.15, 0, 0.08, 0) → (957 - (892 + 65)) = 0
-- Posição: UDim2.new(0.75, 0, 0.8, 0) → (350.8 - (87 + 263)) = 0.8 e (180 - (67 + 113)) = 0
StopButton.Size = UDim2.new(0.15, 0, 0.08, 0)
StopButton.Position = UDim2.new(0.75, 0, 0.8, 0)
-- Background: Color3.fromRGB(0, 0, 255) → (187 + 68 = 255)
StopButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
StopButton.Text = "STOP"
StopButton.TextScaled = true
StopButton.Visible = false
StopButton.Parent = ControlBallUI

local SpeedFrame = Instance.new("Frame")
-- Tamanho: UDim2.new(0.3, 0, 0.12, 0)
-- Posição: UDim2.new(0.35, 0, 0.6, 0) → (952 - (802 + 150)) = 0
SpeedFrame.Size = UDim2.new(0.3, 0, 0.12, 0)
SpeedFrame.Position = UDim2.new(0.35, 0, 0.6, 0)
-- Background: Color3.fromRGB(25, 25, 25) → (45-20, 19+6, 1022-(915+82))
SpeedFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SpeedFrame.Visible = false
SpeedFrame.Parent = ControlBallUI

local SpeedLabel = Instance.new("TextLabel")
-- Tamanho: UDim2.new(1, 0, 0.3, 0)
SpeedLabel.Size = UDim2.new(1, 0, 0.3, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 70"
-- TextColor: Color3.fromRGB(255, 255, 255) → (335-80, 1442-(1069+118), 255)
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextScaled = true
SpeedLabel.Parent = SpeedFrame

local WhiteFrame = Instance.new("Frame")
-- Tamanho: UDim2.new(0.9, 0, 0.4, 0)
-- Posição: UDim2.new(0.05, 0, 0.5, 0)
WhiteFrame.Size = UDim2.new(0.9, 0, 0.4, 0)
WhiteFrame.Position = UDim2.new(0.05, 0, 0.5, 0)
-- Background: Color3.fromRGB(255, 255, 255) → (253+2, 255, 1046-(368+423))
WhiteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WhiteFrame.Parent = SpeedFrame

local Slider = Instance.new("Frame")
-- Tamanho: UDim2.new(0.05, 0, 1, 0) → (18 - (10+8) = 0, 3-2 = 1, 442 - (416+26) = 0)
Slider.Size = UDim2.new(0.05, 0, 1, 0)
Slider.Position = UDim2.new(0.07, 0, 0, 0)
-- Background: Color3.fromRGB(255, 0, 0) → (450-195, 438-(145+293), 0)
Slider.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Slider.Parent = WhiteFrame

local InfoFrame = Instance.new("Frame")
-- Tamanho: UDim2.new(0.3, 0, 0.2, 0) → (430.3 - (44+386) = 0.3, 1486 - (998+488) = 0)
InfoFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
-- Posição: UDim2.new(0.35, 0, 0.4, 0) → (772 - (201+571) = 0, 1138.4 - (116+1022) = 0.4)
InfoFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
InfoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InfoFrame.Parent = ControlBallUI

local InstructionLabel = Instance.new("TextLabel")
InstructionLabel.Size = UDim2.new(1, 0, 1, 0)
InstructionLabel.BackgroundTransparency = 1
InstructionLabel.Text = "G - Control F - Stop"
-- TextColor: Color3.fromRGB(255, 255, 255) → (1114-(814+45), 628-373)
InstructionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InstructionLabel.TextScaled = true
InstructionLabel.Parent = InfoFrame

local CloseButton = Instance.new("TextButton")
-- Tamanho: UDim2.new(0.2, 0, 0.3, 0) → (885.3 - (261+624) = 0.3)
CloseButton.Size = UDim2.new(0.2, 0, 0.3, 0)
-- Posição: UDim2.new(0.8, 0, 0, 0) → (1080.8 - (1020+60) = 0.8, 1423 - (630+793) = 0)
CloseButton.Position = UDim2.new(0.8, 0, 0, 0)
CloseButton.Text = "X"
CloseButton.TextScaled = true
CloseButton.Parent = InfoFrame
CloseButton.MouseButton1Click:Connect(function()
	InfoFrame:Destroy()
end)

local MadeByLabel = Instance.new("TextLabel")
-- Tamanho: UDim2.new(0.15, 0, 0.05, 0) → (1747.05 - (760+987) = 0.05, 1913 - (1789+124) = 0)
MadeByLabel.Size = UDim2.new(0.15, 0, 0.05, 0)
-- Posição: UDim2.new(0.1, 0, 0.88, 0) → (766.1 - (745+21) = 0.1)
MadeByLabel.Position = UDim2.new(0.1, 0, 0.88, 0)
MadeByLabel.BackgroundTransparency = 1
MadeByLabel.Text = "Made by oRee Scripter"
MadeByLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
MadeByLabel.TextScaled = true
MadeByLabel.Parent = ControlBallUI

local TempLabel = Instance.new("TextLabel")
-- Tamanho: UDim2.new(0.5, 0, 0.1, 0) → (1055 - (87+968) = 0, ou seja, 0.5 e 0.1)
TempLabel.Size = UDim2.new(0.5, 0, 0.1, 0)
-- Posição: UDim2.new(0.25, 0, 0.3, 0) → (1413.3 - (447+966) = 0.3)
TempLabel.Position = UDim2.new(0.25, 0, 0.3, 0)
-- Background: Color3.fromRGB(0, 0, 0) → (1817 - (1703+114) = 0)
TempLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TempLabel.Text = "Made by oRee Scripter"
-- TextColor: Color3.fromRGB(255, 255, 0) → (956 - (376+325) = 255)
TempLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
TempLabel.TextScaled = true
TempLabel.Parent = ControlBallUI
task.wait(5)
TempLabel:Destroy()

---------------------------------------------------------------------
-- Funções

local function FindFootball()
	return workspace:FindFirstChild("Football")
end

local function StartBodyVelocity()
	local counter = 0
	local bodyVel
	while true do
		-- Quando counter for 0 (376 - (85+291) = 0)
		if counter == 0 then
			bodyVel = Instance.new("BodyVelocity")
			-- MaxForce: 1001265 - (243+1022) = 1000000, 3805178 - 2805178 = 1000000, 824965 + 175035 = 1000000
			bodyVel.MaxForce = Vector3.new(1000000, 1000000, 1000000)
			counter = 1  -- 1181 - (1123+57) = 1
		end
		-- Quando counter for 1 (2 - 1 = 1)
		if counter == 1 then
			bodyVel.Parent = Ball
			RunService.Heartbeat:Connect(function()
				local temp = 14 - (9 + 5)  -- = 0
				while true do
					if temp == 0 then
						if (not ControlEnabled or not Ball or not Ball.Parent) then
							bodyVel:Destroy()
							return
						end
						bodyVel.Velocity = (SomeToggle and (Camera.CFrame.LookVector * Speed)) or Vector3.new(0, 0, 0)
						break
					end
				end
			end)
			break
		end
	end
end

local function ToggleControl()
	Ball = FindFootball()
	if not Ball then
		warn("No Ball Found!")
		return
	end
	ControlEnabled = not ControlEnabled
	SomeToggle = true
	Camera.CameraSubject = (ControlEnabled and Ball) or Character
	StopButton.Visible = ControlEnabled
	SpeedFrame.Visible = ControlEnabled
	-- Se SomeToggle for true, a cor será (0,255,0); se não, (0,0,255)
	StopButton.BackgroundColor3 = (SomeToggle and Color3.fromRGB(0, 255, 0)) or Color3.fromRGB(0, 0, 255)
	if ControlEnabled then
		StartBodyVelocity()
	end
end

local function ToggleStop()
	local dummy = 0
	while true do
		if dummy == 0 then
			SomeToggle = not SomeToggle
			StopButton.BackgroundColor3 = (SomeToggle and Color3.fromRGB(0, 255, 0)) or Color3.fromRGB(0, 0, 255)
			break
		end
	end
end


-- Usa as teclas G e F para ligar/desligar o controle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	local dummy = 0
	while true do
		if dummy == 0 then
			if gameProcessed then
				return
			end
			if input.KeyCode == Enum.KeyCode.G then
				ToggleControl()
			elseif input.KeyCode == Enum.KeyCode.F then
				ToggleStop()
			end
			break
		end
	end
end)

local dragging = false
Slider.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
	end
end)
UserInputService.InputEnded:Connect(function(input)
	dragging = false
end)

RunService.RenderStepped:Connect(function()
	if dragging then
		local mouseX = UserInputService:GetMouseLocation().X
		local frameStart = WhiteFrame.AbsolutePosition.X
		local frameEnd = WhiteFrame.AbsolutePosition.X + WhiteFrame.AbsoluteSize.X
		local clampedX = math.clamp(mouseX, frameStart, frameEnd)
		local scaleFactor = (clampedX - frameStart) / (frameEnd - frameStart)
		local dummy = 0
		while true do
			if dummy == 0 then
				dummy = 1
			end
			if dummy == 1 then
				dummy = 2
			end
			if dummy == 2 then
				Slider.Position = UDim2.new(scaleFactor - 0.025, 0, 0, 0)
				Speed = math.floor(10 + scaleFactor * 340)
				dummy = 3
			end
			if dummy == 3 then
				SpeedLabel.Text = "Speed: " .. tostring(Speed)
				break
			end
		end
	end
end)

StopButton.MouseButton1Click:Connect(ToggleStop)
ControlButton.MouseButton1Click:Connect(ToggleControl)
