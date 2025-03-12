-- This script was not made by me but by Universal Syn Save Instance | AGPL-3.0 license
-- oRee Scripter

local player = game.Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:FindFirstChildOfClass("PlayerGui")
screenGui.Name = "DownloadGameGui"

local button = Instance.new("TextButton")
button.Parent = screenGui
button.Size = UDim2.new(0, 250, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.5, -25)
button.Text = "Download Game By oRee Scripter"
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.AutoButtonColor = true
button.Draggable = true -- Permite arrastar o botão

button.MouseButton1Click:Connect(function()
    print("This script was not made by me but by Universal Syn Save Instance | AGPL-3.0 license")
    print("oRee Scripter :D")
    saveinstance()
end)
