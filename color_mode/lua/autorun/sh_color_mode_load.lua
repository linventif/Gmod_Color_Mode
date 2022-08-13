print(" ")
print(" ")
print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
print(" -                                                           - ")
print(" -                        Color Mode                         - ")
print(" -                                                           - ")
print(" -                   Create by Linventif                     - ")
print(" -        Join my discord : https://dsc.gg/linventif         - ")
print(" -         Watch my website : https://linventif.org          - ")
print(" -                                                           - ")
print(" -          Avec le soutient de Garry's Mod France           - ")
print(" -   Rejoigniez le discord : https://discord.gg/6n5SEJAhGp   - ")
print(" -                                                           - ")
print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
print(" ")
print(" ")

local Folder = "color_mode"
Color_Mode = Color_Mode or {}

AddCSLuaFile(Folder .. "/sh_config.lua")
include(Folder .. "/sh_config.lua")

print("| Color Mode | File Load | addons/" .. Folder .. "/lua/autorun/sh_" .. Folder .. "_load.lua")
print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/sh_config.lua")

if SERVER then
    for k, v in ipairs(file.Find(Folder .. "/languages/*.lua", "LUA")) do
		AddCSLuaFile(Folder .. "/languages/" .. v)
        print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/languages/" .. v)
	end

	for k, v in ipairs(file.Find(Folder .. "/client/*.lua", "LUA")) do
		AddCSLuaFile(Folder .. "/client/" .. v)
        print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/client/" .. v)
	end

	for k, v in ipairs(file.Find(Folder .. "/server/*.lua", "LUA")) do
		include(Folder .. "/server/" .. v)
        print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/server/" .. v)
	end
else    
    if !file.Exists("linventif", "data") then
        file.CreateDir("linventif")
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Config))
    elseif !file.Exists("linventif/color_mode.json", "DATA") then
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Config))
    else
        local Config_Read = {}
        Config_Read = util.JSONToTable(file.Read("linventif/color_mode.json", "DATA"))
        if Color_Mode.Config.Version != Config_Read.Version then
            local version = Color_Mode.Config.Version
            table.CopyFromTo(Config_Read, Color_Mode.Config)
            Color_Mode.Config.Version = version
            file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Config))
        else
            Color_Mode.Config = Config_Read
        end
    end
    
    include(Folder .. "/languages/" .. Color_Mode.Config.Language .. ".lua")
    print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/languages/" .. string.lower(Color_Mode.Config.Language) .. ".lua")

	for k, v in ipairs(file.Find(Folder .. "/client/*.lua", "LUA")) do
		include(Folder .. "/client/" .. v)
        print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/client/" .. v)
	end

	for k, v in ipairs(file.Find(Folder .. "/server/*.lua", "LUA")) do
		include(Folder .. "/server/" .. v)
        print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/server/" .. v)
	end
end

print(" ")
print(" ")