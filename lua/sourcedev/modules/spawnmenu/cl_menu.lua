sourcedev("spawnmenu")


local mat_grad_bottom = Material("vgui/gradient-d")

local mat_grad_right = Material("vgui/gradient-r")

local mat_grad_top = Material("vgui/gradient-u")

local clr_bg_top = Color(100,100,100,100)
local clr_bg_bot = Color(255,255,255,100)

MODULE.mt_listMenu = MODULE.mt_listMenu or {}


function spawnmenu.registerMenu(name, func)
    MODULE.mt_listMenu[menu] = func
end


function spawnmenu.createMenu()
    local fr = vgui.Create("EditablePanel")
    spawnmenu.mp_foundationPanel = fr

    fr:SetSize(w+1000, h+1000)
    fr:Center()
    fr:MakePopup()
    fr:SetMouseInputEnabled(true)
    fr:SetKeyBoardInputEnabled(true)
    fr:SetFocusTopLevel(true)
    fr.Paint = function(self, w, h)
        ui2.BoxMaterial(0, 0, w, h, clr_bg_bot, mat_grad_bottom)
        ui2.BoxMaterial(0, 0, w, h, clr_bg_top, mat_grad_top)

        ui2.BoxMaterialRotate(100, 100, 400, 50, clr.black, mat_grad_right, 225)

        ui2.BoxMaterialRotate(w-100, h - 100, 400, 50, clr.black, mat_grad_right, 45)
    end


    local main = fr:Add("sourcedev.spawnmenu.panel")
    main:SetSize(w+900, h+900)
    main:Center()
    main:DockPadding(5, 5, 5, 5)

    local main_content = main:Add("sourcedev.spawnmenu.panel")
    main_content:Dock(FILL)
    main_content:InvalidateParent(true)

    main_content.mt_loadedContent = {}
    main_content.mp_lastContent = false
    main_content.mp_lastIcon = false

    local clr_gray = Color(50,50,50,255)
    local selectors = main_content:Add("sourcedev.spawnmenu.panel")
    selectors:SetTall(h+75)
    selectors:Dock(TOP)
    selectors:InvalidateParent(true)
    selectors.Paint = function(self, w, h)
        ui.Box(0,0,w,h,clr_gray)
    end

    local inform = main_content:Add("sourcedev.spawnmenu.panel")
    inform:Dock(FILL)
    inform:InvalidateParent(true)


    for name, func in pairs(mt_listMenu) do
        local icon = selectors:Add("sourcedev.spawnmenu.panel")
        icon:SetWide(h+75)
        icon:Dock(LEFT)
        icon:InvalidateParent(true)
        icon:SetVisible(true)

        local content = inform:Add("sourcedev.spawnmenu.panel")
        content:Dock(FILL)
        content:InvalidateParent(true)
        content:SetVisible(true)


        icon.OnMousePressed = function(_, key)
            if key == MOUSE_LEFT and main_content.mt_loadedContent[name] then
                if IsValid(main_content.mp_lastContent) then
                    main_content.mp_lastContent:SetVisible(false)
                    main_content.mp_lastIcon:SetSelected(false)
                end
                icon:SetSelected(true)
                content:SetVisible(true)
            else
                local res, err = pcall(func, icon, content)
                if res == false then print("SR SpawnMenu Errored") end
            end
        end
    end
end


