fx_version 'adamant'

autor 'd4z1/d4z1 scripts'
game 'gta5'
lua54 'yes'
shared_script '@ox_lib/init.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/*.lua'
}
