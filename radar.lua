ply = LocalPlayer()
radar_r = tonumber(ply:GetPData("radar_r", 1000))
debugmode = ply:GetPData("debugmode", false)
minr = ply:GetPData("minr", 500)
maxr = ply:GetPData("minr", 1500)

n = 0
n2 = 0

Col = Color(ply:GetPData("EntColR",194),ply:GetPData("EntColG",194),ply:GetPData("EntColB",194),ply:GetPData("EntColA",255))
mainCol = Color(ply:GetPData("MainColorR",69),ply:GetPData("MainColorG",68),ply:GetPData("MainColorB",68),ply:GetPData("MainColorA",255))
secCol = Color(ply:GetPData("SecColR",87),ply:GetPData("SecColG",87),ply:GetPData("SecColB",87),ply:GetPData("SecColA",200))
textCol = Color(ply:GetPData("TextColR",255),ply:GetPData("TextColG",255),ply:GetPData("TextColB",255),ply:GetPData("TextColA",255))

minr = 500
maxr = 1500

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
        if (math.abs(ply:GetPos().x - v:GetPos().x) < radar_r and math.abs(ply:GetPos().y - v:GetPos().y) < radar_r ) then
            xradar = v:GetPos().x - ply:GetPos().x
            yradar = v:GetPos().y - ply:GetPos().y

            coe = (radar_r / 100)
            coe2 = (radar_r / 1000)

            if v:IsPlayer() then
                draw.SimpleText(v:Nick(), "Nicknamefont", 130 + xradar / coe , 110 + yradar / coe, textCol)
            end
            if (v:IsPlayer() or v:IsNPC()) then
                
                draw.RoundedBox(0, 130 + xradar /coe, 123 + yradar / coe, 30, 5, mainCol)
                draw.RoundedBox(0, 130 + xradar / coe, 123 + yradar / coe, v:Health() / v:GetMaxHealth() * 30, 5, Color(255, 0, 0))
                
            end

            if debugmode then
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

frame = vgui.Create("DFrame")
frame:SetSize(0, 0)

frame2 = vgui.Create("DFrame", frame)
frame2:SetSize(0,0)
frame2:SetDraggable(false)

GearButton2 = vgui.Create("DButton", frame)
GearButton2:SetPos(5,25)
GearButton2:SetSize(50,50)
GearButton2:SetText("")

GearButton3 = vgui.Create("DButton", frame)
GearButton3:SetPos(5,80)
GearButton3:SetSize(50,50)
GearButton3:SetText("")

frame1close = vgui.Create("DButton", frame)
frame1close:SetPos(454, 5)
frame1close:SetSize(50,15)
frame1close:SetTextColor(textCol)
frame1close:SetText("X")

frame2Colorpicker = vgui.Create('DColorMixer', frame2)
frame2Colorpicker:SetPos(0,0)

frame2Colorpickertitle = vgui.Create("DLabel",frame2)
frame2Colorpickertitle:SetText("Entity/Player Color Picker")

frame2ColorpickerButton = vgui.Create("DButton",frame2)
frame2ColorpickerButton:SetText("Slect and confirm")

frame3 = vgui.Create("DFrame", frame)
frame3:SetSize(0,0)
frame3:SetDraggable(false)

frame2Colorpickermaincolor = vgui.Create('DColorMixer', frame2)

frame2Colorpickermaincolortitle = vgui.Create("DLabel", frame2)
frame2Colorpickermaincolortitle:SetText("Main Color Color Picker")

frame2ColorpickermaincolorButton = vgui.Create("DButton",frame2)
frame2ColorpickermaincolorButton:SetText("Slect and confirm")


frame2Colorpickersecondarycolor = vgui.Create('DColorMixer', frame2)

frame2Colorpickersecondarycolortitle = vgui.Create("DLabel", frame2)
frame2Colorpickersecondarycolortitle:SetText("Secondary Color Color Picker")

frame2ColorpickersecondarycolorButton = vgui.Create("DButton",frame2)
frame2ColorpickersecondarycolorButton:SetText("Slect and confirm")


frame2ColorpickerTextColor = vgui.Create('DColorMixer', frame2)

frame2ColorpickerTextColorTitle = vgui.Create("DLabel", frame2)
frame2ColorpickerTextColorTitle:SetText("Text Color Color Picker")

frame2ColorpickerTextColorButton = vgui.Create("DButton",frame2)
frame2ColorpickerTextColorButton:SetText("Slect and confirm")


frame3DebugTitle = vgui.Create("DLabel", frame3)
frame3DebugTitle:SetText("Debug mode ")

frame3DebugCheck = vgui.Create("DCheckBox", frame3)


