ply = LocalPlayer()
radar_r = 1000
Col = Color(194, 194, 194)
debugmode = false

n = 0
n2 = 0

hook.Add("HUDPaint", "Radar", function()
    surface.SetDrawColor( 0, 0, 0, 200)
    draw.NoTexture()
    draw.RoundedBox(3, 10, 10, 220,220,Color(69, 68, 68))
    draw.RoundedBox(0, 20, 20, 200, 200, Color(87, 87, 87, 200))
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
                draw.SimpleText(v:Nick(), "Nicknamefont", 130 + xradar / coe , 110 + yradar / coe, Color(255,255,255))
            end
            if (v:IsPlayer() or v:IsNPC()) then
                
                draw.RoundedBox(0, 130 + xradar /coe, 123 + yradar / coe, 30, 5, Color(69, 68, 68))
                draw.RoundedBox(0, 130 + xradar / coe, 123 + yradar / coe, v:Health() / v:GetMaxHealth() * 30, 5, Color(255, 0, 0))
                
            end

            if debugmode then
                if (v:GetPos() - ply:GetPos()):Length2D() > 70 then

                    draw.SimpleText(v:GetClass(), "Nicknamefont", 130 + xradar /coe , 110 + yradar / coe, Color(255,255,255))
                end
            end

            draw.RoundedBox(6,( 120 + xradar / coe ), ( 120 + yradar / coe) , (5 * 1000 / radar_r ), (5 * 1000 / radar_r), Col)
        end
    end
    draw.RoundedBox(40, 50, 10, 150, 25,  Color(69, 68, 68))
    draw.SimpleText("Radar", "RadarFont", 100, 15, Color(255,255,255))
end)

local button1 = vgui.Create("DButton")
button1:SetPos(240, 15)
button1:SetSize(20, 20)
button1:SetTextColor(Color(255,255,255))
button1:SetText("+")

local button2 = vgui.Create("DButton")
button2:SetPos(240, 40)
button2:SetSize(20, 20)
button2:SetTextColor(Color(255,255,255))
button2:SetText("-")

function button1:DoClick()
    radar_r = radar_r - 100
    if radar_r <= 500 then radar_r = 500 end
end

function button2:DoClick()
    radar_r = radar_r + 100
    if radar_r >= 1500 then radar_r = 1500 end
end


function button1:Paint(w,h)
    draw.RoundedBox( 3, 0, 0, w, h, Color(69, 68, 68) )
end
function button2:Paint(w,h)
    draw.RoundedBox( 3, 0, 0, w, h, Color(69, 68, 68) )
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