-- CodeRedemptionGUI.lua

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CodeRedemptionGUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 200, 0, 50)
TextBox.Position = UDim2.new(0.5, -100, 0.3, 0)
TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.PlaceholderText = "Enter code here"
TextBox.Parent = Frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0, 100, 0, 50)
SubmitButton.Position = UDim2.new(0.5, -50, 0.7, 0)
SubmitButton.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Text = "Submit"
SubmitButton.Parent = Frame

SubmitButton.MouseButton1Click:Connect(function()
    local code = TextBox.Text
    game.ReplicatedStorage.CodeRedemptionEvent:FireServer(code)
end)

local NotificationLabel = Instance.new("TextLabel")
NotificationLabel.Size = UDim2.new(0, 200, 0, 30)
NotificationLabel.Position = UDim2.new(0.5, -100, 0.9, 0)
NotificationLabel.AnchorPoint = Vector2.new(0.5, 0.5)
NotificationLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NotificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationLabel.Text = ""
NotificationLabel.Parent = Frame

local function showNotification(message)
    NotificationLabel.Text = message
    wait(3)
    NotificationLabel.Text = ""
end

game.ReplicatedStorage.CodeRedemptionResponseEvent.OnClientEvent:Connect(showNotification)

-- CodeRedemptionGUI.lua