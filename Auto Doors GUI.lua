local DOORSEntityDetector = Instance.new("ScreenGui")
local MainWindow = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
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
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local UICorner_8 = Instance.new("UICorner")
local SectionEntityDetection = Instance.new("TextLabel")
local EntityListModule = Instance.new("TextButton")
local UICorner_9 = Instance.new("UICorner")
local TextLabel_2 = Instance.new("TextLabel")
local NameTagModule = Instance.new("TextButton")
local UICorner_10 = Instance.new("UICorner")
local TextLabel_3 = Instance.new("TextLabel")
local AutomationPage = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
local Frame = Instance.new("Frame")
local TextLabel_4 = Instance.new("TextLabel")
local Frame_2 = Instance.new("Frame")
local UICorner_11 = Instance.new("UICorner")
local TextLabel_5 = Instance.new("TextLabel")
local TextLabel_6 = Instance.new("TextLabel")
local Frame_3 = Instance.new("Frame")
local UICorner_12 = Instance.new("UICorner")
local TextLabel_7 = Instance.new("TextLabel")
local TextLabel_8 = Instance.new("TextLabel")
local Tabs = Instance.new("Frame")
local UIListLayout_2 = Instance.new("UIListLayout")
local Entities = Instance.new("TextButton")
local UICorner_13 = Instance.new("UICorner")
local Automation = Instance.new("TextButton")
local UICorner_14 = Instance.new("UICorner")
local Notifications = Instance.new("Frame")
local UIListLayout_3 = Instance.new("UIListLayout")
local CloseConfirmation = Instance.new("Frame")
local UICorner_15 = Instance.new("UICorner")
local TextLabel_9 = Instance.new("TextLabel")
local TextLabel_10 = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local UICorner_16 = Instance.new("UICorner")
local TextButton_3 = Instance.new("TextButton")
local UICorner_17 = Instance.new("UICorner")

--Properties:

DOORSEntityDetector.Name = "DOORSEntityDetector"
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

DOORSEntityDetector.Parent = LocalPlayer:WaitForChild("PlayerGui")DOORSEntityDetector.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
DOORSEntityDetector.DisplayOrder = 9999
DOORSEntityDetector.ResetOnSpawn = false

MainWindow.Name = "MainWindow"
MainWindow.Parent = DOORSEntityDetector
MainWindow.BackgroundColor3 = Color3.fromRGB(17, 19, 27)
MainWindow.BorderSizePixel = 0
MainWindow.ClipsDescendants = true
MainWindow.Position = UDim2.new(0, 350, 0, 1)
MainWindow.Size = UDim2.new(0, 430, 0, 600)

UICorner.CornerRadius = UDim.new(0, 11)
UICorner.Parent = MainWindow

Header.Name = "Header"
Header.Parent = MainWindow
Header.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(0, 430, 0, 60)

UICorner_2.CornerRadius = UDim.new(0, 11)
UICorner_2.Parent = Header

TitleLine.Name = "TitleLine"
TitleLine.Parent = Header
TitleLine.BackgroundColor3 = Color3.fromRGB(255, 73, 84)
TitleLine.BorderColor3 = Color3.fromRGB(255, 73, 84)
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
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 19.000
Title.TextXAlignment = Enum.TextXAlignment.Left

Description.Name = "Description"
Description.Parent = Header
Description.BackgroundTransparency = 1.000
Description.Position = UDim2.new(0, 18, 0, 34)
Description.Size = UDim2.new(1, -150, 0, 16)
Description.Font = Enum.Font.GothamMedium
Description.Text = "ENTITY DETECTION  /  AUTOMATION"
Description.TextColor3 = Color3.fromRGB(157, 163, 180)
Description.TextSize = 9.000
Description.TextXAlignment = Enum.TextXAlignment.Left

