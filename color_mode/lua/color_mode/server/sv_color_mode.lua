util.AddNetworkString("color_mode_config_admin")
util.AddNetworkString("color_mode_config_admin_not_install")

net.Receive("color_mode_config_admin", function(len, ply)
    if file.Exists("linventif/color_mode.json", "DATA") then
        ply:ConCommand(color_mode_config)
    else
        net.Start("color_mode_config_admin_not_install")
        net.Send(ply)
    end
end)