-- Configuration
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chatDelay = 1.25
local messages = {
    "『💀』 Hello Bhai 😈 " .. player.Name .. ", Guys Wanna Join Celestial Syndicate 🔥 『🩸』",
    "『😎』//OWNER//:LEADER:// 『🤩』",
    "『🚩』ASUKA REIGN ON TOP『🚩』",
    "ASUKA HUB XD 🗿", -- Added right below -pd
    "SCriPt By Yadsan_Godverse WorkiNg!"
}
-- Function to safely send chat messages across different Roblox chat systems
local function sendChat(message)
    -- Modern TextChatService (2023+)
    local textChatService = game:GetService("TextChatService")
    if textChatService and textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local textChannel = textChatService.TextChannels:FindFirstChild("RBXGeneral")
        if textChannel then
            textChannel:SendAsync(message)
            return
        end
    end
    
    -- Legacy ChatService fallback
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local defaultChatSystemChatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if defaultChatSystemChatEvents then
        local sayMessageRequest = defaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
        if sayMessageRequest and sayMessageRequest:IsA("RemoteEvent") then
            sayMessageRequest:FireServer(message, "All")
        end
    end
end
-- Main Execution Sequence
task.spawn(function()
    -- Loop through and send the configured messages with the specified delay
    for _, msg in ipairs(messages) do
        sendChat(msg)
        task.wait(chatDelay)
    end
    
    -- Execute the external Patchma Hub script after the final delay
    local success, err = pcall(function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ZxyYadsan/Asuka-Hub/refs/heads/main/AsukaHub_YadsanXLuffy_RedBlack_Rain.lua"))()
    end)
    
    if not success then
        warn("Failed to execute external script: " .. tostring(err))
    end
end)

