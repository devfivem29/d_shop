ESX = exports["es_extended"]:getSharedObject()

-- Définir le menu principal pour Ammunation
local AmmunationMenu = {
    Base = {
        Header = ConfigAmmunation.MenuSettings.header,
        Color = ConfigAmmunation.MenuSettings.color,
        HeaderColor = ConfigAmmunation.MenuSettings.headerColor,
        Title = ConfigAmmunation.MenuSettings.title,
    },
    Data = {
        currentMenu = "Liste des Armes",
        GetPlayerName()
    },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    
            if btn.action == "buyWeapon" and btn.dataName and btn.price then
                TriggerServerEvent("ammunation:buyWeapon", btn.dataName, btn.price)
            end
        end,
    },
    Menu = {
        ["Liste des Armes"] = {
            b = {}
        }
    }
}

-- Charger les items depuis ConfigAmmunation
Citizen.CreateThread(function()
    if ConfigAmmunation.MenuItems and #ConfigAmmunation.MenuItems > 0 then
        for _, item in ipairs(ConfigAmmunation.MenuItems) do
            table.insert(AmmunationMenu.Menu["Liste des Armes"].b, {
                name = item.label,
                dataName = item.name,
                price = item.price,
                ask = item.icon or "",
                askX = true,
                action = item.action or nil
            })
        end
    else
        print("[WARNING] Aucun item configuré dans ConfigAmmunation.MenuItems")
    end
end)

-- Vérifier la position pour ouvrir le menu Ammunation
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, pos in ipairs(ConfigAmmunation.Positions) do
            local distance = #(playerCoords - vector3(pos.x, pos.y, pos.z))
            if distance < ConfigAmmunation.InteractionSettings.distance then
                ESX.ShowHelpNotification(ConfigAmmunation.InteractionSettings.helpText)
                if IsControlJustPressed(1, ConfigAmmunation.InteractionSettings.key) then
                    CreateMenu(AmmunationMenu)
                end
            end
        end
    end
end)

-- Afficher les blips des Ammunations
Citizen.CreateThread(function()
    for _, pos in ipairs(ConfigAmmunation.Positions) do
        local blip = AddBlipForCoord(pos.x, pos.y, pos.z)
        SetBlipSprite(blip, ConfigAmmunation.BlipSettings.blipId)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, ConfigAmmunation.BlipSettings.scale)
        SetBlipColour(blip, ConfigAmmunation.BlipSettings.color)
        SetBlipAsShortRange(blip, ConfigAmmunation.BlipSettings.shortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ConfigAmmunation.BlipSettings.name)
        EndTextCommandSetBlipName(blip)
    end
end)
