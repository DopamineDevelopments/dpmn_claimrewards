fx_version 'cerulean'
games { 'gta5' }

author 'DopamineDevelopments'

description 'Claim Item and Car for New Players'

client_scripts {
  'client/main.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

shared_scripts {
    'shared/config.lua'
}
