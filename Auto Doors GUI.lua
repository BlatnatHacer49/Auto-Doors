local DOORSEntityDetector = Instance.new("ScreenGui")
local MainWindow = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Header = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local TitleLine = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Description = Instance.new("TextLabel")
local Resize = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Minimize = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local Close = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local SelectedTab = Instance.new("Frame")
local EntitiesPage = Instance.new("ScrollingFrame")
local EntityOutlinesModule = Instance.new("Frame")
local ModuleText = Instance.new("TextLabel")
local ModuleCheckbox = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local UICorner_8 = Instance.new("UICorner")
local UIStroke_2 = Instance.new("UIStroke")
local SectionEntityDetection = Instance.new("TextLabel")
local EntityListModule = Instance.new("TextButton")
local UICorner_9 = Instance.new("UICorner")
local Arrow = Instance.new("TextLabel")
local Dropdown = Instance.new("ScrollingFrame")
local UICorner_10 = Instance.new("UICorner")
local NameTagModule = Instance.new("TextButton")
local UICorner_11 = Instance.new("UICorner")
local Arrow_2 = Instance.new("TextLabel")
local Dropdown_2 = Instance.new("ScrollingFrame")
local UICorner_12 = Instance.new("UICorner")
local AutomationPage = Instance.new("ScrollingFrame")
local SectionAutomation = Instance.new("TextLabel")
local Tabs = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local Entities = Instance.new("TextButton")
local UICorner_13 = Instance.new("UICorner")
local Automation = Instance.new("TextButton")
local UICorner_14 = Instance.new("UICorner")
local Notifications = Instance.new("Frame")
local UIListLayout_2 = Instance.new("UIListLayout")
local CloseConfirmation = Instance.new("Frame")
local UIStroke_3 = Instance.new("UIStroke")
local UICorner_15 = Instance.new("UICorner")
local ConfirmationText = Instance.new("TextLabel")
local ConfirmationExplanation = Instance.new("TextLabel")
local Cancel = Instance.new("TextButton")
local UICorner_16 = Instance.new("UICorner")
local CloseScript = Instance.new("TextButton")
local UICorner_17 = Instance.new("UICorner")

local C = {
    Background = Color3.fromRGB(17, 19, 27),
    Panel = Color3.fromRGB(22, 24, 33),
    Surface = Color3.fromRGB(29, 32, 43),
    SurfaceHover = Color3.fromRGB(39, 42, 55),
    RedDark = Color3.fromRGB(255, 39, 52),
    RedHover = Color3.fromRGB(255, 73, 84),
    White = Color3.fromRGB(255, 255, 255),
    UIStroke1 = Color3.fromRGB(67, 73, 91),
    SecondaryText = Color3.fromRGB(157, 163, 180),
    Black = Color3.fromRGB(0, 0, 0),
}

--Properties:

DOORSEntityDetector.Name = "DOORSEntityDetector"
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

DOORSEntityDetector.Parent = LocalPlayer:WaitForChild("PlayerGui")
DOORSEntityDetector.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
DOORSEntityDetector.DisplayOrder = 9999
DOORSEntityDetector.ResetOnSpawn = false

MainWindow.Name = "MainWindow"
MainWindow.Parent = DOORSEntityDetector
MainWindow.BackgroundColor3 = C.Background
MainWindow.BorderSizePixel = 0
MainWindow.ClipsDescendants = true
MainWindow.Position = UDim2.new(0, 350, 0, 1)
MainWindow.Size = UDim2.new(0, 430, 0, 600)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainWindow

UIStroke.Color = C.UIStroke1
UIStroke.Thickness = 1
UIStroke.Parent = MainWindow

Header.Name = "Header"
Header.Parent = MainWindow
Header.BackgroundColor3 = C.Panel
Header.BorderSizePixel = 0
Header.Size = UDim2.new(0, 430, 0, 60)

UICorner_2.CornerRadius = UDim.new(0, 10)
UICorner_2.Parent = Header

TitleLine.Name = "TitleLine"
TitleLine.Parent = Header
TitleLine.BackgroundColor3 = C.RedHover
TitleLine.BorderColor3 = C.RedHover
TitleLine.BorderSizePixel = 0
TitleLine.Position = UDim2.new(0, 0, 0, 8)
TitleLine.Size = UDim2.new(0, 4, 0, 48)

