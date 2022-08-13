util.AddNetworkString("color_mode_config_admin")
util.AddNetworkString("color_mode_config_admin_not_install")
util.AddNetworkString("color_mode_config_admin_install")

net.Receive("color_mode_config_admin", function(len, ply)
    if file.Exists("linventif/color_mode.json", "DATA") then
        net.Start("color_mode_config_admin_install")
        net.Send(ply)
    else
        net.Start("color_mode_config_admin_not_install")
        net.Send(ply)
    end
end)