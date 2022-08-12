local button_y = 0
local slider_y = {}

net.Receive("color_mode_ply_load", function(ply)
    Color_Mode.Config = net.ReadTable()
    Color_Mode.Admin_Config = Color_Mode.Config
    include("color_mode/language/" .. Color_Mode.Config.Language .. ".lua")
    if Color_Mode.Config.Init_Message then 
        timer.Simple(5, function()
            chat.AddText( Color( 100, 100, 255 ), "[ Color Mode ]  ", Color( 255, 255, 255 ), Color_Mode.Language.Init_Message)
        end)
    end

    if Color_Mode.Config.Button_on_Top then
        button_y = 45
        slider_y = {
            [1] = 80,
            [2] = 160,
            [3] = 240
        }
    else
        button_y = Color_Mode.Config.Size.y-75
        slider_y = {
            [1] = 15,
            [2] = 80,
            [3] = 145
        }
    end
end)

if Color_Mode.Config.Button_on_Top then
    button_y = 45
    slider_y = {
        [1] = 80,
        [2] = 160,
        [3] = 240
    }
else
    button_y = Color_Mode.Config.Size.y-75
    slider_y = {
        [1] = 15,
        [2] = 80,
        [3] = 145
    }
end

--  if Color_Mode.Config.Theme == "Light" then
--      Color_Mode.Config.BackGroundColor = Color(32, 32, 32)
--      Color_Mode.Config.ButtonColor = Color(60, 90, 120)
--  elseif Color_Mode.Config.Theme == "Purple" then
--      Color_Mode.Config.BackGroundColor = Color(32, 32, 32)
--      Color_Mode.Config.ButtonColor = Color(60, 90, 120)
--  else -- Default Theme = Dark
--      Color_Mode.Config.BackGroundColor = Color(32, 32, 32)
--      Color_Mode.Config.ButtonColor = Color(60, 90, 120)
--  end

if !file.Exists("linventif", "data") then
    file.CreateDir("linventif")
    if Color_Mode.Config.Default_Mode != "boost" then 
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Color_Default))
    else
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Color_Boost))
    end
elseif !file.Exists("linventif/color_mode.json", "DATA") then
    if Color_Mode.Config.Default_Mode != "boost" then 
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Color_Default))
    else
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Color_Boost))
    end
end

Color_Mode.Color = util.JSONToTable(file.Read("linventif/color_mode.json", "DATA"))
hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
    DrawColorModify(Color_Mode.Color)
end)

