fx_version 'cerulean'

games { 'gta5' }

author 'Javi'

lua54 'yes'

description 'Interfaz by Javi'

ui_page 'ui/index.html'

files {
    'ui/**/**/*.*'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua',
}

exports {
    'showNotification'
}

dependencies {
    'es_extended'
}