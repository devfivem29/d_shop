ESX = exports["es_extended"]:getSharedObject()

-- Définir le menu principal
local Shhop = {
    Base = {
        Header = Config.MenuSettings.header,
        Color = Config.MenuSettings.color,
        HeaderColor = Config.MenuSettings.headerColor,
        Title = Config.MenuSettings.title,
    },
    Data = {
        currentMenu = "Options disponibles",
        GetPlayerName()
    },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    
            if btn.action == "buyItem" and btn.dataName and btn.price then
                TriggerServerEvent("d_shop:buyItem", btn.dataName, btn.price)
            end
        end,
    },
    Menu = {
        ["Options disponibles"] = {
            b = {}
        }
    }
}

-- Charger les items depuis Config
Citizen.CreateThread(function()
    if Config.MenuItems and #Config.MenuItems > 0 then
        for _, item in ipairs(Config.MenuItems) do
            table.insert(Shhop.Menu["Options disponibles"].b, {
                name = item.label,
                dataName = item.name,
                price = item.price,
                ask = item.icon or "",
                askX = true,
                action = item.action or nil
            })
        end
    else
        print("[WARNING] Aucun item configuré dans Config.MenuItems")
    end
end)

-- Vérifier la position pour ouvrir le menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, pos in ipairs(Config.Positions) do
            local distance = #(playerCoords - vector3(pos.x, pos.y, pos.z))
            if distance < Config.InteractionSettings.distance then
                ESX.ShowHelpNotification(Config.InteractionSettings.helpText)
                if IsControlJustPressed(1, Config.InteractionSettings.key) then
                    CreateMenu(Shhop)
                end
            end
        end
    end
end)

-- Afficher les blips des supérettes
Citizen.CreateThread(function()
    for _, pos in ipairs(Config.Positions) do
        local blip = AddBlipForCoord(pos.x, pos.y, pos.z)
        SetBlipSprite(blip, Config.BlipSettings.blipId or 52)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.BlipSettings.scale or 0.8)
        SetBlipColour(blip, Config.BlipSettings.color or 2)
        SetBlipAsShortRange(blip, Config.BlipSettings.shortRange or true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipSettings.name or "Superette")
        EndTextCommandSetBlipName(blip)
    end
end)
