Color_Mode.Config = Color_Mode.Config or {}
Color_Mode.Config.Version = 1

Color_Mode.Config.Language = "english" -- french, english or russian

Color_Mode.Config.Size = {
    x = 710,
    y = 313
}


Color_Mode.Config.BackGroundColor = Color(32, 32, 32)
Color_Mode.Config.ButtonColor = Color(60, 90, 120)

Color_Mode.Config.NotificationsTime = 3

Color_Mode.Config.Init_Message = true
Color_Mode.Config.Button_on_Top = false

Color_Mode.Config.Theme = "Dark" -- Dark, Light, Green or Purple

Color_Mode.Config.Default_Mode = "boost" -- normal or boost

Color_Mode.Config.Commands = { 
    ["!cm"] = true,
    ["!color_mode"] = true
}

Color_Mode.Config.Commands_Admin = { 
    ["!cm_admin"] = true, -- don't remove
    ["!color_mode_admin"] = true
}

Color_Mode.Config.Admin = { 
    ["superadmin"] = true,
    ["admin"] = false
} 

Color_Mode.Color_Default = {
    ["$pp_colour_addr"]         = 0,
    ["$pp_colour_addg"]         = 0,
    ["$pp_colour_addb"]         = 0,
    ["$pp_colour_brightness"]   = 0,
    ["$pp_colour_contrast"]     = 1,
    ["$pp_colour_colour"]       = 1,
    ["$pp_colour_mulr"]         = 0,
    ["$pp_colour_mulg"]         = 0,
    ["$pp_colour_mulb"]         = 0
}

Color_Mode.Color_Boost = {
    ['$pp_colour_addr']         = 0.01,
    ["$pp_colour_addg"]         = 0,
    ['$pp_colour_addb']         = 0.01,
    ['$pp_colour_brightness']   = 0.01,
    ['$pp_colour_contrast']     = 1.05,
    ['$pp_colour_colour']       = 1.62,
    ["$pp_colour_mulr"]         = 0,
    ["$pp_colour_mulg"]         = 0,
    ["$pp_colour_mulb"]         = 0
}