Resize.Name = "Resize"
Resize.Parent = Header
Resize.BackgroundColor3 = Color3.fromRGB(29, 32, 43)
Resize.BorderSizePixel = 0
Resize.Position = UDim2.new(0, 355, 0, 15)
Resize.Size = UDim2.new(0, 30, 0, 30)
Resize.AutoButtonColor = false
Resize.Font = Enum.Font.GothamBold
Resize.Text = "▢"
Resize.TextColor3 = Color3.fromRGB(255, 255, 255)
Resize.TextSize = 15.000

UICorner_4.CornerRadius = UDim.new(0, 7)
UICorner_4.Parent = Resize

Minimize.Name = "Minimize"
Minimize.Parent = Header
Minimize.BackgroundColor3 = Color3.fromRGB(29, 32, 43)
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0, 320, 0, 15)
Minimize.Size = UDim2.new(0, 30, 0, 30)
Minimize.AutoButtonColor = false
Minimize.Font = Enum.Font.GothamMedium
Minimize.Text = "—"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextSize = 15.000

UICorner_5.CornerRadius = UDim.new(0, 7)
UICorner_5.Parent = Minimize

Close.Name = "Close"
Close.Parent = Header
Close.BackgroundColor3 = Color3.fromRGB(132, 39, 49)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0, 390, 0, 15)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.AutoButtonColor = false
Close.Font = Enum.Font.Gotham
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 40.000

UICorner_6.CornerRadius = UDim.new(0, 7)
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
EntitiesPage.CanvasSize = UDim2.new(0, 0, 0, 0)
EntitiesPage.ScrollBarThickness = 4

EntityOutlinesModule.Name = "EntityOutlinesModule"
EntityOutlinesModule.Parent = EntitiesPage
EntityOutlinesModule.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
EntityOutlinesModule.BorderSizePixel = 0
EntityOutlinesModule.Position = UDim2.new(0, 1, 0, 135)
EntityOutlinesModule.Size = UDim2.new(0, 398, 0, 50)

TextLabel.Parent = EntityOutlinesModule
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0, 12, 0, 0)
TextLabel.Size = UDim2.new(1, -70, 1, 0)
TextLabel.Font = Enum.Font.GothamMedium
TextLabel.Text = "Entity Outlines"
TextLabel.TextColor3 = Color3.fromRGB(245, 246, 250)
TextLabel.TextSize = 15.000
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

TextButton.Parent = EntityOutlinesModule
TextButton.BackgroundColor3 = Color3.fromRGB(132, 39, 49)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(1, -38, 0.5, -13)
TextButton.Size = UDim2.new(0, 26, 0, 26)
TextButton.AutoButtonColor = false
TextButton.Font = Enum.Font.GothamMedium
TextButton.Text = "✓"
TextButton.TextColor3 = Color3.fromRGB(245, 246, 250)
TextButton.TextSize = 15.000

UICorner_7.CornerRadius = UDim.new(0, 7)
UICorner_7.Parent = TextButton

UICorner_8.Parent = EntityOutlinesModule

SectionEntityDetection.Name = "SectionEntityDetection"
SectionEntityDetection.Parent = EntitiesPage
SectionEntityDetection.BackgroundTransparency = 1.000
SectionEntityDetection.Size = UDim2.new(0, 400, 0, 15)
SectionEntityDetection.Font = Enum.Font.GothamBold
SectionEntityDetection.Text = "Entity Detection:"
SectionEntityDetection.TextColor3 = Color3.fromRGB(255, 73, 84)
SectionEntityDetection.TextSize = 14.000
SectionEntityDetection.TextXAlignment = Enum.TextXAlignment.Left

EntityListModule.Name = "EntityListModule"
EntityListModule.Parent = EntitiesPage
EntityListModule.BackgroundColor3 = Color3.fromRGB(29, 32, 43)
EntityListModule.BorderSizePixel = 0
EntityListModule.Position = UDim2.new(0, 0, 0, 25)
EntityListModule.Size = UDim2.new(0, 400, 0, 45)
EntityListModule.AutoButtonColor = false
EntityListModule.Font = Enum.Font.GothamMedium
EntityListModule.Text = "  Entities Detected:"
EntityListModule.TextColor3 = Color3.fromRGB(255, 255, 255)
EntityListModule.TextSize = 15.000
EntityListModule.TextXAlignment = Enum.TextXAlignment.Left

