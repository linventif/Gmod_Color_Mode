hook.Add("InitPostEntity", "Ready", function()
    timer.Simple(5, function()
        chat.AddText( Color( 100, 100, 255 ), "[ Color Mode ]  ", Color( 255, 255, 255 ), Color_Mode.Language.Init_Message)
    end)
end)

hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
    DrawColorModify(Color_Mode.Config.Color)
end)

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

local ply = LocalPlayer()
local UI_Color = {
    Background = Color(32, 32, 32),
    Other = Color(60, 90, 120),
    Transparent = Color(255, 255, 255, 0)
}
local Size = {
    x = 710,
    y = 313
}

net.Receive("color_mode_config_admin_not_install", function(len, ply)
    local Main_Frame = vgui.Create("DFrame")
    Main_Frame:SetSize(Size.x, Size.y)
    Main_Frame:Center()
    Main_Frame:SetTitle("Color Mode v" .. Color_Mode.Config.Version)
    Main_Frame:MakePopup()
    Main_Frame:SetDraggable(true)
    Main_Frame:ShowCloseButton(false)
    Main_Frame.Paint = function(s, w, h)
        draw.RoundedBox(8, 0, 0, w, h, UI_Color.Background)
        draw.RoundedBox(0, 0, 0, w, 23, UI_Color.Other)
        draw.SimpleText(Color_Mode.Language.Not_Install, "Trebuchet24", w/2, h/3, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(Color_Mode.Language.Not_Yet_Avalable, "Trebuchet24", w/2, (h/5)*4, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local Button_Close = vgui.Create("DButton", Main_Frame)
    Button_Close:SetText("")
    Button_Close:SetPos(Size.x-25, 0)
    Button_Close:SetSize(25, 25)
    Button_Close:SetIcon("icon16/cross.png")
    Button_Close.DoClick = function()
    	Main_Frame:Close()
    end
    Button_Close.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
    end
    
    local Button_Config = vgui.Create("DButton", Main_Frame)
    Button_Config:SetText("")
    Button_Config:SetPos(Size.x-50, 0)
    Button_Config:SetSize(25, 25)
    Button_Config:SetIcon("icon16/wrench.png")
    Button_Config.DoClick = function()
        RunConsoleCommand("color_mode_config")
        Main_Frame:Close()
    end
    Button_Config.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
    end
    
    local Button_Config_Admin = vgui.Create("DButton", Main_Frame)
    Button_Config_Admin:SetText("")
    Button_Config_Admin:SetPos(Size.x-75, 0)
    Button_Config_Admin:SetSize(25, 25)
    Button_Config_Admin:SetIcon("icon16/arrow_rotate_anticlockwise.png")
    Button_Config_Admin.DoClick = function()
        RunConsoleCommand("color_mode")
        Main_Frame:Close()
    end
    Button_Config_Admin.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
    end

    local Button_1 = vgui.Create("DButton", Main_Frame) 
    Button_1:SetText("Install")
    Button_1:SetFont("Trebuchet24")
    Button_1:SetPos(Size.x/2-60, Size.y/2)
    Button_1:SetSize(120, 40)
    Button_1:SetColor(Color(255,255,255))
    Button_1.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end
    Button_1.DoClick = function()
        gui.OpenURL("https://dsc.gg/linventif")
    end
end)

local function Color_Mode_Open()
    local Main_Frame = vgui.Create("DFrame")
    Main_Frame:SetSize(Size.x, Size.y)
    Main_Frame:Center()
    Main_Frame:SetTitle("Color Mode v" .. Color_Mode.Config.Version)
    Main_Frame:MakePopup()
    Main_Frame:SetDraggable(true)
    Main_Frame:ShowCloseButton(false)
    Main_Frame.Paint = function(s, w, h)
        draw.RoundedBox(8, 0, 0, w, h, UI_Color.Background)
        draw.RoundedBox(0, 0, 0, w, 23, UI_Color.Other)
    end

    local Button_Close = vgui.Create("DButton", Main_Frame)
    Button_Close:SetText("")
    Button_Close:SetPos(Size.x-25, 0)
    Button_Close:SetSize(25, 25)
    Button_Close:SetIcon("icon16/cross.png")
    Button_Close.DoClick = function()
    	Main_Frame:Close()
    end
    Button_Close.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
    end
    
    local Button_Config = vgui.Create("DButton", Main_Frame)
    Button_Config:SetText("")
    Button_Config:SetPos(Size.x-50, 0)
    Button_Config:SetSize(25, 25)
    Button_Config:SetIcon("icon16/wrench.png")
    Button_Config.DoClick = function()
        RunConsoleCommand("color_mode_config")
        Main_Frame:Close()
    end
    Button_Config.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
    end
    
    if LocalPlayer():IsUserGroup("superadmin") then
        local Button_Config_Admin = vgui.Create("DButton", Main_Frame)
        Button_Config_Admin:SetText("")
        Button_Config_Admin:SetPos(Size.x-75, 0)
        Button_Config_Admin:SetSize(25, 25)
        Button_Config_Admin:SetIcon("icon16/shield.png")
        Button_Config_Admin.DoClick = function()
            net.Start("color_mode_config_admin")
            net.SendToServer()
            Main_Frame:Close()
        end
        Button_Config_Admin.Paint = function(s, w, h)
            draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
        end
    end

    local Num_Slider_1 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_1:SetPos(35, 15)
    Num_Slider_1:SetSize(300, 100)
    Num_Slider_1:SetText(Color_Mode.Language.Red)
    Num_Slider_1:SetValue(Color_Mode.Config.Color["$pp_colour_addr"])
    Num_Slider_1:SetMin(0)
    Num_Slider_1:SetMax(1)
    Num_Slider_1:SetDecimals(2)
    Num_Slider_1.OnValueChanged = function(self, value)
        Color_Mode.Config.Color["$pp_colour_addr"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Config.Color)
        end)
    end
    
    local Num_Slider_2 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_2:SetPos(35, 80)			
    Num_Slider_2:SetSize(300, 100)		
    Num_Slider_2:SetText(Color_Mode.Language.Green)
    Num_Slider_2:SetValue(Color_Mode.Config.Color["$pp_colour_addg"])
    Num_Slider_2:SetMin(0)
    Num_Slider_2:SetMax(1)
    Num_Slider_2:SetDecimals(2)
    Num_Slider_2.OnValueChanged = function(self, value)
        Color_Mode.Config.Color["$pp_colour_addg"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Config.Color)
        end)
    end
 
    local Num_Slider_3 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_3:SetPos(35, 145)			
    Num_Slider_3:SetSize(300, 100)		
    Num_Slider_3:SetText(Color_Mode.Language.Blue)
    Num_Slider_3:SetValue(Color_Mode.Config.Color["$pp_colour_addb"])
    Num_Slider_3:SetMin(0)				
    Num_Slider_3:SetMax(1)				
    Num_Slider_3:SetDecimals(2)			

    Num_Slider_3.OnValueChanged = function(self, value)
        Color_Mode.Config.Color["$pp_colour_addb"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Config.Color)
        end)
    end
 
    local Num_Slider_4 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_4:SetPos(398, 15)
    Num_Slider_4:SetSize(300, 100)
    Num_Slider_4:SetText(Color_Mode.Language.Brightness)
    Num_Slider_4:SetValue(Color_Mode.Config.Color["$pp_colour_brightness"])
    Num_Slider_4:SetMin(0)
    Num_Slider_4:SetMax(1)
    Num_Slider_4:SetDecimals(2)
    Num_Slider_4.OnValueChanged = function(self, value)
        Color_Mode.Config.Color["$pp_colour_brightness"] = math.Round( value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Config.Color)
        end)
    end
 
    local Num_Slider_5 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_5:SetPos(398, 80)			
    Num_Slider_5:SetSize(300, 100)		
    Num_Slider_5:SetText(Color_Mode.Language.Contrast)
    Num_Slider_5:SetValue(Color_Mode.Config.Color["$pp_colour_contrast"])
    Num_Slider_5:SetMin(0)
    Num_Slider_5:SetMax(1)
    Num_Slider_5:SetDecimals(2)
    Num_Slider_5.OnValueChanged = function(self, value)
        Color_Mode.Config.Color["$pp_colour_contrast"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Config.Color)
        end)
    end
 
    local Num_Slider_6 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_6:SetPos(398, 145)			
    Num_Slider_6:SetSize(300, 100)		
    Num_Slider_6:SetText(Color_Mode.Language.Color)
    Num_Slider_6:SetValue(Color_Mode.Config.Color["$pp_colour_colour"])
    Num_Slider_6:SetMin(0)				
    Num_Slider_6:SetMax(4)				
    Num_Slider_6:SetDecimals(2)
    Num_Slider_6.OnValueChanged = function(self, value)
        Color_Mode.Config.Color["$pp_colour_colour"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Config.Color)
        end)
    end

    local Button_1 = vgui.Create("DButton", Main_Frame) 
    Button_1:SetText(Color_Mode.Language.Mode_Reset)
    Button_1:SetPos(35, Size.y-75)
    Button_1:SetSize(120, 40)
    Button_1:SetColor(Color(255,255,255))
    Button_1.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end
    Button_1.DoClick = function()
        Num_Slider_1:SetValue(Color_Mode.Color_Default["$pp_colour_addr"])
        Num_Slider_2:SetValue(Color_Mode.Color_Default["$pp_colour_addg"])
        Num_Slider_3:SetValue(Color_Mode.Color_Default["$pp_colour_addb"])
        Num_Slider_4:SetValue(Color_Mode.Color_Default["$pp_colour_brightness"])
        Num_Slider_5:SetValue(Color_Mode.Color_Default["$pp_colour_contrast"])
        Num_Slider_6:SetValue(Color_Mode.Color_Default["$pp_colour_colour"])
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color_Default)
        end)
    end

    local Button_2 = vgui.Create("DButton", Main_Frame) 
    Button_2:SetText(Color_Mode.Language.Mode_Boost)	
    Button_2:SetPos(209, Size.y-75)	
    Button_2:SetSize(120, 40)        
    Button_2:SetColor(Color(255,255,255))            
    Button_2.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end
    Button_2.DoClick = function()
        Num_Slider_1:SetValue(Color_Mode.Color_Boost["$pp_colour_addr"])
        Num_Slider_2:SetValue(Color_Mode.Color_Boost["$pp_colour_addg"])
        Num_Slider_3:SetValue(Color_Mode.Color_Boost["$pp_colour_addb"])
        Num_Slider_4:SetValue(Color_Mode.Color_Boost["$pp_colour_brightness"])
        Num_Slider_5:SetValue(Color_Mode.Color_Boost["$pp_colour_contrast"])
        Num_Slider_6:SetValue(Color_Mode.Color_Boost["$pp_colour_colour"])
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color_Boost)
        end)
    end

    local Button_3 = vgui.Create("DButton", Main_Frame)
    Button_3:SetText(Color_Mode.Language.Mode_Load)
    Button_3:SetPos(383, Size.y-75)
    Button_3:SetSize(120, 40)
    Button_3:SetColor(Color(255,255,255))
    Button_3.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end
    Button_3.DoClick = function()
        if file.Size("linventif/color_mode.json", "DATA") != 0 then
            local Read = util.JSONToTable( file.Read("linventif/color_mode.json", "DATA"))
            Num_Slider_1:SetValue(Read.Color["$pp_colour_addr"])
            Num_Slider_2:SetValue(Read.Color["$pp_colour_addg"])
            Num_Slider_3:SetValue(Read.Color["$pp_colour_addb"])
            Num_Slider_4:SetValue(Read.Color["$pp_colour_brightness"])
            Num_Slider_5:SetValue(Read.Color["$pp_colour_contrast"])
              Num_Slider_6:SetValue(Read.Color["$pp_colour_colour"])
            hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
                DrawColorModify(Read.Color)
            end)
            notification.AddLegacy(Color_Mode.Language.Config_Load, 0, 3)
        else 
            notification.AddLegacy(Color_Mode.Language.Config_Not_Found, 1, 3)
        end
    end

    local Button_4 = vgui.Create("DButton", Main_Frame)
    Button_4:SetText(Color_Mode.Language.Mode_Save)
    Button_4:SetPos(557, Size.y-75)
    Button_4:SetSize(120, 40)
    Button_4:SetColor(Color(255,255,255))
    Button_4.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end
    Button_4.DoClick = function()
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Config))
        notification.AddLegacy(Color_Mode.Language.Config_Save, 0, 3)
    end
