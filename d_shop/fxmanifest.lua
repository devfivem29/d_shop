fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

escrow_ignore {
    'config.lua', -- Permet aux utilisateurs de modifier ce fichier
    --'README.md'   -- Si vous avez une documentation incluse
}

client_scripts {
  'pmenu.lua',
  "client.lua",
  "amunations.lua",
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  "server.lua",
}


shared_script {
    "config.lua",
    "@es_extended/imports.lua",
}
