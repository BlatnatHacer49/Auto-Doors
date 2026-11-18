return function(context)
    local C = context.C
    local AutoDoors = context.AutoDoors
    local MainWindow = context.MainWindow
    local Header = context.Header
    local Resize = context.Resize
    local Minimize = context.Minimize
    local Close = context.Close
    local SelectedTab = context.SelectedTab
    local DetectionPage = context.DetectionPage
    local EntityOutlinesModule = context.EntityOutlinesModule
    local ModuleText = context.ModuleText
    local ModuleCheckbox = context.ModuleCheckbox
    local SectionEntityDetection = context.SectionEntityDetection
    local EntityListModule = context.EntityListModule
    local Arrow = context.Arrow
    local Dropdown = context.Dropdown
    local DropdownClip = context.DropdownClip
    local NameTagModule = context.NameTagModule
    local Arrow_2 = context.Arrow_2
    local Dropdown_2 = context.Dropdown_2
    local DropdownClip_2 = context.DropdownClip_2
    local AutomationPage = context.AutomationPage
    local SectionAutomation = context.SectionAutomation
    local Tabs = context.Tabs
    local Detection = context.Detection
    local Automation = context.Automation
    local Notifications = context.Notifications
    local CloseConfirmation = context.CloseConfirmation
    local ConfirmationText = context.ConfirmationText
    local ConfirmationExplanation = context.ConfirmationExplanation
    local Cancel = context.Cancel
    local CloseScript = context.CloseScript
    local ExtraControls = context.ExtraControls
    local addCorner = context.addCorner
    local addStroke = context.addStroke
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
        Detection = {button = Detection, page = DetectionPage},
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
    guiConnect(Detection.MouseButton1Click, function() switchTab("Detection") end)
    guiConnect(Automation.MouseButton1Click, function() switchTab("Automation") end)
    guiConnect(ExtraControls.MiscellaneousTab.MouseButton1Click, function() switchTab("Miscellaneous") end)
    switchTab("Detection")

    local function wireHover(buttonObject, baseColor, hoverColor)
        if not buttonObject or not buttonObject:IsA("TextButton") then return end
        local base = baseColor or buttonObject.BackgroundColor3
        local hover = hoverColor or C.SurfaceHover
        local tabName = buttonObject == Detection and "Detection"
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

    for _, object in ipairs(AutoDoors:GetDescendants()) do
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

    local function createDetectionRow(definition, order, dropdownTarget, enabledState, changedEvent, rowPrefix)
        local row = Instance.new("Frame")
        row.Name = rowPrefix .. "Option_" .. tostring(definition.name)
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.Size = UDim2.new(1, -8, 0, 34)
        row.LayoutOrder = order
        row.ZIndex = 8
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
        optionLabel.ZIndex = 9
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
        checkbox.ZIndex = 9
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
        rowClickArea.ZIndex = 9
        rowClickArea.Parent = row
        optionLabel.ZIndex = 9
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
        dropdown.ZIndex = 8
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
            DetectionPage.CanvasSize = UDim2.new(0, 0, 0, 560)
        elseif name == "Items" or (isOpen and name ~= "Items") then
            DetectionPage.CanvasSize = UDim2.new(0, 0, 0, 440)
            DetectionPage.CanvasPosition = Vector2.new(0, 0)
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

            if name == "Items" then
                local targetHeight = updateDropdownHeight(control.dropdown, control.layout)
                local contentBottom = control.module.Position.Y.Offset + control.module.Size.Y.Offset + targetHeight
                local viewportHeight = DetectionPage.AbsoluteSize.Y
                local desiredY = math.max(0, contentBottom - viewportHeight + 8)
                local maxY = math.max(0, DetectionPage.CanvasSize.Y.Offset - viewportHeight)
                desiredY = math.min(desiredY, maxY)
                if desiredY > DetectionPage.CanvasPosition.Y then
                    DetectionPage.CanvasPosition = Vector2.new(0, desiredY)
                end
            else
                DetectionPage.CanvasPosition = Vector2.new(0, 0)
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
        option.ZIndex = 8
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
            if AutoDoors and AutoDoors.Parent then
                AutoDoors:Destroy()
            end
        end)
    end
    guiConnect(CloseScript.MouseButton1Click, closeScriptNow)

    local guiReferences = {
        ScreenGui = AutoDoors,
        MainWindow = MainWindow,
        Resize = Resize,
        Minimize = Minimize,
        Close = Close,
        CloseConfirmation = CloseConfirmation,
        CancelClose = Cancel,
        ConfirmClose = CloseScript,
        DetectionTab = Detection,
        AutomationTab = Automation,
        MiscellaneousTab = ExtraControls.MiscellaneousTab,
        DetectionPage = DetectionPage,
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
    guiConnect(AutoDoors.Destroying, function() signalFontsReady(false) end)

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
        for _, object in ipairs(AutoDoors:GetDescendants()) do
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
        while AutoDoors.Parent do
            attempt += 1
            if textObjects and fontFamilies and requestedFaces and tryPreload(textObjects, fontFamilies, requestedFaces) then
                AutoDoors.Enabled = true
                local renderSucceeded = pcall(function()
                    RunService.RenderStepped:Wait()
                    RunService.RenderStepped:Wait()
                end)
                if renderSucceeded and AutoDoors.Parent then
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