frame3NmaxTitle = vgui.Create("DLabel", frame3)
frame3NmaxTitle:SetText("Maximum zoom in value")
frame3NmaxTitle:SetSize(0,0)

frame3NmaxSlider = vgui.Create("DNumSlider",frame3)
frame3NmaxSlider:SetSize(0,0)
frame3NmaxSlider:SetMinMax(minr/1000, 2)
frame3NmaxSlider:SetDefaultValue(maxr/1000)
frame3NmaxSlider:ResetToDefaultValue()

frame3NminTitle = vgui.Create("DLabel", frame3)
frame3NminTitle:SetText("Maximum zoom out value")
frame3NminTitle:SetSize(0,0)

frame3NminSlider = vgui.Create("DNumSlider",frame3)
frame3NminSlider:SetSize(0,0)
frame3NminSlider:SetMinMax(0.1,maxr/1000)
frame3NminSlider:SetDefaultValue(minr/1000)
frame3NminSlider:ResetToDefaultValue()


frame3ZoomInTitle = vgui.Create("DLabel", frame3)
frame3ZoomInTitle:SetText("Zoom in/out value")
frame3ZoomInTitle:SetSize(0,0)


frame3ZoomInSlider = vgui.Create("DNumSlider",frame3)
frame3ZoomInSlider:SetMinMax(minr/1000, maxr/1000)
frame3ZoomInSlider:SetDefaultValue(radar_r/1000)
frame3ZoomInSlider:ResetToDefaultValue()


frame3Button = vgui.Create("DButton", frame3)

frame3Reset = vgui.Create("DButton", frame3)

img_code = vgui.Create("DImage", frame)
img_code:SetSize(0, 0)
img_code:SetImage("code.png")

img_paint = vgui.Create("DImage", frame)
img_paint:SetSize(0, 0)
img_paint:SetImage("paint.png")

frametemp = vgui.Create("DFrame", frame)
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

        gearbutton2active = true

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
            ply:SetPData("EntColR", Col.r)
            ply:SetPData("EntColG", Col.g)
            ply:SetPData("EntColB", Col.b)
            ply:SetPData("EntColA", Col.a)
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
            ply:SetPData("MainColorR", mainCol.r)
            ply:SetPData("MainColorG", mainCol.g)
            ply:SetPData("MainColorB", mainCol.b)
            ply:SetPData("MainColorA", mainCol.a)
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
            ply:SetPData("SecColR", secCol.r)
            ply:SetPData("SecColG", secCol.g)
            ply:SetPData("SecColB", secCol.b)
            ply:SetPData("SecColA", secCol.a)
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
            ply:SetPData("TextColR", textCol.r)
            ply:SetPData("TextColG", textCol.g)
            ply:SetPData("TextColB", textCol.b)
            ply:SetPData("TextColA", textCol.a)
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

            radar_r = frame3ZoomInSlider:GetValue() * 1000
            ply:SetPData("radar_r", radar_r)
            
            if frame3DebugCheck:GetChecked() then
                debugmode = true   
                ply:SetPData("debugmode", debugmode)
            else 
                debugmode = false 
                ply:SetPData("debugmode", debugmode)       
            end
            minr = frame3NminSlider:GetValue() * 1000
            ply:SetPData("minr", minr)
            maxr = frame3NmaxSlider:GetValue() * 1000
            ply:SetPData("maxr", maxr)

        end
        function frame3Reset:DoClick()

            radar_r = 1000
                ply:SetPData("radar_r", radar_r)

            debugmode = false
                ply:SetPData("debugmode", debugmode)

            minr = 500
                ply:SetPData("minr", minr)

            maxr = 1500
                ply:SetPData("maxr", maxr)

            Col = Color(196,194,194,255)
                ply:SetPData("EntColR", Col.r)
                ply:SetPData("EntColG", Col.g)
                ply:SetPData("EntColB", Col.b)
                ply:SetPData("EntColA", Col.a)

            mainCol = Color(69,68,68,255)
                ply:SetPData("MainColorR", mainCol.r)
                ply:SetPData("MainColorG", mainCol.g)
                ply:SetPData("MainColorB", mainCol.b)
                ply:SetPData("MainColorA", mainCol.a)

            secCol = Color(87, 87, 87, 200)
                ply:SetPData("SecColR", secCol.r)
                ply:SetPData("SecColG", secCol.g)
                ply:SetPData("SecColB", secCol.b)
                ply:SetPData("SecColA", secCol.a)

            textCol = Color(255,255,255,255)
                ply:SetPData("TextColR", textCol.r)
                ply:SetPData("TextColG", textCol.g)
                ply:SetPData("TextColB", textCol.b)
                ply:SetPData("TextColA", textCol.a)
            
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

function distancefunction ( x1, y1, x2, y2 )
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