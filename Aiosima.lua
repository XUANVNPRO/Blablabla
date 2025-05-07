local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", game.CoreGui)

local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0, 300, 0, 25)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.BackgroundTransparency = 0.4
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 18
label.Text = "Position: ..."

local copyBtn = Instance.new("TextButton", gui)
copyBtn.Size = UDim2.new(0, 150, 0, 30)
copyBtn.Position = UDim2.new(0, 10, 0, 40)
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.Font = Enum.Font.SourceSansBold
copyBtn.TextSize = 16
copyBtn.Text = "Copy Position"

Instance.new("UICorner", label)
Instance.new("UICorner", copyBtn)

local lastPos = Vector3.zero

RunService.RenderStepped:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        lastPos = hrp.Position
        label.Text = string.format("X: %.2f | Y: %.2f | Z: %.2f", lastPos.X, lastPos.Y, lastPos.Z)
    end
end)

copyBtn.MouseButton1Click:Connect(function()
    setclipboard(string.format("Vector3.new(%.2f, %.2f, %.2f)", lastPos.X, lastPos.Y, lastPos.Z))
    copyBtn.Text = "Copied!"
    task.delay(1, function()
        copyBtn.Text = "Copy Position"
    end)
end)
