-- Linoria-inspired UI Library Module

local TweenService = game:GetService("TweenService")
local UILib = {}

-- Default Colors (for dark mode)
local Theme = {
    BackgroundColor = Color3.fromRGB(34, 34, 34),
    ButtonColor = Color3.fromRGB(45, 45, 45),
    AccentColor = Color3.fromRGB(255, 104, 104),
    TextColor = Color3.fromRGB(255, 255, 255),
    ButtonHoverColor = Color3.fromRGB(60, 60, 60),
    Font = Enum.Font.Gotham,
}

-- Smooth animation easing
local function createTween(object, goal, time)
    local tweenInfo = TweenInfo.new(time or 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, goal)
    tween:Play()
end

-- Create Button
function UILib:CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = size or UDim2.new(0, 200, 0, 50)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = Theme.ButtonColor
    button.TextColor3 = Theme.TextColor
    button.Font = Theme.Font
    button.TextSize = 20
    button.TextTransparency = 0
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.BorderSizePixel = 0
    button.Parent = parent
    button.ClipsDescendants = true
    button.BackgroundTransparency = 0.8

    -- Smooth Hover Effect
    button.MouseEnter:Connect(function()
        createTween(button, {BackgroundColor3 = Theme.ButtonHoverColor}, 0.2)
    end)

    button.MouseLeave:Connect(function()
        createTween(button, {BackgroundColor3 = Theme.ButtonColor}, 0.2)
    end)

    -- Click Effect
    button.MouseButton1Click:Connect(function()
        callback()
        createTween(button, {BackgroundColor3 = Theme.AccentColor}, 0.1)
        wait(0.1)
        createTween(button, {BackgroundColor3 = Theme.ButtonColor}, 0.1)
    end)

    return button
end

-- Create Label
function UILib:CreateLabel(parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = size or UDim2.new(0, 200, 0, 50)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Theme.TextColor
    label.Font = Theme.Font
    label.TextSize = 18
    label.TextAlign = Enum.TextXAlignment.Center
    label.TextTransparency = 0.8
    label.Parent = parent
    return label
end

-- Create Frame (Main container)
function UILib:CreateFrame(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0, 500, 0, 300)
    frame.Position = position or UDim2.new(0.5, -250, 0.5, -150)
    frame.BackgroundColor3 = Theme.BackgroundColor
    frame.BorderSizePixel = 0
    frame.Parent = parent
    return frame
end

-- Create Slider
function UILib:CreateSlider(parent, min, max, size, position, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = size or UDim2.new(0, 400, 0, 20)
    sliderFrame.Position = position or UDim2.new(0, 0, 0, 0)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = parent

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0, 0, 1, 0)
    slider.BackgroundColor3 = Theme.AccentColor
    slider.Parent = sliderFrame

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 1, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(0, 0, 0.5, 0)
    knob.Parent = sliderFrame

    -- Slider dragging effect
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local dragConnection
            dragConnection = input.Move:Connect(function()
                local mouseX = game:GetService("UserInputService"):GetMouseLocation().X
                local sliderX = sliderFrame.AbsolutePosition.X
                local newX = math.clamp(mouseX - sliderX, 0, sliderFrame.AbsoluteSize.X)
                slider.Size = UDim2.new(0, newX, 1, 0)
                knob.Position = UDim2.new(0, newX, 0.5, 0)
                local value = min + ((max - min) * (newX / sliderFrame.AbsoluteSize.X))
                callback(value)
            end)
            input.Ended:Connect(function()
                dragConnection:Disconnect()
            end)
        end
    end)

    return sliderFrame
end

return UILib