UICorner_3.CornerRadius = UDim.new(0, 2)
UICorner_3.Parent = TitleLine

Title.Name = "Title"
Title.Parent = Header
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 17, 0, 7)
Title.Size = UDim2.new(1, -150, 0, 27)
Title.Font = Enum.Font.GothamBold
Title.Text = "AUTO DOORS"
Title.TextColor3 = C.White
Title.TextSize = 19.000
Title.TextXAlignment = Enum.TextXAlignment.Left

Description.Name = "Description"
Description.Parent = Header
Description.BackgroundTransparency = 1.000
Description.Position = UDim2.new(0, 18, 0, 34)
Description.Size = UDim2.new(1, -150, 0, 16)
Description.Font = Enum.Font.GothamMedium
Description.Text = "ENTITY DETECTION  /  AUTOMATION"
Description.TextColor3 = C.SecondaryText
Description.TextSize = 9.000
Description.TextXAlignment = Enum.TextXAlignment.Left

Resize.Name = "Resize"
Resize.Parent = Header
Resize.BackgroundColor3 = C.Surface
Resize.BorderSizePixel = 0
Resize.Position = UDim2.new(0, 355, 0, 15)
Resize.Size = UDim2.new(0, 30, 0, 30)
Resize.AutoButtonColor = false
Resize.Font = Enum.Font.GothamBold
Resize.Text = "▢"
Resize.TextColor3 = C.White
Resize.TextSize = 15.000

UICorner_4.Parent = Resize

Minimize.Name = "Minimize"
Minimize.Parent = Header
Minimize.BackgroundColor3 = C.Surface
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0, 320, 0, 15)
Minimize.Size = UDim2.new(0, 30, 0, 30)
Minimize.AutoButtonColor = false
Minimize.Font = Enum.Font.GothamMedium
Minimize.Text = "—"
Minimize.TextColor3 = C.White
Minimize.TextSize = 15.000

UICorner_5.Parent = Minimize

Close.Name = "Close"
Close.Parent = Header
Close.BackgroundColor3 = C.RedDark
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0, 390, 0, 15)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.AutoButtonColor = false
Close.Font = Enum.Font.Gotham
Close.Text = "×"
Close.TextColor3 = C.White
Close.TextSize = 40.000

UICorner_6.Parent = Close

SelectedTab.Name = "SelectedTab"
SelectedTab.Parent = MainWindow
SelectedTab.BackgroundTransparency = 1.000
SelectedTab.Position = UDim2.new(0, 15, 0, 120)
SelectedTab.Size = UDim2.new(0, 400, 0, 440)

EntitiesPage.Name = "EntitiesPage"
EntitiesPage.Parent = SelectedTab
EntitiesPage.BackgroundTransparency = 1.000
EntitiesPage.BorderSizePixel = 0
EntitiesPage.Size = UDim2.new(1, 0, 1, 0)
EntitiesPage.Visible = false
EntitiesPage.CanvasSize = UDim2.new(0, 0, 0, 0)
EntitiesPage.ScrollBarThickness = 4

EntityOutlinesModule.Name = "EntityOutlinesModule"
EntityOutlinesModule.Parent = EntitiesPage
EntityOutlinesModule.BackgroundColor3 = C.Panel
EntityOutlinesModule.BorderSizePixel = 0
EntityOutlinesModule.Position = UDim2.new(0, 1, 0, 135)
EntityOutlinesModule.Size = UDim2.new(0, 398, 0, 50)

ModuleText.Name = "ModuleText"
ModuleText.Parent = EntityOutlinesModule
ModuleText.BackgroundTransparency = 1.000
ModuleText.Position = UDim2.new(0, 12, 0, 0)
ModuleText.Size = UDim2.new(1, -70, 1, 0)
ModuleText.Font = Enum.Font.GothamMedium
ModuleText.Text = "Entity Outlines"
ModuleText.TextColor3 = C.White
ModuleText.TextSize = 15.000
ModuleText.TextXAlignment = Enum.TextXAlignment.Left

ModuleCheckbox.Name = "ModuleCheckbox"
ModuleCheckbox.Parent = EntityOutlinesModule
ModuleCheckbox.BackgroundColor3 = C.RedDark
ModuleCheckbox.BorderSizePixel = 0
ModuleCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
ModuleCheckbox.Size = UDim2.new(0, 26, 0, 26)
ModuleCheckbox.AutoButtonColor = false
ModuleCheckbox.Font = Enum.Font.GothamMedium
ModuleCheckbox.Text = "✓"
ModuleCheckbox.TextColor3 = C.White
ModuleCheckbox.TextSize = 15.000