UICorner_9.CornerRadius = UDim.new(0, 7)
UICorner_9.Parent = EntityListModule

TextLabel_2.Parent = EntityListModule
TextLabel_2.AnchorPoint = Vector2.new(1, 0.5)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(1, -3, 0.75, 0)
TextLabel_2.Size = UDim2.new(0, 25, 0, 30)
TextLabel_2.Font = Enum.Font.GothamBold
TextLabel_2.Text = "ꜜ"
TextLabel_2.TextColor3 = Color3.fromRGB(245, 246, 250)
TextLabel_2.TextSize = 30.000
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

NameTagModule.Name = "NameTagModule"
NameTagModule.Parent = EntitiesPage
NameTagModule.BackgroundColor3 = Color3.fromRGB(29, 32, 43)
NameTagModule.BorderSizePixel = 0
NameTagModule.Position = UDim2.new(0, 0, 0, 80)
NameTagModule.Size = UDim2.new(0, 400, 0, 45)
NameTagModule.AutoButtonColor = false
NameTagModule.Font = Enum.Font.GothamMedium
NameTagModule.Text = "  Name Tags: Recommended"
NameTagModule.TextColor3 = Color3.fromRGB(255, 255, 255)
NameTagModule.TextSize = 15.000
NameTagModule.TextXAlignment = Enum.TextXAlignment.Left

UICorner_10.CornerRadius = UDim.new(0, 7)
UICorner_10.Parent = NameTagModule

TextLabel_3.Parent = NameTagModule
TextLabel_3.AnchorPoint = Vector2.new(1, 0.5)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Position = UDim2.new(1, -3, 0.75, 0)
TextLabel_3.Size = UDim2.new(0, 25, 0, 30)
TextLabel_3.Font = Enum.Font.GothamBold
TextLabel_3.Text = "ꜛ"
TextLabel_3.TextColor3 = Color3.fromRGB(245, 246, 250)
TextLabel_3.TextSize = 30.000
TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

AutomationPage.Name = "AutomationPage"
AutomationPage.Parent = SelectedTab
AutomationPage.BackgroundTransparency = 1.000
AutomationPage.BorderSizePixel = 0
AutomationPage.Size = UDim2.new(1, 0, 1, 0)
AutomationPage.Visible = false
AutomationPage.CanvasSize = UDim2.new(0, 0, 0, 0)
AutomationPage.ScrollBarThickness = 4

UIListLayout.Parent = AutomationPage
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

UIPadding.Parent = AutomationPage
UIPadding.PaddingBottom = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 2)
UIPadding.PaddingRight = UDim.new(0, 5)
UIPadding.PaddingTop = UDim.new(0, 4)

Frame.Parent = AutomationPage
Frame.BackgroundTransparency = 1.000
Frame.Size = UDim2.new(1, 0, 0, 25)

TextLabel_4.Parent = Frame
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.Size = UDim2.new(1, 0, 1, 0)
TextLabel_4.Font = Enum.Font.GothamBold
TextLabel_4.Text = "Automation"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 73, 84)
TextLabel_4.TextSize = 14.000
TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left

Frame_2.Parent = AutomationPage
Frame_2.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
Frame_2.BorderSizePixel = 0
Frame_2.Size = UDim2.new(1, 0, 0, 68)

UICorner_11.Parent = Frame_2

