-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the main menu frame
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 300, 0, 400)
menuFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
menuFrame.BackgroundColor3 = Color3.new(0, 0, 0)
menuFrame.BorderSizePixel = 0
menuFrame.Parent = screenGui

-- Create the draggable functionality
local dragging
local dragInput
local startPos

menuFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = input.Position
        dragInput = input
    end
end)

menuFrame.InputEnded:Connect(function(input)
    if input == dragInput then
        dragging = false
    end
end)

game:GetService("User  InputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - startPos
        menuFrame.Position = UDim2.new(menuFrame.Position.X.Scale, menuFrame.Position.X.Offset + delta.X, menuFrame.Position.Y.Scale, menuFrame.Position.Y.Offset + delta.Y)
        startPos = input.Position
    end
end)

-- Create the title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Text = "Script Loader"
titleLabel.Parent = menuFrame

-- Create the close button (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Text = "X"
closeButton.Parent = menuFrame

-- Hide the menu initially
menuFrame.Visible = true

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    menuFrame.Visible = false
end)

-- Create the button area
local buttonArea = Instance.new("Frame")
buttonArea.Size = UDim2.new(1, 0, 0, 300)
buttonArea.Position = UDim2.new(0, 0, 0, 50)
buttonArea.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
buttonArea.Parent = menuFrame

-- Create the load script label
local loadScriptLabel = Instance.new("TextLabel")
loadScriptLabel.Size = UDim2.new(1, 0, 0, 50)
loadScriptLabel.Position = UDim2.new(0, 0, 0, 0)
loadScriptLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
loadScriptLabel.TextColor3 = Color3.new(1, 1, 1)
loadScriptLabel.Text = "Load Script: None"
loadScriptLabel.Parent = buttonArea

-- Button data
local buttons = {
    {Name = "Infinite Yield", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()"},
    {Name = "CMDX", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()"},
    {Name = "Chat Troll Script", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/the1ofthenoobplayer/Roblox-Chat-Troll/refs/heads/main/Script'))()"},
    {Name = "Chat Bypass", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Synergy-Networks/products/main/BetterBypasser/loader.lua'))()"},
    {Name = "Chat GPT Chat", Script = "loadstring(game:HttpGet('https://rawscripts.net/raw/Universal-Script-Chat-GPT-Script-21140\'))()"},
}

-- Create buttons
for i, buttonData in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = UDim2.new(0, 0, 0, (i-1) * 60)
    button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = buttonData.Name
    button.Parent = buttonArea

    -- Button click event
    button.MouseButton1Click:Connect(function()
        loadScriptLabel.Text = "Load Script: " .. buttonData.Name
        loadScriptLabel.Tag = buttonData.Script
    end)
end

-- Create the Load Script button
local loadButton = Instance.new("TextButton")
loadButton.Size = UDim2.new(1, 0, 0, 50)
loadButton.Position = UDim2.new(0, 0, 0, 300)
loadButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
loadButton.TextColor3 = Color3.new(1, 1, 1)
loadButton.Text = "Load Script"
loadButton.Parent = buttonArea

-- Load script event
loadButton.MouseButton1Click:Connect(function()
    local scriptToLoad = loadScriptLabel.Tag
    if scriptToLoad then
        loadstring(scriptToLoad)()
    end
end)

-- Key press to reopen the menu
local UserInputService = game:GetService("User InputService")

User InputService.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == Enum.KeyCode.P then
        menuFrame.Visible = true
    end
end)