UICorner_7.Parent = ModuleCheckbox

UICorner_8.Parent = EntityOutlinesModule

UIStroke_2.Color = C.UIStroke1
UIStroke_2.Thickness = 1
UIStroke_2.Parent = EntityOutlinesModule

SectionEntityDetection.Name = "SectionEntityDetection"
SectionEntityDetection.Parent = EntitiesPage
SectionEntityDetection.BackgroundTransparency = 1.000
SectionEntityDetection.Size = UDim2.new(0, 400, 0, 15)
SectionEntityDetection.Font = Enum.Font.GothamBold
SectionEntityDetection.Text = "Entity Detection:"
SectionEntityDetection.TextColor3 = C.RedHover
SectionEntityDetection.TextSize = 14.000
SectionEntityDetection.TextXAlignment = Enum.TextXAlignment.Left

EntityListModule.Name = "EntityListModule"
EntityListModule.Parent = EntitiesPage
EntityListModule.BackgroundColor3 = C.Surface
EntityListModule.BorderSizePixel = 0
EntityListModule.Position = UDim2.new(0, 0, 0, 25)
EntityListModule.Size = UDim2.new(0, 400, 0, 45)
EntityListModule.ZIndex = 2
EntityListModule.AutoButtonColor = false
EntityListModule.Font = Enum.Font.GothamMedium
EntityListModule.Text = "  Entities Detected:"
EntityListModule.TextColor3 = C.White
EntityListModule.TextSize = 15.000
EntityListModule.TextXAlignment = Enum.TextXAlignment.Left

UICorner_9.Parent = EntityListModule

Arrow.Name = "Arrow"
Arrow.Parent = EntityListModule
Arrow.AnchorPoint = Vector2.new(1, 0.5)
Arrow.BackgroundTransparency = 1.000
Arrow.Position = UDim2.new(1, -3, 0.75, 0)
Arrow.Size = UDim2.new(0, 25, 0, 30)
Arrow.Font = Enum.Font.GothamBold
Arrow.Text = "ꜜ"
Arrow.TextColor3 = C.White
Arrow.TextSize = 30.000
Arrow.TextXAlignment = Enum.TextXAlignment.Left

Dropdown.Name = "Dropdown"
Dropdown.Parent = EntityListModule
Dropdown.Active = true
Dropdown.BackgroundColor3 = C.Surface
Dropdown.BorderColor3 = C.Black
Dropdown.BorderSizePixel = 0
Dropdown.Position = UDim2.new(0, 0, 0, 39)
Dropdown.Size = UDim2.new(0, 400, 0, 250)
Dropdown.Visible = false

UICorner_10.CornerRadius = UDim.new(0, 0)
UICorner_10.Parent = Dropdown

NameTagModule.Name = "NameTagModule"
NameTagModule.Parent = EntitiesPage
NameTagModule.BackgroundColor3 = C.Surface
NameTagModule.BorderSizePixel = 0
NameTagModule.Position = UDim2.new(0, 0, 0, 80)
NameTagModule.Size = UDim2.new(0, 400, 0, 45)
NameTagModule.AutoButtonColor = false
NameTagModule.Font = Enum.Font.GothamMedium
NameTagModule.Text = "  Name Tags: Recommended"
NameTagModule.TextColor3 = C.White
NameTagModule.TextSize = 15.000
NameTagModule.TextXAlignment = Enum.TextXAlignment.Left

UICorner_11.Parent = NameTagModule

Arrow_2.Name = "Arrow"
Arrow_2.Parent = NameTagModule
Arrow_2.AnchorPoint = Vector2.new(1, 0.5)
Arrow_2.BackgroundTransparency = 1.000
Arrow_2.Position = UDim2.new(1, -3, 0.75, 0)
Arrow_2.Size = UDim2.new(0, 25, 0, 30)
Arrow_2.Font = Enum.Font.GothamBold
Arrow_2.Text = "ꜜ"
Arrow_2.TextColor3 = C.White
Arrow_2.TextSize = 30.000
Arrow_2.TextXAlignment = Enum.TextXAlignment.Left

