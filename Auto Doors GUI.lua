-- UI construction
local function buildGUI(entityDefinitions, enabledEntities, initialNameTagMode, initialFullbrightEnabled, itemDefinitions, enabledItems, initialItemOutlinesEnabled, initialAntiAFKEnabled)
    local standaloneEntities = {
        {name = "Test1", display = "Test 1"}, {name = "Test2", display = "Test 2"},
        {name = "Test3", display = "Test 3"}, {name = "Test4", display = "Test 4"},
        {name = "Test5", display = "Test 5"}, {name = "Test6", display = "Test 6"},
        {name = "Test7", display = "Test 7"}, {name = "Test8", display = "Test 8"},
        {name = "Test9", display = "Test 9"}, {name = "Test10", display = "Test 10"},
    }
    entityDefinitions = type(entityDefinitions) == "table" and entityDefinitions or standaloneEntities
    itemDefinitions = type(itemDefinitions) == "table" and itemDefinitions or {}
    enabledItems = type(enabledItems) == "table" and enabledItems or {}

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

    -- Keep added controls grouped so the GUI's local-register usage stays low.
    local ExtraControls = {
        MiscellaneousPage = Instance.new("ScrollingFrame"),
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

    for _, root in ipairs({CoreGui, PlayerGui}) do
        local previousGui = root:FindFirstChild("DOORSEntityDetector")
        if previousGui then previousGui:Destroy() end
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
    DOORSEntityDetector.Enabled = false
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
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 17, 0, 7)
    Title.Size = UDim2.new(1, -150, 0, 27)
    Title.FontFace = Font.fromEnum(Enum.Font.GothamBold)
    Title.Text = "AUTO DOORS"
    Title.TextColor3 = C.White
    Title.TextSize = 19
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Description.Name = "Description"
    Description.Parent = Header
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 18, 0, 34)
    Description.Size = UDim2.new(1, -150, 0, 16)
    Description.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    Description.Text = "DETECTION  /  AUTOMATION  /  MISCELLANEOUS"
    Description.TextColor3 = C.SecondaryText
    Description.TextSize = 9
    Description.TextXAlignment = Enum.TextXAlignment.Left

    Resize.Name = "Resize"
    Resize.Parent = Header
    Resize.BackgroundColor3 = C.Surface
    Resize.BorderSizePixel = 0
    Resize.Position = UDim2.new(0, 355, 0, 15)
    Resize.Size = UDim2.new(0, 30, 0, 30)
    Resize.AutoButtonColor = false
    Resize.FontFace = Font.fromEnum(Enum.Font.GothamBold)
    Resize.Text = "▢"
    Resize.TextColor3 = C.White
    Resize.TextSize = 15
    addCorner(Resize, 8, 8, 8, 8)

    Minimize.Name = "Minimize"
    Minimize.Parent = Header
    Minimize.BackgroundColor3 = C.Surface
    Minimize.BorderSizePixel = 0
    Minimize.Position = UDim2.new(0, 320, 0, 15)
    Minimize.Size = UDim2.new(0, 30, 0, 30)
    Minimize.AutoButtonColor = false
    Minimize.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    Minimize.Text = "—"
    Minimize.TextColor3 = C.White
    Minimize.TextSize = 15
    addCorner(Minimize, 8, 8, 8, 8)

    Close.Name = "Close"
    Close.Parent = Header
    Close.BackgroundColor3 = C.Red
    Close.BorderSizePixel = 0
    Close.Position = UDim2.new(0, 390, 0, 15)
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.AutoButtonColor = false
    Close.FontFace = Font.fromEnum(Enum.Font.Gotham)
    Close.Text = "×"
    Close.TextColor3 = C.White
    Close.TextSize = 40
    addCorner(Close, 8, 8, 8, 8)

    SelectedTab.Name = "SelectedTab"
    SelectedTab.Parent = MainWindow
    SelectedTab.BackgroundTransparency = 1
    SelectedTab.Position = UDim2.new(0, 15, 0, 120)
    SelectedTab.Size = UDim2.new(0, 400, 0, 440)

    EntitiesPage.Name = "EntitiesPage"
    EntitiesPage.Parent = SelectedTab
    EntitiesPage.BackgroundTransparency = 1
    EntitiesPage.BorderSizePixel = 0
    EntitiesPage.Size = UDim2.new(1, 0, 1, 0)
    EntitiesPage.Visible = false
    EntitiesPage.CanvasSize = UDim2.new(0, 0, 0, 440)
    EntitiesPage.ScrollBarThickness = 4
    EntitiesPage.Active = true
    EntitiesPage.ScrollingEnabled = true

    EntityOutlinesModule.Name = "EntityOutlinesModule"
    EntityOutlinesModule.Parent = EntitiesPage
    EntityOutlinesModule.BackgroundColor3 = C.Panel
    EntityOutlinesModule.BorderSizePixel = 0
    EntityOutlinesModule.Position = UDim2.new(0, 1, 0, 135)
    EntityOutlinesModule.Size = UDim2.new(0, 398, 0, 50)

    ModuleText.Name = "ModuleText"
    ModuleText.Parent = EntityOutlinesModule
    ModuleText.BackgroundTransparency = 1
    ModuleText.Position = UDim2.new(0, 12, 0, 0)
    ModuleText.Size = UDim2.new(1, -70, 1, 0)
    ModuleText.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ModuleText.Text = "Entity Outlines"
    ModuleText.TextColor3 = C.White
    ModuleText.TextSize = 15
    ModuleText.TextXAlignment = Enum.TextXAlignment.Left

    ModuleCheckbox.Name = "ModuleCheckbox"
    ModuleCheckbox.Parent = EntityOutlinesModule
    ModuleCheckbox.BackgroundColor3 = C.Red
    ModuleCheckbox.BorderSizePixel = 0
    ModuleCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ModuleCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ModuleCheckbox.AutoButtonColor = false
    ModuleCheckbox.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ModuleCheckbox.Text = "✓"
    ModuleCheckbox.TextColor3 = C.White
    ModuleCheckbox.TextSize = 15
    addCorner(ModuleCheckbox, 8, 8, 8, 8)
    addCorner(EntityOutlinesModule, 8, 8, 8, 8)
    addStroke(EntityOutlinesModule, C.UIStroke1, 1)

    SectionEntityDetection.Name = "SectionEntityDetection"
    SectionEntityDetection.Parent = EntitiesPage
    SectionEntityDetection.BackgroundTransparency = 1
    SectionEntityDetection.Size = UDim2.new(0, 400, 0, 15)
    SectionEntityDetection.FontFace = Font.fromEnum(Enum.Font.GothamBold)
    SectionEntityDetection.Text = "Entity Detection:"
    SectionEntityDetection.TextColor3 = C.RedHover
    SectionEntityDetection.TextSize = 14
    SectionEntityDetection.TextXAlignment = Enum.TextXAlignment.Left

    EntityListModule.Name = "EntityListModule"
    EntityListModule.Parent = EntitiesPage
    EntityListModule.BackgroundColor3 = C.Surface
    EntityListModule.BorderSizePixel = 0
    EntityListModule.Position = UDim2.new(0, 0, 0, 25)
    EntityListModule.Size = UDim2.new(0, 400, 0, 45)
    EntityListModule.ZIndex = 2
    EntityListModule.AutoButtonColor = false
    EntityListModule.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    EntityListModule.Text = "  Entities Detected:"
    EntityListModule.TextColor3 = C.White
    EntityListModule.TextSize = 15
    EntityListModule.TextXAlignment = Enum.TextXAlignment.Left
    addCorner(EntityListModule, 8, 8, 8, 8)

    Arrow.Name = "Arrow"
    Arrow.Parent = EntityListModule
    Arrow.AnchorPoint = Vector2.new(1, 0.5)
    Arrow.BackgroundTransparency = 1
    Arrow.Position = UDim2.new(1, -3, 0.75, 0)
    Arrow.Size = UDim2.new(0, 25, 0, 30)
    Arrow.FontFace = Font.fromEnum(Enum.Font.GothamBold)
    Arrow.Text = "ꜜ"
    Arrow.TextColor3 = C.White
    Arrow.TextSize = 30
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
    NameTagModule.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    NameTagModule.Text = "  Name Tags: Recommended"
    NameTagModule.TextColor3 = C.White
    NameTagModule.TextSize = 15
    NameTagModule.TextXAlignment = Enum.TextXAlignment.Left
    addCorner(NameTagModule, 8, 8, 8, 8)

    Arrow_2.Name = "Arrow"
    Arrow_2.Parent = NameTagModule
    Arrow_2.AnchorPoint = Vector2.new(1, 0.5)
    Arrow_2.BackgroundTransparency = 1
    Arrow_2.Position = UDim2.new(1, -3, 0.75, 0)
    Arrow_2.Size = UDim2.new(0, 25, 0, 30)
    Arrow_2.FontFace = Font.fromEnum(Enum.Font.GothamBold)
    Arrow_2.Text = "ꜜ"
    Arrow_2.TextColor3 = C.White
    Arrow_2.TextSize = 30
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

    -- Item detection controls are intentionally empty until item detection is implemented.
    ExtraControls.SectionItemDetection.Name = "SectionItemDetection"
    ExtraControls.SectionItemDetection.Parent = EntitiesPage
    ExtraControls.SectionItemDetection.BackgroundTransparency = 1
    ExtraControls.SectionItemDetection.Position = UDim2.new(0, 0, 0, 200)
    ExtraControls.SectionItemDetection.Size = UDim2.new(0, 400, 0, 15)
    ExtraControls.SectionItemDetection.FontFace = Font.fromEnum(Enum.Font.GothamBold)
    ExtraControls.SectionItemDetection.Text = "Item Detection:"
    ExtraControls.SectionItemDetection.TextColor3 = C.RedHover
    ExtraControls.SectionItemDetection.TextSize = 14
    ExtraControls.SectionItemDetection.TextXAlignment = Enum.TextXAlignment.Left

    ExtraControls.ItemListModule.Name = "ItemListModule"
    ExtraControls.ItemListModule.Parent = EntitiesPage
    ExtraControls.ItemListModule.BackgroundColor3 = C.Surface
    ExtraControls.ItemListModule.BorderSizePixel = 0
    ExtraControls.ItemListModule.Position = UDim2.new(0, 0, 0, 225)
    ExtraControls.ItemListModule.Size = UDim2.new(0, 400, 0, 45)
    ExtraControls.ItemListModule.ZIndex = 2
    ExtraControls.ItemListModule.AutoButtonColor = false
    ExtraControls.ItemListModule.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ExtraControls.ItemListModule.Text = "  Items Detected:"
    ExtraControls.ItemListModule.TextColor3 = C.White
    ExtraControls.ItemListModule.TextSize = 15
    ExtraControls.ItemListModule.TextXAlignment = Enum.TextXAlignment.Left
    addCorner(ExtraControls.ItemListModule, 8, 8, 8, 8)

    ExtraControls.ItemArrow.Name = "Arrow"
    ExtraControls.ItemArrow.Parent = ExtraControls.ItemListModule
    ExtraControls.ItemArrow.AnchorPoint = Vector2.new(1, 0.5)
    ExtraControls.ItemArrow.BackgroundTransparency = 1
    ExtraControls.ItemArrow.Position = UDim2.new(1, -3, 0.75, 0)
    ExtraControls.ItemArrow.Size = UDim2.new(0, 25, 0, 30)
    ExtraControls.ItemArrow.FontFace = Font.fromEnum(Enum.Font.GothamBold)
    ExtraControls.ItemArrow.Text = "ꜜ"
    ExtraControls.ItemArrow.TextColor3 = C.White
    ExtraControls.ItemArrow.TextSize = 30
    ExtraControls.ItemArrow.TextXAlignment = Enum.TextXAlignment.Left

    ExtraControls.ItemDropdown.Name = "Dropdown"
    ExtraControls.ItemDropdownClip = Instance.new("Frame")
    ExtraControls.ItemDropdownClip.Name = "DropdownClip"
    ExtraControls.ItemDropdownClip.Parent = ExtraControls.ItemListModule
    ExtraControls.ItemDropdownClip.BackgroundTransparency = 1
    ExtraControls.ItemDropdownClip.BorderSizePixel = 0
    ExtraControls.ItemDropdownClip.ClipsDescendants = true
    ExtraControls.ItemDropdownClip.Position = UDim2.new(0, 0, 0, 45)
    ExtraControls.ItemDropdownClip.Size = UDim2.new(0, 400, 0, 0)
    ExtraControls.ItemDropdownClip.Visible = false
    ExtraControls.ItemDropdownClip.ZIndex = 3
    ExtraControls.ItemDropdown.Parent = ExtraControls.ItemDropdownClip
    ExtraControls.ItemDropdown.Active = true
    ExtraControls.ItemDropdown.BackgroundColor3 = C.Surface
    ExtraControls.ItemDropdown.BorderColor3 = C.Black
    ExtraControls.ItemDropdown.BorderSizePixel = 0
    ExtraControls.ItemDropdown.Position = UDim2.new(0, 0, 0, 0)
    ExtraControls.ItemDropdown.Size = UDim2.new(0, 400, 0, 0)
    ExtraControls.ItemDropdown.Visible = true
    addCorner(ExtraControls.ItemDropdown, 0, 0, 8, 8)

    ExtraControls.ItemOutlinesModule.Name = "ItemOutlinesModule"
    ExtraControls.ItemOutlinesModule.Parent = EntitiesPage
    ExtraControls.ItemOutlinesModule.BackgroundColor3 = C.Panel
    ExtraControls.ItemOutlinesModule.BorderSizePixel = 0
    ExtraControls.ItemOutlinesModule.Position = UDim2.new(0, 1, 0, 280)
    ExtraControls.ItemOutlinesModule.Size = UDim2.new(0, 398, 0, 50)

    ExtraControls.ItemOutlinesText.Name = "ItemOutlinesText"
    ExtraControls.ItemOutlinesText.Parent = ExtraControls.ItemOutlinesModule
    ExtraControls.ItemOutlinesText.BackgroundTransparency = 1
    ExtraControls.ItemOutlinesText.Position = UDim2.new(0, 12, 0, 0)
    ExtraControls.ItemOutlinesText.Size = UDim2.new(1, -70, 1, 0)
    ExtraControls.ItemOutlinesText.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ExtraControls.ItemOutlinesText.Text = "Item Outlines"
    ExtraControls.ItemOutlinesText.TextColor3 = C.White
    ExtraControls.ItemOutlinesText.TextSize = 15
    ExtraControls.ItemOutlinesText.TextXAlignment = Enum.TextXAlignment.Left

    ExtraControls.ItemOutlinesCheckbox.Name = "ItemOutlinesCheckbox"
    ExtraControls.ItemOutlinesCheckbox.Parent = ExtraControls.ItemOutlinesModule
    ExtraControls.ItemOutlinesCheckbox.BackgroundColor3 = C.Red
    ExtraControls.ItemOutlinesCheckbox.BorderSizePixel = 0
    ExtraControls.ItemOutlinesCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ExtraControls.ItemOutlinesCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ExtraControls.ItemOutlinesCheckbox.AutoButtonColor = false
    ExtraControls.ItemOutlinesCheckbox.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ExtraControls.ItemOutlinesCheckbox.Text = "✓"
    ExtraControls.ItemOutlinesCheckbox.TextColor3 = C.White
    ExtraControls.ItemOutlinesCheckbox.TextSize = 15
    addCorner(ExtraControls.ItemOutlinesCheckbox, 8, 8, 8, 8)
    addCorner(ExtraControls.ItemOutlinesModule, 8, 8, 8, 8)
    addStroke(ExtraControls.ItemOutlinesModule, C.UIStroke1, 1)

    AutomationPage.Name = "AutomationPage"
    AutomationPage.Parent = SelectedTab
    AutomationPage.BackgroundTransparency = 1
    AutomationPage.BorderSizePixel = 0
    AutomationPage.Size = UDim2.new(1, 0, 1, 0)
    AutomationPage.CanvasSize = UDim2.new(0, 0, 0, 0)
    AutomationPage.ScrollBarThickness = 4
    SectionAutomation.Name = "SectionAutomation"
    SectionAutomation.Parent = AutomationPage
    SectionAutomation.BackgroundTransparency = 1
    SectionAutomation.Size = UDim2.new(0, 400, 0, 15)
    SectionAutomation.FontFace = Font.fromEnum(Enum.Font.GothamBold)
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
    ExtraControls.MiscellaneousPage.ScrollBarThickness = 4
    ExtraControls.MiscellaneousPage.Active = true
    ExtraControls.MiscellaneousPage.ScrollingEnabled = true

    ExtraControls.FullbrightModule.Name = "FullbrightModule"
    ExtraControls.FullbrightModule.Parent = ExtraControls.MiscellaneousPage
    ExtraControls.FullbrightModule.BackgroundColor3 = C.Panel
    ExtraControls.FullbrightModule.BorderSizePixel = 0
    ExtraControls.FullbrightModule.Position = UDim2.new(0, 1, 0, 14)
    ExtraControls.FullbrightModule.Size = UDim2.new(0, 398, 0, 50)
    ExtraControls.FullbrightText.Name = "FullbrightText"
    ExtraControls.FullbrightText.Parent = ExtraControls.FullbrightModule
    ExtraControls.FullbrightText.BackgroundTransparency = 1
    ExtraControls.FullbrightText.Position = UDim2.new(0, 12, 0, 0)
    ExtraControls.FullbrightText.Size = UDim2.new(1, -70, 1, 0)
    ExtraControls.FullbrightText.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ExtraControls.FullbrightText.Text = "Fullbright"
    ExtraControls.FullbrightText.TextColor3 = C.White
    ExtraControls.FullbrightText.TextSize = 15
    ExtraControls.FullbrightText.TextXAlignment = Enum.TextXAlignment.Left
    ExtraControls.FullbrightCheckbox.Name = "FullbrightCheckbox"
    ExtraControls.FullbrightCheckbox.Parent = ExtraControls.FullbrightModule
    ExtraControls.FullbrightCheckbox.BackgroundColor3 = C.Red
    ExtraControls.FullbrightCheckbox.BorderSizePixel = 0
    ExtraControls.FullbrightCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ExtraControls.FullbrightCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ExtraControls.FullbrightCheckbox.AutoButtonColor = false
    ExtraControls.FullbrightCheckbox.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ExtraControls.FullbrightCheckbox.Text = "✓"
    ExtraControls.FullbrightCheckbox.TextColor3 = C.White
    ExtraControls.FullbrightCheckbox.TextSize = 15
    addCorner(ExtraControls.FullbrightCheckbox, 8, 8, 8, 8)
    addCorner(ExtraControls.FullbrightModule, 8, 8, 8, 8)
    addStroke(ExtraControls.FullbrightModule, C.UIStroke1, 1)

    ExtraControls.AntiAFKModule.Name = "AntiAFKModule"
    ExtraControls.AntiAFKModule.Parent = ExtraControls.MiscellaneousPage
    ExtraControls.AntiAFKModule.BackgroundColor3 = C.Panel
    ExtraControls.AntiAFKModule.BorderSizePixel = 0
    ExtraControls.AntiAFKModule.Position = UDim2.new(0, 1, 0, 76)
    ExtraControls.AntiAFKModule.Size = UDim2.new(0, 398, 0, 50)
    ExtraControls.AntiAFKText.Name = "AntiAFKText"
    ExtraControls.AntiAFKText.Parent = ExtraControls.AntiAFKModule
    ExtraControls.AntiAFKText.BackgroundTransparency = 1
    ExtraControls.AntiAFKText.Position = UDim2.new(0, 12, 0, 0)
    ExtraControls.AntiAFKText.Size = UDim2.new(1, -70, 1, 0)
    ExtraControls.AntiAFKText.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ExtraControls.AntiAFKText.Text = "Anti-AFK"
    ExtraControls.AntiAFKText.TextColor3 = C.White
    ExtraControls.AntiAFKText.TextSize = 15
    ExtraControls.AntiAFKText.TextXAlignment = Enum.TextXAlignment.Left
    ExtraControls.AntiAFKCheckbox.Name = "AntiAFKCheckbox"
    ExtraControls.AntiAFKCheckbox.Parent = ExtraControls.AntiAFKModule
    ExtraControls.AntiAFKCheckbox.BackgroundColor3 = C.Red
    ExtraControls.AntiAFKCheckbox.BorderSizePixel = 0
    ExtraControls.AntiAFKCheckbox.Position = UDim2.new(1, -38, 0.5, -13)
    ExtraControls.AntiAFKCheckbox.Size = UDim2.new(0, 26, 0, 26)
    ExtraControls.AntiAFKCheckbox.AutoButtonColor = false
    ExtraControls.AntiAFKCheckbox.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ExtraControls.AntiAFKCheckbox.Text = "✓"
    ExtraControls.AntiAFKCheckbox.TextColor3 = C.White
    ExtraControls.AntiAFKCheckbox.TextSize = 15
    addCorner(ExtraControls.AntiAFKCheckbox, 8, 8, 8, 8)
    addCorner(ExtraControls.AntiAFKModule, 8, 8, 8, 8)
    addStroke(ExtraControls.AntiAFKModule, C.UIStroke1, 1)

    Tabs.Name = "Tabs"
    Tabs.Parent = MainWindow
    Tabs.BackgroundTransparency = 1
    Tabs.Position = UDim2.new(0, 15, 0, 70)
    Tabs.Size = UDim2.new(0, 400, 0, 40)
    UIListLayout.Parent = Tabs
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Padding = UDim.new(0, 8)

    Entities.Name = "Detection"
    Entities.Parent = Tabs
    Entities.BackgroundColor3 = C.Surface
    Entities.BorderColor3 = C.Surface
    Entities.BorderSizePixel = 0
    Entities.Size = UDim2.new(1 / 3, -16 / 3, 1, 0)
    Entities.AutoButtonColor = false
    Entities.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    Entities.Text = "Detection"
    Entities.TextColor3 = C.White
    Entities.TextSize = 15
    addCorner(Entities, 8, 8, 8, 8)

    Automation.Name = "Automation"
    Automation.Parent = Tabs
    Automation.BackgroundColor3 = C.Surface
    Automation.BorderColor3 = C.Surface
    Automation.BorderSizePixel = 0
    Automation.Size = UDim2.new(1 / 3, -16 / 3, 1, 0)
    Automation.AutoButtonColor = false
    Automation.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    Automation.Text = "Automation"
    Automation.TextColor3 = C.White
    Automation.TextSize = 15
    addCorner(Automation, 8, 8, 8, 8)

    ExtraControls.MiscellaneousTab = Instance.new("TextButton")
    ExtraControls.MiscellaneousTab.Name = "Miscellaneous"
    ExtraControls.MiscellaneousTab.Parent = Tabs
    ExtraControls.MiscellaneousTab.BackgroundColor3 = C.Surface
    ExtraControls.MiscellaneousTab.BorderColor3 = C.Surface
    ExtraControls.MiscellaneousTab.BorderSizePixel = 0
    ExtraControls.MiscellaneousTab.Size = UDim2.new(1 / 3, -16 / 3, 1, 0)
    ExtraControls.MiscellaneousTab.AutoButtonColor = false
    ExtraControls.MiscellaneousTab.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    ExtraControls.MiscellaneousTab.Text = "Miscellaneous"
    ExtraControls.MiscellaneousTab.TextColor3 = C.White
    ExtraControls.MiscellaneousTab.TextSize = 15
    addCorner(ExtraControls.MiscellaneousTab, 8, 8, 8, 8)

    Notifications.Name = "Notifications"
    Notifications.Parent = DOORSEntityDetector
    Notifications.AnchorPoint = Vector2.new(1, 0)
    Notifications.BackgroundTransparency = 1
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
    ConfirmationText.BackgroundTransparency = 1
    ConfirmationText.Position = UDim2.new(0, 14, 0, 12)
    ConfirmationText.Size = UDim2.new(1, -28, 0, 25)
    ConfirmationText.ZIndex = 21
    ConfirmationText.FontFace = Font.fromEnum(Enum.Font.GothamBold)
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
    ConfirmationExplanation.FontFace = Font.fromEnum(Enum.Font.Gotham)
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
    Cancel.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    Cancel.Text = "Cancel"
    Cancel.TextColor3 = C.White
    Cancel.TextSize = 15
    addCorner(Cancel, 8, 8, 8, 8)

    CloseScript.Name = "CloseScript"
    CloseScript.Parent = CloseConfirmation
    CloseScript.BackgroundColor3 = C.Red
    CloseScript.BorderSizePixel = 0
    CloseScript.Position = UDim2.new(0.5, 7, 1, -45)
    CloseScript.Size = UDim2.new(0.5, -21, 0, 32)
    CloseScript.ZIndex = 21
    CloseScript.AutoButtonColor = false
    CloseScript.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
    CloseScript.Text = "Close Script"
    CloseScript.TextColor3 = C.White
    CloseScript.TextSize = 15
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

    ExtraControls.SetFullbrightEnabled = function(enabled)
        ExtraControls.FullbrightEnabled = enabled == true
        ExtraControls.FullbrightCheckbox.Text = ExtraControls.FullbrightEnabled and "✓" or ""
        ExtraControls.FullbrightCheckbox.BackgroundColor3 = ExtraControls.FullbrightEnabled
            and (ExtraControls.FullbrightHovering and C.RedHover or C.Red)
            or (ExtraControls.FullbrightHovering and C.SurfaceHover or C.Background)
    end

    ExtraControls.SetItemOutlinesEnabled = function(enabled)
        ExtraControls.ItemOutlinesEnabled = enabled == true
        ExtraControls.ItemOutlinesCheckbox.Text = ExtraControls.ItemOutlinesEnabled and "✓" or ""
        ExtraControls.ItemOutlinesCheckbox.BackgroundColor3 = ExtraControls.ItemOutlinesEnabled
            and (ExtraControls.ItemOutlinesHovering and C.RedHover or C.Red)
            or (ExtraControls.ItemOutlinesHovering and C.SurfaceHover or C.Background)
    end

    ExtraControls.SetAntiAFKEnabled = function(enabled)
        ExtraControls.AntiAFKEnabled = enabled == true
        ExtraControls.AntiAFKCheckbox.Text = ExtraControls.AntiAFKEnabled and "✓" or ""
        ExtraControls.AntiAFKCheckbox.BackgroundColor3 = ExtraControls.AntiAFKEnabled
            and (ExtraControls.AntiAFKHovering and C.RedHover or C.Red)
            or (ExtraControls.AntiAFKHovering and C.SurfaceHover or C.Background)
    end

    local fullSize = MainWindow.Size
    local smallSize = UDim2.new(fullSize.X.Scale, fullSize.X.Offset, 0, Header.Size.Y.Offset)
    local shrunk = false
    guiConnect(Resize.MouseButton1Click, function()
        shrunk = not shrunk
        MainWindow.Size = shrunk and smallSize or fullSize
        Resize.Text = shrunk and "□" or "▢"
    end)
    guiConnect(Minimize.MouseButton1Click, function() MainWindow.Visible = false end)
    guiConnect(UserInputService.InputBegan, function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.F1 then
            MainWindow.Visible = not MainWindow.Visible
        end
    end)

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

    local selectedTab = "Detection"
    local tabControls = {
        Detection = {button = Entities, page = EntitiesPage},
        Automation = {button = Automation, page = AutomationPage},
        Miscellaneous = {button = ExtraControls.MiscellaneousTab, page = ExtraControls.MiscellaneousPage},
    }
    local function switchTab(which)
        selectedTab = which
        for name, control in pairs(tabControls) do
            local active = name == which
            control.page.Visible = active
            control.button.BackgroundColor3 = active and C.Red or C.Surface
        end
    end
    guiConnect(Entities.MouseButton1Click, function() switchTab("Detection") end)
    guiConnect(Automation.MouseButton1Click, function() switchTab("Automation") end)
    guiConnect(ExtraControls.MiscellaneousTab.MouseButton1Click, function() switchTab("Miscellaneous") end)
    switchTab("Detection")

    local function wireHover(buttonObject, baseColor, hoverColor)
        if not buttonObject or not buttonObject:IsA("TextButton") then return end
        local base = baseColor or buttonObject.BackgroundColor3
        local hover = hoverColor or C.SurfaceHover
        local tabName = buttonObject == Entities and "Detection"
            or buttonObject == Automation and "Automation"
            or buttonObject == ExtraControls.MiscellaneousTab and "Miscellaneous"
        guiConnect(buttonObject.MouseEnter, function()
            if tabName then
                buttonObject.BackgroundColor3 = selectedTab == tabName and C.RedHover or hover
            elseif buttonObject == ModuleCheckbox then
                outlineHovering = true
                setOutlineEnabled(outlineEnabled)
            elseif buttonObject == ExtraControls.FullbrightCheckbox then
                ExtraControls.FullbrightHovering = true
                ExtraControls.SetFullbrightEnabled(ExtraControls.FullbrightEnabled)
            elseif buttonObject == ExtraControls.ItemOutlinesCheckbox then
                ExtraControls.ItemOutlinesHovering = true
                ExtraControls.SetItemOutlinesEnabled(ExtraControls.ItemOutlinesEnabled)
            elseif buttonObject == ExtraControls.AntiAFKCheckbox then
                ExtraControls.AntiAFKHovering = true
                ExtraControls.SetAntiAFKEnabled(ExtraControls.AntiAFKEnabled)
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
            elseif buttonObject == ExtraControls.FullbrightCheckbox then
                ExtraControls.FullbrightHovering = false
                ExtraControls.SetFullbrightEnabled(ExtraControls.FullbrightEnabled)
            elseif buttonObject == ExtraControls.ItemOutlinesCheckbox then
                ExtraControls.ItemOutlinesHovering = false
                ExtraControls.SetItemOutlinesEnabled(ExtraControls.ItemOutlinesEnabled)
            elseif buttonObject == ExtraControls.AntiAFKCheckbox then
                ExtraControls.AntiAFKHovering = false
                ExtraControls.SetAntiAFKEnabled(ExtraControls.AntiAFKEnabled)
            else
                buttonObject.BackgroundColor3 = base
            end
        end)
    end

    for _, object in ipairs(DOORSEntityDetector:GetDescendants()) do
        if object:IsA("TextButton") and object ~= ModuleCheckbox and object ~= ExtraControls.FullbrightCheckbox
            and object ~= ExtraControls.ItemOutlinesCheckbox and object ~= ExtraControls.AntiAFKCheckbox then
            if object == Close or object == CloseScript then
                wireHover(object, object.BackgroundColor3, C.RedHover)
            else
                wireHover(object)
            end
        end
    end
    wireHover(ModuleCheckbox)
    wireHover(ExtraControls.FullbrightCheckbox)
    wireHover(ExtraControls.ItemOutlinesCheckbox)
    wireHover(ExtraControls.AntiAFKCheckbox)

    setOutlineEnabled(true)
    ExtraControls.SetFullbrightEnabled(ExtraControls.FullbrightEnabled)
    ExtraControls.SetItemOutlinesEnabled(ExtraControls.ItemOutlinesEnabled)
    ExtraControls.SetAntiAFKEnabled(ExtraControls.AntiAFKEnabled)
    guiConnect(ModuleCheckbox.MouseButton1Click, function()
        setOutlineEnabled(not outlineEnabled)
        OutlineChanged:Fire(outlineEnabled)
    end)
    guiConnect(ExtraControls.FullbrightCheckbox.MouseButton1Click, function()
        ExtraControls.SetFullbrightEnabled(not ExtraControls.FullbrightEnabled)
        ExtraControls.FullbrightChanged:Fire(ExtraControls.FullbrightEnabled)
    end)
    guiConnect(ExtraControls.ItemOutlinesCheckbox.MouseButton1Click, function()
        ExtraControls.SetItemOutlinesEnabled(not ExtraControls.ItemOutlinesEnabled)
        ExtraControls.ItemOutlineChanged:Fire(ExtraControls.ItemOutlinesEnabled)
    end)
    guiConnect(ExtraControls.AntiAFKCheckbox.MouseButton1Click, function()
        ExtraControls.SetAntiAFKEnabled(not ExtraControls.AntiAFKEnabled)
        ExtraControls.AntiAFKChanged:Fire(ExtraControls.AntiAFKEnabled)
    end)

    -- Entity controls and dropdowns
    local EntityEnabledChanged = Instance.new("BindableEvent")
    local NameTagModeChanged = Instance.new("BindableEvent")
    local dropdownOpen = {Entities = false, NameTags = false, Items = false}
    local entityEnabledState = enabledEntities or {}
    for _, entity in ipairs(entityDefinitions) do
        if entityEnabledState[entity.name] == nil then entityEnabledState[entity.name] = true end
    end
    if entityEnabledState.__Portrait == nil then entityEnabledState.__Portrait = true end
    local nameTagMode = (initialNameTagMode == "All" or initialNameTagMode == "None")
        and initialNameTagMode or "Recommended"

    local entityListLayout, nameTagChoices, itemListLayout
    local DROPDOWN_MAX_HEIGHT = 250
    local DROPDOWN_TWEEN_INFO = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local dropdownTweens = {}
    local dropdownTweenConnections = {}
    local originalParentCornerRadii = {}
    local parentCornerCache = {}

    local function setParentDropdownCorners(parent, isOpen)
        local corner = parentCornerCache[parent]
        if corner == nil then
            corner = parent:FindFirstChildOfClass("UICorner") or false
            parentCornerCache[parent] = corner
        end
        if corner == false then return end
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
        -- A closing tween has a Completed connection. Disconnect it before
        -- cancelling/replacing the tween so rapid open/close clicks cannot leave
        -- callbacks retained by abandoned Tween instances.
        local previousConnection = dropdownTweenConnections[clip]
        if previousConnection then
            pcall(function() previousConnection:Disconnect() end)
            dropdownTweenConnections[clip] = nil
        end
        if dropdownTweens[clip] then
            pcall(function() dropdownTweens[clip]:Cancel() end)
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
            local completionConnection
            completionConnection = closingTween.Completed:Connect(function(playbackState)
                if dropdownTweenConnections[clip] == completionConnection then
                    dropdownTweenConnections[clip] = nil
                end
                if dropdownTweens[clip] == closingTween
                    and playbackState == Enum.PlaybackState.Completed then
                    clip.Visible = false
                    dropdownTweens[clip] = nil
                    if onClosed then onClosed() end
                end
                if completionConnection then
                    completionConnection:Disconnect()
                end
            end)
            dropdownTweenConnections[clip] = completionConnection
            closingTween:Play()
        end
    end

    -- Entity and item rows share one renderer so their spacing, hover behavior,
    -- checkbox sizing, and click targets remain identical.
    local function createDetectionRow(definition, order, dropdownTarget, enabledState, changedEvent, rowPrefix)
        local row = Instance.new("Frame")
        row.Name = rowPrefix .. "Option_" .. tostring(definition.name)
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.Size = UDim2.new(1, -8, 0, 34)
        row.LayoutOrder = order
        row.ZIndex = 4
        row.Parent = dropdownTarget
        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0, 5)
        rowCorner.Parent = row

        local optionLabel = Instance.new("TextLabel")
        optionLabel.Name = rowPrefix .. "Name"
        optionLabel.BackgroundTransparency = 1
        optionLabel.Position = UDim2.new(0, 10, 0, 0)
        optionLabel.Size = UDim2.new(1, -52, 1, 0)
        optionLabel.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
        optionLabel.Text = tostring(definition.display or definition.name)
        optionLabel.TextColor3 = C.White
        optionLabel.TextSize = 14
        optionLabel.TextXAlignment = Enum.TextXAlignment.Left
        optionLabel.ZIndex = 5
        optionLabel.Parent = row

        local checkbox = Instance.new("TextButton")
        checkbox.Name = rowPrefix .. "Checkbox"
        checkbox.BackgroundColor3 = C.Red
        checkbox.BorderSizePixel = 0
        checkbox.Position = UDim2.new(1, -36, 0.5, -13)
        checkbox.Size = UDim2.new(0, 26, 0, 26)
        checkbox.AutoButtonColor = false
        checkbox.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
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
        local function updateRow()
            local enabled = enabledState[definition.name] ~= false
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
            enabledState[definition.name] = not (enabledState[definition.name] ~= false)
            updateRow()
            changedEvent:Fire(definition.name, enabledState[definition.name])
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
                if stateName == "main" then mainHovering = true else checkboxHovering = true end
                updateRow()
            end)
            guiConnect(target.MouseLeave, function()
                if stateName == "main" then mainHovering = false else checkboxHovering = false end
                updateRow()
            end)
        end
        updateRow()
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
        createDetectionRow(entity, order, Dropdown, entityEnabledState, EntityEnabledChanged, "Entity")
    end
    for _, item in ipairs(itemDefinitions) do
        if enabledItems[item.name] == nil then enabledItems[item.name] = true end
    end
    nameTagChoices = configureDropdownContent(Dropdown_2)
    itemListLayout = configureDropdownContent(ExtraControls.ItemDropdown)
    local itemRows = table.clone(itemDefinitions)
    table.sort(itemRows, function(a, b)
        return string.lower(a.display or a.name) < string.lower(b.display or b.name)
    end)
    for order, item in ipairs(itemRows) do
        createDetectionRow(item, order, ExtraControls.ItemDropdown, enabledItems, ExtraControls.ItemEnabledChanged, "Item")
    end

    local dropdownControls = {
        Entities = {module = EntityListModule, arrow = Arrow, dropdown = Dropdown, clip = DropdownClip, layout = entityListLayout},
        NameTags = {module = NameTagModule, arrow = Arrow_2, dropdown = Dropdown_2, clip = DropdownClip_2, layout = nameTagChoices},
        Items = {module = ExtraControls.ItemListModule, arrow = ExtraControls.ItemArrow, dropdown = ExtraControls.ItemDropdown, clip = ExtraControls.ItemDropdownClip, layout = itemListLayout},
    }

    local function setDropdownOpen(name, open)
        local control = dropdownControls[name]
        if not control then return end
        local isOpen = open == true
        dropdownOpen[name] = isOpen
        if name == "Items" and isOpen then
            -- Expand the page's scrollable canvas only while the item popup is open.
            EntitiesPage.CanvasSize = UDim2.new(0, 0, 0, 560)
        elseif name == "Items" or (isOpen and name ~= "Items") then
            EntitiesPage.CanvasSize = UDim2.new(0, 0, 0, 440)
            EntitiesPage.CanvasPosition = Vector2.new(0, 0)
        end
        if isOpen then
            for otherName, other in pairs(dropdownControls) do
                if otherName ~= name and dropdownOpen[otherName] then
                    dropdownOpen[otherName] = false
                    animateDropdown(other.dropdown, other.layout, other.clip, false, function()
                        setParentDropdownCorners(other.module, false)
                    end)
                    other.arrow.Text = "ꜜ"
                end
            end
            setParentDropdownCorners(control.module, true)

            -- Keep the entire item popup inside the detection page viewport.
            -- The popup still uses the same clipping frame, tween, and max height
            -- as the entity dropdown; the page simply scrolls to reveal it.
            if name == "Items" then
                local targetHeight = updateDropdownHeight(control.dropdown, control.layout)
                local contentBottom = control.module.Position.Y.Offset + control.module.Size.Y.Offset + targetHeight
                local viewportHeight = EntitiesPage.AbsoluteSize.Y
                local desiredY = math.max(0, contentBottom - viewportHeight + 8)
                local maxY = math.max(0, EntitiesPage.CanvasSize.Y.Offset - viewportHeight)
                desiredY = math.min(desiredY, maxY)
                if desiredY > EntitiesPage.CanvasPosition.Y then
                    EntitiesPage.CanvasPosition = Vector2.new(0, desiredY)
                end
            else
                EntitiesPage.CanvasPosition = Vector2.new(0, 0)
            end
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
        option.FontFace = Font.fromEnum(Enum.Font.GothamMedium)
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
    setParentDropdownCorners(ExtraControls.ItemListModule, false)

    guiConnect(EntityListModule.MouseButton1Click, function()
        setDropdownOpen("Entities", not dropdownOpen.Entities)
    end)
    guiConnect(NameTagModule.MouseButton1Click, function()
        setDropdownOpen("NameTags", not dropdownOpen.NameTags)
    end)
    guiConnect(ExtraControls.ItemListModule.MouseButton1Click, function()
        setDropdownOpen("Items", not dropdownOpen.Items)
    end)

    guiConnect(Close.MouseButton1Click, function() CloseConfirmation.Visible = true end)
    guiConnect(Cancel.MouseButton1Click, function() CloseConfirmation.Visible = false end)

    -- Unload and exported interface
    local function disconnectGuiConnections()
        for _, connection in ipairs(guiConnections) do
            pcall(function() connection:Disconnect() end)
        end
        table.clear(guiConnections)

        for clip, connection in pairs(dropdownTweenConnections) do
            pcall(function() connection:Disconnect() end)
            dropdownTweenConnections[clip] = nil
        end
        for clip, tween in pairs(dropdownTweens) do
            pcall(function() tween:Cancel() end)
            dropdownTweens[clip] = nil
        end
    end

    local signalFontsReady
    local guiClosing = false
    local function closeScriptNow()
        if guiClosing then return end
        guiClosing = true
        UnloadRequested:Fire()
        if signalFontsReady then signalFontsReady(false) end
        disconnectGuiConnections()
        task.defer(function()
            if DOORSEntityDetector and DOORSEntityDetector.Parent then
                DOORSEntityDetector:Destroy()
            end
        end)
    end
    guiConnect(CloseScript.MouseButton1Click, closeScriptNow)

    local guiReferences = {
        ScreenGui = DOORSEntityDetector,
        MainWindow = MainWindow,
        Resize = Resize,
        Minimize = Minimize,
        Close = Close,
        CloseConfirmation = CloseConfirmation,
        CancelClose = Cancel,
        ConfirmClose = CloseScript,
        DetectionTab = Entities,
        EntitiesTab = Entities, -- Compatibility for older integrations.
        AutomationTab = Automation,
        MiscellaneousTab = ExtraControls.MiscellaneousTab,
        DetectionPage = EntitiesPage,
        EntitiesPage = EntitiesPage, -- Compatibility for older integrations.
        AutomationPage = AutomationPage,
        MiscellaneousPage = ExtraControls.MiscellaneousPage,
        EntityListModule = EntityListModule,
        ItemListModule = ExtraControls.ItemListModule,
        NameTagModule = NameTagModule,
        EntityOutlinesModule = EntityOutlinesModule,
        OutlineToggle = ModuleCheckbox,
        OutlineChanged = OutlineChanged,
        EntityEnabledChanged = EntityEnabledChanged,
        ItemEnabledChanged = ExtraControls.ItemEnabledChanged,
        ItemOutlineChanged = ExtraControls.ItemOutlineChanged,
        SetItemOutlinesEnabled = ExtraControls.SetItemOutlinesEnabled,
        AntiAFKChanged = ExtraControls.AntiAFKChanged,
        SetAntiAFKEnabled = ExtraControls.SetAntiAFKEnabled,
        NameTagModeChanged = NameTagModeChanged,
        ItemOutlinesToggle = ExtraControls.ItemOutlinesCheckbox,
        AntiAFKToggle = ExtraControls.AntiAFKCheckbox,
        FullbrightToggle = ExtraControls.FullbrightCheckbox,
        FullbrightChanged = ExtraControls.FullbrightChanged,
        SetFullbrightEnabled = ExtraControls.SetFullbrightEnabled,
        UnloadRequested = UnloadRequested,
        CloseScriptNow = closeScriptNow,
        SetOutlineEnabled = setOutlineEnabled,
        Notifications = Notifications,
        WaitForFonts = function()
            if not fontsReady then fontsReadyEvent.Event:Wait() end
            return fontLoadSucceeded
        end,
    }

    signalFontsReady = function(success)
        if fontsReady then return end
        fontsReady = true
        fontLoadSucceeded = success == true
        fontsReadyEvent:Fire(fontLoadSucceeded)
    end
    guiConnect(DOORSEntityDetector.Destroying, function() signalFontsReady(false) end)

    local function getFontFamilyUri(fontFace)
        local family = fontFace.Family
        if type(family) == "string" and family ~= "" then return family end
        local ok, sourceType, uri = pcall(function() return family.SourceType, family.Uri end)
        if ok and sourceType == Enum.ContentSourceType.Uri and type(uri) == "string" and uri ~= "" then
            return uri
        end
        return nil
    end

    local function collectFontAssets()
        local textObjects = {}
        local fontFamilies = {}
        local requestedFaces = {}
        local requestedFaceKeys = {}
        for _, object in ipairs(DOORSEntityDetector:GetDescendants()) do
            if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
                textObjects[#textObjects + 1] = object
                local fontFace = object.FontFace
                local familyUri = getFontFamilyUri(fontFace)
                if not familyUri then return nil, nil, nil end
                fontFamilies[familyUri] = true
                local faceKey = familyUri .. "|" .. tostring(fontFace.Weight) .. "|" .. tostring(fontFace.Style)
                if not requestedFaceKeys[faceKey] then
                    requestedFaceKeys[faceKey] = true
                    requestedFaces[#requestedFaces + 1] = {family = familyUri, font = fontFace}
                end
            end
        end
        return textObjects, fontFamilies, requestedFaces
    end

    local function tryPreload(textObjects, fontFamilies, requestedFaces)
        local familyInfoByUri = {}
        for familyUri in pairs(fontFamilies) do
            local familyLoaded, familyInfo = pcall(function()
                return TextService:GetFamilyInfoAsync(familyUri)
            end)
            if not familyLoaded or type(familyInfo) ~= "table" or type(familyInfo.Faces) ~= "table"
                or next(familyInfo.Faces) == nil then
                return false
            end
            familyInfoByUri[familyUri] = familyInfo
        end
        for _, requested in ipairs(requestedFaces) do
            local familyInfo = familyInfoByUri[requested.family]
            local matchingFace = false
            for _, availableFace in pairs(familyInfo.Faces) do
                if availableFace.Weight == requested.font.Weight and availableFace.Style == requested.font.Style then
                    matchingFace = true
                    break
                end
            end
            if not matchingFace then return false end
        end
        local preloadItems = {}
        for _, object in ipairs(textObjects) do preloadItems[#preloadItems + 1] = object end
        local failedAsset = false
        local callSucceeded = pcall(function()
            ContentProvider:PreloadAsync(preloadItems, function(_, status)
                if status ~= Enum.AssetFetchStatus.Success then failedAsset = true end
            end)
        end)
        if not callSucceeded or failedAsset then return false end
        for _, requested in ipairs(requestedFaces) do
            local params = Instance.new("GetTextBoundsParams")
            params.Text = "Auto Doors"
            params.Font = requested.font
            params.Size = 20
            params.Width = 1000
            local boundsOk, bounds = pcall(function() return TextService:GetTextBoundsAsync(params) end)
            params:Destroy()
            if not boundsOk or typeof(bounds) ~= "Vector2" or bounds.X <= 0 or bounds.Y <= 0 then
                return false
            end
        end
        return true
    end

    local function preloadFonts()
        local textObjects, fontFamilies, requestedFaces = collectFontAssets()
        local attempt = 0
        while DOORSEntityDetector.Parent do
            attempt += 1
            if textObjects and fontFamilies and requestedFaces and tryPreload(textObjects, fontFamilies, requestedFaces) then
                DOORSEntityDetector.Enabled = true
                local renderSucceeded = pcall(function()
                    RunService.RenderStepped:Wait()
                    RunService.RenderStepped:Wait()
                end)
                if renderSucceeded and DOORSEntityDetector.Parent then
                    signalFontsReady(true)
                    return
                end
                DOORSEntityDetector.Enabled = false
            end
            if attempt == 1 or attempt % 5 == 0 then
                warn("[Auto Doors] GUI font resources are not ready; retrying (attempt " .. attempt .. ").")
            end
            task.wait(math.min(0.5 * (2 ^ math.min(attempt - 1, 4)), 8))
        end
        signalFontsReady(false)
    end

    task.spawn(preloadFonts)
    return guiReferences
end

local mainEntities, mainEnabledEntities, mainNameTagMode, mainFullbrightEnabled = ...
if mainEntities ~= nil then
    return buildGUI(mainEntities, mainEnabledEntities, mainNameTagMode, mainFullbrightEnabled)
end
return buildGUI()
