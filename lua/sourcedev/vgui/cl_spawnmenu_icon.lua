local PANEL = {}

AccessorFunc(PANEL, "mt_data", "Data")

function PANEL:Init()
    self:SetMouseInputEnabled(true)
    self:SetData({})
end


function PANEL:OnMousePressed(key)
    local menu = DermaMenu() 
    if self.mt_data.path then
        menu:AddOption( "Copy Path", function() SetClipboardText( self.mt_data.path ) end )
    end
    if self.mt_data.class then
        menu:AddOption( "Copy Class", function() SetClipboardText( self.mt_data.class ) end )
    end
    menu:AddOption( "Close", function() end )
    menu:Open()
end


vgui.Register("sourcedev.spawnmenu.icon", PANEL, "sourcedev.model")