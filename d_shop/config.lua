Config = {}
Config.PaymentMethod = "bank" -- Changez en "cash" pour utiliser de l'argent liquide
-- Positions configurables
Config.Positions = {
    {x = -707.40, y =  -914.66, z = 19.21}, -- Position initiale
     {x =  1698.15, y = 4924.64, z = 42.06},
    -- Vous pouvez ajouter d'autres positions ici
     }

     
-- Propriétés des blips-------------------------------------------------
Config.BlipSettings = {
    blipId = 52,         -- ID du blip (52 pour les supérettes)
    color = 2,           -- Couleur du blip (2 = vert)
    scale = 0.8,         -- Taille du blip
    shortRange = true,   -- Visible uniquement à courte distance
    name = "Superette"   -- Nom du blip
}

Config.MenuItems = {
    {name = "water", label = "Eau", price = 5, icon = "💧", action = "buyItem"},
    {name = "bread", label = "Pain", price = 3, icon = "🍞", action = "buyItem"},
   
}


-- Messages de notification-------------------------------------------------------
Config.Notifications = {
    purchaseSuccess = "Vous avez acheté ~b~1x {itemLabel}~s~ pour ~g~${price}",
    notEnoughBank = "Vous n'avez pas assez d'argent en banque.",
    notEnoughCash = "Vous n'avez pas assez d'argent liquide.",
}
--------------------------------config couleur du menu et titre-------------------------
Config.MenuSettings = {
    header = {"commonmenu", "interaction_bgd"}, -- Texture d'en-tête
    color = {150, 0, 0}, -- Couleur principale (bleu par défaut)
    headerColor = {255, 255, 255}, -- Couleur du texte de l'en-tête (blanc par défaut)
    title = "LTD", -- Nom du menu
}

-- Configuration des interactions------------------------------------------
Config.InteractionSettings = {
    helpText = "Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec le marchant",
    key = 51, -- Touche "E" (INPUT_CONTEXT)
    distance = 1.0 -- Distance pour activer le menu
}
----------------------------------------amunations---------------------------------------------------------------------------------------------------------
ConfigAmmunation = {}
-- Mode de paiement : "cash" ou "bank"
ConfigAmmunation.PaymentMethod = "bank"
-- Configuration du menu pour Ammunation
ConfigAmmunation.MenuSettings = {
    header = {"commonmenu", "interaction_bgd"},
    color = {0, 0, 0}, -- Rouge
    headerColor = {150, 0, 0}, -- Blanc
    title = "Ammunation",
}

-- Configuration des interactions pour Ammunation
ConfigAmmunation.InteractionSettings = {
    helpText = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l'Ammunation.",
    key = 51, -- Touche "E" (INPUT_CONTEXT)
    distance = 2.0 -- Distance pour activer le menu
}



-- Notifications personnalisées
ConfigAmmunation.Notifications = {
    success = "Vous avez acheté ~b~1x {itemLabel}~s~ pour ~g~${price}.",
    notEnoughMoney = "Vous n'avez pas assez d'argent {paymentMethod}.",
}

-- Items configurables pour l'Ammunation
ConfigAmmunation.MenuItems = {
   
    {name = "WEAPON_BAT", label = "Batte de baseball", price = 1000, icon = "🏏", action = "buyWeapon"},
    
}

-- Positions des Ammunations
ConfigAmmunation.Positions = {
    {x = -662.1, y = -935.3, z = 21.8},
    {x = 1693.44, y = 3760.14, z = 34.71}, 
}

-- Propriétés des blips pour Ammunation
ConfigAmmunation.BlipSettings = {
    blipId = 110, -- Icône des Ammunations
    color = 1, -- Rouge
    scale = 0.8, -- Taille du blip
    shortRange = true, -- Visible uniquement à courte distance
    name = "Ammunation",
}
