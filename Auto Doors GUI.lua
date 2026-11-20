local function buildGUI(entityDefinitions, enabledEntities, initialNameTagMode, initialFullbrightEnabled, itemDefinitions, enabledItems, initialItemOutlinesEnabled, initialAntiAFKEnabled)
    local standaloneEntities = {
        {name = "Test1", display = "Test 1"},
        {name = "Test2", display = "Test 2"},
        {name = "Test3", display = "Test 3"},
        {name = "Test4", display = "Test 4"},
        {name = "Test5", display = "Test 5"},
        {name = "Test6", display = "Test 6"},
        {name = "Test7", display = "Test 7"},
        {name = "Test8", display = "Test 8"},
        {name = "Test9", display = "Test 9"},
        {name = "Test10", display = "Test 10"},
    }
    entityDefinitions = type(entityDefinitions) == "table" and entityDefinitions or standaloneEntities
    local standaloneItems = {
        {name = "Test1", display = "Test 1"},
        {name = "Test2", display = "Test 2"},
        {name = "Test3", display = "Test 3"},
        {name = "Test4", display = "Test 4"},
        {name = "Test5", display = "Test 5"},
        {name = "Test6", display = "Test 6"},
        {name = "Test7", display = "Test 7"},
        {name = "Test8", display = "Test 8"},
        {name = "Test9", display = "Test 9"},
        {name = "Test10", display = "Test 10"},
    }
    itemDefinitions = type(itemDefinitions) == "table" and itemDefinitions or standaloneItems
    enabledItems = type(enabledItems) == "table" and enabledItems or {}

    local AutoDoors = Instance.new("ScreenGui")
    local MainWindow = Instance.new("Frame")
    local Header = Instance.new("Frame")
    local TitleLine = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Description = Instance.new("TextLabel")
    local Resize = Instance.new("TextButton")
    local Minimize = Instance.new("TextButton")
    local Close = Instance.new("TextButton")
    local SelectedTab = Instance.new("Frame")
    local DetectionPage = Instance.new("ScrollingFrame")
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
    local Detection = Instance.new("TextButton")
    local Automation = Instance.new("TextButton")
    local Notifications = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local CloseConfirmation = Instance.new("Frame")
    local ConfirmationText = Instance.new("TextLabel")
    local ConfirmationExplanation = Instance.new("TextLabel")
    local Cancel = Instance.new("TextButton")
    local CloseScript = Instance.new("TextButton")

    local ExtraControls = {
        MiscellaneousPage = Instance.new("ScrollingFrame"),
        SectionMiscellaneous = Instance.new("TextLabel"),
        FullbrightModule = Instance.new("Frame"),
        FullbrightText = Instance.new("TextLabel"),
        FullbrightCheckbox = Instance.new("TextButton"),
        SectionItemDetection = Instance.new("TextLabel"),
        ItemListModule = Instance.new("TextButton"),
        ItemArrow = Instance.new("TextLabel"),
        ItemDropdown = Instance.new("ScrollingFrame"),
        ItemOutlinesModule = Instance.new("Frame"),
        ItemOutlinesText = Instance.new("TextLabel"),
        ItemOutlinesCheckbox = Instance.new("TextButton"),
        ItemOutlineChanged = Instance.new("BindableEvent"),
        ItemOutlinesEnabled = initialItemOutlinesEnabled ~= false,
        ItemOutlinesHovering = false,
        ItemEnabledChanged = Instance.new("BindableEvent"),
        FullbrightChanged = Instance.new("BindableEvent"),
        FullbrightEnabled = initialFullbrightEnabled == true,
        FullbrightHovering = false,
        AntiAFKModule = Instance.new("Frame"),
        AntiAFKText = Instance.new("TextLabel"),
        AntiAFKCheckbox = Instance.new("TextButton"),
        AntiAFKChanged = Instance.new("BindableEvent"),
        AntiAFKEnabled = initialAntiAFKEnabled == true,
        AntiAFKHovering = false,
    }

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
    local ContentProvider = game:GetService("ContentProvider")
    local TextService = game:GetService("TextService")
    local RunService = game:GetService("RunService")
    local fontsReady = false
    local fontLoadSucceeded = false
    local fontsReadyEvent = Instance.new("BindableEvent")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local GUIParent = RunService:IsStudio() and PlayerGui or CoreGui

    for _, root in ipairs({CoreGui, PlayerGui}) do
        local previousGui = root:FindFirstChild("AutoDoors")
        if previousGui then previousGui:Destroy() end
    end

    local function addCorner(parent, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = parent
        return corner
    end

    local function addBottomCorner(parent, radius)
        local corner = Instance.new("UICorner")
        corner.TopLeftRadius = UDim.new(0, 0)
        corner.TopRightRadius = UDim.new(0, 0)
        corner.BottomLeftRadius = UDim.new(0, radius)
        corner.BottomRightRadius = UDim.new(0, radius)
        corner.Parent = parent
        return corner
    end

    local function addDefaultCorner(parent)
        local corner = Instance.new("UICorner")
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

    AutoDoors.Name = "AutoDoors"
    AutoDoors.Enabled = false
    AutoDoors.Parent = GUIParent
    AutoDoors.ZIndexBehavior = Enum.ZIndexBehavior.Global
    AutoDoors.DisplayOrder = 9999
    AutoDoors.ResetOnSpawn = false

    MainWindow.Name = "MainWindow"
    MainWindow.Parent = AutoDoors
    MainWindow.BackgroundColor3 = C.Background
    MainWindow.BorderSizePixel = 0
    MainWindow.ClipsDescendants = true
    MainWindow.Position = UDim2.new(0, 350, 0, 1)
    MainWindow.Size = UDim2.new(0, 430, 0, 600)
    MainWindow.ZIndex = 0
    addCorner(MainWindow, 10)
    addStroke(MainWindow, C.UIStroke1, 1)

    Header.Name = "Header"
    Header.Parent = MainWindow
    Header.BackgroundColor3 = C.Panel
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(0, 430, 0, 60)
    Header.ZIndex = 1
    addDefaultCorner(Header)

    TitleLine.Name = "TitleLine"
    TitleLine.Parent = Header
    TitleLine.BackgroundColor3 = C.RedHover
    TitleLine.BorderColor3 = C.RedHover
    TitleLine.BorderSizePixel = 0
    TitleLine.Position = UDim2.new(0, 0, 0, 8)
    TitleLine.Size = UDim2.new(0, 4, 0, 48)
    TitleLine.ZIndex = 2
    addCorner(TitleLine, 0)

    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 13)
    Title.Size = UDim2.new(0, 280, 0, 20)
    Title.ZIndex = 2
    Title.Font = Enum.Font.GothamBold
    Title.Text = "AUTO DOORS"
    Title.TextColor3 = C.White
    Title.TextSize = 19
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Description.Name = "Description"
    Description.Parent = Header
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 15, 0, 37)
    Description.Size = UDim2.new(0, 280, 0, 10)
    Description.ZIndex = 2
    Description.Font = Enum.Font.GothamMedium
    Description.Text = "DETECTION / AUTOMATION"
    Description.TextColor3 = C.SecondaryText
    Description.TextSize = 9
    Description.TextXAlignment = Enum.TextXAlignment.Left

    Resize.Name = "Resize"
    Resize.Parent = Header
    Resize.BackgroundColor3 = C.Surface
    Resize.BorderSizePixel = 0
    Resize.Position = UDim2.new(0, 355, 0, 15)
    Resize.ZIndex = 2
    Resize.Size = UDim2.new(0, 30, 0, 30)
    Resize.AutoButtonColor = false
    Resize.Font = Enum.Font.GothamBold
    Resize.Text = "▢"
    Resize.TextColor3 = C.White
    Resize.TextSize = 15
    addDefaultCorner(Resize)

    Minimize.Name = "Minimize"
    Minimize.Parent = Header
    Minimize.BackgroundColor3 = C.Surface
    Minimize.BorderSizePixel = 0
    Minimize.Position = UDim2.new(0, 320, 0, 15)
    Minimize.ZIndex = 2
    Minimize.Size = UDim2.new(0, 30, 0, 30)
    Minimize.AutoButtonColor = false
    Minimize.Font = Enum.Font.GothamMedium
    Minimize.Text = "—"
    Minimize.TextColor3 = C.White
    Minimize.TextSize = 15
    addDefaultCorner(Minimize)

    Close.Name = "Close"
    Close.Parent = Header
    Close.BackgroundColor3 = C.Red
    Close.BorderSizePixel = 0
    Close.Position = UDim2.new(0, 390, 0, 15)
    Close.ZIndex = 2
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.AutoButtonColor = false
    Close.Font = Enum.Font.Gotham
    Close.Text = "×"
    Close.TextColor3 = C.White
    Close.TextSize = 40
    addDefaultCorner(Close)

    SelectedTab.Name = "SelectedTab"
    SelectedTab.Parent = MainWindow
    SelectedTab.BackgroundTransparency = 1
    SelectedTab.Position = UDim2.new(0, 15, 0, 120)
    SelectedTab.Size = UDim2.new(0, 400, 0, 465)
    SelectedTab.ZIndex = 3

    DetectionPage.Name = "DetectionPage"
    DetectionPage.Parent = SelectedTab
    DetectionPage.BackgroundTransparency = 1
    DetectionPage.BorderSizePixel = 0
    DetectionPage.Size = UDim2.new(1, 0, 1, 0)
    DetectionPage.Visible = false
    DetectionPage.CanvasSize = UDim2.new(0, 0, 0, 440)
    DetectionPage.ZIndex = 4
    DetectionPage.ScrollBarThickness = 4
    DetectionPage.Active = true
    DetectionPage.ScrollingEnabled = true

    EntityOutlinesModule.Name = "EntityOutlinesModule"
    EntityOutlinesModule.Parent = DetectionPage
    EntityOutlinesModule.BackgroundColor3 = C.Panel
    EntityOutlinesModule.BorderSizePixel = 0
    EntityOutlinesModule.Position = UDim2.new(0, 1, 0, 136)
    EntityOutlinesModule.ZIndex = 5
    EntityOutlinesModule.Size = UDim2.new(0, 398, 0, 50)

    ModuleText.Name = "ModuleText"
    ModuleText.Parent = EntityOutlinesModule
    ModuleText.BackgroundTransparency = 1
    ModuleText.Position = UDim2.new(0, 12, 0, 0)
    ModuleText.ZIndex = 6
    ModuleText.Size = UDim2.new(1, -70, 1, 0)
    ModuleText.Font = Enum.Font.GothamMedium
    ModuleText.Text = "Entity Highlights"
    ModuleText.TextColor3 = C.White
    ModuleText.TextSize = 15
    ModuleText.TextXAlignment = Enum.TextXAlignment.Left

    ModuleCheckbox.Name = "ModuleCheckbox"
    ModuleCheckbox.Parent = EntityOutlinesModule
    ModuleCheckbox.BackgroundColor3 = C.Red
    ModuleCheckbox.BorderSizePixel = 0
    ModuleCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ModuleCheckbox.ZIndex = 6
    ModuleCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ModuleCheckbox.AutoButtonColor = false
    ModuleCheckbox.Font = Enum.Font.GothamMedium
    ModuleCheckbox.Text = "✓"
    ModuleCheckbox.TextColor3 = C.White
    ModuleCheckbox.TextSize = 15
    addDefaultCorner(ModuleCheckbox)
    addDefaultCorner(EntityOutlinesModule)
    addStroke(EntityOutlinesModule, C.UIStroke1, 1)

    SectionEntityDetection.Name = "SectionEntityDetection"
    SectionEntityDetection.Parent = DetectionPage
    SectionEntityDetection.BackgroundTransparency = 1
    SectionEntityDetection.Size = UDim2.new(0, 400, 0, 15)
    SectionEntityDetection.ZIndex = 4
    SectionEntityDetection.Font = Enum.Font.GothamBold
    SectionEntityDetection.Text = "Entity Detection:"
    SectionEntityDetection.TextColor3 = C.RedHover
    SectionEntityDetection.TextSize = 14
    SectionEntityDetection.TextXAlignment = Enum.TextXAlignment.Left

    EntityListModule.Name = "EntityListModule"
    EntityListModule.Parent = DetectionPage
    EntityListModule.BackgroundColor3 = C.Surface
    EntityListModule.BorderSizePixel = 0
    EntityListModule.Position = UDim2.new(0, 0, 0, 25)
    EntityListModule.Size = UDim2.new(0, 400, 0, 45)
    EntityListModule.ZIndex = 5
    EntityListModule.AutoButtonColor = false
    EntityListModule.Font = Enum.Font.GothamMedium
    EntityListModule.Text = "  Entities Detected:"
    EntityListModule.TextColor3 = C.White
    EntityListModule.TextSize = 15
    EntityListModule.TextXAlignment = Enum.TextXAlignment.Left
    addDefaultCorner(EntityListModule)

    Arrow.Name = "Arrow"
    Arrow.Parent = EntityListModule
    Arrow.AnchorPoint = Vector2.new(1, 0.5)
    Arrow.BackgroundTransparency = 1
    Arrow.Position = UDim2.new(1, -3, 0.75, 0)
    Arrow.ZIndex = 6
    Arrow.Size = UDim2.new(0, 25, 0, 30)
    Arrow.Font = Enum.Font.GothamBold
    Arrow.Text = "ꜜ"
    Arrow.TextColor3 = C.White
    Arrow.TextSize = 30
    Arrow.TextXAlignment = Enum.TextXAlignment.Left

    Dropdown.Name = "Dropdown"
    local DropdownClip = Instance.new("Frame")
    DropdownClip.Name = "DropdownClip"
    DropdownClip.Parent = EntityListModule
    DropdownClip.BackgroundColor3 = C.Surface
    DropdownClip.BackgroundTransparency = 0
    DropdownClip.BorderSizePixel = 0
    DropdownClip.ClipsDescendants = true
    DropdownClip.Position = UDim2.new(0, 0, 0, 45)
    DropdownClip.Size = UDim2.new(0, 400, 0, 0)
    DropdownClip.Visible = false
    DropdownClip.ZIndex = 7
    addBottomCorner(DropdownClip, 8)
    Dropdown.Parent = DropdownClip
    Dropdown.Active = true
    Dropdown.BackgroundColor3 = C.Surface
    Dropdown.BackgroundTransparency = 1
    Dropdown.BorderColor3 = C.Black
    Dropdown.BorderSizePixel = 0
    Dropdown.Position = UDim2.new(0, 0, 0, 0)
    Dropdown.Size = UDim2.new(0, 400, 0, 0)
    Dropdown.ZIndex = 7
    Dropdown.Visible = true

    NameTagModule.Name = "NameTagModule"
    NameTagModule.Parent = DetectionPage
    NameTagModule.BackgroundColor3 = C.Surface
    NameTagModule.BorderSizePixel = 0
    NameTagModule.Position = UDim2.new(0, 0, 0, 80)
    NameTagModule.Size = UDim2.new(0, 400, 0, 45)
    NameTagModule.ZIndex = 5
    NameTagModule.AutoButtonColor = false
    NameTagModule.Font = Enum.Font.GothamMedium
    NameTagModule.Text = "  Name Tags: Recommended"
    NameTagModule.TextColor3 = C.White
    NameTagModule.TextSize = 15
    NameTagModule.TextXAlignment = Enum.TextXAlignment.Left
    addDefaultCorner(NameTagModule)

    Arrow_2.Name = "Arrow"
    Arrow_2.Parent = NameTagModule
    Arrow_2.AnchorPoint = Vector2.new(1, 0.5)
    Arrow_2.BackgroundTransparency = 1
    Arrow_2.Position = UDim2.new(1, -3, 0.75, 0)
    Arrow_2.ZIndex = 6
    Arrow_2.Size = UDim2.new(0, 25, 0, 30)
    Arrow_2.Font = Enum.Font.GothamBold
    Arrow_2.Text = "ꜜ"
    Arrow_2.TextColor3 = C.White
    Arrow_2.TextSize = 30
    Arrow_2.TextXAlignment = Enum.TextXAlignment.Left

    Dropdown_2.Name = "Dropdown"
    local DropdownClip_2 = Instance.new("Frame")
    DropdownClip_2.Name = "DropdownClip"
    DropdownClip_2.Parent = NameTagModule
    DropdownClip_2.BackgroundColor3 = C.Surface
    DropdownClip_2.BackgroundTransparency = 0
    DropdownClip_2.BorderSizePixel = 0
    DropdownClip_2.ClipsDescendants = true
    DropdownClip_2.Position = UDim2.new(0, 0, 0, 45)
    DropdownClip_2.Size = UDim2.new(0, 400, 0, 0)
    DropdownClip_2.Visible = false
    DropdownClip_2.ZIndex = 7
    addBottomCorner(DropdownClip_2, 8)
    Dropdown_2.Parent = DropdownClip_2
    Dropdown_2.Active = true
    Dropdown_2.BackgroundColor3 = C.Surface
    Dropdown_2.BackgroundTransparency = 1
    Dropdown_2.BorderColor3 = C.Black
    Dropdown_2.BorderSizePixel = 0
    Dropdown_2.Position = UDim2.new(0, 0, 0, 0)
    Dropdown_2.Size = UDim2.new(0, 400, 0, 0)
    Dropdown_2.Visible = true

    ExtraControls.SectionItemDetection.Name = "SectionItemDetection"
    ExtraControls.SectionItemDetection.Parent = DetectionPage
    ExtraControls.SectionItemDetection.BackgroundTransparency = 1
    ExtraControls.SectionItemDetection.Position = UDim2.new(0, 0, 0, 197)
    ExtraControls.SectionItemDetection.Size = UDim2.new(0, 400, 0, 15)
    ExtraControls.SectionItemDetection.ZIndex = 4
    ExtraControls.SectionItemDetection.Font = Enum.Font.GothamBold
    ExtraControls.SectionItemDetection.Text = "Item Detection:"
    ExtraControls.SectionItemDetection.TextColor3 = C.RedHover
    ExtraControls.SectionItemDetection.TextSize = 14
    ExtraControls.SectionItemDetection.TextXAlignment = Enum.TextXAlignment.Left

    ExtraControls.ItemListModule.Name = "ItemListModule"
    ExtraControls.ItemListModule.Parent = DetectionPage
    ExtraControls.ItemListModule.BackgroundColor3 = C.Surface
    ExtraControls.ItemListModule.BorderSizePixel = 0
    ExtraControls.ItemListModule.Position = UDim2.new(0, 0, 0, 222)
    ExtraControls.ItemListModule.Size = UDim2.new(0, 400, 0, 45)
    ExtraControls.ItemListModule.ZIndex = 5
    ExtraControls.ItemListModule.AutoButtonColor = false
    ExtraControls.ItemListModule.Font = Enum.Font.GothamMedium
    ExtraControls.ItemListModule.Text = "  Items Detected:"
    ExtraControls.ItemListModule.TextColor3 = C.White
    ExtraControls.ItemListModule.TextSize = 15
    ExtraControls.ItemListModule.TextXAlignment = Enum.TextXAlignment.Left
    addDefaultCorner(ExtraControls.ItemListModule)

    ExtraControls.ItemArrow.Name = "Arrow"
    ExtraControls.ItemArrow.Parent = ExtraControls.ItemListModule
    ExtraControls.ItemArrow.AnchorPoint = Vector2.new(1, 0.5)
    ExtraControls.ItemArrow.BackgroundTransparency = 1
    ExtraControls.ItemArrow.Position = UDim2.new(1, -3, 0.75, 0)
    ExtraControls.ItemArrow.ZIndex = 6
    ExtraControls.ItemArrow.Size = UDim2.new(0, 25, 0, 30)
    ExtraControls.ItemArrow.Font = Enum.Font.GothamBold
    ExtraControls.ItemArrow.Text = "ꜜ"
    ExtraControls.ItemArrow.TextColor3 = C.White
    ExtraControls.ItemArrow.TextSize = 30
    ExtraControls.ItemArrow.TextXAlignment = Enum.TextXAlignment.Left

    ExtraControls.ItemDropdown.Name = "Dropdown"
    ExtraControls.ItemDropdownClip = Instance.new("Frame")
    ExtraControls.ItemDropdownClip.Name = "DropdownClip"
    ExtraControls.ItemDropdownClip.Parent = ExtraControls.ItemListModule
    ExtraControls.ItemDropdownClip.BackgroundColor3 = C.Surface
    ExtraControls.ItemDropdownClip.BackgroundTransparency = 0
    ExtraControls.ItemDropdownClip.BorderSizePixel = 0
    ExtraControls.ItemDropdownClip.ClipsDescendants = true
    ExtraControls.ItemDropdownClip.Position = UDim2.new(0, 0, 0, 45)
    ExtraControls.ItemDropdownClip.Size = UDim2.new(0, 400, 0, 0)
    ExtraControls.ItemDropdownClip.Visible = false
    ExtraControls.ItemDropdownClip.ZIndex = 7
    addBottomCorner(ExtraControls.ItemDropdownClip, 8)
    ExtraControls.ItemDropdown.Parent = ExtraControls.ItemDropdownClip
    ExtraControls.ItemDropdown.Active = true
    ExtraControls.ItemDropdown.BackgroundColor3 = C.Surface
    ExtraControls.ItemDropdown.BackgroundTransparency = 1
    ExtraControls.ItemDropdown.BorderColor3 = C.Black
    ExtraControls.ItemDropdown.BorderSizePixel = 0
    ExtraControls.ItemDropdown.Position = UDim2.new(0, 0, 0, 0)
    ExtraControls.ItemDropdown.Size = UDim2.new(0, 400, 0, 0)
    ExtraControls.ItemDropdown.ZIndex = 7
    ExtraControls.ItemDropdown.Visible = true

    ExtraControls.ItemOutlinesModule.Name = "ItemOutlinesModule"
    ExtraControls.ItemOutlinesModule.Parent = DetectionPage
    ExtraControls.ItemOutlinesModule.BackgroundColor3 = C.Panel
    ExtraControls.ItemOutlinesModule.BorderSizePixel = 0
    ExtraControls.ItemOutlinesModule.Position = UDim2.new(0, 1, 0, 278)
    ExtraControls.ItemOutlinesModule.ZIndex = 5
    ExtraControls.ItemOutlinesModule.Size = UDim2.new(0, 398, 0, 50)

    ExtraControls.ItemOutlinesText.Name = "ItemOutlinesText"
    ExtraControls.ItemOutlinesText.Parent = ExtraControls.ItemOutlinesModule
    ExtraControls.ItemOutlinesText.BackgroundTransparency = 1
    ExtraControls.ItemOutlinesText.Position = UDim2.new(0, 12, 0, 0)
    ExtraControls.ItemOutlinesText.ZIndex = 6
    ExtraControls.ItemOutlinesText.Size = UDim2.new(1, -70, 1, 0)
    ExtraControls.ItemOutlinesText.Font = Enum.Font.GothamMedium
    ExtraControls.ItemOutlinesText.Text = "Item Highlights"
    ExtraControls.ItemOutlinesText.TextColor3 = C.White
    ExtraControls.ItemOutlinesText.TextSize = 15
    ExtraControls.ItemOutlinesText.TextXAlignment = Enum.TextXAlignment.Left

    ExtraControls.ItemOutlinesCheckbox.Name = "ModuleCheckbox"
    ExtraControls.ItemOutlinesCheckbox.Parent = ExtraControls.ItemOutlinesModule
    ExtraControls.ItemOutlinesCheckbox.BackgroundColor3 = C.Red
    ExtraControls.ItemOutlinesCheckbox.BorderSizePixel = 0
    ExtraControls.ItemOutlinesCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ExtraControls.ItemOutlinesCheckbox.ZIndex = 6
    ExtraControls.ItemOutlinesCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ExtraControls.ItemOutlinesCheckbox.AutoButtonColor = false
    ExtraControls.ItemOutlinesCheckbox.Font = Enum.Font.GothamMedium
    ExtraControls.ItemOutlinesCheckbox.Text = "✓"
    ExtraControls.ItemOutlinesCheckbox.TextColor3 = C.White
    ExtraControls.ItemOutlinesCheckbox.TextSize = 15
    addDefaultCorner(ExtraControls.ItemOutlinesCheckbox)
    addDefaultCorner(ExtraControls.ItemOutlinesModule)
    addStroke(ExtraControls.ItemOutlinesModule, C.UIStroke1, 1)

    AutomationPage.Name = "AutomationPage"
    AutomationPage.Parent = SelectedTab
    AutomationPage.BackgroundTransparency = 1
    AutomationPage.BorderSizePixel = 0
    AutomationPage.Size = UDim2.new(1, 0, 1, 0)
    AutomationPage.ZIndex = 4
    AutomationPage.CanvasSize = UDim2.new(0, 0, 0, 0)
    AutomationPage.ScrollBarThickness = 4

    SectionAutomation.Name = "SectionAutomation"
    SectionAutomation.Parent = AutomationPage
    SectionAutomation.BackgroundTransparency = 1
    SectionAutomation.Size = UDim2.new(0, 400, 0, 15)
    SectionAutomation.ZIndex = 4
    SectionAutomation.Font = Enum.Font.GothamBold
    SectionAutomation.Text = "Automation:"
    SectionAutomation.TextColor3 = C.RedHover
    SectionAutomation.TextSize = 14
    SectionAutomation.TextXAlignment = Enum.TextXAlignment.Left

    ExtraControls.MiscellaneousPage.Name = "MiscellaneousPage"
    ExtraControls.MiscellaneousPage.Parent = SelectedTab
    ExtraControls.MiscellaneousPage.BackgroundTransparency = 1
    ExtraControls.MiscellaneousPage.BorderSizePixel = 0
    ExtraControls.MiscellaneousPage.Size = UDim2.new(1, 0, 1, 0)
    ExtraControls.MiscellaneousPage.CanvasSize = UDim2.new(0, 0, 0, 142)
    ExtraControls.MiscellaneousPage.Visible = false
    ExtraControls.MiscellaneousPage.ZIndex = 4
    ExtraControls.MiscellaneousPage.ScrollBarThickness = 4
    ExtraControls.MiscellaneousPage.Active = true
    ExtraControls.MiscellaneousPage.ScrollingEnabled = true

    ExtraControls.FullbrightModule.Name = "FullbrightModule"
    ExtraControls.FullbrightModule.Parent = ExtraControls.MiscellaneousPage
    ExtraControls.FullbrightModule.BackgroundColor3 = C.Panel
    ExtraControls.FullbrightModule.BorderSizePixel = 0
    ExtraControls.FullbrightModule.Position = UDim2.new(0, 1, 0, 88)
    ExtraControls.FullbrightModule.ZIndex = 5
    ExtraControls.FullbrightModule.Size = UDim2.new(0, 398, 0, 50)
    ExtraControls.FullbrightText.Name = "FullbrightText"
    ExtraControls.FullbrightText.Parent = ExtraControls.FullbrightModule
    ExtraControls.FullbrightText.BackgroundTransparency = 1
    ExtraControls.FullbrightText.Position = UDim2.new(0, 12, 0, 0)
    ExtraControls.FullbrightText.ZIndex = 6
    ExtraControls.FullbrightText.Size = UDim2.new(1, -70, 1, 0)
    ExtraControls.FullbrightText.Font = Enum.Font.GothamMedium
    ExtraControls.FullbrightText.Text = "Fullbright"
    ExtraControls.FullbrightText.TextColor3 = C.White
    ExtraControls.FullbrightText.TextSize = 15
    ExtraControls.FullbrightText.TextXAlignment = Enum.TextXAlignment.Left
    ExtraControls.FullbrightCheckbox.Name = "FullbrightCheckbox"
    ExtraControls.FullbrightCheckbox.Parent = ExtraControls.FullbrightModule
    ExtraControls.FullbrightCheckbox.BackgroundColor3 = C.Red
    ExtraControls.FullbrightCheckbox.BorderSizePixel = 0
    ExtraControls.FullbrightCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ExtraControls.FullbrightCheckbox.ZIndex = 6
    ExtraControls.FullbrightCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ExtraControls.FullbrightCheckbox.AutoButtonColor = false
    ExtraControls.FullbrightCheckbox.Font = Enum.Font.GothamMedium
    ExtraControls.FullbrightCheckbox.Text = "✓"
    ExtraControls.FullbrightCheckbox.TextColor3 = C.White
    ExtraControls.FullbrightCheckbox.TextSize = 15
    addDefaultCorner(ExtraControls.FullbrightCheckbox)
    addDefaultCorner(ExtraControls.FullbrightModule)
    addStroke(ExtraControls.FullbrightModule, C.UIStroke1, 1)

    ExtraControls.AntiAFKModule.Name = "AntiAFKModule"
    ExtraControls.AntiAFKModule.Parent = ExtraControls.MiscellaneousPage
    ExtraControls.AntiAFKModule.BackgroundColor3 = C.Panel
    ExtraControls.AntiAFKModule.BorderSizePixel = 0
    ExtraControls.AntiAFKModule.Position = UDim2.new(0, 1, 0, 26)
    ExtraControls.AntiAFKModule.ZIndex = 5
    ExtraControls.AntiAFKModule.Size = UDim2.new(0, 398, 0, 50)
    ExtraControls.AntiAFKText.Name = "AntiAFKText"
    ExtraControls.AntiAFKText.Parent = ExtraControls.AntiAFKModule
    ExtraControls.AntiAFKText.BackgroundTransparency = 1
    ExtraControls.AntiAFKText.Position = UDim2.new(0, 12, 0, 0)
    ExtraControls.AntiAFKText.ZIndex = 6
    ExtraControls.AntiAFKText.Size = UDim2.new(1, -70, 1, 0)
    ExtraControls.AntiAFKText.Font = Enum.Font.GothamMedium
    ExtraControls.AntiAFKText.Text = "Anti-AFK"
    ExtraControls.AntiAFKText.TextColor3 = C.White
    ExtraControls.AntiAFKText.TextSize = 15
    ExtraControls.AntiAFKText.TextXAlignment = Enum.TextXAlignment.Left
    ExtraControls.AntiAFKCheckbox.Name = "AntiAFKCheckbox"
    ExtraControls.AntiAFKCheckbox.Parent = ExtraControls.AntiAFKModule
    ExtraControls.AntiAFKCheckbox.BackgroundColor3 = C.Red
    ExtraControls.AntiAFKCheckbox.BorderSizePixel = 0
    ExtraControls.AntiAFKCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ExtraControls.AntiAFKCheckbox.ZIndex = 6
    ExtraControls.AntiAFKCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ExtraControls.AntiAFKCheckbox.AutoButtonColor = false
    ExtraControls.AntiAFKCheckbox.Font = Enum.Font.GothamMedium
    ExtraControls.AntiAFKCheckbox.Text = "✓"
    ExtraControls.AntiAFKCheckbox.TextColor3 = C.White
    ExtraControls.AntiAFKCheckbox.TextSize = 15
    addDefaultCorner(ExtraControls.AntiAFKCheckbox)
    addDefaultCorner(ExtraControls.AntiAFKModule)
    addStroke(ExtraControls.AntiAFKModule, C.UIStroke1, 1)

    ExtraControls.SectionMiscellaneous.Name = "SectionMiscellaneous"
    ExtraControls.SectionMiscellaneous.Parent = ExtraControls.MiscellaneousPage
    ExtraControls.SectionMiscellaneous.BackgroundTransparency = 1
    ExtraControls.SectionMiscellaneous.Size = UDim2.new(0, 400, 0, 15)
    ExtraControls.SectionMiscellaneous.ZIndex = 4
    ExtraControls.SectionMiscellaneous.Font = Enum.Font.GothamBold
    ExtraControls.SectionMiscellaneous.Text = "Miscellaneous:"
    ExtraControls.SectionMiscellaneous.TextColor3 = C.RedHover
    ExtraControls.SectionMiscellaneous.TextSize = 14
    ExtraControls.SectionMiscellaneous.TextXAlignment = Enum.TextXAlignment.Left

    Tabs.Name = "Tabs"
    Tabs.Parent = MainWindow
    Tabs.BackgroundTransparency = 1
    Tabs.Position = UDim2.new(0, 15, 0, 70)
    Tabs.Size = UDim2.new(0, 400, 0, 40)
    Tabs.ZIndex = 3

    Detection.Name = "Detection"
    Detection.Parent = Tabs
    Detection.BackgroundColor3 = C.Surface
    Detection.BorderColor3 = C.Surface
    Detection.BorderSizePixel = 0
    Detection.Position = UDim2.new(0, 135, 0, 0)
    Detection.Size = UDim2.new(0, 130, 1, 0)
    Detection.ZIndex = 4
    Detection.AutoButtonColor = false
    Detection.Font = Enum.Font.GothamMedium
    Detection.Text = "Detection"
    Detection.TextColor3 = C.White
    Detection.TextSize = 15
    addDefaultCorner(Detection)

    Automation.Name = "Automation"
    Automation.Parent = Tabs
    Automation.BackgroundColor3 = C.Surface
    Automation.BorderColor3 = C.Surface
    Automation.BorderSizePixel = 0
    Automation.Position = UDim2.new(0, 0, 0, 0)
    Automation.Size = UDim2.new(0, 130, 1, 0)
    Automation.ZIndex = 4
    Automation.AutoButtonColor = false
    Automation.Font = Enum.Font.GothamMedium
    Automation.Text = "Automation"
    Automation.TextColor3 = C.White
    Automation.TextSize = 15
    addDefaultCorner(Automation)

    ExtraControls.MiscellaneousTab = Instance.new("TextButton")
    ExtraControls.MiscellaneousTab.Name = "Miscellaneous"
    ExtraControls.MiscellaneousTab.Parent = Tabs
    ExtraControls.MiscellaneousTab.BackgroundColor3 = C.Surface
    ExtraControls.MiscellaneousTab.BorderColor3 = C.Surface
    ExtraControls.MiscellaneousTab.BorderSizePixel = 0
    ExtraControls.MiscellaneousTab.Position = UDim2.new(0, 270, 0, 0)
    ExtraControls.MiscellaneousTab.Size = UDim2.new(0, 130, 1, 0)
    ExtraControls.MiscellaneousTab.ZIndex = 4
    ExtraControls.MiscellaneousTab.AutoButtonColor = false
    ExtraControls.MiscellaneousTab.Font = Enum.Font.GothamMedium
    ExtraControls.MiscellaneousTab.Text = "Miscellaneous"
    ExtraControls.MiscellaneousTab.TextColor3 = C.White
    ExtraControls.MiscellaneousTab.TextSize = 15
    addDefaultCorner(ExtraControls.MiscellaneousTab)

    Notifications.Name = "Notifications"
    Notifications.Parent = AutoDoors
    Notifications.AnchorPoint = Vector2.new(1, 0)
    Notifications.BackgroundTransparency = 1
    Notifications.Position = UDim2.new(1, -22, 0, 22)
    Notifications.Size = UDim2.new(0, 320, 0, 390)
    Notifications.ZIndex = 20
    UIListLayout.Parent = Notifications
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayout.Padding = UDim.new(0, 9)

    CloseConfirmation.Name = "CloseConfirmation"
    CloseConfirmation.Parent = AutoDoors
    CloseConfirmation.AnchorPoint = Vector2.new(0.5, 0.5)
    CloseConfirmation.BackgroundColor3 = C.Panel
    CloseConfirmation.BorderSizePixel = 0
    CloseConfirmation.Position = UDim2.new(0.5, 0, 0.5, 0)
    CloseConfirmation.Size = UDim2.new(0, 310, 0, 145)
    CloseConfirmation.Visible = false
    CloseConfirmation.ZIndex = 20
    addStroke(CloseConfirmation, C.RedHover, 1)
    addCorner(CloseConfirmation, 10)

    ConfirmationText.Name = "ConfirmationText"
    ConfirmationText.Parent = CloseConfirmation
    ConfirmationText.BackgroundTransparency = 1
    ConfirmationText.Position = UDim2.new(0, 14, 0, 12)
    ConfirmationText.Size = UDim2.new(1, -28, 0, 25)
    ConfirmationText.ZIndex = 21
    ConfirmationText.Font = Enum.Font.GothamBold
    ConfirmationText.Text = "Close Auto Doors?"
    ConfirmationText.TextColor3 = C.White
    ConfirmationText.TextSize = 15
    ConfirmationText.TextXAlignment = Enum.TextXAlignment.Left

    ConfirmationExplanation.Name = "ConfirmationExplanation"
    ConfirmationExplanation.Parent = CloseConfirmation
    ConfirmationExplanation.BackgroundTransparency = 1
    ConfirmationExplanation.Position = UDim2.new(0, 14, 0, 40)
    ConfirmationExplanation.Size = UDim2.new(1, -28, 0, 32)
    ConfirmationExplanation.ZIndex = 21
    ConfirmationExplanation.Font = Enum.Font.Gotham
    ConfirmationExplanation.Text = "This will stop detection and remove all script visuals."
    ConfirmationExplanation.TextColor3 = C.SecondaryText
    ConfirmationExplanation.TextSize = 11
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
    Cancel.TextSize = 15
    addDefaultCorner(Cancel)

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
    CloseScript.TextSize = 15
    addDefaultCorner(CloseScript)

    local GUI_LOGIC_URL = "https://raw.githubusercontent.com/BlatnatHacer49/Auto-Doors/refs/heads/main/Auto%20Doors%20GUI%20Logic.lua"
    local logicSource = assert(game:HttpGet(GUI_LOGIC_URL), "Failed to download Auto Doors GUI Logic source")
    local logicChunk = assert(loadstring(logicSource), "Failed to compile Auto Doors GUI Logic source")
    local initializeGUIBehavior = logicChunk()
    assert(type(initializeGUIBehavior) == "function", "Auto Doors GUI Logic source must return an initializer function")

    return initializeGUIBehavior({
        C = C,
        AutoDoors = AutoDoors,
        MainWindow = MainWindow,
        Header = Header,
        Resize = Resize,
        Minimize = Minimize,
        Close = Close,
        SelectedTab = SelectedTab,
        DetectionPage = DetectionPage,
        EntityOutlinesModule = EntityOutlinesModule,
        ModuleText = ModuleText,
        ModuleCheckbox = ModuleCheckbox,
        SectionEntityDetection = SectionEntityDetection,
        EntityListModule = EntityListModule,
        Arrow = Arrow,
        Dropdown = Dropdown,
        DropdownClip = DropdownClip,
        NameTagModule = NameTagModule,
        Arrow_2 = Arrow_2,
        Dropdown_2 = Dropdown_2,
        DropdownClip_2 = DropdownClip_2,
        AutomationPage = AutomationPage,
        SectionAutomation = SectionAutomation,
        Tabs = Tabs,
        Detection = Detection,
        Automation = Automation,
        Notifications = Notifications,
        CloseConfirmation = CloseConfirmation,
        ConfirmationText = ConfirmationText,
        ConfirmationExplanation = ConfirmationExplanation,
        Cancel = Cancel,
        CloseScript = CloseScript,
        ExtraControls = ExtraControls,
        addCorner = addCorner,
        addStroke = addStroke,
        entityDefinitions = entityDefinitions,
        enabledEntities = enabledEntities,
        initialNameTagMode = initialNameTagMode,
        itemDefinitions = itemDefinitions,
        enabledItems = enabledItems,
        ContentProvider = ContentProvider,
        TextService = TextService,
        RunService = RunService,
        fontsReady = fontsReady,
        fontLoadSucceeded = fontLoadSucceeded,
        fontsReadyEvent = fontsReadyEvent,
    })
end

local mainEntities, mainEnabledEntities, mainNameTagMode, mainFullbrightEnabled,
    mainItemDefinitions, mainEnabledItems, mainItemOutlinesEnabled, mainAntiAFKEnabled = ...
if mainEntities ~= nil then
    return buildGUI(
        mainEntities,
        mainEnabledEntities,
        mainNameTagMode,
        mainFullbrightEnabled,
        mainItemDefinitions,
        mainEnabledItems,
        mainItemOutlinesEnabled,
        mainAntiAFKEnabled
    )
end
return buildGUI()
