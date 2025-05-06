local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "DeepScanGui"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Quét Thông Tin Vật Thể"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local info = Instance.new("TextBox", frame)
info.Position = UDim2.new(0, 0, 0, 30)
info.Size = UDim2.new(1, 0, 1, -30)
info.TextWrapped = true
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextYAlignment = Enum.TextYAlignment.Top
info.TextEditable = false
info.Text = "Chạm vào vật thể..."
info.ClearTextOnFocus = false
info.BackgroundTransparency = 1
info.TextColor3 = Color3.fromRGB(230, 230, 230)
info.Font = Enum.Font.Code
info.TextSize = 16
info.TextStrokeTransparency = 0.8
info.TextScaled = false
info.MultiLine = true

-- Highlight
local highlight = Instance.new("Highlight")
highlight.FillTransparency = 0.7
highlight.OutlineTransparency = 0
highlight.FillColor = Color3.fromRGB(255, 200, 50)
highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
highlight.Enabled = false
highlight.Parent = game:GetService("CoreGui")

-- Tìm model cha cao nhất
local function findTopModel(part)
	local model = part
	while model and not model:IsA("Model") and model.Parent do
		model = model.Parent
	end
	if model and model:IsA("Model") then
		return model
	end
	return nil
end

-- Quét thông tin đơn giản giống ảnh
local function getSimpleInfo(model)
	local hasHumanoid = model:FindFirstChildOfClass("Humanoid") and "Có" or "Không"
	local infoLines = {
		"Tên: " .. model.Name,
		"Lớp: " .. model.ClassName,
		"Cha: " .. (model.Parent and model.Parent:GetFullName() or "Không rõ"),
		"Có Humanoid? " .. hasHumanoid
	}
	return table.concat(infoLines, "\n")
end

-- Quét liên tục theo chuột
RunService.RenderStepped:Connect(function()
	local target = mouse.Target
	if target then
		local model = findTopModel(target)
		if model then
			info.Text = getSimpleInfo(model)
			highlight.Adornee = model
			highlight.Enabled = true
		else
			info.Text = "Không tìm thấy mô hình cha."
			highlight.Enabled = false
		end
	else
		info.Text = "Chạm vào vật thể để xem thông tin..."
		highlight.Enabled = false
	end
end)
