fx_version 'cerulean'
game 'gta5'

this_is_a_map 'yes'

author '!ViDu'
description 'Simple Flower job for your FiveM Server By !ViDu'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
	'client/main.lua',
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua'
}

server_script 'server/*.lua'
