sourcedev("spawnmenu")




function spawnmenu.toggleMenu()
    if spawnmenu.isOpen then
        if IsValid(spawnmenu.mp_foundationPanel) then spawnmenu.mp_foundationPanel:Remove() end
        spawnmenu.isOpen = false
    else
        spawnmenu.createMenu()
        spawnmenu.isOpen = true
    end
end


concommand.Add("sourcedev.spawnmenu", function()
    spawnmenu.toggleMenu()
end)

concommand.Add("sourcedev.parse", function()
    spawnmenu.hd_parseProp()
    PrintTable(spawnmenu.mt_parsedProp)
end)