TextLabel_5.Parent = Frame_2
TextLabel_5.BackgroundTransparency = 1.000
TextLabel_5.Position = UDim2.new(0, 12, 0, 8)
TextLabel_5.Size = UDim2.new(1, -24, 0, 20)
TextLabel_5.Font = Enum.Font.GothamBold
TextLabel_5.Text = "Loot Pathing"
TextLabel_5.TextColor3 = Color3.fromRGB(245, 246, 250)
TextLabel_5.TextSize = 14.000
TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_6.Parent = Frame_2
TextLabel_6.BackgroundTransparency = 1.000
TextLabel_6.Position = UDim2.new(0, 12, 0, 33)
TextLabel_6.Size = UDim2.new(1, -24, 0, 20)
TextLabel_6.Font = Enum.Font.Gotham
TextLabel_6.Text = "Not running — automation is not implemented yet"
TextLabel_6.TextColor3 = Color3.fromRGB(157, 163, 180)
TextLabel_6.TextSize = 12.000
TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left

Frame_3.Parent = AutomationPage
Frame_3.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
Frame_3.BorderSizePixel = 0
Frame_3.Size = UDim2.new(1, 0, 0, 100)

UICorner_12.Parent = Frame_3

TextLabel_7.Parent = Frame_3
TextLabel_7.BackgroundTransparency = 1.000
TextLabel_7.Position = UDim2.new(0, 12, 0, 8)
TextLabel_7.Size = UDim2.new(1, -24, 0, 20)
TextLabel_7.Font = Enum.Font.GothamBold
TextLabel_7.Text = "Planned Features"
TextLabel_7.TextColor3 = Color3.fromRGB(255, 73, 84)
TextLabel_7.TextSize = 13.000
TextLabel_7.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_8.Parent = Frame_3
TextLabel_8.BackgroundTransparency = 1.000
TextLabel_8.Position = UDim2.new(0, 12, 0, 31)
TextLabel_8.Size = UDim2.new(1, -24, 0, 64)
TextLabel_8.Font = Enum.Font.Gotham
TextLabel_8.Text = "• Identify lootable drawers and containers\\n• Learn optimal paths through each room\\n• Automate looting\\n• Plan entity avoidance"
TextLabel_8.TextColor3 = Color3.fromRGB(157, 163, 180)
TextLabel_8.TextSize = 13.000
TextLabel_8.TextWrapped = true
TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_8.TextYAlignment = Enum.TextYAlignment.Top

Tabs.Name = "Tabs"
Tabs.Parent = MainWindow
Tabs.BackgroundTransparency = 1.000
Tabs.Position = UDim2.new(0, 15, 0, 70)
Tabs.Size = UDim2.new(0, 400, 0, 40)

UIListLayout_2.Parent = Tabs
UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_2.Padding = UDim.new(0, 8)

Entities.Name = "Entities"
Entities.Parent = Tabs
Entities.BackgroundColor3 = Color3.fromRGB(132, 39, 49)
Entities.BorderSizePixel = 0
Entities.Size = UDim2.new(0.5, -4, 1, 0)
Entities.AutoButtonColor = false
Entities.Font = Enum.Font.GothamMedium
Entities.Text = "Entities"
Entities.TextColor3 = Color3.fromRGB(245, 246, 250)
Entities.TextSize = 15.000

UICorner_13.CornerRadius = UDim.new(0, 7)
UICorner_13.Parent = Entities

Automation.Name = "Automation"
Automation.Parent = Tabs
Automation.BackgroundColor3 = Color3.fromRGB(29, 32, 43)
Automation.BorderSizePixel = 0
Automation.Size = UDim2.new(0.5, -4, 1, 0)
Automation.AutoButtonColor = false
Automation.Font = Enum.Font.GothamMedium
Automation.Text = "Automation"
Automation.TextColor3 = Color3.fromRGB(245, 246, 250)
Automation.TextSize = 15.000

UICorner_14.CornerRadius = UDim.new(0, 7)
UICorner_14.Parent = Automation

Notifications.Name = "Notifications"
Notifications.Parent = DOORSEntityDetector
Notifications.AnchorPoint = Vector2.new(1, 0)
Notifications.BackgroundTransparency = 1.000
Notifications.Position = UDim2.new(1, -22, 0, 22)
Notifications.Size = UDim2.new(0, 320, 0, 390)

