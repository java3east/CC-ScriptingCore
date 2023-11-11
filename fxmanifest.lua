fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "jb_scriptingCore"
description "Scripting core for FiveM including framework translations between ESX and QB"
author "Java3east <https://javabeast.net>"
version "1.0.0"
shared_scripts {
    'shared/*.lua'
}

client_scripts {
    'client/*.lua',
    'client/framework/*.lua'
}

server_scripts {
    'server/*.lua',
    'server/framework/*.lua'
}