--==================================================
-- ASUKA ON TOP | YADSAN X LUFFY INTRO
-- RED & BLACK THEME + RAIN + INNER TRIANGLE
--==================================================
do
	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local Player = Players.LocalPlayer
	local PlayerGui = Player:WaitForChild("PlayerGui")

	-- SETTINGS
	local DURATION = 6
	local RED = Color3.fromRGB(235, 15, 25)
	local BRIGHT_RED = Color3.fromRGB(255, 40, 45)
	local DARK_RED = Color3.fromRGB(120, 0, 10)
	local BLACK = Color3.fromRGB(5, 3, 4)

	-- CLEANUP
	local old = PlayerGui:FindFirstChild("ASUKA_YADSAN_LUFFY_INTRO")
	if old then old:Destroy() end

	-- SCREEN
	local Gui = Instance.new("ScreenGui")
	Gui.Name = "ASUKA_YADSAN_LUFFY_INTRO"
	Gui.IgnoreGuiInset = true
	Gui.ResetOnSpawn = false
	Gui.DisplayOrder = 999
	Gui.Parent = PlayerGui

	-- BACKGROUND
	local BG = Instance.new("Frame")
	BG.Size = UDim2.fromScale(1, 1)
	BG.BackgroundColor3 = BLACK
	BG.BorderSizePixel = 0
	BG.ClipsDescendants = true
	BG.Parent = Gui

	local BGGradient = Instance.new("UIGradient")
	BGGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 0, 5)),
		ColorSequenceKeypoint.new(0.5, BLACK),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 0, 4))
	})
	BGGradient.Rotation = 90
	BGGradient.Parent = BG

	-- TWEEN HELPER
	local function Tween(obj, duration, properties, repeatCount)
		local info = TweenInfo.new(
			duration,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.InOut,
			repeatCount or 0
		)

		local animation = TweenService:Create(obj, info, properties)
		animation:Play()
		return animation
	end

	-- RED RAIN EFFECT
	local RainContainer = Instance.new("Frame")
	RainContainer.Name = "RainContainer"
	RainContainer.Size = UDim2.fromScale(1, 1)
	RainContainer.BackgroundTransparency = 1
	RainContainer.ClipsDescendants = true
	RainContainer.ZIndex = 1
	RainContainer.Parent = BG

	local rainActive = true
	task.spawn(function()
		while rainActive and Gui.Parent do
			local startX = math.random(0, 100) / 100
			local dropLength = math.random(14, 28)
			local dropSpeed = math.random(5, 10) / 10

			local drop = Instance.new("Frame")
			drop.Size = UDim2.fromOffset(2, dropLength)
			drop.Position = UDim2.new(startX, 0, 0, -dropLength)
			drop.BackgroundColor3 = RED
			drop.BackgroundTransparency = math.random(2, 5) / 10
			drop.BorderSizePixel = 0
			drop.ZIndex = 1
			drop.Parent = RainContainer

			local dropGrad = Instance.new("UIGradient")
			dropGrad.Rotation = 90
			dropGrad.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, BRIGHT_RED),
				ColorSequenceKeypoint.new(1, DARK_RED)
			})
			dropGrad.Parent = drop

			local t = TweenService:Create(
				drop,
				TweenInfo.new(dropSpeed, Enum.EasingStyle.Linear),
				{ Position = UDim2.new(startX - 0.03, 0, 1, dropLength) }
			)
			t.Completed:Once(function()
				if drop and drop.Parent then
					drop:Destroy()
				end
			end)
			t:Play()

			task.wait(0.035)
		end
	end)

	-- RESPONSIVE PORTAL
	local Portal = Instance.new("Frame")
	Portal.Name = "Portal"
	Portal.AnchorPoint = Vector2.new(0.5, 0.5)
	Portal.Position = UDim2.fromScale(0.5, 0.37)
	Portal.Size = UDim2.fromOffset(300, 300)
	Portal.BackgroundTransparency = 1
	Portal.ZIndex = 2
	Portal.Parent = BG

	local function ResizePortal()
		local camera = workspace.CurrentCamera
		if not camera then return end

		local viewport = camera.ViewportSize
		local diameter = math.floor(math.min(viewport.X, viewport.Y) * 0.78)

		Portal.Size = UDim2.fromOffset(diameter, diameter)
	end

	ResizePortal()

	local camConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(ResizePortal)
	local vpConn
	if workspace.CurrentCamera then
		vpConn = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(ResizePortal)
	end

	-- CIRCLE CREATOR
	local function Ring(parent, size, color, thickness, transparency)
		local circle = Instance.new("Frame")
		circle.AnchorPoint = Vector2.new(0.5, 0.5)
		circle.Position = UDim2.fromScale(0.5, 0.5)
		circle.Size = UDim2.fromScale(size, size)
		circle.BackgroundTransparency = 1
		circle.ZIndex = 2
		circle.Parent = parent

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = circle

		local stroke = Instance.new("UIStroke")
		stroke.Color = color
		stroke.Thickness = thickness
		stroke.Transparency = transparency or 0.15
		stroke.Parent = circle

		return circle
	end

	-- ROTATING LAYER
	local function RotatingLayer(duration, direction)
		local layer = Instance.new("Frame")
		layer.AnchorPoint = Vector2.new(0.5, 0.5)
		layer.Position = UDim2.fromScale(0.5, 0.5)
		layer.Size = UDim2.fromScale(1, 1)
		layer.BackgroundTransparency = 1
		layer.ZIndex = 2
		layer.Parent = Portal

		Tween(layer, duration, {
			Rotation = direction * 360
		}, -1)

		return layer
	end

	-- OUTER RINGS
	local OuterLayer = RotatingLayer(35, 1)
	Ring(OuterLayer, 0.98, DARK_RED, 1, 0.2)
	Ring(OuterLayer, 0.91, RED, 1, 0.35)

	-- SECOND ROTATING LAYER
	local SecondLayer = RotatingLayer(24, -1)
	Ring(SecondLayer, 0.80, RED, 2, 0.12)
	Ring(SecondLayer, 0.73, DARK_RED, 1, 0.2)

	-- THIRD ROTATING LAYER
	local ThirdLayer = RotatingLayer(15, 1)
	Ring(ThirdLayer, 0.61, BRIGHT_RED, 2, 0.1)
	Ring(ThirdLayer, 0.53, RED, 1, 0.2)

	-- GEOMETRIC POLYGON CREATOR
	local function Polygon(parent, sides, radius, color, zIndex)
		for i = 1, sides do
			local a1 = ((i - 1) / sides) * math.pi * 2 - math.pi / 2
			local a2 = (i / sides) * math.pi * 2 - math.pi / 2

			local x1 = 0.5 + math.cos(a1) * radius
			local y1 = 0.5 + math.sin(a1) * radius

			local x2 = 0.5 + math.cos(a2) * radius
			local y2 = 0.5 + math.sin(a2) * radius

			local dx = x2 - x1
			local dy = y2 - y1

			local line = Instance.new("Frame")
			line.AnchorPoint = Vector2.new(0.5, 0.5)
			line.Position = UDim2.fromScale((x1 + x2) / 2, (y1 + y2) / 2)
			line.Size = UDim2.fromScale(math.sqrt(dx * dx + dy * dy), 0)
			line.Rotation = math.deg(math.atan2(dy, dx))
			line.BorderSizePixel = 0
			line.BackgroundColor3 = color
			line.BackgroundTransparency = 0.2
			line.ZIndex = zIndex or 2
			line.Parent = parent

			local stroke = Instance.new("UIStroke")
			stroke.Color = color
			stroke.Thickness = 1.2
			stroke.Parent = line
		end
	end

	local PolygonLayer = RotatingLayer(12, -1)
	Polygon(PolygonLayer, 8, 0.29, RED, 2)

	local PolygonLayer2 = RotatingLayer(19, 1)
	Polygon(PolygonLayer2, 5, 0.22, BRIGHT_RED, 2)

	-- LAST CIRCLE (INNER CORE) + NEW TRIANGLE INSIDE
	Ring(Portal, 0.30, BRIGHT_RED, 2, 0.05)

	local CoreFill = Instance.new("Frame")
	CoreFill.AnchorPoint = Vector2.new(0.5, 0.5)
	CoreFill.Position = UDim2.fromScale(0.5, 0.5)
	CoreFill.Size = UDim2.fromScale(0.26, 0.26)
	CoreFill.BackgroundColor3 = Color3.fromRGB(16, 2, 4)
	CoreFill.BorderSizePixel = 0
	CoreFill.ZIndex = 3
	CoreFill.Parent = Portal

	local CoreCorner = Instance.new("UICorner")
	CoreCorner.CornerRadius = UDim.new(1, 0)
	CoreCorner.Parent = CoreFill

	local CoreStroke = Instance.new("UIStroke")
	CoreStroke.Color = RED
	CoreStroke.Thickness = 2
	CoreStroke.Parent = CoreFill

	Tween(CoreStroke, 1.5, {
		Transparency = 0.7
	}, -1)

	-- NEW ROTATING TRIANGLE INSIDE LAST CIRCLE
	local TriangleLayer = Instance.new("Frame")
	TriangleLayer.Name = "TriangleLayer"
	TriangleLayer.AnchorPoint = Vector2.new(0.5, 0.5)
	TriangleLayer.Position = UDim2.fromScale(0.5, 0.5)
	TriangleLayer.Size = UDim2.fromScale(1, 1)
	TriangleLayer.BackgroundTransparency = 1
	TriangleLayer.ZIndex = 4
	TriangleLayer.Parent = CoreFill

	Tween(TriangleLayer, 8, {
		Rotation = -360
	}, -1)

	Polygon(TriangleLayer, 3, 0.40, BRIGHT_RED, 4)

	-- FLOATING PARTICLES
	for i = 1, 14 do
		local dot = Instance.new("Frame")
		dot.AnchorPoint = Vector2.new(0.5, 0.5)
		dot.Position = UDim2.fromScale(
			((i * 37) % 90 + 5) / 100,
			((i * 61) % 90 + 5) / 100
		)
		dot.Size = UDim2.fromOffset(i % 3 + 1, i % 3 + 1)
		dot.BackgroundColor3 = RED
		dot.BackgroundTransparency = 0.25
		dot.BorderSizePixel = 0
		dot.ZIndex = 2
		dot.Parent = BG

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = dot
	end

	-- TITLE
	local Title = Instance.new("TextLabel")
	Title.AnchorPoint = Vector2.new(0.5, 0.5)
	Title.Position = UDim2.fromScale(0.5, 0.66)
	Title.Size = UDim2.fromScale(0.94, 0.085)
	Title.BackgroundTransparency = 1
	Title.Text = "A S U K A   O N   T O P"
	Title.TextColor3 = BRIGHT_RED
	Title.Font = Enum.Font.GothamBlack
	Title.TextScaled = true
	Title.TextTransparency = 1
	Title.ZIndex = 5
	Title.Parent = BG

	-- SUBTITLE
	local Subtitle = Instance.new("TextLabel")
	Subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
	Subtitle.Position = UDim2.fromScale(0.5, 0.72)
	Subtitle.Size = UDim2.fromScale(0.7, 0.035)
	Subtitle.BackgroundTransparency = 1
	Subtitle.Text = "Y A D S A N   X   L U F F Y"
	Subtitle.TextColor3 = RED
	Subtitle.Font = Enum.Font.GothamMedium
	Subtitle.TextScaled = true
	Subtitle.TextTransparency = 1
	Subtitle.ZIndex = 5
	Subtitle.Parent = BG

	-- STATUS
	local Status = Instance.new("TextLabel")
	Status.AnchorPoint = Vector2.new(0.5, 0.5)
	Status.Position = UDim2.fromScale(0.5, 0.84)
	Status.Size = UDim2.fromScale(0.8, 0.035)
	Status.BackgroundTransparency = 1
	Status.Text = "INITIALIZING SYSTEMS..."
	Status.TextColor3 = RED
	Status.Font = Enum.Font.Gotham
	Status.TextScaled = true
	Status.TextTransparency = 0
	Status.ZIndex = 5
	Status.Parent = BG

	-- PROGRESS BAR
	local BarBG = Instance.new("Frame")
	BarBG.AnchorPoint = Vector2.new(0.5, 0.5)
	BarBG.Position = UDim2.fromScale(0.5, 0.91)
	BarBG.Size = UDim2.fromScale(0.58, 0.009)
	BarBG.BackgroundColor3 = Color3.fromRGB(50, 8, 12)
	BarBG.BorderSizePixel = 0
	BarBG.ZIndex = 5
	BarBG.Parent = BG

	local Bar = Instance.new("Frame")
	Bar.Size = UDim2.fromScale(0, 1)
	Bar.BackgroundColor3 = BRIGHT_RED
	Bar.BorderSizePixel = 0
	Bar.ZIndex = 5
	Bar.Parent = BarBG

	-- ANIMATION
	Tween(Title, 1.2, {
		TextTransparency = 0
	})

	Tween(Subtitle, 1.5, {
		TextTransparency = 0
	})

	Tween(Bar, DURATION, {
		Size = UDim2.fromScale(1, 1)
	})

	local messages = {
		"INITIALIZING ASUKA SYSTEMS...",
		"CONNECTING TO ASUKA HUB...",
		"YADSAN X LUFFY...",
		"ASUKA ON TOP XD",
		"LOADING COMPLETE"
	}

	for _, message in ipairs(messages) do
		Status.Text = message
		task.wait(DURATION / #messages)
	end

	-- FADE TRANSITION
	rainActive = false
	for _, object in ipairs(Gui:GetDescendants()) do
		if object:IsA("GuiObject") then
			local properties = {
				BackgroundTransparency = 1
			}

			if object:IsA("TextLabel") then
				properties.TextTransparency = 1
			end

			Tween(object, 0.7, properties)
		elseif object:IsA("UIStroke") then
			Tween(object, 0.7, {
				Transparency = 1
			})
		end
	end

	task.wait(0.8)
	if camConn then camConn:Disconnect() end
	if vpConn then vpConn:Disconnect() end
	Gui:Destroy()
end
