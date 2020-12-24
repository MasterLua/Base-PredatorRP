--
-- Created by MasterLua.
--

fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'MasterLua'
description 'MasterLua boutique'
version '1.0.0'

--RAGEUI
client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
}

-- MENU
client_scripts {
    'config.lua',
    'client/client.lua'
}

server_scripts {
    'server/server.lua',
    '@mysql-async/lib/MySQL.lua'
}