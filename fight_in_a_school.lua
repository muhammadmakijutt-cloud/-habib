-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Settings
local Settings = {
    AutoFarm = false,
    Hitbox = false,
    ESP = false,
    WalkSpeed = 16,
    HitboxSize = Vector3.new(15, 15, 15)
}

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MadoHubUI"
ScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 360)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "FIGHT IN A SCHOOL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.FredokaOne
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Close Button (❌)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "❌"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Hide / Minimize Button (-)
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 25, 0, 25)
HideBtn.Position = UDim2.new(1, -60, 0, 8)
HideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
HideBtn.Text = "-"
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.TextSize = 16
HideBtn.Font = Enum.Font.SourceSansBold
HideBtn.Parent = MainFrame

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 6)
HideCorner.Parent = HideBtn

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, 0, 1, -80)
Container.Position = UDim2.new(0, 0, 0, 40)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local isHidden = false
HideBtn.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    Container.Visible = not isHidden
    MainFrame.Size = isHidden and UDim2.new(0, 320, 0, 40) or UDim2.new(0, 320, 0, 360)
end)

-- Watermark Footer (Mado Hub)
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundTransparency = 1
Footer.Text = "YouTube: Mado Hub"
Footer.TextColor3 = Color3.fromRGB(255, 255, 255)
Footer.TextSize = 18
Footer.Font = Enum.Font.FredokaOne
Footer.Parent = MainFrame

-- Helper Function for Toggles
local function CreateToggle(name, position, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.9, 0, 0, 35)
    Frame.Position = position
    Frame.BackgroundTransparency = 1
    Frame.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18
    Label.Font = Enum.Font.FredokaOne
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 28, 0, 28)
    Button.Position = UDim2.new(1, -30, 0.5, -14)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Text = ""
    Button.Parent = Frame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Button

    local state = false
    Button.MouseButton1Click:Connect(function()
        state = not state
        Button.BackgroundColor3 = state and Color3.fromRGB(220, 40, 40) or Color3.fromRGB(50, 50, 50)
        Button.Text = state and "✓" or ""
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        callback(state)
    end)
end

-- Toggles
CreateToggle("Auto Farm Kills", UDim2.new(0.05, 0, 0, 5), function(val) Settings.AutoFarm = val end)
CreateToggle("Hitbox Extender", UDim2.new(0.05, 0, 0, 45), function(val) Settings.Hitbox = val end)
CreateToggle("ESP (Player Highlight)", UDim2.new(0.05, 0, 0, 85), function(val) Settings.ESP = val end)

-- WalkSpeed Input
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(0.9, 0, 0, 40)
SpeedFrame.Position = UDim2.new(0.05, 0, 0, 130)
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.Parent = Container

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.5, 0, 1, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Walk Speed"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 18
SpeedLabel.Font = Enum.Font.FredokaOne
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedFrame

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0, 60, 0, 28)
SpeedInput.Position = UDim2.new(1, -60, 0.5, -14)
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedInput.Text = "16"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Font = Enum.Font.FredokaOne
SpeedInput.TextSize = 16
SpeedInput.Parent = SpeedFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = SpeedInput

SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then Settings.WalkSpeed = num else SpeedInput.Text = tostring(Settings.WalkSpeed) end
end)

-- Feature Handlers
RunService.Stepped:Connect(function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    if Settings.Hitbox then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local hrp = player.Character.HumanoidRootPart
                    hrp.Size = Settings.HitboxSize
                    hrp.Transparency = 0.7
                    hrp.Color = Color3.fromRGB(255, 0, 0)
                    hrp.Material = Enum.Material.ForceField
                    hrp.CanCollide = false
                end)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("MadoESPHighlight")
            if Settings.ESP then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "MadoESPHighlight"
                    highlight.FillColor = Color3.fromRGB(255, 50, 50)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.Parent = player.Character
                end
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Settings.AutoFarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
                    if targetHRP then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
                        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                        if tool then
                            if tool.Parent ~= LocalPlayer.Character then LocalPlayer.Character.Humanoid:EquipTool(tool) end
                            tool:Activate()
                        end
                        break
                    end
                end
            end
        end
    end
end)