end

local function Color_Mode_Open_Config()
    local Main_Frame = vgui.Create("DFrame")
    Main_Frame:SetSize(Size.x, Size.y)
    Main_Frame:Center()
    Main_Frame:SetTitle("Color Mode v" .. Color_Mode.Config.Version)
    Main_Frame:MakePopup()
    Main_Frame:SetDraggable(true)
    Main_Frame:ShowCloseButton(false)
    Main_Frame.Paint = function(s, w, h)
        draw.RoundedBox(8, 0, 0, w, h, UI_Color.Background)
        draw.RoundedBox(0, 0, 0, w, 23, UI_Color.Other)
        draw.SimpleText(Color_Mode.Language.Language, "Trebuchet18", 150, 66, Color(255,255,255,255))
        draw.SimpleText(Color_Mode.Language.Button_Placement, "Trebuchet18", 150, 132, Color(255,255,255,255))
        draw.SimpleText(Color_Mode.Language.Enable_Init_Message, "Trebuchet18", 470, 132, Color(255,255,255,255))
        draw.SimpleText(Color_Mode.Language.Themes, "Trebuchet18", 470, 66, Color(255,255,255,255))
    end

    local Button_Close = vgui.Create("DButton", Main_Frame)
    Button_Close:SetText("")
    Button_Close:SetPos(Size.x-25, 0)
    Button_Close:SetSize(25, 25)
    Button_Close:SetIcon("icon16/cross.png")
    Button_Close.DoClick = function()
    	Main_Frame:Close()
    end
    Button_Close.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
    end
    
    local Button_Config = vgui.Create("DButton", Main_Frame)
    Button_Config:SetText("")
    Button_Config:SetPos(Size.x-50, 0)
    Button_Config:SetSize(25, 25)
    Button_Config:SetIcon("icon16/arrow_rotate_anticlockwise.png")
    Button_Config.DoClick = function()
        RunConsoleCommand("color_mode")
        Main_Frame:Close()
    end
    Button_Config.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
    end
    
    if LocalPlayer():IsUserGroup("superadmin") then
        local Button_Config_Admin = vgui.Create("DButton", Main_Frame)
        Button_Config_Admin:SetText("")
        Button_Config_Admin:SetPos(Size.x-75, 0)
        Button_Config_Admin:SetSize(25, 25)
        Button_Config_Admin:SetIcon("icon16/shield.png")
        Button_Config_Admin.DoClick = function()
            net.Start("color_mode_config_admin")
            net.SendToServer()
            Main_Frame:Close()
        end
        Button_Config_Admin.Paint = function(s, w, h)
            draw.RoundedBox(0, 0, 0, w, h, UI_Color.Transparent)
        end
    end

    local ComboBox_Language = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Language:SetPos(35, 58)
    ComboBox_Language:SetSize(100, 30)
    ComboBox_Language:SetColor(Color(255,255,255))
    ComboBox_Language:SetValue(Color_Mode.Config.Language)
    ComboBox_Language:AddChoice("French")
    ComboBox_Language:AddChoice("English")
    ComboBox_Language:AddChoice("Russian")
    ComboBox_Language:AddChoice("Add Language")
    ComboBox_Language.OnSelect = function(self, index, value)
        if value == "Add Language" then
            chat.AddText( Color( 100, 100, 255 ), "[ Color Mode ]  ", Color( 255, 255, 255 ), "You want add language, contact me discord : Linventif#0253 or dsc.gg/linventif")
        else
            Color_Mode.Config.Language = string.lower(value)
            notification.AddLegacy(Color_Mode.Language.Config_Save, 0, 3)        
            file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Config))
            include("color_mode/languages/" .. Color_Mode.Config.Language .. ".lua")
            Main_Frame:Close()
            RunConsoleCommand("color_mode_config")
        end
    end
    ComboBox_Language.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)        
    end

    local ComboBox_Themes = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Themes:SetPos(355, 58)
    ComboBox_Themes:SetSize(100, 30)
    ComboBox_Themes:SetColor(Color(255,255,255))
    ComboBox_Themes:SetValue("Dark")
    ComboBox_Themes:AddChoice("Dark")
    ComboBox_Themes:AddChoice("Light")
    ComboBox_Themes:AddChoice("Custom")
    ComboBox_Themes.OnSelect = function(self, index, value)
        notification.AddLegacy(Color_Mode.Language.Feature_in_Dev, 1, 3)
    end
    ComboBox_Themes.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end

    local ComboBox_Button_Top = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Button_Top:SetPos(35, 125)
    ComboBox_Button_Top:SetSize(100, 30)
    ComboBox_Button_Top:SetColor(Color(255,255,255))
    ComboBox_Button_Top:SetValue("false")
    ComboBox_Button_Top:AddChoice("True")
    ComboBox_Button_Top:AddChoice("False")
    ComboBox_Button_Top.OnSelect = function(self, index, value)
        notification.AddLegacy(Color_Mode.Language.Feature_in_Dev, 1, 3)
    end
    ComboBox_Button_Top.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end

    local ComboBox_Init_Message = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Init_Message:SetPos(355, 125)
    ComboBox_Init_Message:SetSize(100, 30)
    ComboBox_Init_Message:SetColor(Color(255,255,255))
    ComboBox_Init_Message:SetValue("false")
    ComboBox_Init_Message:AddChoice("True")
    ComboBox_Init_Message:AddChoice("False")
    ComboBox_Init_Message.OnSelect = function(self, index, value)
        notification.AddLegacy(Color_Mode.Language.Feature_in_Dev, 1, 3)
    end
    ComboBox_Init_Message.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end

    local Button_1 = vgui.Create("DButton", Main_Frame) 
    Button_1:SetText(Color_Mode.Language.Mode_Reset)
    Button_1:SetPos(Size.x/2-60, Size.y-75)
    Button_1:SetSize(120, 40)
    Button_1:SetColor(Color(255,255,255))
    Button_1.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, UI_Color.Other)
    end
    Button_1.DoClick = function()
        include("color_mode/sh_config.lua")
        notification.AddLegacy(Color_Mode.Language.Config_Reset, 0, 3)        
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Config))
        Main_Frame:Close()
        RunConsoleCommand("color_mode_config")
    end
end

hook.Add( "OnPlayerChat", "Color_Mode_Open", function( ply, strText, bTeam, bDead ) 
	if ( strText == "!color_mode" ) then
		Color_Mode_Open()
	end
end)

hook.Add( "OnPlayerChat", "Color_Mode_Open_Config", function( ply, strText, bTeam, bDead ) 
	if ( strText == "!color_mode_config" ) then
		Color_Mode_Open_Config()
	end
end)

concommand.Add("color_mode", Color_Mode_Open)
concommand.Add("color_mode_config", Color_Mode_Open_Config)