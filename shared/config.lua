Config = {}

Config.debug        = true     -- set to true if you need to find a bug

Config.framework    = "ESX"     -- ESX / QB / CUSTOM
Config.resource     = nil       -- set the name of your resource here in case you have renamed your esx / qb resource (esx default: "es_extended", qb default: "qb-core")

Config.server = {}
Config.server.colors = {
    {r = 9, g = 1, b = 9},
    {r = 83, g = 7, b = 94},
    {r = 147, g = 1, b = 169},
}
Config.server.marker = {
    color = Config.server.colors[3],
    alpha = 90,
    viewDistance = 25.0
}