UIListLayout_3.Parent = Notifications
UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout_3.Padding = UDim.new(0, 9)

CloseConfirmation.Name = "CloseConfirmation"
CloseConfirmation.Parent = DOORSEntityDetector
CloseConfirmation.AnchorPoint = Vector2.new(0.5, 0.5)
CloseConfirmation.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
CloseConfirmation.BorderSizePixel = 0
CloseConfirmation.Position = UDim2.new(0.5, 0, 0.5, 0)
CloseConfirmation.Size = UDim2.new(0, 310, 0, 145)
CloseConfirmation.Visible = false
CloseConfirmation.ZIndex = 20

UICorner_15.CornerRadius = UDim.new(0, 10)
UICorner_15.Parent = CloseConfirmation

TextLabel_9.Parent = CloseConfirmation
TextLabel_9.BackgroundTransparency = 1.000
TextLabel_9.Position = UDim2.new(0, 14, 0, 12)
TextLabel_9.Size = UDim2.new(1, -28, 0, 25)
TextLabel_9.ZIndex = 21
TextLabel_9.Font = Enum.Font.GothamBold
TextLabel_9.Text = "Close Auto Doors?"
TextLabel_9.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_9.TextSize = 15.000
TextLabel_9.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_10.Parent = CloseConfirmation
TextLabel_10.BackgroundTransparency = 1.000
TextLabel_10.Position = UDim2.new(0, 14, 0, 40)
TextLabel_10.Size = UDim2.new(1, -28, 0, 32)
TextLabel_10.ZIndex = 21
TextLabel_10.Font = Enum.Font.Gotham
TextLabel_10.Text = "This will stop detection and remove all script visuals."
TextLabel_10.TextColor3 = Color3.fromRGB(157, 163, 180)
TextLabel_10.TextSize = 11.000
TextLabel_10.TextWrapped = true
TextLabel_10.TextXAlignment = Enum.TextXAlignment.Left

TextButton_2.Parent = CloseConfirmation
TextButton_2.BackgroundColor3 = Color3.fromRGB(29, 32, 43)
TextButton_2.BorderSizePixel = 0
TextButton_2.Position = UDim2.new(0, 14, 1, -45)
TextButton_2.Size = UDim2.new(0.5, -21, 0, 32)
TextButton_2.ZIndex = 21
TextButton_2.AutoButtonColor = false
TextButton_2.Font = Enum.Font.GothamMedium
TextButton_2.Text = "Cancel"
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextSize = 15.000

UICorner_16.CornerRadius = UDim.new(0, 7)
UICorner_16.Parent = TextButton_2

TextButton_3.Parent = CloseConfirmation
TextButton_3.BackgroundColor3 = Color3.fromRGB(132, 39, 49)
TextButton_3.BorderSizePixel = 0
TextButton_3.Position = UDim2.new(0.5, 7, 1, -45)
TextButton_3.Size = UDim2.new(0.5, -21, 0, 32)
TextButton_3.ZIndex = 21
TextButton_3.AutoButtonColor = false
TextButton_3.Font = Enum.Font.GothamMedium
TextButton_3.Text = "Close Script"
TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.TextSize = 15.000

UICorner_17.CornerRadius = UDim.new(0, 7)
UICorner_17.Parent = TextButton_3
return {
    ScreenGui = DOORSEntityDetector,
    MainWindow = MainWindow,

    -- Window controls
    Resize = Resize,
    Minimize = Minimize,
    Close = Close,
    CloseConfirmation = CloseConfirmation,
    CancelClose = TextButton_2,
    ConfirmClose = TextButton_3,

    -- Tabs
    EntitiesTab = Entities,
    AutomationTab = Automation,
    EntitiesPage = EntitiesPage,
    AutomationPage = AutomationPage,

    -- Entity settings
    EntityListModule = EntityListModule,
    NameTagModule = NameTagModule,
    EntityOutlinesModule = EntityOutlinesModule,
    OutlineToggle = TextButton,

    -- Notifications
    Notifications = Notifications,
}