local function Color_Mode_Open()
    local ply = LocalPlayer()
    local Main_Frame = vgui.Create("DFrame")
    Main_Frame:SetSize(Color_Mode.Config.Size.x, Color_Mode.Config.Size.y)
    Main_Frame:Center()
    Main_Frame:SetTitle("Color Mode v" .. Color_Mode.Config.Version)
    Main_Frame:MakePopup()
    Main_Frame:SetDraggable(true)
    Main_Frame:ShowCloseButton(false)
    Main_Frame.Paint = function(s, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color_Mode.Config.BackGroundColor)
        draw.RoundedBox(0, 0, 0, w, 23, Color_Mode.Config.ButtonColor)
    end

    local Button_Close = vgui.Create("DButton", Main_Frame)
    Button_Close:SetText("")
    Button_Close:SetPos(Color_Mode.Config.Size.x-25, 0)
    Button_Close:SetSize(25, 25)
    Button_Close:SetIcon("icon16/cross.png")
    Button_Close.DoClick = function()
    	Main_Frame:Close()
    end
    Button_Close.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end

    if Color_Mode.Config.Admin[ply:GetUserGroup()] then
        local Button_Admin = vgui.Create("DButton", Main_Frame)
        Button_Admin:SetText("")
        Button_Admin:SetPos(Color_Mode.Config.Size.x-50, 0)
        Button_Admin:SetSize(25, 25)
        Button_Admin:SetIcon("icon16/wrench.png")
        Button_Admin.DoClick = function()
            RunConsoleCommand("color_mode_open_admin")
            Main_Frame:Close()
        end
        Button_Admin.Paint = function(s, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
        end
    end

    local Num_Slider_1 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_1:SetPos(35, slider_y[1])
    Num_Slider_1:SetSize(300, 100)
    Num_Slider_1:SetText(Color_Mode.Language.Red)
    Num_Slider_1:SetValue(Color_Mode.Color["$pp_colour_addr"])
    Num_Slider_1:SetMin(0)
    Num_Slider_1:SetMax(1)
    Num_Slider_1:SetDecimals(2)
    Num_Slider_1.OnValueChanged = function(self, value)
        Color_Mode.Color["$pp_colour_addr"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color)
        end)
    end
    
    local Num_Slider_2 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_2:SetPos(35, slider_y[2])			
    Num_Slider_2:SetSize(300, 100)		
    Num_Slider_2:SetText(Color_Mode.Language.Green)
    Num_Slider_2:SetValue(Color_Mode.Color["$pp_colour_addg"])
    Num_Slider_2:SetMin(0)
    Num_Slider_2:SetMax(1)
    Num_Slider_2:SetDecimals(2)
    Num_Slider_2.OnValueChanged = function(self, value)
        Color_Mode.Color["$pp_colour_addg"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color)
        end)
    end
 
    local Num_Slider_3 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_3:SetPos(35, slider_y[3])			
    Num_Slider_3:SetSize(300, 100)		
    Num_Slider_3:SetText(Color_Mode.Language.Blue)
    Num_Slider_3:SetValue(Color_Mode.Color["$pp_colour_addb"])
    Num_Slider_3:SetMin(0)				
    Num_Slider_3:SetMax(1)				
    Num_Slider_3:SetDecimals(2)			

    Num_Slider_3.OnValueChanged = function(self, value)
        Color_Mode.Color["$pp_colour_addb"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color)
        end)
    end
 
    local Num_Slider_4 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_4:SetPos(398, slider_y[1])
    Num_Slider_4:SetSize(300, 100)
    Num_Slider_4:SetText(Color_Mode.Language.Brightness)
    Num_Slider_4:SetValue(Color_Mode.Color["$pp_colour_brightness"])
    Num_Slider_4:SetMin(0)
    Num_Slider_4:SetMax(1)
    Num_Slider_4:SetDecimals(2)
    Num_Slider_4.OnValueChanged = function(self, value)
        Color_Mode.Color["$pp_colour_brightness"] = math.Round( value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color)
        end)
    end
 
    local Num_Slider_5 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_5:SetPos(398, slider_y[2])			
    Num_Slider_5:SetSize(300, 100)		
    Num_Slider_5:SetText(Color_Mode.Language.Contrast)
    Num_Slider_5:SetValue(Color_Mode.Color["$pp_colour_contrast"])
    Num_Slider_5:SetMin(0)
    Num_Slider_5:SetMax(1)
    Num_Slider_5:SetDecimals(2)
    Num_Slider_5.OnValueChanged = function(self, value)
        Color_Mode.Color["$pp_colour_contrast"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color)
        end)
    end
 
    local Num_Slider_6 = vgui.Create("DNumSlider", Main_Frame)
    Num_Slider_6:SetPos(398, slider_y[3])			
    Num_Slider_6:SetSize(300, 100)		
    Num_Slider_6:SetText(Color_Mode.Language.Color)
    Num_Slider_6:SetValue(Color_Mode.Color["$pp_colour_colour"])
    Num_Slider_6:SetMin(0)				
    Num_Slider_6:SetMax(4)				
    Num_Slider_6:SetDecimals(2)
    Num_Slider_6.OnValueChanged = function(self, value)
        Color_Mode.Color["$pp_colour_colour"] = math.Round(value, 2)
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color)
        end)
    end

    local Button_1 = vgui.Create("DButton", Main_Frame) 
    Button_1:SetText(Color_Mode.Language.Mode_Reset)
    Button_1:SetPos(35, button_y)
    Button_1:SetSize(120, 40)
    Button_1:SetColor(Color(255,255,255))
    Button_1.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
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
    Button_2:SetPos(209, button_y)	
    Button_2:SetSize(120, 40)        
    Button_2:SetColor(Color(255,255,255))            
    Button_2.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
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
    Button_3:SetPos(383, button_y)
    Button_3:SetSize(120, 40)
    Button_3:SetColor(Color(255,255,255))
    Button_3.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
    end
    Button_3.DoClick = function()
        if file.Size("linventif/color_mode.json", "DATA") != 0 then
            Color_Mode.Color = util.JSONToTable( file.Read("linventif/color_mode.json", "DATA"))
            Num_Slider_1:SetValue(Color_Mode.Color["$pp_colour_addr"])
            Num_Slider_2:SetValue(Color_Mode.Color["$pp_colour_addg"])
            Num_Slider_3:SetValue(Color_Mode.Color["$pp_colour_addb"])
            Num_Slider_4:SetValue(Color_Mode.Color["$pp_colour_brightness"])
            Num_Slider_5:SetValue(Color_Mode.Color["$pp_colour_contrast"])
            Num_Slider_6:SetValue(Color_Mode.Color["$pp_colour_colour"])
            hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
                DrawColorModify(Color_Mode.Color)
            end)
            notification.AddLegacy(Color_Mode.Language.Config_Load, 0, 3)
        else 
            notification.AddLegacy(Color_Mode.Language.Config_Not_Found, 1, 3)
        end
    end

    local Button_4 = vgui.Create("DButton", Main_Frame)
    Button_4:SetText(Color_Mode.Language.Mode_Save)
    Button_4:SetPos(557, button_y)
    Button_4:SetSize(120, 40)
    Button_4:SetColor(Color(255,255,255))
    Button_4.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
    end
    Button_4.DoClick = function()
        file.Write("linventif/color_mode.json", util.TableToJSON(Color_Mode.Color))
        notification.AddLegacy(Color_Mode.Language.Config_Save, 0, 3)        
    end
    
    if Color_Mode.Color == Color_Mode.Color_Default and Color_Mode.Config.Default_Mode == "boost" then
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color_Boost)
        end)
    elseif Color_Mode.Color == Color_Mode.Color_Default and Color_Mode.Config.Default_Mode == "normal" then
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color_Default)
        end)
    else
        hook.Add("RenderScreenspaceEffects", "RefreshColors", function()
            DrawColorModify(Color_Mode.Color)
        end)
    end
    Num_Slider_1:SetValue(Color_Mode.Color["$pp_colour_addr"])
    Num_Slider_2:SetValue(Color_Mode.Color["$pp_colour_addg"])
    Num_Slider_3:SetValue(Color_Mode.Color["$pp_colour_addb"])
    Num_Slider_4:SetValue(Color_Mode.Color["$pp_colour_brightness"])
    Num_Slider_5:SetValue(Color_Mode.Color["$pp_colour_contrast"])
    Num_Slider_6:SetValue(Color_Mode.Color["$pp_colour_colour"])
