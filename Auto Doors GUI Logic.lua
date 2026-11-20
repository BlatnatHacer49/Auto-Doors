return function(context)
    local C = context.C
    local AutoDoors = context.AutoDoors
    local MainWindow = context.MainWindow
    local Header = context.Header
    local Resize = context.Resize
    local Minimize = context.Minimize
    local Close = context.Close
    local DetectionPage = context.DetectionPage
    local EntityOutlinesModule = context.EntityOutlinesModule
    local ModuleCheckbox = context.ModuleCheckbox
    local EntityListModule = context.EntityListModule
    local Arrow = context.Arrow
    local Dropdown = context.Dropdown
    local DropdownClip = context.DropdownClip
    local Dropdown_2 = context.Dropdown_2
    local DropdownClip_2 = context.DropdownClip_2
    local NameTagModule = context.NameTagModule
    local Arrow_2 = context.Arrow_2
    local AutomationPage = context.AutomationPage
    local Detection = context.Detection
    local Automation = context.Automation
    local Notifications = context.Notifications
    local CloseConfirmation = context.CloseConfirmation
    local Cancel = context.Cancel
    local CloseScript = context.CloseScript
    local ExtraControls = context.ExtraControls
    local entityDefinitions = context.entityDefinitions
    local enabledEntities = context.enabledEntities
    local initialNameTagMode = context.initialNameTagMode
    local itemDefinitions = context.itemDefinitions
    local enabledItems = context.enabledItems
    local ContentProvider = context.ContentProvider
    local TextService = context.TextService
    local RunService = context.RunService
    local fontsReady = context.fontsReady
    local fontLoadSucceeded = context.fontLoadSucceeded
    local fontsReadyEvent = context.fontsReadyEvent

    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local guiConnections = {}
    local activeTweens = {}
    local tweenCompletionConnections = {}

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        guiConnections[#guiConnections + 1] = connection
        return connection
    end

    local function disconnect(connection)
        if connection then
            pcall(function()
                connection:Disconnect()
            end)
        end
    end

    local function disconnectAll()
        for index = #guiConnections, 1, -1 do
            disconnect(guiConnections[index])
            guiConnections[index] = nil
        end
        for clip, connection in pairs(tweenCompletionConnections) do
            disconnect(connection)
            tweenCompletionConnections[clip] = nil
        end
        for clip, tween in pairs(activeTweens) do
            pcall(function()
                tween:Cancel()
            end)
            activeTweens[clip] = nil
        end
    end

    local function renderCheckbox(button, enabled, hovering)
        button.Text = enabled and "✓" or ""
        if enabled then
            button.BackgroundColor3 = hovering and C.RedHover or C.Red
        else
            button.BackgroundColor3 = hovering and C.SurfaceHover or C.Background
        end
    end

    local function bindToggle(button, initialState, changedEvent, stateOwner, stateField, hoverField)
        local enabled = initialState == true
        local hovering = false

        local function setEnabled(value)
            enabled = value == true
            if stateOwner and stateField then
                stateOwner[stateField] = enabled
            end
            if stateOwner and hoverField then
                stateOwner[hoverField] = hovering
            end
            renderCheckbox(button, enabled, hovering)
            return enabled
        end

        connect(button.MouseButton1Click, function()
            setEnabled(not enabled)
            if changedEvent then
                changedEvent:Fire(enabled)
            end
        end)

        connect(button.MouseEnter, function()
            hovering = true
            if stateOwner and hoverField then
                stateOwner[hoverField] = true
            end
            renderCheckbox(button, enabled, hovering)
        end)

        connect(button.MouseLeave, function()
            hovering = false
            if stateOwner and hoverField then
                stateOwner[hoverField] = false
            end
            renderCheckbox(button, enabled, hovering)
        end)

        setEnabled(enabled)
        return setEnabled, function()
            return enabled
        end
    end

    local OutlineChanged = Instance.new("BindableEvent")
    local UnloadRequested = Instance.new("BindableEvent")
    local EntityEnabledChanged = Instance.new("BindableEvent")
    local NameTagModeChanged = Instance.new("BindableEvent")

    local setOutlineEnabled = bindToggle(ModuleCheckbox, true, OutlineChanged)
    local setFullbrightEnabled = bindToggle(
        ExtraControls.FullbrightCheckbox,
        ExtraControls.FullbrightEnabled,
        ExtraControls.FullbrightChanged,
        ExtraControls,
        "FullbrightEnabled",
        "FullbrightHovering"
    )
    local setItemOutlinesEnabled = bindToggle(
        ExtraControls.ItemOutlinesCheckbox,
        ExtraControls.ItemOutlinesEnabled,
        ExtraControls.ItemOutlineChanged,
        ExtraControls,
        "ItemOutlinesEnabled",
        "ItemOutlinesHovering"
    )
    local setAntiAFKEnabled = bindToggle(
        ExtraControls.AntiAFKCheckbox,
        ExtraControls.AntiAFKEnabled,
        ExtraControls.AntiAFKChanged,
        ExtraControls,
        "AntiAFKEnabled",
        "AntiAFKHovering"
    )

    ExtraControls.SetFullbrightEnabled = setFullbrightEnabled
    ExtraControls.SetItemOutlinesEnabled = setItemOutlinesEnabled
    ExtraControls.SetAntiAFKEnabled = setAntiAFKEnabled

    local function bindButtonHover(button, baseColor, hoverColor)
        local normal = baseColor or button.BackgroundColor3
        local hovered = hoverColor or C.SurfaceHover
        connect(button.MouseEnter, function()
            button.BackgroundColor3 = hovered
        end)
        connect(button.MouseLeave, function()
            button.BackgroundColor3 = normal
        end)
    end

    bindButtonHover(Resize)
    bindButtonHover(Minimize)
    bindButtonHover(Close, C.Red, C.RedHover)
    bindButtonHover(EntityListModule)
    bindButtonHover(NameTagModule)
    bindButtonHover(ExtraControls.ItemListModule)
    bindButtonHover(Cancel)
    bindButtonHover(CloseScript, C.Red, C.RedHover)

    local selectedTab = "Detection"
    local tabControls = {
        {name = "Detection", button = Detection, page = DetectionPage},
        {name = "Automation", button = Automation, page = AutomationPage},
        {name = "Miscellaneous", button = ExtraControls.MiscellaneousTab, page = ExtraControls.MiscellaneousPage},
    }
    local tabHovering = {
        Detection = false,
        Automation = false,
        Miscellaneous = false,
    }

    local function renderTab(tab)
        local active = selectedTab == tab.name
        local hovering = tabHovering[tab.name]
        if active then
            tab.button.BackgroundColor3 = hovering and C.RedHover or C.Red
        else
            tab.button.BackgroundColor3 = hovering and C.SurfaceHover or C.Surface
        end
    end

    local function switchTab(name)
        selectedTab = name
        for _, tab in ipairs(tabControls) do
            tab.page.Visible = tab.name == name
            renderTab(tab)
        end
    end

    for _, tab in ipairs(tabControls) do
        local tabControl = tab
        local tabName = tabControl.name
        local tabButton = tabControl.button
        connect(tabButton.MouseEnter, function()
            tabHovering[tabName] = true
            renderTab(tabControl)
        end)
        connect(tabButton.MouseLeave, function()
            tabHovering[tabName] = false
            renderTab(tabControl)
        end)
        connect(tabButton.MouseButton1Click, function()
            switchTab(tabName)
        end)
    end

    switchTab("Detection")

    local originalWindowSize = MainWindow.Size
    local compactWindowSize = UDim2.new(
        originalWindowSize.X.Scale,
        originalWindowSize.X.Offset,
        0,
        Header.Size.Y.Offset
    )
    local compact = false

    connect(Resize.MouseButton1Click, function()
        compact = not compact
        MainWindow.Size = compact and compactWindowSize or originalWindowSize
        Resize.Text = compact and "□" or "▢"
    end)

    connect(Minimize.MouseButton1Click, function()
        MainWindow.Visible = false
    end)

    connect(UserInputService.InputBegan, function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.F1 then
            MainWindow.Visible = not MainWindow.Visible
        end
    end)

    local function bindWindowDragging()
        local dragging = false
        local dragInput = nil
        local dragStart = nil
        local dragStartPosition = nil

        local function pointInside(guiObject, point)
            local position = guiObject.AbsolutePosition
            local size = guiObject.AbsoluteSize
            return point.X >= position.X
                and point.X <= position.X + size.X
                and point.Y >= position.Y
                and point.Y <= position.Y + size.Y
        end

        local function beginDrag(input)
            local inputType = input.UserInputType
            if inputType ~= Enum.UserInputType.MouseButton1 and inputType ~= Enum.UserInputType.Touch then
                return
            end
            local point = input.Position
            if pointInside(Resize, point) or pointInside(Minimize, point) or pointInside(Close, point) then
                return
            end
            dragging = true
            dragInput = inputType == Enum.UserInputType.Touch and input or nil
            dragStart = point
            dragStartPosition = MainWindow.Position
        end

        local function updateDrag(input)
            if not dragging then
                return
            end
            local isMouseMove = input.UserInputType == Enum.UserInputType.MouseMovement
            local isTrackedTouch = dragInput ~= nil and input == dragInput
            if not isMouseMove and not isTrackedTouch then
                return
            end
            local delta = input.Position - dragStart
            MainWindow.Position = UDim2.new(
                dragStartPosition.X.Scale,
                dragStartPosition.X.Offset + delta.X,
                dragStartPosition.Y.Scale,
                dragStartPosition.Y.Offset + delta.Y
            )
        end

        local function endDrag(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input == dragInput then
                dragging = false
                dragInput = nil
                dragStart = nil
                dragStartPosition = nil
            end
        end

        connect(Header.InputBegan, beginDrag)
        connect(UserInputService.InputChanged, updateDrag)
        connect(UserInputService.InputEnded, endDrag)
    end

    bindWindowDragging()

    local dropdownMaximumHeight = 250
    local dropdownAnimationSpeed = 1136
    local dropdownOpen = {
        EntityList = false,
        NameTags = false,
        Items = false,
    }

    DropdownClip_2.ZIndex = DropdownClip.ZIndex
    Dropdown_2.ZIndex = Dropdown.ZIndex

    local dropdownControls = {
        EntityList = {
            module = EntityListModule,
            arrow = Arrow,
            dropdown = Dropdown,
            clip = DropdownClip,
        },
        NameTags = {
            module = NameTagModule,
            arrow = Arrow_2,
            dropdown = Dropdown_2,
            clip = DropdownClip_2,
        },
        Items = {
            module = ExtraControls.ItemListModule,
            arrow = ExtraControls.ItemArrow,
            dropdown = ExtraControls.ItemDropdown,
            clip = ExtraControls.ItemDropdownClip,
        },
    }

    local function cancelDropdownTween(clip)
        disconnect(tweenCompletionConnections[clip])
        tweenCompletionConnections[clip] = nil
        local tween = activeTweens[clip]
        if tween then
            pcall(function()
                tween:Cancel()
            end)
            activeTweens[clip] = nil
        end
    end

    local function contentHeight(control)
        local measuredHeight = control.layout.AbsoluteContentSize.Y
        if measuredHeight > 0 then
            return measuredHeight + 4
        end
        local totalHeight = 0
        local rowCount = 0
        for _, child in ipairs(control.dropdown:GetChildren()) do
            if child:IsA("GuiObject") and child ~= control.layout and child ~= control.padding then
                rowCount = rowCount + 1
                totalHeight = totalHeight + child.Size.Y.Offset
                    + child.Size.Y.Scale * control.dropdown.AbsoluteSize.Y
            end
        end
        if rowCount > 1 then
            totalHeight = totalHeight + control.layout.Padding.Offset * (rowCount - 1)
        end
        return totalHeight + 4
    end

    local function updateDropdownSize(control)
        local totalHeight = contentHeight(control)
        local visibleHeight = math.min(totalHeight, dropdownMaximumHeight)
        local width = control.dropdown.Size.X.Offset
        control.dropdown.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
        control.dropdown.ScrollBarThickness = totalHeight > dropdownMaximumHeight and 4 or 0
        control.dropdown.Size = UDim2.new(0, width, 0, visibleHeight)
        return visibleHeight, totalHeight
    end

    local function animateDropdown(control, shouldOpen, onClosed)
        cancelDropdownTween(control.clip)
        local visibleHeight = updateDropdownSize(control)
        local targetHeight = shouldOpen and visibleHeight or 0
        if shouldOpen then
            control.clip.Visible = true
        end

        local currentHeight = control.clip.Size.Y.Offset
        local distance = math.abs(targetHeight - currentHeight)
        if distance == 0 then
            control.clip.Size = UDim2.new(0, control.clip.Size.X.Offset, 0, targetHeight)
            control.clip.Visible = shouldOpen
            if not shouldOpen and onClosed then
                onClosed()
            end
            return
        end

        local tweenDuration = distance / dropdownAnimationSpeed
        local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(control.clip, tweenInfo, {
            Size = UDim2.new(0, control.clip.Size.X.Offset, 0, targetHeight),
        })
        activeTweens[control.clip] = tween
        local completionConnection
        completionConnection = tween.Completed:Connect(function(playbackState)
            if activeTweens[control.clip] == tween then
                activeTweens[control.clip] = nil
                tweenCompletionConnections[control.clip] = nil
                if playbackState == Enum.PlaybackState.Completed then
                    if shouldOpen then
                        control.clip.Visible = true
                    else
                        control.clip.Visible = false
                        if onClosed then
                            onClosed()
                        end
                    end
                end
            end
            disconnect(completionConnection)
        end)
        tweenCompletionConnections[control.clip] = completionConnection
        tween:Play()
    end

    local function addDropdownLayout(control, layoutName)
        local layout = Instance.new("UIListLayout")
        layout.Name = layoutName .. "Layout"
        layout.Padding = UDim.new(0, 2)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = control.dropdown

        local padding = Instance.new("UIPadding")
        padding.Name = layoutName .. "Padding"
        padding.PaddingTop = UDim.new(0, 0)
        padding.PaddingBottom = UDim.new(0, 0)
        padding.PaddingLeft = UDim.new(0, 2)
        padding.PaddingRight = UDim.new(0, 2)
        padding.Parent = control.dropdown

        control.layout = layout
        control.padding = padding
        control.dropdown.AutomaticCanvasSize = Enum.AutomaticSize.None
        control.dropdown.CanvasSize = UDim2.new(0, 0, 0, 0)
        control.dropdown.ScrollBarImageColor3 = C.Red
        control.dropdown.ScrollingDirection = Enum.ScrollingDirection.Y
        updateDropdownSize(control)
    end

    addDropdownLayout(dropdownControls.EntityList, "EntityList")
    addDropdownLayout(dropdownControls.NameTags, "NameTag")
    addDropdownLayout(dropdownControls.Items, "ItemList")

    local function createOptionRow(kind, definition, order, control, enabledState, changedEvent)
        local name = tostring(definition.name)
        local row = Instance.new("Frame")
        row.Name = kind .. "Option_" .. name
        row.BackgroundColor3 = C.SurfaceHover
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.Size = UDim2.new(1, -8, 0, 34)
        row.LayoutOrder = order
        row.ZIndex = control.dropdown.ZIndex + 1
        row.Parent = control.dropdown

        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0, 5)
        rowCorner.Parent = row

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = kind .. "Name"
        nameLabel.BackgroundTransparency = 1
        nameLabel.Position = UDim2.new(0, 10, 0, 0)
        nameLabel.Size = UDim2.new(1, -52, 1, 0)
        nameLabel.Font = Enum.Font.GothamMedium
        nameLabel.Text = tostring(definition.display or definition.name)
        nameLabel.TextColor3 = C.White
        nameLabel.TextSize = 14
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.ZIndex = control.dropdown.ZIndex + 2
        nameLabel.Parent = row

        local checkbox = Instance.new("TextButton")
        checkbox.Name = kind .. "Checkbox"
        checkbox.BackgroundColor3 = C.Red
        checkbox.BorderSizePixel = 0
        checkbox.Position = UDim2.new(1, -36, 0.5, -13)
        checkbox.Size = UDim2.new(0, 26, 0, 26)
        checkbox.AutoButtonColor = false
        checkbox.Font = Enum.Font.GothamMedium
        checkbox.Text = "✓"
        checkbox.TextColor3 = C.White
        checkbox.TextSize = 15
        checkbox.ZIndex = control.dropdown.ZIndex + 2
        checkbox.Parent = row

        local checkboxCorner = Instance.new("UICorner")
        checkboxCorner.CornerRadius = UDim.new(0, 6)
        checkboxCorner.Parent = checkbox

        local selectButton = Instance.new("TextButton")
        selectButton.Name = kind .. "Select"
        selectButton.BackgroundTransparency = 1
        selectButton.BorderSizePixel = 0
        selectButton.Size = UDim2.new(1, -42, 1, 0)
        selectButton.AutoButtonColor = false
        selectButton.Text = ""
        selectButton.ZIndex = control.dropdown.ZIndex + 2
        selectButton.Parent = row

        local rowHovering = false
        local checkboxHovering = false
        local enabled = enabledState[name] ~= false

        local function renderRow()
            enabled = enabledState[name] ~= false
            nameLabel.TextColor3 = enabled and C.White or C.SecondaryText
            checkbox.Text = enabled and "✓" or ""
            row.BackgroundTransparency = rowHovering and 0 or 1
            if checkboxHovering then
                checkbox.BackgroundColor3 = enabled and C.RedHover or C.SurfaceHover
            else
                checkbox.BackgroundColor3 = enabled and C.Red or C.Background
            end
        end

        local function toggleRow()
            enabledState[name] = not (enabledState[name] ~= false)
            renderRow()
            changedEvent:Fire(name, enabledState[name])
        end

        connect(selectButton.MouseButton1Click, toggleRow)
        connect(checkbox.MouseButton1Click, toggleRow)
        connect(selectButton.MouseEnter, function()
            rowHovering = true
            renderRow()
        end)
        connect(selectButton.MouseLeave, function()
            rowHovering = false
            renderRow()
        end)
        connect(checkbox.MouseEnter, function()
            checkboxHovering = true
            renderRow()
        end)
        connect(checkbox.MouseLeave, function()
            checkboxHovering = false
            renderRow()
        end)

        renderRow()
    end

    local entityEnabledState = type(enabledEntities) == "table" and enabledEntities or {}
    for _, definition in ipairs(entityDefinitions) do
        local name = tostring(definition.name)
        if entityEnabledState[name] == nil then
            entityEnabledState[name] = true
        end
    end
    if entityEnabledState.__Portrait == nil then
        entityEnabledState.__Portrait = true
    end

    local itemEnabledState = type(enabledItems) == "table" and enabledItems or {}
    for _, definition in ipairs(itemDefinitions) do
        local name = tostring(definition.name)
        if itemEnabledState[name] == nil then
            itemEnabledState[name] = true
        end
    end

    for order, definition in ipairs(entityDefinitions) do
        createOptionRow("Entity", definition, order, dropdownControls.EntityList, entityEnabledState, EntityEnabledChanged)
    end

    local sortedItems = {}
    for _, definition in ipairs(itemDefinitions) do
        sortedItems[#sortedItems + 1] = definition
    end
    table.sort(sortedItems, function(left, right)
        local leftName = string.lower(tostring(left.display or left.name))
        local rightName = string.lower(tostring(right.display or right.name))
        return leftName < rightName
    end)

    for order, definition in ipairs(sortedItems) do
        createOptionRow("Item", definition, order, dropdownControls.Items, itemEnabledState, ExtraControls.ItemEnabledChanged)
    end

    local validNameTagModes = {
        All = true,
        Recommended = true,
        None = true,
    }
    local nameTagMode = validNameTagModes[initialNameTagMode] and initialNameTagMode or "Recommended"

    local function setNameTagMode(mode, fireChanged)
        if not validNameTagModes[mode] then
            return
        end
        nameTagMode = mode
        NameTagModule.Text = "  Name Tags: " .. nameTagMode
        if fireChanged then
            NameTagModeChanged:Fire(nameTagMode)
        end
    end

    setNameTagMode(nameTagMode, false)

    local setModuleCorner

    for order, mode in ipairs({"All", "Recommended", "None"}) do
        local currentMode = mode
        local option = Instance.new("TextButton")
        option.Name = "NameTagOption_" .. currentMode
        option.BackgroundColor3 = C.Surface
        option.BorderSizePixel = 0
        option.Size = UDim2.new(1, -8, 0, 32)
        option.LayoutOrder = order
        option.AutoButtonColor = false
        option.Font = Enum.Font.GothamMedium
        option.Text = "  " .. currentMode
        option.TextColor3 = C.White
        option.TextSize = 14
        option.TextXAlignment = Enum.TextXAlignment.Left
        option.ZIndex = dropdownControls.NameTags.dropdown.ZIndex + 1
        option.Parent = dropdownControls.NameTags.dropdown
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 5)
        corner.Parent = option
        bindButtonHover(option)
        connect(option.MouseButton1Click, function()
            setNameTagMode(currentMode, true)
            if dropdownOpen.NameTags then
                dropdownOpen.NameTags = false
                dropdownControls.NameTags.arrow.Text = "ꜜ"
                setModuleCorner(dropdownControls.NameTags, false)
                animateDropdown(dropdownControls.NameTags, false)
            end
        end)
    end

    for _, control in pairs(dropdownControls) do
        control.originalCorner = control.module:FindFirstChildOfClass("UICorner")
        if control.originalCorner then
            control.originalBottomLeft = control.originalCorner.BottomLeftRadius
            control.originalBottomRight = control.originalCorner.BottomRightRadius
        end
    end

    setModuleCorner = function(control, open)
        local corner = control.originalCorner
        if not corner then
            return
        end
        if open then
            corner.BottomLeftRadius = UDim.new(0, 0)
            corner.BottomRightRadius = UDim.new(0, 0)
        else
            corner.BottomLeftRadius = control.originalBottomLeft
            corner.BottomRightRadius = control.originalBottomRight
        end
    end

    local function updateDetectionPageCanvas(openItems, itemDropdownHeight)
        if not openItems then
            DetectionPage.CanvasSize = UDim2.new(0, 0, 0, 440)
            DetectionPage.CanvasPosition = Vector2.new(0, 0)
            return
        end
        local contentBottom = ExtraControls.ItemListModule.Position.Y.Offset
            + ExtraControls.ItemListModule.Size.Y.Offset
            + itemDropdownHeight
        local canvasHeight = math.max(440, contentBottom + 8)
        DetectionPage.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
        task.defer(function()
            if not AutoDoors.Parent or not dropdownOpen.Items then
                return
            end
            local viewportHeight = DetectionPage.AbsoluteSize.Y
            local desiredPosition = math.max(0, contentBottom - viewportHeight + 8)
            local maximumPosition = math.max(0, canvasHeight - viewportHeight)
            DetectionPage.CanvasPosition = Vector2.new(0, math.min(desiredPosition, maximumPosition))
        end)
    end

    local function setDropdownOpen(name, shouldOpen)
        local control = dropdownControls[name]
        if not control then
            return
        end
        shouldOpen = shouldOpen == true
        if dropdownOpen[name] == shouldOpen then
            return
        end

        if shouldOpen then
            for otherName, otherControl in pairs(dropdownControls) do
                if otherName ~= name and dropdownOpen[otherName] then
                    dropdownOpen[otherName] = false
                    otherControl.arrow.Text = "ꜜ"
                    setModuleCorner(otherControl, false)
                    animateDropdown(otherControl, false)
                end
            end
        end

        dropdownOpen[name] = shouldOpen
        control.arrow.Text = shouldOpen and "ꜛ" or "ꜜ"

        if shouldOpen then
            setModuleCorner(control, true)
            local visibleHeight = updateDropdownSize(control)
            if name == "Items" then
                updateDetectionPageCanvas(true, visibleHeight)
            else
                updateDetectionPageCanvas(false)
            end
            animateDropdown(control, true)
        else
            if name == "Items" then
                updateDetectionPageCanvas(false)
            end
            setModuleCorner(control, false)
            animateDropdown(control, false)
        end
    end

    connect(EntityListModule.MouseButton1Click, function()
        setDropdownOpen("EntityList", not dropdownOpen.EntityList)
    end)
    connect(NameTagModule.MouseButton1Click, function()
        setDropdownOpen("NameTags", not dropdownOpen.NameTags)
    end)
    connect(ExtraControls.ItemListModule.MouseButton1Click, function()
        setDropdownOpen("Items", not dropdownOpen.Items)
    end)

    connect(Close.MouseButton1Click, function()
        CloseConfirmation.Visible = true
    end)
    connect(Cancel.MouseButton1Click, function()
        CloseConfirmation.Visible = false
    end)

    local function signalFontsReady(success)
        if fontsReady then
            return
        end
        fontsReady = true
        fontLoadSucceeded = success == true
        fontsReadyEvent:Fire(fontLoadSucceeded)
    end

    local guiClosing = false
    local function closeScriptNow()
        if guiClosing then
            return
        end
        guiClosing = true
        UnloadRequested:Fire()
        signalFontsReady(false)
        disconnectAll()
        task.defer(function()
            if AutoDoors and AutoDoors.Parent then
                AutoDoors:Destroy()
            end
        end)
    end

    connect(CloseScript.MouseButton1Click, closeScriptNow)
    connect(AutoDoors.Destroying, function()
        signalFontsReady(false)
    end)

    local guiReferences = {
        ScreenGui = AutoDoors,
        Notifications = Notifications,
        OutlineChanged = OutlineChanged,
        EntityEnabledChanged = EntityEnabledChanged,
        ItemEnabledChanged = ExtraControls.ItemEnabledChanged,
        ItemOutlineChanged = ExtraControls.ItemOutlineChanged,
        NameTagModeChanged = NameTagModeChanged,
        FullbrightChanged = ExtraControls.FullbrightChanged,
        AntiAFKChanged = ExtraControls.AntiAFKChanged,
        UnloadRequested = UnloadRequested,
        SetOutlineEnabled = setOutlineEnabled,
        SetFullbrightEnabled = setFullbrightEnabled,
        SetItemOutlinesEnabled = setItemOutlinesEnabled,
        SetAntiAFKEnabled = setAntiAFKEnabled,
        CloseScriptNow = closeScriptNow,
        WaitForFonts = function()
            if not fontsReady then
                fontsReadyEvent.Event:Wait()
            end
            return fontLoadSucceeded
        end,
    }

    local function getFontFamilyUri(fontFace)
        local family = fontFace.Family
        if type(family) == "string" and family ~= "" then
            return family
        end
        local ok, sourceType, uri = pcall(function()
            return family.SourceType, family.Uri
        end)
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

        for _, object in ipairs(AutoDoors:GetDescendants()) do
            if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
                textObjects[#textObjects + 1] = object
                local fontFace = object.FontFace
                local familyUri = getFontFamilyUri(fontFace)
                if not familyUri then
                    return nil, nil, nil
                end
                fontFamilies[familyUri] = true
                local faceKey = familyUri .. "|" .. tostring(fontFace.Weight) .. "|" .. tostring(fontFace.Style)
                if not requestedFaceKeys[faceKey] then
                    requestedFaceKeys[faceKey] = true
                    requestedFaces[#requestedFaces + 1] = {
                        family = familyUri,
                        font = fontFace,
                    }
                end
            end
        end

        return textObjects, fontFamilies, requestedFaces
    end

    local function preloadFontAssets(textObjects, fontFamilies, requestedFaces)
        local familyInfoByUri = {}
        for familyUri in pairs(fontFamilies) do
            local familyLoaded, familyInfo = pcall(function()
                return TextService:GetFamilyInfoAsync(familyUri)
            end)
            if not familyLoaded or type(familyInfo) ~= "table"
                or type(familyInfo.Faces) ~= "table" or next(familyInfo.Faces) == nil then
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
            if not matchingFace then
                return false
            end
        end

        local failedAsset = false
        local preloadSucceeded = pcall(function()
            ContentProvider:PreloadAsync(textObjects, function(_, status)
                if status ~= Enum.AssetFetchStatus.Success then
                    failedAsset = true
                end
            end)
        end)
        if not preloadSucceeded or failedAsset then
            return false
        end

        for _, requested in ipairs(requestedFaces) do
            local parameters = Instance.new("GetTextBoundsParams")
            parameters.Text = "Auto Doors"
            parameters.Font = requested.font
            parameters.Size = 20
            parameters.Width = 1000
            local boundsSucceeded, bounds = pcall(function()
                return TextService:GetTextBoundsAsync(parameters)
            end)
            parameters:Destroy()
            if not boundsSucceeded or typeof(bounds) ~= "Vector2" or bounds.X <= 0 or bounds.Y <= 0 then
                return false
            end
        end

        return true
    end

    local function preloadFonts()
        local textObjects, fontFamilies, requestedFaces = collectFontAssets()
        local attempt = 0

        while AutoDoors.Parent do
            attempt = attempt + 1
            if textObjects and fontFamilies and requestedFaces
                and preloadFontAssets(textObjects, fontFamilies, requestedFaces) then
                AutoDoors.Enabled = true
                local rendered = pcall(function()
                    RunService.RenderStepped:Wait()
                    RunService.RenderStepped:Wait()
                end)
                if rendered and AutoDoors.Parent then
                    signalFontsReady(true)
                    return
                end
                AutoDoors.Enabled = false
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
