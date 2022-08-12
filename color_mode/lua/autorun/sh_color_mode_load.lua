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
Color_Mode = {}

AddCSLuaFile(Folder .. "/sh_config.lua")
include(Folder .. "/sh_config.lua")

if SERVER then
    print("| Color Mode | File Load | addons/" .. Folder .. "/lua/autorun/sh_" .. Folder .. "_load.lua")
    print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/sh_config.lua")
    
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
            print("| Color Mode | New Version Load | v" .. version)
            file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Config))
        else
            Color_Mode.Config = Config_Read
        end
        print("| Color Mode | File Load | data/linventif/color_mode.json")
    end
    
    for k, v in ipairs(file.Find(Folder .. "/language/*.lua", "LUA")) do
		AddCSLuaFile(Folder .. "/language/" .. v)
        print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/language/" .. v)
	end

	for k, v in ipairs(file.Find(Folder .. "/client/*.lua", "LUA")) do
		AddCSLuaFile(Folder .. "/client/" .. v)
        print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/client/" .. v)
	end

	for k, v in ipairs(file.Find(Folder .. "/server/*.lua", "LUA")) do
		include(Folder .. "/server/" .. v)
        print("| Color Mode | File Load | addons/" .. Folder .. "/lua/" .. Folder .. "/server/" .. v)
	end
    print(" ")
    print(" ")
else    
    for k, v in ipairs(file.Find(Folder .. "/client/*.lua", "LUA")) do
        include(Folder .. "/client/" .. v)
    end
end


--[[
    Features
        General
            Full in game configuration
            Language in French, English or Russian
        User
            Create and save custom color mode (color modificator)
            in game menu

        Admin
            Change Language
            Allow user to use they own configuration or not

        Future Update 
            Admin can change the color boost parameter
            Admin can Change the ui
]]--