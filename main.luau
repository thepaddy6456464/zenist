-- main.luau (Your UI Library)

local UILib = {}

-- Create a table to hold all UI elements
UILib.UIElements = {}

-- Setup UI elements

function UILib:CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = size or UDim2.new(0, 200, 0, 50)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 20
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.Parent = parent

    -- Button Hover Effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    -- Button Click Effect
    button.MouseButton1Click:Connect(function()
        callback()
    end)

    table.insert(UILib.UIElements, button)  -- Store this button for later reference
    return button
end

function UILib:CreateLabel(parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = size or UDim2.new(0, 200, 0, 50)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    label.TextAlign = Enum.TextXAlignment.Center
    label.Parent = parent

    table.insert(UILib.UIElements, label)
    return label
end

function UILib:CreateFrame(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0, 500, 0, 300)
    frame.Position = position or UDim2.new(0.5, -250, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    table.insert(UILib.UIElements, frame)
    return frame
end

return UILib  -- Return the module so it can be accessed externally