Dropdown_2.Name = "Dropdown"
Dropdown_2.Parent = NameTagModule
Dropdown_2.Active = true
Dropdown_2.BackgroundColor3 = C.Surface
Dropdown_2.BorderColor3 = C.Black
Dropdown_2.BorderSizePixel = 0
Dropdown_2.Position = UDim2.new(0, 0, 0, 39)
Dropdown_2.Size = UDim2.new(0, 400, 0, 250)
Dropdown_2.Visible = false

UICorner_12.CornerRadius = UDim.new(0, 0)
UICorner_12.Parent = Dropdown_2

AutomationPage.Name = "AutomationPage"
AutomationPage.Parent = SelectedTab
AutomationPage.BackgroundTransparency = 1.000
AutomationPage.BorderSizePixel = 0
AutomationPage.Size = UDim2.new(1, 0, 1, 0)
AutomationPage.CanvasSize = UDim2.new(0, 0, 0, 0)
AutomationPage.ScrollBarThickness = 4

SectionAutomation.Name = "SectionAutomation"
SectionAutomation.Parent = AutomationPage
SectionAutomation.BackgroundTransparency = 1.000
SectionAutomation.Size = UDim2.new(0, 400, 0, 15)
SectionAutomation.Font = Enum.Font.GothamBold
SectionAutomation.Text = "Automation:"
SectionAutomation.TextColor3 = C.RedHover
SectionAutomation.TextSize = 14.000
SectionAutomation.TextXAlignment = Enum.TextXAlignment.Left

Tabs.Name = "Tabs"
Tabs.Parent = MainWindow
Tabs.BackgroundTransparency = 1.000
Tabs.Position = UDim2.new(0, 15, 0, 70)
Tabs.Size = UDim2.new(0, 400, 0, 40)

UIListLayout.Parent = Tabs
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.Padding = UDim.new(0, 8)

Entities.Name = "Entities"
Entities.Parent = Tabs
Entities.BackgroundColor3 = C.Surface
Entities.BorderColor3 = C.Surface
Entities.BorderSizePixel = 0
Entities.Size = UDim2.new(0.5, -4, 1, 0)
Entities.AutoButtonColor = false
Entities.Font = Enum.Font.GothamMedium
Entities.Text = "Entities"
Entities.TextColor3 = C.White
Entities.TextSize = 15.000

UICorner_13.Parent = Entities

Automation.Name = "Automation"
Automation.Parent = Tabs
Automation.BackgroundColor3 = C.Surface
Automation.BorderColor3 = C.Surface
Automation.BorderSizePixel = 0
Automation.Size = UDim2.new(0.5, -4, 1, 0)
Automation.AutoButtonColor = false
Automation.Font = Enum.Font.GothamMedium
Automation.Text = "Automation"
Automation.TextColor3 = C.White
Automation.TextSize = 15.000

UICorner_14.Parent = Automation

Notifications.Name = "Notifications"
Notifications.Parent = DOORSEntityDetector
Notifications.AnchorPoint = Vector2.new(1, 0)
Notifications.BackgroundTransparency = 1.000
Notifications.Position = UDim2.new(1, -22, 0, 22)
Notifications.Size = UDim2.new(0, 320, 0, 390)

UIListLayout_2.Parent = Notifications
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout_2.Padding = UDim.new(0, 9)

CloseConfirmation.Name = "CloseConfirmation"
CloseConfirmation.Parent = DOORSEntityDetector
CloseConfirmation.AnchorPoint = Vector2.new(0.5, 0.5)
CloseConfirmation.BackgroundColor3 = C.Panel
CloseConfirmation.BorderSizePixel = 0
CloseConfirmation.Position = UDim2.new(0.5, 0, 0.5, 0)
CloseConfirmation.Size = UDim2.new(0, 310, 0, 145)
CloseConfirmation.Visible = false
CloseConfirmation.ZIndex = 20

UIStroke_3.Color = C.RedHover
UIStroke_3.Thickness = 1
UIStroke_3.Parent = CloseConfirmation

UICorner_15.CornerRadius = UDim.new(0, 10)
UICorner_15.Parent = CloseConfirmation

ConfirmationText.Name = "ConfirmationText"
ConfirmationText.Parent = CloseConfirmation
ConfirmationText.BackgroundTransparency = 1.000
ConfirmationText.Position = UDim2.new(0, 14, 0, 12)
ConfirmationText.Size = UDim2.new(1, -28, 0, 25)
ConfirmationText.ZIndex = 21
ConfirmationText.Font = Enum.Font.GothamBold
ConfirmationText.Text = "Close Auto Doors?"
ConfirmationText.TextColor3 = C.White
ConfirmationText.TextSize = 15.000
ConfirmationText.TextXAlignment = Enum.TextXAlignment.Left

