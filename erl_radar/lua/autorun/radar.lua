hook.Add( "InitPostEntity", "some_unique_name", function()

    local ply = LocalPlayer()

    local radar_r = tonumber(cookie.GetNumber("radar_r", 1000))
    local debugmode = cookie.GetNumber("debugmode", 0)
    local minr = cookie.GetNumber("minr", 500)
    local maxr = cookie.GetNumber("minr", 1500)

    local n = 0
    local n2 = 0

    local Col = Color( cookie.GetNumber("EntColR",194), cookie.GetNumber("EntColG",194), cookie.GetNumber("EntColB",194), cookie.GetNumber("EntColA",255))
    local mainCol = Color(cookie.GetNumber("MainColorR",69), cookie.GetNumber("MainColorG",68),cookie.GetNumber("MainColorB",68), cookie.GetNumber("MainColorA",255))
    local secCol = Color(cookie.GetNumber("SecColR",87), cookie.GetNumber("SecColG",87), cookie.GetNumber("SecColB",87), cookie.GetNumber("SecColA",200))
    local textCol = Color(cookie.GetNumber("TextColR",255), cookie.GetNumber("TextColG",255), cookie.GetNumber("TextColB",255), cookie.GetNumber("TextColA",255))

    local minr = 500
    local maxr = 1500

    hook.Add("HUDPaint", "Radar", function()
        surface.SetDrawColor( 0, 0, 0, 200)
        draw.NoTexture()
        draw.RoundedBox(3, 10, 10, 220,220,mainCol)
        draw.RoundedBox(0, 20, 20, 200, 200, secCol)
        for k,v in pairs(ents.GetAll()) do
            --if v:GetPos():Length2D(ply:GetPos()) < 300 then
                --x = v:GetPos().x - LocalPlayer():GetPos().x
                --print(v:GetPos().x.." - "..LocalPlayer():GetPos().x)
            --end
            if (math.abs(ply:GetPos().x - v:GetPos().x) < radar_r and math.abs(ply:GetPos().y - v:GetPos().y) < radar_r and LocalPlayer():IsValid()) then
                local xradar = v:GetPos().x - ply:GetPos().x
                local yradar = v:GetPos().y - ply:GetPos().y

                local coe = (radar_r / 100)
                local coe2 = (radar_r / 1000)

                if v:IsPlayer() then
                    draw.SimpleText(v:Nick(), "Nicknamefont", 130 + xradar / coe , 110 + yradar / coe, textCol)
                end
                if (v:IsPlayer() or v:IsNPC()) then
                    
                    draw.RoundedBox(0, 130 + xradar /coe, 123 + yradar / coe, 30, 5, mainCol)
                    draw.RoundedBox(0, 130 + xradar / coe, 123 + yradar / coe, v:Health() / v:GetMaxHealth() * 30, 5, Color(255, 0, 0))
                    
                end

                if debugmode == 1 then
                    if (v:GetPos() - ply:GetPos()):Length2D() > 70 then

                        draw.SimpleText(v:GetClass(), "Nicknamefont", 130 + xradar /coe , 110 + yradar / coe, textCol)
                    end
                end

                draw.RoundedBox(6,( 120 + xradar / coe ), ( 120 + yradar / coe) , (5 * 1000 / radar_r ), (5 * 1000 / radar_r), Col)
            end
        end
        draw.RoundedBox(40, 50, 10, 150, 25,  mainCol)
        draw.SimpleText("Radar", "RadarFont", 100, 15, textCol)
    end)

    local button1 = vgui.Create("DButton")
    button1:SetPos(240, 15)
    button1:SetSize(20, 20)
    button1:SetTextColor(textCol)
    button1:SetText("+")

    local button2 = vgui.Create("DButton")
    button2:SetPos(240, 40)
    button2:SetSize(20, 20)
    button2:SetTextColor(textCol)
    button2:SetText("-")

    local button3 = vgui.Create("DButton")
    button3:SetPos(240, 65)
    button3:SetSize(20, 20)
    button3:SetTextColor(textCol)
    button3:SetText("")

    local img_gear = vgui.Create("DImage")
    img_gear:SetSize(15, 15)
    img_gear:SetPos(242, 68)
    img_gear:SetImage("gear.png")

    function button1:DoClick()
        radar_r = radar_r - 100
        if radar_r <= minr then radar_r = minr end
    end

    function button2:DoClick()
        radar_r = radar_r + 100
        if radar_r >= maxr then radar_r = maxr end
    end

    local frame = vgui.Create("DFrame")
    frame:SetSize(0, 0)

    local frame2 = vgui.Create("DFrame", frame)
    frame2:SetSize(0,0)
    frame2:SetDraggable(false)

    local GearButton2 = vgui.Create("DButton", frame)
    GearButton2:SetPos(5,25)
    GearButton2:SetSize(50,50)
    GearButton2:SetText("")

    local GearButton3 = vgui.Create("DButton", frame)
    GearButton3:SetPos(5,80)
    GearButton3:SetSize(50,50)
    GearButton3:SetText("")

    local frame1close = vgui.Create("DButton", frame)
    frame1close:SetPos(454, 5)
    frame1close:SetSize(50,15)
    frame1close:SetTextColor(textCol)
    frame1close:SetText("X")

    local frame2Colorpicker = vgui.Create('DColorMixer', frame2)
    frame2Colorpicker:SetPos(0,0)

    local frame2Colorpickertitle = vgui.Create("DLabel",frame2)
    frame2Colorpickertitle:SetText("Entity/Player Color Picker")

    local frame2ColorpickerButton = vgui.Create("DButton",frame2)
    frame2ColorpickerButton:SetText("Slect and confirm")

    local frame3 = vgui.Create("DFrame", frame)
    frame3:SetSize(0,0)
    frame3:SetDraggable(false)

    local frame2Colorpickermaincolor = vgui.Create('DColorMixer', frame2)

    local frame2Colorpickermaincolortitle = vgui.Create("DLabel", frame2)
    frame2Colorpickermaincolortitle:SetText("Main Color Color Picker")

    local frame2ColorpickermaincolorButton = vgui.Create("DButton",frame2)
    frame2ColorpickermaincolorButton:SetText("Slect and confirm")


    local frame2Colorpickersecondarycolor = vgui.Create('DColorMixer', frame2)

    local frame2Colorpickersecondarycolortitle = vgui.Create("DLabel", frame2)
    frame2Colorpickersecondarycolortitle:SetText("Secondary Color Color Picker")

    local frame2ColorpickersecondarycolorButton = vgui.Create("DButton",frame2)
    frame2ColorpickersecondarycolorButton:SetText("Slect and confirm")


    local frame2ColorpickerTextColor = vgui.Create('DColorMixer', frame2)

    local frame2ColorpickerTextColorTitle = vgui.Create("DLabel", frame2)
    frame2ColorpickerTextColorTitle:SetText("Text Color Color Picker")

    local frame2ColorpickerTextColorButton = vgui.Create("DButton",frame2)
    frame2ColorpickerTextColorButton:SetText("Slect and confirm")


    local frame3DebugTitle = vgui.Create("DLabel", frame3)
    frame3DebugTitle:SetText("Debug mode ")

    local frame3DebugCheck = vgui.Create("DCheckBox", frame3)


    local frame3NmaxTitle = vgui.Create("DLabel", frame3)
    frame3NmaxTitle:SetText("Maximum zoom in value")
    frame3NmaxTitle:SetSize(0,0)

    local frame3NmaxSlider = vgui.Create("DNumSlider",frame3)
    frame3NmaxSlider:SetSize(0,0)
    frame3NmaxSlider:SetMinMax(minr/1000, 2)
    frame3NmaxSlider:SetDefaultValue(maxr/1000)
    frame3NmaxSlider:ResetToDefaultValue()

    local frame3NminTitle = vgui.Create("DLabel", frame3)
    frame3NminTitle:SetText("Maximum zoom out value")
    frame3NminTitle:SetSize(0,0)

    local frame3NminSlider = vgui.Create("DNumSlider",frame3)
    frame3NminSlider:SetSize(0,0)
    frame3NminSlider:SetMinMax(0.1,maxr/1000)
    frame3NminSlider:SetDefaultValue(minr/1000)
    frame3NminSlider:ResetToDefaultValue()


    local frame3ZoomInTitle = vgui.Create("DLabel", frame3)
    frame3ZoomInTitle:SetText("Zoom in/out value")
    frame3ZoomInTitle:SetSize(0,0)


    local frame3ZoomInSlider = vgui.Create("DNumSlider",frame3)
    frame3ZoomInSlider:SetMinMax(minr/1000, maxr/1000)
    frame3ZoomInSlider:SetDefaultValue(radar_r/1000)
    frame3ZoomInSlider:ResetToDefaultValue()


    local frame3Button = vgui.Create("DButton", frame3)

    local frame3Reset = vgui.Create("DButton", frame3)

    local img_code = vgui.Create("DImage", frame)
    img_code:SetSize(0, 0)
    img_code:SetImage("code.png")

    local img_paint = vgui.Create("DImage", frame)
    img_paint:SetSize(0, 0)
    img_paint:SetImage("paint.png")

    local frametemp = vgui.Create("DFrame", frame)
    frametemp:SetSize(0,0)
    frametemp:SetDraggable(false)

    function button3:DoClick()
        frame:SetSize(510, 380)
        frame:Center()
        frame:SetTitle("Setting Menu")
        frame:SetIsMenu(false)
        frame:ShowCloseButton(false)

        frametemp:SetSize(445, 350)
        frametemp:SetTitle("")
        frametemp:SetIsMenu(false)
        frametemp:ShowCloseButton(false)
        frametemp:SetPos(60, 25)

        img_code:SetPos(10,90)
        img_code:SetSize( 38.1 ,30)

        img_paint:SetPos(10,35)
        img_paint:SetSize( 38.1 ,30)
        function frame1close:DoClick()
            frame:SetSize(0,0)
            frame2:SetSize(0,0)
            frame3:SetSize(0,0)
        end

        function GearButton2:DoClick()

            frame3:SetSize(0,0)
            frametemp:SetSize(0,0)

            frame:SetSize(510, 543)

            frame2:SetSize(445, 513)
            frame2:SetPos(60, 25)
            frame2:ShowCloseButton(false)
            frame2:SetTitle("")

            frame2Colorpicker:SetSize(200, 200)
            frame2Colorpicker:SetPos(5, 20)

            frame2Colorpickertitle:SetSize(200, 20)
            frame2Colorpickertitle:SetPos(5, 0)
            frame2Colorpickertitle:SetTextColor(textCol)

            frame2ColorpickerButton:SetPos(5, 230)
            frame2ColorpickerButton:SetSize(140, 20)
            frame2ColorpickerButton:SetTextColor(textCol)

            function frame2ColorpickerButton:DoClick()
                Col = frame2Colorpicker:GetColor()
                cookie.Set("EntColR", Col.r)
                cookie.Set("EntColG", Col.g)
                cookie.Set("EntColB", Col.b)
                cookie.Set("EntColA", Col.a)
            end
            --------------
            frame2Colorpickermaincolor:SetPos(235, 20)
            frame2Colorpickermaincolor:SetSize(200, 200)

            frame2Colorpickermaincolortitle:SetSize(200, 20)
            frame2Colorpickermaincolortitle:SetPos(235, 0)
            frame2Colorpickermaincolortitle:SetTextColor(textCol)

            frame2ColorpickermaincolorButton:SetPos(235,230)
            frame2ColorpickermaincolorButton:SetSize(140, 20)
            frame2ColorpickermaincolorButton:SetTextColor(textCol)

            function frame2ColorpickermaincolorButton:DoClick()
                mainCol = frame2Colorpickermaincolor:GetColor()
                cookie.Set("MainColorR", mainCol.r)
                cookie.Set("MainColorG", mainCol.g)
                cookie.Set("MainColorB", mainCol.b)
                cookie.Set("MainColorA", mainCol.a)
            end
            --------------------------------
            frame2Colorpickersecondarycolor:SetPos(5, 270)
            frame2Colorpickersecondarycolor:SetSize(200, 200)

            frame2Colorpickersecondarycolortitle:SetSize(200, 20)
            frame2Colorpickersecondarycolortitle:SetPos(5, 250)
            frame2Colorpickersecondarycolortitle:SetTextColor(textCol)

            frame2ColorpickersecondarycolorButton:SetPos(5,480)
            frame2ColorpickersecondarycolorButton:SetSize(140, 20)
            frame2ColorpickersecondarycolorButton:SetTextColor(textCol)

            function frame2ColorpickersecondarycolorButton:DoClick()
                secCol = frame2Colorpickersecondarycolor:GetColor()
                cookie.Set("SecColR", secCol.r)
                cookie.Set("SecColG", secCol.g)
                cookie.Set("SecColB", secCol.b)
                cookie.Set("SecColA", secCol.a)
            end
            ---------------------------------

            frame2ColorpickerTextColor:SetPos(235, 270)
            frame2ColorpickerTextColor:SetSize(200, 200)

            frame2ColorpickerTextColorTitle:SetSize(200, 20)
            frame2ColorpickerTextColorTitle:SetPos(235, 250)
            frame2ColorpickerTextColorTitle:SetTextColor(textCol)

            frame2ColorpickerTextColorButton:SetPos(235,480)
            frame2ColorpickerTextColorButton:SetSize(140, 20)
            frame2ColorpickerTextColorButton:SetTextColor(textCol)

            function frame2ColorpickerTextColorButton:DoClick()
                textCol = frame2ColorpickerTextColor:GetColor()
                cookie.Set("TextColR", textCol.r)
                cookie.Set("TextColG", textCol.g)
                cookie.Set("TextColB", textCol.b)
                cookie.Set("TextColA", textCol.a)
            end
            
        end 
        function GearButton3:DoClick()
            frame2:SetSize(0,0)
            frametemp:SetSize(0,0)
            
            frame:SetSize(510, 380)

            frame3:SetSize(445, 350)
            frame3:SetPos(60, 25)
            frame3:ShowCloseButton(false)
            frame3:SetTitle("")

            frame3DebugTitle:SetPos(5,5)
            frame3DebugTitle:SetSize(200, 20)

            frame3DebugCheck:SetPos(420, 7)
            frame3DebugCheck:SetSize(15, 15)

            frame3NmaxTitle:SetPos(5, 25)
            frame3NmaxTitle:SetSize(200, 20)

            frame3NmaxSlider:SetPos(405, 25)
            frame3NmaxSlider:SetSize(50, 20)

            frame3NminTitle:SetPos(5, 45)
            frame3NminTitle:SetSize(200, 20)

            frame3NminSlider:SetPos(405, 45)
            frame3NminSlider:SetSize(50, 20)

            frame3ZoomInTitle:SetPos(5, 65)
            frame3ZoomInTitle:SetSize(200, 20)

            frame3ZoomInSlider:SetPos(405, 65)
            frame3ZoomInSlider:SetSize(50, 20)

            frame3Button:SetPos(230, 320)
            frame3Button:SetSize(130, 20)
            frame3Button:SetText("Save Settings")
            frame3Button:SetTextColor(textCol)

            frame3Reset:SetPos(90,320)
            frame3Reset:SetSize(130, 20)
            frame3Reset:SetText("Factory Reset")
            frame3Reset:SetTextColor(textCol)

            function frame3Button:DoClick()

                local radar_r = frame3ZoomInSlider:GetValue() * 1000
                cookie.Set("radar_r", radar_r)
                
                if frame3DebugCheck:GetChecked() then
                    debugmode = 1
                    cookie.Set("debugmode", debugmode)
                else 
                    debugmode = 0 
                    cookie.Set("debugmode", debugmode)       
                end
                minr = frame3NminSlider:GetValue() * 1000
                cookie.Set("minr", minr)
                maxr = frame3NmaxSlider:GetValue() * 1000
                cookie.Set("maxr", maxr)

            end
            function frame3Reset:DoClick()

                radar_r = 1000
                    cookie.Set("radar_r", radar_r)

                debugmode = 0
                    cookie.Set("debugmode", debugmode)

                minr = 500
                    cookie.Set("minr", minr)

                maxr = 1500
                    cookie.Set("maxr", maxr)

                Col = Color(196,194,194,255)
                    cookie.Set("EntColR", Col.r)
                    cookie.Set("EntColG", Col.g)
                    cookie.Set("EntColB", Col.b)
                    cookie.Set("EntColA", Col.a)

                mainCol = Color(69,68,68,255)
                    cookie.Set("MainColorR", mainCol.r)
                    cookie.Set("MainColorG", mainCol.g)
                    cookie.Set("MainColorB", mainCol.b)
                    cookie.Set("MainColorA", mainCol.a)

                secCol = Color(87, 87, 87, 200)
                    cookie.Set("SecColR", secCol.r)
                    cookie.Set("SecColG", secCol.g)
                    cookie.Set("SecColB", secCol.b)
                    cookie.Set("SecColA", secCol.a)

                textCol = Color(255,255,255,255)
                    cookie.Set("TextColR", textCol.r)
                    cookie.Set("TextColG", textCol.g)
                    cookie.Set("TextColB", textCol.b)
                    cookie.Set("TextColA", textCol.a)
                
            end
        end

    end
    function frame3Reset:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )   
    end
    function frametemp:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, secCol)
    end
    function frame3DebugCheck:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
        if frame3DebugCheck:GetChecked() then
            draw.SimpleText("X", "DermaDefault", 5,1,Color(255,255,255,255))
        end
    end
    function frame3Button:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end
    function frame2ColorpickerTextColorButton:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end
    function frame2ColorpickersecondarycolorButton:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end
    function frame2ColorpickermaincolorButton:Paint (w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end
    function frame3:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, secCol )
    end
    function frame2ColorpickerButton:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end
    function frame1close:Paint(w, h)
        draw.RoundedBox( 3, 0, 0, w, h, secCol )
    end
    function frame2:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, secCol )
    end
    function GearButton3:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, secCol)
    end
    function GearButton2:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, secCol )
    end
    function frame:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end
    function button1:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end
    function button2:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end
    function button3:Paint(w,h)
        draw.RoundedBox( 3, 0, 0, w, h, mainCol )
    end

    local function distancefunction( x1, y1, x2, y2 )
        local dx = x1 - x2
        local dy = y1 - y2
        return math.sqrt ( dx * dx + dy * dy )
    end

    surface.CreateFont( "Nicknamefont", {
        font = "Arial", 
        extended = false,
        size = 13,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    })
    surface.CreateFont( "RadarFont", {
        font = "Arial", 
        extended = false,
        size = 20,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    })

end)