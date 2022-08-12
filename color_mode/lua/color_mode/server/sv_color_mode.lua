util.AddNetworkString("color_mode_open")
util.AddNetworkString("color_mode_open_admin")
util.AddNetworkString("color_mode_save_config")
util.AddNetworkString("color_mode_reset_config")
util.AddNetworkString("color_mode_ply_load")

hook.Add("PlayerSay", "Color_Mode_Open", function(ply, text)
    if Color_Mode.Config.Commands[text] then
        net.Start("color_mode_open")
        net.Send(ply)
    end
end)

hook.Add("PlayerSay", "Color_Mode_Open_Admin", function(ply, text)
    if Color_Mode.Config.Commands_Admin[text] then
        net.Start("color_mode_open_admin")
        net.Send(ply)
    end
end)

net.Receive("color_mode_save_config", function(len, ply)
    local table_read = net.ReadTable()
    if Color_Mode.Config.Admin[ply:GetUserGroup()] then
        file.Write("linventif/color_mode.json", util.TableToJSON(table_read))        
	    net.Start("color_mode_ply_load")
        net.WriteTable(table_read)
        net.Broadcast()
    end
end)

hook.Add("PlayerInitialSpawn", "Color_Mode_Config", function(ply)
	net.Start("color_mode_ply_load")
        net.WriteTable(Color_Mode.Config)
    net.Send(ply)
end)

net.Receive("color_mode_reset_config", function(len, ply)
    PrintTable(Color_Mode.Config)
    AddCSLuaFile("color_mode/sh_config.lua")
    include("color_mode/sh_config.lua")
    PrintTable(Color_Mode.Config)
    file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Config))
end)