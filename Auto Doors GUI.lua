-- UI construction
local function buildGUI(entityDefinitions, enabledEntities, initialNameTagMode)
    local standaloneEntities = {
        {name = "Test1",  display = "Test 1"},
        {name = "Test2",  display = "Test 2"},
        {name = "Test3",  display = "Test 3"},
        {name = "Test4",  display = "Test 4"},
        {name = "Test5",  display = "Test 5"},
        {name = "Test6",  display = "Test 6"},
        {name = "Test7",  display = "Test 7"},
        {name = "Test8",  display = "Test 8"},
        {name = "Test9",  display = "Test 9"},
        {name = "Test10", display = "Test 10"},
    }
    entityDefinitions = type(entityDefinitions) == "table" and entityDefinitions or standaloneEntities
    local DOORSEntityDetector = Instance.new("ScreenGui")
    local MainWindow = Instance.new("Frame")

    local Header = Instance.new("Frame")
    local TitleLine = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Description = Instance.new("TextLabel")
    local Resize = Instance.new("TextButton")
    local Minimize = Instance.new("TextButton")
    local Close = Instance.new("TextButton")

    local SelectedTab = Instance.new("Frame")
    local EntitiesPage = Instance.new("ScrollingFrame")
    local EntityOutlinesModule = Instance.new("Frame")
    local ModuleText = Instance.new("TextLabel")
    local ModuleCheckbox = Instance.new("TextButton")
    local SectionEntityDetection = Instance.new("TextLabel")
    local EntityListModule = Instance.new("TextButton")
    local Arrow = Instance.new("TextLabel")
    local Dropdown = Instance.new("ScrollingFrame")
    local NameTagModule = Instance.new("TextButton")
    local Arrow_2 = Instance.new("TextLabel")
    local Dropdown_2 = Instance.new("ScrollingFrame")

    local AutomationPage = Instance.new("ScrollingFrame")
    local SectionAutomation = Instance.new("TextLabel")

    local Tabs = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local Entities = Instance.new("TextButton")
    local Automation = Instance.new("TextButton")

    local Notifications = Instance.new("Frame")
    local UIListLayout_2 = Instance.new("UIListLayout")

    local CloseConfirmation = Instance.new("Frame")
    local ConfirmationText = Instance.new("TextLabel")
    local ConfirmationExplanation = Instance.new("TextLabel")
    local Cancel = Instance.new("TextButton")
    local CloseScript = Instance.new("TextButton")

    local C = {
        Background = Color3.fromRGB(17, 19, 27),
        Panel = Color3.fromRGB(22, 24, 33),
        Surface = Color3.fromRGB(29, 32, 43),
        SurfaceHover = Color3.fromRGB(39, 42, 55),
        Red = Color3.fromRGB(255, 73, 84),
        RedHover = Color3.fromRGB(255, 102, 111),
        White = Color3.fromRGB(255, 255, 255),
        UIStroke1 = Color3.fromRGB(67, 73, 91),
        SecondaryText = Color3.fromRGB(157, 163, 180),
        Black = Color3.fromRGB(0, 0, 0),
    }

    local CoreGui = game:GetService("CoreGui")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    for _, root in ipairs({CoreGui, PlayerGui}) do
        local previousGui = root:FindFirstChild("DOORSEntityDetector")
        if previousGui then
            previousGui:Destroy()
        end
    end

    local function addCorner(parent, topLeft, topRight, bottomLeft, bottomRight)
        local corner = Instance.new("UICorner")
        corner.BottomLeftRadius = UDim.new(0, bottomLeft)
        corner.BottomRightRadius = UDim.new(0, bottomRight)
        corner.TopLeftRadius = UDim.new(0, topLeft)
        corner.TopRightRadius = UDim.new(0, topRight)
        corner.Parent = parent
        return corner
    end

    local function addStroke(parent, color, thickness)
        local stroke = Instance.new("UIStroke")
        stroke.Color = color
        stroke.Thickness = thickness
        stroke.Parent = parent
        return stroke
    end

    DOORSEntityDetector.Name = "DOORSEntityDetector"
    DOORSEntityDetector.Parent = CoreGui
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

    addCorner(MainWindow, 10, 10, 10, 10)

    addStroke(MainWindow, C.UIStroke1, 1)

    Header.Name = "Header"
    Header.Parent = MainWindow
    Header.BackgroundColor3 = C.Panel
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(0, 430, 0, 60)

    addCorner(Header, 10, 10, 0, 0)

    TitleLine.Name = "TitleLine"
    TitleLine.Parent = Header
    TitleLine.BackgroundColor3 = C.RedHover
    TitleLine.BorderColor3 = C.RedHover
    TitleLine.BorderSizePixel = 0
    TitleLine.Position = UDim2.new(0, 0, 0, 8)
    TitleLine.Size = UDim2.new(0, 4, 0, 48)

    addCorner(TitleLine, 2, 2, 2, 2)

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

    addCorner(Resize, 8, 8, 8, 8)

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

    addCorner(Minimize, 8, 8, 8, 8)

    Close.Name = "Close"
    Close.Parent = Header
    Close.BackgroundColor3 = C.Red
    Close.BorderSizePixel = 0
    Close.Position = UDim2.new(0, 390, 0, 15)
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.AutoButtonColor = false
    Close.Font = Enum.Font.Gotham
    Close.Text = "×"
    Close.TextColor3 = C.White
    Close.TextSize = 40.000

    addCorner(Close, 8, 8, 8, 8)

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
    ModuleCheckbox.BackgroundColor3 = C.Red
    ModuleCheckbox.BorderSizePixel = 0
    ModuleCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ModuleCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ModuleCheckbox.AutoButtonColor = false
    ModuleCheckbox.Font = Enum.Font.GothamMedium
    ModuleCheckbox.Text = "✓"
    ModuleCheckbox.TextColor3 = C.White
    ModuleCheckbox.TextSize = 15.000

    addCorner(ModuleCheckbox, 8, 8, 8, 8)

    addCorner(EntityOutlinesModule, 8, 8, 8, 8)

    addStroke(EntityOutlinesModule, C.UIStroke1, 1)

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

    addCorner(EntityListModule, 8, 8, 8, 8)

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
    local DropdownClip = Instance.new("Frame")
    DropdownClip.Name = "DropdownClip"
    DropdownClip.Parent = EntityListModule
    DropdownClip.BackgroundTransparency = 1
    DropdownClip.BorderSizePixel = 0
    DropdownClip.ClipsDescendants = true
    DropdownClip.Position = UDim2.new(0, 0, 0, 45)
    DropdownClip.Size = UDim2.new(0, 400, 0, 0)
    DropdownClip.Visible = false
    DropdownClip.ZIndex = 3

    Dropdown.Parent = DropdownClip
    Dropdown.Active = true
    Dropdown.BackgroundColor3 = C.Surface
    Dropdown.BorderColor3 = C.Black
    Dropdown.BorderSizePixel = 0
    Dropdown.Position = UDim2.new(0, 0, 0, 0)
    Dropdown.Size = UDim2.new(0, 400, 0, 0)
    Dropdown.Visible = true

    addCorner(Dropdown, 0, 0, 8, 8)

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

    addCorner(NameTagModule, 8, 8, 8, 8)

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
    local DropdownClip_2 = Instance.new("Frame")
    DropdownClip_2.Name = "DropdownClip"
    DropdownClip_2.Parent = NameTagModule
    DropdownClip_2.BackgroundTransparency = 1
    DropdownClip_2.BorderSizePixel = 0
    DropdownClip_2.ClipsDescendants = true
    DropdownClip_2.Position = UDim2.new(0, 0, 0, 45)
    DropdownClip_2.Size = UDim2.new(0, 400, 0, 0)
    DropdownClip_2.Visible = false
    DropdownClip_2.ZIndex = 3

    Dropdown_2.Parent = DropdownClip_2
    Dropdown_2.Active = true
    Dropdown_2.BackgroundColor3 = C.Surface
    Dropdown_2.BorderColor3 = C.Black
    Dropdown_2.BorderSizePixel = 0
    Dropdown_2.Position = UDim2.new(0, 0, 0, 0)
    Dropdown_2.Size = UDim2.new(0, 400, 0, 0)
    Dropdown_2.Visible = true

    addCorner(Dropdown_2, 0, 0, 8, 8)

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

    addCorner(Entities, 8, 8, 8, 8)

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

    addCorner(Automation, 8, 8, 8, 8)

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

    addStroke(CloseConfirmation, C.RedHover, 1)

    addCorner(CloseConfirmation, 10, 10, 10, 10)

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

    addCorner(Cancel, 8, 8, 8, 8)

    CloseScript.Name = "CloseScript"
    CloseScript.Parent = CloseConfirmation
    CloseScript.BackgroundColor3 = C.Red
    CloseScript.BorderSizePixel = 0
    CloseScript.Position = UDim2.new(0.5, 7, 1, -45)
    CloseScript.Size = UDim2.new(0.5, -21, 0, 32)
    CloseScript.ZIndex = 21
    CloseScript.AutoButtonColor = false
    CloseScript.Font = Enum.Font.GothamMedium
    CloseScript.Text = "Close Script"
    CloseScript.TextColor3 = C.White
    CloseScript.TextSize = 15.000

    addCorner(CloseScript, 8, 8, 8, 8)

    -- Window controls and navigation
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
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
        ModuleCheckbox.BackgroundColor3 = outlineEnabled
            and (outlineHovering and C.RedHover or C.Red)
            or (outlineHovering and C.SurfaceHover or C.Background)
    end

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

    do
        local dragging, dragStart, startPosition = false, nil, nil
        guiConnect(Header.InputBegan, function(input)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end
            local p = input.Position
            local function inside(buttonObject)
                local pos, size = buttonObject.AbsolutePosition, buttonObject.AbsoluteSize
                return p.X >= pos.X and p.X <= pos.X + size.X and p.Y >= pos.Y and p.Y <= pos.Y + size.Y
            end
            if inside(Resize) or inside(Minimize) or inside(Close) then
                return
            end
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
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end

    local selectedTab = "Entities"
    local tabControls = {
        Entities = {button = Entities, page = EntitiesPage},
        Automation = {button = Automation, page = AutomationPage},
    }

    local function switchTab(which)
        selectedTab = which
        for name, control in pairs(tabControls) do
            local active = name == which
            control.page.Visible = active
            control.button.BackgroundColor3 = active and C.Red or C.Surface
        end
    end
    guiConnect(Entities.MouseButton1Click, function()
        switchTab("Entities")
    end)
    guiConnect(Automation.MouseButton1Click, function()
        switchTab("Automation")
    end)
    switchTab("Entities")

    local function wireHover(buttonObject, baseColor, hoverColor)
        if not buttonObject or not buttonObject:IsA("TextButton") then
            return
        end
        local base = baseColor or buttonObject.BackgroundColor3
        local hover = hoverColor or C.SurfaceHover
        local tabName = buttonObject == Entities and "Entities"
            or buttonObject == Automation and "Automation"

        guiConnect(buttonObject.MouseEnter, function()
            if tabName then
                buttonObject.BackgroundColor3 = selectedTab == tabName and C.RedHover or hover
            elseif buttonObject == ModuleCheckbox then
                outlineHovering = true
                setOutlineEnabled(outlineEnabled)
            else
                buttonObject.BackgroundColor3 = hover
            end
        end)
        guiConnect(buttonObject.MouseLeave, function()
            if tabName then
                buttonObject.BackgroundColor3 = selectedTab == tabName and C.Red or C.Surface
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

    setOutlineEnabled(true)
    guiConnect(ModuleCheckbox.MouseButton1Click, function()
        setOutlineEnabled(not outlineEnabled)
        OutlineChanged:Fire(outlineEnabled)
    end)

    -- Entity controls and dropdowns
    local EntityEnabledChanged = Instance.new("BindableEvent")
    local NameTagModeChanged = Instance.new("BindableEvent")
    local dropdownOpen = {
        Entities = false,
        NameTags = false,
    }
    local entityEnabledState = enabledEntities or {}
    for _, entity in ipairs(entityDefinitions) do
        if entityEnabledState[entity.name] == nil then
            entityEnabledState[entity.name] = true
        end
    end
    if entityEnabledState.__Portrait == nil then
        entityEnabledState.__Portrait = true
    end
    if entityEnabledState.HitByA90 == nil then
        entityEnabledState.HitByA90 = true
    end
    local nameTagMode = (initialNameTagMode == "All" or initialNameTagMode == "None")
        and initialNameTagMode
        or "Recommended"
    local entityListLayout, nameTagChoices

    local DROPDOWN_MAX_HEIGHT = 250
    local DROPDOWN_TWEEN_INFO = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local dropdownTweens = {}

    local originalParentCornerRadii = {}
    local parentCornerCache = {}

    local function setParentDropdownCorners(parent, isOpen)
        local corner = parentCornerCache[parent]
        if corner == nil then
            corner = parent:FindFirstChildOfClass("UICorner") or false
            parentCornerCache[parent] = corner
        end
        if corner == false then
            return
        end

        if originalParentCornerRadii[corner] == nil then
            originalParentCornerRadii[corner] = {
                BottomLeftRadius = corner.BottomLeftRadius,
                BottomRightRadius = corner.BottomRightRadius,
            }
        end

        if isOpen then
            corner.BottomLeftRadius = UDim.new(0, 0)
            corner.BottomRightRadius = UDim.new(0, 0)
        else
            local original = originalParentCornerRadii[corner]
            corner.BottomLeftRadius = original.BottomLeftRadius
            corner.BottomRightRadius = original.BottomRightRadius
        end
    end

    local function updateDropdownHeight(dropdown, layout)
        local contentHeight = layout.AbsoluteContentSize.Y + 4
        return math.clamp(contentHeight, 0, DROPDOWN_MAX_HEIGHT), contentHeight > DROPDOWN_MAX_HEIGHT
    end

    local function animateDropdown(dropdown, layout, clip, open, onClosed)
        if dropdownTweens[clip] then
            pcall(function()
                dropdownTweens[clip]:Cancel()
            end)
            dropdownTweens[clip] = nil
        end
        if open then
            local targetHeight, needsScrolling = updateDropdownHeight(dropdown, layout)
            dropdown.ScrollBarThickness = needsScrolling and 4 or 0
            dropdown.Size = UDim2.new(0, 400, 0, targetHeight)
            clip.Visible = true
            dropdownTweens[clip] = TweenService:Create(clip, DROPDOWN_TWEEN_INFO, {
                Size = UDim2.new(0, 400, 0, targetHeight)
            })
            dropdownTweens[clip]:Play()
        else
            local closingTween = TweenService:Create(clip, DROPDOWN_TWEEN_INFO, {
                Size = UDim2.new(0, 400, 0, 0)
            })
            dropdownTweens[clip] = closingTween
            local thisTween = closingTween
            thisTween.Completed:Connect(function(playbackState)
                if dropdownTweens[clip] == thisTween then
                    if playbackState == Enum.PlaybackState.Completed then
                        clip.Visible = false
                        dropdownTweens[clip] = nil
                        if onClosed then
                            onClosed()
                        end
                    end
                end
            end)
            closingTween:Play()
        end
    end


    -- Entity dropdown rows
    local function createEntityRow(entity, order)
        local row = Instance.new("Frame")
        row.Name = "EntityOption_" .. tostring(entity.name)
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.Size = UDim2.new(1, -8, 0, 34)
        row.LayoutOrder = order
        row.ZIndex = 4
        row.Parent = Dropdown
        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0, 5)
        rowCorner.Parent = row

        local optionLabel = Instance.new("TextLabel")
        optionLabel.Name = "EntityName"
        optionLabel.BackgroundTransparency = 1
        optionLabel.Position = UDim2.new(0, 10, 0, 0)
        optionLabel.Size = UDim2.new(1, -52, 1, 0)
        optionLabel.Font = Enum.Font.GothamMedium
        optionLabel.Text = tostring(entity.display or entity.name)
        optionLabel.TextColor3 = C.White
        optionLabel.TextSize = 14
        optionLabel.TextXAlignment = Enum.TextXAlignment.Left
        optionLabel.ZIndex = 5
        optionLabel.Parent = row

        local checkbox = Instance.new("TextButton")
        checkbox.Name = "EntityCheckbox"
        checkbox.BackgroundColor3 = C.Red
        checkbox.BorderSizePixel = 0
        checkbox.Position = UDim2.new(1, -36, 0.5, -13)
        checkbox.Size = UDim2.new(0, 26, 0, 26)
        checkbox.AutoButtonColor = false
        checkbox.Font = Enum.Font.GothamMedium
        checkbox.Text = "✓"
        checkbox.TextColor3 = C.White
        checkbox.TextSize = 15
        checkbox.ZIndex = 5
        checkbox.Parent = row
        local checkboxCorner = Instance.new("UICorner")
        checkboxCorner.CornerRadius = UDim.new(0, 6)
        checkboxCorner.Parent = checkbox

        local mainHovering = false
        local checkboxHovering = false

        local function updateEntityRow()
            local enabled = entityEnabledState[entity.name] ~= false
            local hovering = mainHovering or checkboxHovering
            optionLabel.TextColor3 = enabled and C.White or C.SecondaryText
            checkbox.Text = enabled and "✓" or ""
            row.BackgroundColor3 = C.SurfaceHover
            row.BackgroundTransparency = hovering and 0 or 1
            checkbox.BackgroundColor3 = checkboxHovering
                and (enabled and C.RedHover or C.SurfaceHover)
                or (enabled and C.Red or C.Background)
        end

        local function flip()
            entityEnabledState[entity.name] = not (entityEnabledState[entity.name] ~= false)
            updateEntityRow()
            EntityEnabledChanged:Fire(entity.name, entityEnabledState[entity.name])
        end
        local rowClickArea = Instance.new("TextButton")
        rowClickArea.Name = "RowClickArea"
        rowClickArea.BackgroundTransparency = 1
        rowClickArea.BorderSizePixel = 0
        rowClickArea.Text = ""
        rowClickArea.Size = UDim2.new(1, -42, 1, 0)
        rowClickArea.ZIndex = 5
        rowClickArea.Parent = row
        optionLabel.ZIndex = 6
        guiConnect(rowClickArea.MouseButton1Click, flip)
        guiConnect(checkbox.MouseButton1Click, flip)

        local function bindHoverState(target, stateName)
            guiConnect(target.MouseEnter, function()
                if stateName == "main" then
                    mainHovering = true
                else
                    checkboxHovering = true
                end
                updateEntityRow()
            end)
            guiConnect(target.MouseLeave, function()
                if stateName == "main" then
                    mainHovering = false
                else
                    checkboxHovering = false
                end
                updateEntityRow()
            end)
        end

        updateEntityRow()
        bindHoverState(rowClickArea, "main")
        bindHoverState(checkbox, "checkbox")
    end

    local function configureDropdownContent(dropdown)
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 2)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = dropdown

        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 0)
        padding.PaddingLeft = UDim.new(0, 2)
        padding.PaddingRight = UDim.new(0, 2)
        padding.Parent = dropdown

        dropdown.AutomaticCanvasSize = Enum.AutomaticSize.Y
        dropdown.CanvasSize = UDim2.new(0, 0, 0, 0)
        dropdown.ScrollBarThickness = 4
        dropdown.ScrollBarImageColor3 = C.Red
        dropdown.ZIndex = 3
        return layout
    end

    entityListLayout = configureDropdownContent(Dropdown)

    for order, entity in ipairs(entityDefinitions) do
        createEntityRow(entity, order)
    end

    nameTagChoices = configureDropdownContent(Dropdown_2)

    local dropdownControls = {
        Entities = {
            module = EntityListModule,
            arrow = Arrow,
            dropdown = Dropdown,
            clip = DropdownClip,
            layout = entityListLayout,
            other = "NameTags",
        },
        NameTags = {
            module = NameTagModule,
            arrow = Arrow_2,
            dropdown = Dropdown_2,
            clip = DropdownClip_2,
            layout = nameTagChoices,
            other = "Entities",
        },
    }

    local function setDropdownOpen(name, open)
        local control = dropdownControls[name]
        local isOpen = open == true
        dropdownOpen[name] = isOpen

        if isOpen then
            local other = dropdownControls[control.other]
            dropdownOpen[control.other] = false
            animateDropdown(other.dropdown, other.layout, other.clip, false, function()
                setParentDropdownCorners(other.module, false)
            end)
            other.arrow.Text = "ꜜ"
            setParentDropdownCorners(control.module, true)
        end

        animateDropdown(control.dropdown, control.layout, control.clip, isOpen, function()
            setParentDropdownCorners(control.module, false)
        end)
        control.arrow.Text = isOpen and "ꜛ" or "ꜜ"
    end

    local function setNameTagMode(mode)
        nameTagMode = mode
        NameTagModule.Text = "  Name Tags: " .. mode
        NameTagModeChanged:Fire(mode)
    end
    NameTagModule.Text = "  Name Tags: " .. nameTagMode
    for order, mode in ipairs({"All", "Recommended", "None"}) do
        local option = Instance.new("TextButton")
        option.Name = "NameTagOption_" .. mode
        option.BackgroundColor3 = C.Surface
        option.BorderSizePixel = 0
        option.Size = UDim2.new(1, -8, 0, 32)
        option.LayoutOrder = order
        option.AutoButtonColor = false
        option.Font = Enum.Font.GothamMedium
        option.Text = "  " .. mode
        option.TextColor3 = C.White
        option.TextSize = 14
        option.TextXAlignment = Enum.TextXAlignment.Left
        option.ZIndex = 4
        option.Parent = Dropdown_2
        local optionCorner = Instance.new("UICorner")
        optionCorner.CornerRadius = UDim.new(0, 5)
        optionCorner.Parent = option
        wireHover(option)
        guiConnect(option.MouseButton1Click, function()
            setNameTagMode(mode)
            setDropdownOpen("NameTags", false)
        end)
    end

    setParentDropdownCorners(EntityListModule, false)
    setParentDropdownCorners(NameTagModule, false)

    guiConnect(EntityListModule.MouseButton1Click, function()
        setDropdownOpen("Entities", not dropdownOpen.Entities)
    end)
    guiConnect(NameTagModule.MouseButton1Click, function()
        setDropdownOpen("NameTags", not dropdownOpen.NameTags)
    end)

    guiConnect(Close.MouseButton1Click, function()
        CloseConfirmation.Visible = true
    end)
    guiConnect(Cancel.MouseButton1Click, function()
        CloseConfirmation.Visible = false
    end)
    -- Unload and exported interface
    local function disconnectGuiConnections()
        for _, connection in ipairs(guiConnections) do
            pcall(function()
                connection:Disconnect()
            end)
        end
        table.clear(guiConnections)
    end

    guiConnect(CloseScript.MouseButton1Click, function()
        UnloadRequested:Fire()
        disconnectGuiConnections()
        task.defer(function()
            if DOORSEntityDetector and DOORSEntityDetector.Parent then
                DOORSEntityDetector:Destroy()
            end
        end)
    end)

    return {
        ScreenGui = DOORSEntityDetector,
        MainWindow = MainWindow,

        Resize = Resize,
        Minimize = Minimize,
        Close = Close,
        CloseConfirmation = CloseConfirmation,
        CancelClose = Cancel,
        ConfirmClose = CloseScript,

        EntitiesTab = Entities,
        AutomationTab = Automation,
        EntitiesPage = EntitiesPage,
        AutomationPage = AutomationPage,

        EntityListModule = EntityListModule,
        NameTagModule = NameTagModule,
        EntityOutlinesModule = EntityOutlinesModule,
        OutlineToggle = ModuleCheckbox,
        OutlineChanged = OutlineChanged,
        EntityEnabledChanged = EntityEnabledChanged,
        NameTagModeChanged = NameTagModeChanged,
        UnloadRequested = UnloadRequested,
        SetOutlineEnabled = setOutlineEnabled,

        Notifications = Notifications,
    }
end

local mainEntities, mainEnabledEntities, mainNameTagMode = ...
if mainEntities ~= nil then
    return buildGUI(mainEntities, mainEnabledEntities, mainNameTagMode)
end
return buildGUI()