ConfirmationExplanation.Name = "ConfirmationExplanation"
ConfirmationExplanation.Parent = CloseConfirmation
ConfirmationExplanation.BackgroundTransparency = 1.000
ConfirmationExplanation.Position = UDim2.new(0, 14, 0, 40)
ConfirmationExplanation.Size = UDim2.new(1, -28, 0, 32)
ConfirmationExplanation.ZIndex = 21
ConfirmationExplanation.Font = Enum.Font.Gotham
ConfirmationExplanation.Text = "This will stop detection and remove all script visuals."
ConfirmationExplanation.TextColor3 = C.SecondaryText
ConfirmationExplanation.TextSize = 11.000
ConfirmationExplanation.TextWrapped = true
ConfirmationExplanation.TextXAlignment = Enum.TextXAlignment.Left

Cancel.Name = "Cancel"
Cancel.Parent = CloseConfirmation
Cancel.BackgroundColor3 = C.Surface
Cancel.BorderSizePixel = 0
Cancel.Position = UDim2.new(0, 14, 1, -45)
Cancel.Size = UDim2.new(0.5, -21, 0, 32)
Cancel.ZIndex = 21
Cancel.AutoButtonColor = false
Cancel.Font = Enum.Font.GothamMedium
Cancel.Text = "Cancel"
Cancel.TextColor3 = C.White
Cancel.TextSize = 15.000

UICorner_16.Parent = Cancel

CloseScript.Name = "CloseScript"
CloseScript.Parent = CloseConfirmation
CloseScript.BackgroundColor3 = C.RedDark
CloseScript.BorderSizePixel = 0
CloseScript.Position = UDim2.new(0.5, 7, 1, -45)
CloseScript.Size = UDim2.new(0.5, -21, 0, 32)
CloseScript.ZIndex = 21
CloseScript.AutoButtonColor = false
CloseScript.Font = Enum.Font.GothamMedium
CloseScript.Text = "Close Script"
CloseScript.TextColor3 = C.White
CloseScript.TextSize = 15.000

UICorner_17.Parent = CloseScript
-- Standalone GUI behavior. Entity detection stays in the separate main script.
local UserInputService = game:GetService("UserInputService")
local guiConnections = {}
local function guiConnect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(guiConnections, connection)
    return connection
end

local OutlineChanged = Instance.new("BindableEvent")
local UnloadRequested = Instance.new("BindableEvent")
local outlineEnabled = true
local outlineHovering = false
local function setOutlineEnabled(enabled)
    outlineEnabled = enabled and true or false
    ModuleCheckbox.Text = outlineEnabled and "✓" or ""
    if outlineEnabled then
        ModuleCheckbox.BackgroundColor3 = outlineHovering and C.RedHover or C.RedDark
    else
        ModuleCheckbox.BackgroundColor3 = outlineHovering and C.SurfaceHover or C.Background
    end
end

-- Window sizing and minimize controls.
local fullSize = MainWindow.Size
local smallSize = UDim2.new(fullSize.X.Scale, fullSize.X.Offset, 0, Header.Size.Y.Offset)
local shrunk = false
guiConnect(Resize.MouseButton1Click, function()
    shrunk = not shrunk
    MainWindow.Size = shrunk and smallSize or fullSize
    Resize.Text = shrunk and "□" or "▢"
end)
guiConnect(Minimize.MouseButton1Click, function()
    MainWindow.Visible = false
end)
guiConnect(UserInputService.InputBegan, function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.F1 then
        MainWindow.Visible = not MainWindow.Visible
    end
end)

