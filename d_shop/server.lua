ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("d_shop:buyItem", function(itemName, itemPrice)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        -- Récupérer le label de l'item
        local itemLabel = nil
        for _, item in ipairs(Config.MenuItems) do
            if item.name == itemName then
                itemLabel = item.label
                break
            end
        end

        if not itemLabel then
            print("[ERROR] L'item avec le nom " .. itemName .. " n'a pas été trouvé dans Config.MenuItems")
            return
        end

        -- Vérifier le mode de paiement configuré
        if Config.PaymentMethod == "bank" then
            -- Paiement via banque
            local bankBalance = xPlayer.getAccount("bank").money
            if bankBalance >= itemPrice then
                xPlayer.removeAccountMoney("bank", itemPrice)
                xPlayer.addInventoryItem(itemName, 1)
                TriggerClientEvent("esx:showNotification", source, 
                    Config.Notifications.purchaseSuccess
                        :gsub("{itemLabel}", itemLabel)
                        :gsub("{price}", tostring(itemPrice))
                )
            else
                TriggerClientEvent("esx:showNotification", source, Config.Notifications.notEnoughBank)
            end
        elseif Config.PaymentMethod == "cash" then
            -- Paiement via argent liquide
            local cashBalance = xPlayer.getMoney()
            if cashBalance >= itemPrice then
                xPlayer.removeMoney(itemPrice)
                xPlayer.addInventoryItem(itemName, 1)
                TriggerClientEvent("esx:showNotification", source, 
                    Config.Notifications.purchaseSuccess
                        :gsub("{itemLabel}", itemLabel)
                        :gsub("{price}", tostring(itemPrice))
                )
            else
                TriggerClientEvent("esx:showNotification", source, Config.Notifications.notEnoughCash)
            end
        else
            -- Méthode de paiement non valide
            print("[ERROR] Méthode de paiement invalide dans config.lua : " .. tostring(Config.PaymentMethod))
        end
    end
end)
----------------------------------------amunations---------------------------------------------------------------------------------------------------------
RegisterNetEvent("ammunation:buyWeapon", function(itemName, itemPrice)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        -- Récupérer le label de l'item
        local itemLabel = nil
        for _, item in ipairs(ConfigAmmunation.MenuItems) do
            if item.name == itemName then
                itemLabel = item.label
                break
            end
        end

        if not itemLabel then
            print("[ERROR] L'item " .. itemName .. " n'existe pas dans ConfigAmmunation.MenuItems")
            return
        end

        -- Gestion du paiement
        local paymentMethod = ConfigAmmunation.PaymentMethod
        local hasEnoughMoney = false

        if paymentMethod == "cash" then
            local cash = xPlayer.getMoney()
            hasEnoughMoney = cash >= itemPrice

            if hasEnoughMoney then
                xPlayer.removeMoney(itemPrice)
            end
        elseif paymentMethod == "bank" then
            local bankBalance = xPlayer.getAccount("bank").money
            hasEnoughMoney = bankBalance >= itemPrice

            if hasEnoughMoney then
                xPlayer.removeAccountMoney("bank", itemPrice)
            end
        else
            print("[ERROR] Méthode de paiement invalide dans ConfigAmmunation.PaymentMethod : " .. tostring(paymentMethod))
            return
        end

        -- Traitement de l'achat
        if hasEnoughMoney then
            xPlayer.addInventoryItem(itemName, 1)
            local successMessage = ConfigAmmunation.Notifications.success
                :gsub("{itemLabel}", itemLabel)
                :gsub("{price}", tostring(itemPrice))
            TriggerClientEvent("esx:showNotification", source, successMessage)
        else
            local notEnoughMessage = ConfigAmmunation.Notifications.notEnoughMoney
                :gsub("{paymentMethod}", paymentMethod == "cash" and "en liquide" or "en banque")
            TriggerClientEvent("esx:showNotification", source, notEnoughMessage)
        end
    end
end)