end

local function Color_Mode_Open_Admin()
    local Main_Frame = vgui.Create("DFrame")
    Main_Frame:SetSize(Color_Mode.Config.Size.x, Color_Mode.Config.Size.y)
    Main_Frame:Center()
    Main_Frame:SetTitle("Color Mode v" .. Color_Mode.Config.Version .. " | Administration")
    Main_Frame:MakePopup()
    Main_Frame:SetDraggable(true)
    Main_Frame:ShowCloseButton(false)
    Main_Frame.Paint = function(s, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color_Mode.Config.BackGroundColor)
        draw.RoundedBox(0, 0, 0, w, 23, Color_Mode.Config.ButtonColor)
        draw.SimpleText(Color_Mode.Language.Language, "Trebuchet18", 150, 66, Color(255,255,255,255))   
        draw.SimpleText(Color_Mode.Language.Mode_Default, "Trebuchet18", 150, 132, Color(255,255,255,255))
        draw.SimpleText(Color_Mode.Language.Button_Placement, "Trebuchet18", 150, 194, Color(255,255,255,255))
        draw.SimpleText(Color_Mode.Language.Enable_Init_Message, "Trebuchet18", 150, 255, Color(255,255,255,255))
        draw.SimpleText(Color_Mode.Language.Themes, "Trebuchet18", 470, 66, Color(255,255,255,255))
        draw.SimpleText("New admin options coming to the next update", "Trebuchet18", 395, 150, Color(255,255,255,255))
    end

    local Button_Close = vgui.Create("DButton", Main_Frame)
    Button_Close:SetText("")
    Button_Close:SetPos(Color_Mode.Config.Size.x-25, 0)
    Button_Close:SetSize(25, 25)
    Button_Close:SetIcon("icon16/cross.png")
    Button_Close.DoClick = function()
        Main_Frame:Close()
    end
    Button_Close.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end

    local Button_Admin = vgui.Create("DButton", Main_Frame)
    Button_Admin:SetText("")
    Button_Admin:SetPos(Color_Mode.Config.Size.x-50, 0)
    Button_Admin:SetSize(25, 25)
    Button_Admin:SetIcon("icon16/arrow_rotate_anticlockwise.png")
    Button_Admin.DoClick = function()
        RunConsoleCommand("color_mode_open")
        Main_Frame:Close()
    end
    Button_Admin.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end

    local ComboBox_Language = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Language:SetPos(35, 58)
    ComboBox_Language:SetSize(100, 30)
    ComboBox_Language:SetColor(Color(255,255,255))
    ComboBox_Language:SetValue(Color_Mode.Config.Language)
    ComboBox_Language:AddChoice("French")
    ComboBox_Language:AddChoice("English")
    ComboBox_Language:AddChoice("Russian")
    ComboBox_Language.OnSelect = function(self, index, value)
        Color_Mode.Admin_Config.Language = string.lower( value )
    end
    ComboBox_Language.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)        
    end

    local ComboBox_Default_Mode = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Default_Mode:SetPos(35, 125)
    ComboBox_Default_Mode:SetSize(100, 30)
    ComboBox_Default_Mode:SetColor(Color(255,255,255))
    ComboBox_Default_Mode:SetValue(Color_Mode.Config.Default_Mode)
    ComboBox_Default_Mode:AddChoice("Normal")
    ComboBox_Default_Mode:AddChoice("Boost")
    ComboBox_Default_Mode.OnSelect = function(self, index, value)
        Color_Mode.Admin_Config.Default_Mode = string.lower( value )
    end
    ComboBox_Default_Mode.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
    end

    local ComboBox_Button_Top = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Button_Top:SetPos(35, 187)
    ComboBox_Button_Top:SetSize(100, 30)
    ComboBox_Button_Top:SetColor(Color(255,255,255))
    if Color_Mode.Config.Button_on_Top then ComboBox_Button_Top:SetValue("true") else ComboBox_Button_Top:SetValue("false") end
    ComboBox_Button_Top:AddChoice("True")
    ComboBox_Button_Top:AddChoice("False")
    ComboBox_Button_Top.OnSelect = function(self, index, value)
        if value != "True" then Color_Mode.Admin_Config.Button_on_Top = false else Color_Mode.Admin_Config.Button_on_Top = true end
    end
    ComboBox_Button_Top.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
    end

    local ComboBox_Init_Message = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Init_Message:SetPos(35, 248)
    ComboBox_Init_Message:SetSize(100, 30)
    ComboBox_Init_Message:SetColor(Color(255,255,255))
    if Color_Mode.Config.Init_Message then ComboBox_Init_Message:SetValue("true") else ComboBox_Init_Message:SetValue("false") end
    ComboBox_Init_Message:AddChoice("True")
    ComboBox_Init_Message:AddChoice("False")
    ComboBox_Init_Message.OnSelect = function(self, index, value)
        if value != "True" then Color_Mode.Admin_Config.Init_Message = false else Color_Mode.Admin_Config.Init_Message = true end
    end
    ComboBox_Init_Message.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
    end

    local ComboBox_Themes = vgui.Create("DComboBox", Main_Frame)
    ComboBox_Themes:SetPos(355, 58)
    ComboBox_Themes:SetSize(100, 30)
    ComboBox_Themes:SetColor(Color(255,255,255))
    ComboBox_Themes:SetValue(Color_Mode.Config.Theme)
    ComboBox_Themes:AddChoice("Dark")
    ComboBox_Themes:AddChoice("Light")
    ComboBox_Themes:AddChoice("Custom")
    ComboBox_Themes.OnSelect = function(self, index, value)
        notification.AddLegacy(Color_Mode.Language.Feature_in_Dev, 1, 3)
    end
    ComboBox_Themes.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
    end

