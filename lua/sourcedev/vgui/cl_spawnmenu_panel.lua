local PANEL = {}


function PANEL:Init()
    self:SetMouseInputEnabled(true)
    self:SetKeyBoardInputEnabled(true)
end


local clr_gray = Color(52,52,52,255)
function PANEL:Paint(w, h)
    ui2.Box(0,0,w,h,clr_gray)    
end

vgui.Register("sourcedev.spawnmenu.panel", PANEL, "EditablePanel")