-- Dragging is owned by the GUI, not the entity module.
do
    local dragging, dragStart, startPosition = false, nil, nil
    guiConnect(Header.InputBegan, function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local p = input.Position
        local function inside(buttonObject)
            local pos, size = buttonObject.AbsolutePosition, buttonObject.AbsoluteSize
            return p.X >= pos.X and p.X <= pos.X + size.X and p.Y >= pos.Y and p.Y <= pos.Y + size.Y
        end
        if inside(Resize) or inside(Minimize) or inside(Close) then return end
        dragging = true
        dragStart = p
        startPosition = MainWindow.Position
    end)
    guiConnect(UserInputService.InputChanged, function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainWindow.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X,
                startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
        end
    end)
    guiConnect(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

-- Tab navigation.
local selectedTab = "Entities"
local function switchTab(which)
    selectedTab = which
    local showEntities = which == "Entities"
    EntitiesPage.Visible = showEntities
    AutomationPage.Visible = not showEntities
    Entities.BackgroundColor3 = showEntities and C.RedDark or C.Surface
    Automation.BackgroundColor3 = (not showEntities) and C.RedDark or C.Surface
end
guiConnect(Entities.MouseButton1Click, function() switchTab("Entities") end)
guiConnect(Automation.MouseButton1Click, function() switchTab("Automation") end)
switchTab("Entities")

-- All button hover styling lives here. The two dropdown headers are hover-only;
-- their dropdown behavior is intentionally not implemented.
local function wireHover(buttonObject, baseColor, hoverColor)
    if not buttonObject or not buttonObject:IsA("TextButton") then return end
    local base = baseColor or buttonObject.BackgroundColor3
    local hover = hoverColor or C.SurfaceHover
    guiConnect(buttonObject.MouseEnter, function()
        if buttonObject == Entities then
            buttonObject.BackgroundColor3 = selectedTab == "Entities" and C.RedHover or hover
        elseif buttonObject == Automation then
            buttonObject.BackgroundColor3 = selectedTab == "Automation" and C.RedHover or hover
        elseif buttonObject == ModuleCheckbox then
            outlineHovering = true
            setOutlineEnabled(outlineEnabled)
        else
            buttonObject.BackgroundColor3 = hover
        end
    end)
    guiConnect(buttonObject.MouseLeave, function()
        if buttonObject == Entities then
            buttonObject.BackgroundColor3 = selectedTab == "Entities" and C.RedDark or C.Surface
        elseif buttonObject == Automation then
            buttonObject.BackgroundColor3 = selectedTab == "Automation" and C.RedDark or C.Surface
        elseif buttonObject == ModuleCheckbox then
            outlineHovering = false
            setOutlineEnabled(outlineEnabled)
        else
            buttonObject.BackgroundColor3 = base
        end
    end)
end

for _, object in ipairs(DOORSEntityDetector:GetDescendants()) do
    if object:IsA("TextButton") and object ~= ModuleCheckbox then
        if object == Close or object == CloseScript then
            wireHover(object, object.BackgroundColor3, C.RedHover)
        else
            wireHover(object)
        end
    end
end
wireHover(ModuleCheckbox)

-- The checkbox updates its own appearance and notifies the optional entity module.
setOutlineEnabled(true)
guiConnect(ModuleCheckbox.MouseButton1Click, function()
    setOutlineEnabled(not outlineEnabled)
    OutlineChanged:Fire(outlineEnabled)
end)

-- Closing the GUI is independent. If the main entity module is listening, it can
-- remove highlights/tags first; otherwise this still closes as a standalone GUI.
guiConnect(Close.MouseButton1Click, function()
    CloseConfirmation.Visible = true
end)
guiConnect(Cancel.MouseButton1Click, function()
    CloseConfirmation.Visible = false
end)
guiConnect(CloseScript.MouseButton1Click, function()
    UnloadRequested:Fire()
    for _, connection in ipairs(guiConnections) do
        pcall(function() connection:Disconnect() end)
    end
    DOORSEntityDetector:Destroy()
end)

return {
    ScreenGui = DOORSEntityDetector,
    MainWindow = MainWindow,

    -- Window controls
    Resize = Resize,
    Minimize = Minimize,
    Close = Close,
    CloseConfirmation = CloseConfirmation,
    CancelClose = Cancel,
    ConfirmClose = CloseScript,

    -- Tabs
    EntitiesTab = Entities,
    AutomationTab = Automation,
    EntitiesPage = EntitiesPage,
    AutomationPage = AutomationPage,

    -- Entity settings and integration events
    EntityListModule = EntityListModule,
    NameTagModule = NameTagModule,
    EntityOutlinesModule = EntityOutlinesModule,
    OutlineToggle = ModuleCheckbox,
    OutlineChanged = OutlineChanged,
    UnloadRequested = UnloadRequested,
    SetOutlineEnabled = setOutlineEnabled,

    -- Notifications
    Notifications = Notifications,
}
