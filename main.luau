-- UI Library Module
local UILib = {}

-- Setup UI elements
function UILib:CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = size or UDim2.new(0, 200, 0, 50)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  -- Default button color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Text color
    button.Font = Enum.Font.Gotham
    button.TextSize = 20
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.Parent = parent

    -- Button Hover Effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)  -- Hover color
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  -- Reset color
    end)

    -- Button Click Effect
    button.MouseButton1Click:Connect(function()
        callback()
    end)

    return button
end

-- Create Label
function UILib:CreateLabel(parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = size or UDim2.new(0, 200, 0, 50)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1  -- Transparent background
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    label.TextAlign = Enum.TextXAlignment.Center
    label.Parent = parent

    return label
end

-- Create a Frame (base container for UI elements)
function UILib:CreateFrame(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0, 500, 0, 300)
    frame.Position = position or UDim2.new(0.5, -250, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Dark Background Color
    frame.BorderSizePixel = 0  -- Remove border
    frame.Parent = parent

    return frame
end

-- Create a slider
function UILib:CreateSlider(parent, min, max, size, position, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = size or UDim2.new(0, 400, 0, 20)
    sliderFrame.Position = position or UDim2.new(0, 0, 0, 0)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderFrame.Parent = parent

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0, 0, 1, 0)
    slider.BackgroundColor3 = Color3.fromRGB(100, 100, 255)  -- Slider color
    slider.Parent = sliderFrame

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 1, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Knob color
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