--      local Button_4 = vgui.Create("DButton", Main_Frame)
--      Button_4:SetText(Color_Mode.Language.Mode_Save)
--      Button_4:SetPos(557, Color_Mode.Config.Size.y-75)
--      Button_4:SetSize(120, 40)
--      Button_4:SetColor(Color(255,255,255))
--      Button_4.Paint = function(s, w, h)
--          draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
--      end
--      Button_4.DoClick = function()
--          Main_Frame:Close()
--          net.Start("color_mode_save_config")
--          net.WriteTable(Color_Mode.Admin_Config)
--          net.SendToServer()
--          notification.AddLegacy(Color_Mode.Language.Config_Save, 0, 6)
--      end

    --local DLabel = vgui.Create( "DLabel", Main_Frame )
    --DLabel:SetPos( 40, 40 )
    --DLabel:SetText( "Hello, world!" )

--      local Color_Frame = vgui.Create("DFrame", Main_Frame)
--      Color_Frame:SetPos(20, 43-22)
--      Color_Frame:SetSize(300, 239)
--      Color_Frame:SetDraggable("false")
--      Color_Frame:ShowCloseButton(false)
--      Color_Frame:SetTitle(" ")
--      Color_Frame.Paint = function(s, w, h)
--          draw.RoundedBox(4, 0, 22, w, h-22 , Color_Mode.Config.ButtonColor)
--      end    
--  
--      local Mixer = vgui.Create("DColorMixer", Color_Frame)
--      Mixer:Dock(FILL)
--      Mixer:SetPalette(true)
--      Mixer:SetAlphaBar(true)
--      Mixer:SetWangs(true)
--      Mixer:SetColor(Color(30,100,160))
--  
--      local ComboBox_Color = vgui.Create("DComboBox", Main_Frame)
--      ComboBox_Color:SetPos(20, Color_Mode.Config.Size.y-60)
--      ComboBox_Color:SetSize(140, 40)
--      ComboBox_Color:SetColor(Color(255,255,255))
--      ComboBox_Color:SetValue("Element Color")
--      ComboBox_Color:AddChoice("Text Color")
--      ComboBox_Color:AddChoice("First Color")
--      ComboBox_Color:AddChoice("Sedond Color")
--      ComboBox_Color.OnSelect = function(self, index, value)
--      --    if value == ""Element Color"" then
--      --        notification.AddLegacy(Color_Mode.Language.NotiNone_Element, 0, 6)
--      --    elseif value == "Pther" then
--      --    else
--      --    elseif value == "Pther" then
--      --    else
--      --    end
--      end
--      ComboBox_Color.Paint = function(s, w, h)
--          draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
--      end
--  
--      PrintTable(Mixer:GetColor())
--      local Button_Color_2 = vgui.Create("DButton", Main_Frame)
--      Button_Color_2:SetText(Color_Mode.Language.Mode_Save)
--      Button_Color_2:SetPos(180, Color_Mode.Config.Size.y-60)	
--      Button_Color_2:SetSize(140, 40)
--      Button_Color_2:SetColor(Color(255,255,255))
--      Button_Color_2.Paint = function(s, w, h)
--          draw.RoundedBox(4, 0, 0, w, h, Mixer:GetColor())
--      end
--      Button_Color_2.DoClick = function()        
--          print(Mixer:GetColor())   
--      end

    local Button_4 = vgui.Create("DButton", Main_Frame)
    Button_4:SetText(Color_Mode.Language.Reset_All)
    Button_4:SetPos(383, Color_Mode.Config.Size.y-75)
    Button_4:SetSize(120, 40)
    Button_4:SetColor(Color(255,255,255))
    Button_4.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
    end
    Button_4.DoClick = function()
        Main_Frame:Close()
        net.Start("color_mode_reset_config")
        net.SendToServer()
        notification.AddLegacy(Color_Mode.Language.Config_Reset, 0, 6)
    end

    local Button_5 = vgui.Create("DButton", Main_Frame)
    Button_5:SetText(Color_Mode.Language.Mode_Save)
    Button_5:SetPos(557, Color_Mode.Config.Size.y-75)
    Button_5:SetSize(120, 40)
    Button_5:SetColor(Color(255,255,255))
    Button_5.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color_Mode.Config.ButtonColor)
    end
    Button_5.DoClick = function()
        Main_Frame:Close()
        net.Start("color_mode_save_config")
        net.WriteTable(Color_Mode.Admin_Config)
        net.SendToServer()
        notification.AddLegacy(Color_Mode.Language.Config_Save, 0, 6)
    end
end

net.Receive("color_mode_open_admin", function(_, ply)
    if Color_Mode.Config.Admin[LocalPlayer():GetUserGroup()] then
        Color_Mode_Open_Admin()
    else
        notification.AddLegacy(Color_Mode.Language.Access_Refused, 1, 3)
    end
end)
net.Receive("color_mode_open", Color_Mode_Open)

concommand.Add("color_mode_open_admin", function(ply, cmd, args)
    if Color_Mode.Config.Admin[LocalPlayer():GetUserGroup()] then
        Color_Mode_Open_Admin()
    else
        notification.AddLegacy(Color_Mode.Language.Access_Refused, 1, 3)
    end
end)
concommand.Add("color_mode_open", Color_Mode_Open)