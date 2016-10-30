--[[-------------------------------------------------------

Fight to Survive: Stronghold by RoaringCow, TehBigA is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License. 
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, 
444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

---------------------------------------------------------]]

--[[ Locals ]]--

local TEX_GRADIENT_TOP 			= surface.GetTextureID( "vgui/gradient-u" )
local TEX_GRADIENT_BOTTOM 		= surface.GetTextureID( "vgui/gradient-d" )
local TEX_GRADIENT_RIGHT 		= surface.GetTextureID( "vgui/gradient-r" )
local TEX_GRADIENT_LEFT 		= surface.GetTextureID( "vgui/gradient-l" )
local TEX_GRADIENT_BOTTOMLEFT 	= surface.GetTextureID( "vgui/gradient-bl" )
local TEX_GRADIENT_BOTTOMRIGHT 	= surface.GetTextureID( "vgui/gradient-br" )

local TEX_HUDICONS 					= {}
TEX_HUDICONS["health2"] 			= surface.GetTextureID( "hudicons/health2" )
TEX_HUDICONS["shield"] 				= surface.GetTextureID( "hudicons/shield" )
TEX_HUDICONS["weapon_sh_c4"] 		= surface.GetTextureID( "hudicons/c4" )
TEX_HUDICONS["weapon_sh_flash"] 	= surface.GetTextureID( "hudicons/fnade" )
TEX_HUDICONS["weapon_sh_grenade"] 	= surface.GetTextureID( "hudicons/henade" )
TEX_HUDICONS["weapon_sh_smoke"] 	= surface.GetTextureID( "hudicons/snade" )

local TEX_STANCE_AIMING 			= surface.GetTextureID( "stance/aiming" )
local TEX_STANCE_AIMING_CROUCHED 	= surface.GetTextureID( "stance/aiming_crouched" )
local TEX_STANCE_RELAXED 			= surface.GetTextureID( "stance/relaxed" )
local TEX_STANCE_RELAXED_CROUCHED 	= surface.GetTextureID( "stance/relaxed_crouched" )

local TEX_FIREMODE_AUTO 			= surface.GetTextureID( "firemode/automatic" )
local TEX_FIREMODE_SEMIAUTO 		= surface.GetTextureID( "firemode/semiautomatic" )

-- --------------------------------------------------------------------------------------------------------------
--[[ Helper Functions ]]--

local function ColorBlend( scale, c1, c2 )
	scale = math.Clamp( scale, 0, 1 )
	local scale2 = -(scale-1)
	
	return Color( 
		math.Clamp( math.floor(c1.r*scale2+c2.r*scale), 0, 255 ),
		math.Clamp( math.floor(c1.g*scale2+c2.g*scale), 0, 255 ),
		math.Clamp( math.floor(c1.b*scale2+c2.b*scale), 0, 255 ),
		math.Clamp( math.floor(c1.a*scale2+c2.a*scale), 0, 255 )
	)
end

local function DrawBar( x, y, w, h, scale, right, color, col_scale )
	local bx, by 	= x+1, y+1
	local bh, bw 	= h-2, math.Round( (w-2) * scale )
	local bw_extra 	= math.Round( (w-2) - bw )

	surface.SetDrawColor( 0, 0, 0, 100 )
	surface.DrawRect( x, y, w, h )
	
	surface.SetDrawColor( color.r*col_scale, color.g*col_scale, color.b*col_scale, 120 )
	surface.DrawRect( (right and bx+bw_extra or bx), by, bw, bh )
	
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.SetTexture( TEX_GRADIENT_BOTTOM )
	surface.DrawTexturedRect( (right and bx+bw_extra or bx), by+bh*0.35, bw, bh*0.65 )
	
	surface.SetDrawColor( 255, 255, 255, 2 )
	surface.SetTexture( TEX_GRADIENT_TOP )
	surface.DrawTexturedRect( (right and bx+bw_extra or bx), by, bw, bh*0.65 )
end

-- --------------------------------------------------------------------------------------------------------------
--[[ Normal HUD ]]--

GM.Huds = GM.Huds or {}
GM.Huds.Normal = {}

function GM.Huds.Normal:Paint( GAMEMODE )
	self:DrawHintBar( GAMEMODE )
	self:DrawGBux( GAMEMODE )
	self:DrawHealthAmmo( GAMEMODE )
end

function GM.Huds.Normal:DrawHintBar( GAMEMODE )
	local w, h 			= ScrW(), 20
	local scale 		= math.Clamp( (CurTime() - GAMEMODE.HintBar.LastChange) / GAMEMODE.HintBar.FadeTime, 0, 1 )
	local scale_flash 	= math.Clamp( (CurTime() - GAMEMODE.HintBar.LastChange) / 0.80, 0, 1 )
	local scale_flash_r = (-scale_flash+1)
	local lscale 		= -scale+1

	surface.SetDrawColor( 20, 20, 20, 120 )
	surface.DrawRect( 0, 0, ScrW(), 20 )
	surface.SetDrawColor( 200, 200, 200, 120 )
	surface.DrawLine( 0, 20, ScrW(), 20 )
	surface.SetDrawColor( 0, 0, 0, 120 )
	surface.DrawLine( 0, 21, ScrW(), 21 )
	draw.RoundedBox( 4, 2, 2, w-4, 16, Color(scale_flash_r*255,scale_flash_r*255,scale_flash_r*255,200+55*scale_flash_r) )
	
	-- Ticker
	surface.SetFont( "gbux_default" ) -- This font looks nice, keep it BUT REMEMBER IF GBUX FILE DOESN'T LOAD THE FONT COULD BE MISSING!!!
	surface.SetTextColor( 255, 255, 255, 220 )
	surface.SetTextPos( 5, 4 )
	surface.DrawText( "STRONGHOLD - F1:Help | F2:Teams | F3:Loadout | F4:Options" )
	
	surface.SetFont( "Trebuchet19" )
	if scale > 0 then
		local c = GAMEMODE.CachedColors[GAMEMODE.HintBar.CurColor or 1] or GAMEMODE.CachedColors[1]
		local tw, _ = surface.GetTextSize( GAMEMODE.HintBar.CurMsg )
		if not tw then return end --!!!!!!

		surface.SetTextPos( w*0.50-tw*0.50, 1 )
		surface.SetTextColor( c.r, c.g, c.b, c.a*scale )
		surface.DrawText( GAMEMODE.HintBar.CurMsg )
	end

	if lscale > 0 then
		local c = GAMEMODE.CachedColors[GAMEMODE.HintBar.LastColor or 1] or GAMEMODE.CachedColors[1]
		local tw, _ = surface.GetTextSize( GAMEMODE.HintBar.LastMsg )
		if not tw then return end --!!!!!!

		surface.SetTextPos( w*0.50-tw*0.50, 1 )
		surface.SetTextColor( c.r, c.g, c.b, c.a*lscale )
		surface.DrawText( GAMEMODE.HintBar.LastMsg )
	end
	
	-- Timer
	if GAMEMODE.CountDownEnd != -1 and GAMEMODE.CountDownTitle != "" and GAMEMODE.CountDownEnd-CurTime() <= 600 then
		local timeleft = math.max( 0, GAMEMODE.CountDownEnd-CurTime() )
		local countdown = Format( "%02d.%02d", math.floor(timeleft/60), math.floor(timeleft%60) )
		
		surface.SetTextColor( 255, 255, 255, 220 )

		surface.SetFont( "gbux_defaultbold" )
		local tw, _ = surface.GetTextSize( countdown )
		if not tw then return end --!!!!!!

		surface.SetTextPos( w-tw-5, 4 )
		surface.DrawText( countdown )
		
		surface.SetFont( "Trebuchet19" )
		local tw2, _ = surface.GetTextSize( GAMEMODE.CountDownTitle.." - " )
		if not tw then return end --!!!!!!

		surface.SetTextPos( w-tw-tw2-8, 1 )
		surface.DrawText( GAMEMODE.CountDownTitle.." - " )
	end
end

function GM.Huds.Normal:DrawGBux()
	local x, y, w, h	= GAMEMODE.ConVars.GBux_Offset:GetInt(), 21, 150, 80
	local ply 			= LocalPlayer()

	-- Background
	surface.SetDrawColor( 20, 20, 20, 120 )
	surface.DrawRect( x, y, w, h )
	
	surface.SetDrawColor( 0, 0, 0, 120 )
	surface.DrawRect( x, y, 1, h-1 )
	surface.DrawRect( x, y+h-1, w, 1 )
	surface.DrawRect( x+w-1, y, 1, h-1 )
	
	surface.SetDrawColor( 200, 200, 200, 120 )
	surface.DrawRect( x+1, y, 1, h-2 )
	surface.DrawRect( x+1, y+h-2, w-2, 1 )
	surface.DrawRect( x+w-2, y, 1, h-2 )
	
	surface.SetDrawColor( 0, 0, 0, 120 )
	surface.SetTexture( TEX_GRADIENT_TOP )
	surface.DrawTexturedRect( x+1, y, w-2, h*0.50 )
	
	surface.SetFont( "gbux_bigbold" )
	surface.SetTextColor( 255, 255, 255, 220 )
	
	local tw, th = surface.GetTextSize( "GBux" )
	surface.SetTextPos( x+w*0.50-tw*0.50, y+3 )
	surface.DrawText( "GBux" )
	
	-- Lables
	surface.SetFont( "gbux_defaultbold" )
	
	surface.SetTextPos( x+8, y+22 )
	surface.DrawText( "Money:" )
	
	surface.SetTextPos( x+8, y+34 )
	surface.DrawText( "Multiplier:" )
	
	surface.SetTextPos( x+8, y+46 )
	surface.DrawText( "Kills:" )
	
	surface.SetTextPos( x+8, y+58 )
	surface.DrawText( "Deaths:" )
	
	-- Amounts
	surface.SetFont( "gbux_default" )
	
	local money = UTIL_PRound( ply:GetMoney(), 2 )
	surface.SetTextPos( x+74, y+22 )
	surface.DrawText( UTIL_FormatMoney(money) )
	
	surface.SetTextPos( x+80, y+34 )
	surface.DrawText( ply:GetMultiplier() )
	
	surface.SetTextPos( x+80, y+46 )
	surface.DrawText( ply:Frags() )
	
	surface.SetTextPos( x+80, y+58 )
	surface.DrawText( ply:Deaths() )
end

function GM.Huds.Normal:DrawHealthAmmo()
	local ply 		= LocalPlayer()
	
	local wep 		= ply:GetActiveWeapon()
	local doammo 	= (IsValid( wep ) and wep:Clip1() != -1 and wep.Primary.ClipSize != -1)

	local nadeclass = ply:GetLoadoutExplosive()
	local donade	= false

	for _, v in ipairs( ply:GetWeapons() ) do
		if v:GetClass() == nadeclass then
			donade = true
			break
		end
	end
	
	local sw, sh 	= ScrW(), ScrH()
	local w, h 		= 256, 72
	local h_actual 	= h*2
	local color 	= team.GetColor( ply:Team() )
	
	-- Draw the background
	surface.SetDrawColor( 0, 0, 0, 100 )
	surface.DrawRect( 0, ScrH()-h, w, h )
	
	surface.SetDrawColor( color.r*0.50, color.g*0.50, color.b*0.50, 100 )
	surface.SetTexture( TEX_GRADIENT_BOTTOMLEFT )
	surface.DrawTexturedRect( 0, ScrH()-h, w, h_actual )
	
	surface.SetDrawColor( 200, 200, 200, 200 )
	surface.SetTexture( TEX_GRADIENT_LEFT )
	surface.DrawTexturedRect( 0, ScrH()-h+1, w, 1 )
	surface.SetTexture( TEX_GRADIENT_BOTTOM )
	surface.DrawTexturedRect( w-1, ScrH()-h+1, 1, h-1 )
	
	-- Left side
	if !ply.LastHurt or !ply.LastHeal then ply.LastHurt = 0 ply.LastHeal = 0 end
	local hp, ar, armax = math.max(ply:Health(),0), ply:GetCount( "props" ), GetConVarNumber("sbox_maxprops")
	local lasthurt 		= math.Clamp( (CurTime()-ply.LastHurt) / 0.60, 0, 1 )
	local lastheal 		= math.Clamp( (CurTime()-ply.LastHeal) / 0.30, 0, 1 )
	local hpcolor 		= (lasthurt < 1 and ColorBlend( lasthurt, Color(255,0,0,255), color )) or (lastheal < 1 and ColorBlend( lastheal, Color(0,255,0,255), color )) or color

	local x, y = 0, sh-h
	local bar = 27
	DrawBar( x+5, y+7, w-12, bar, (hp/100), false, hpcolor, 1 )
	DrawBar( x+5, y+bar+12, w-12, bar, -(ar/armax)+1, false, color, 0.60 )
	
	surface.SetTexture( TEX_GRADIENT_BOTTOM )
	for i = 1, armax do
		surface.SetDrawColor( 0, 0, 0, 120*(-i/armax+1) )
		--surface.DrawTexturedRect( x+5+((w-12)/armax)*i, y+38, 1, bar )
		surface.DrawTexturedRect( x+5+((w-12)/armax)*i, y+bar+12, 1, bar )
	end
	
	surface.SetFont( "Trebuchet19" )
	surface.SetTextColor( 255, 255, 255, 255 )
	
	local tw, th = surface.GetTextSize( hp )
	if not tw then return end --!!!!!!

	local hp_x, hp_y = w-18-tw, y+7+bar*0.50-th*0.50
	surface.SetTextPos( hp_x, hp_y )
	surface.DrawText( hp )
	
	local tw, th = surface.GetTextSize( armax-ar )
	local ar_x, ar_y = w-18-tw, y+39+bar*0.50-th*0.50
	surface.SetTextPos( ar_x, ar_y )
	surface.DrawText( armax-ar )
	
	-- Voice Channel
	surface.SetTexture( TEX_GRADIENT_LEFT )
	surface.SetDrawColor( 0, 0, 0, 100 )
	surface.DrawTexturedRect( 0, ScrH()-h-20, 150, 20 )
	surface.SetDrawColor( 200, 200, 200, 200 )
	surface.DrawTexturedRect( 0, ScrH()-h-19, 150, 1 )
	
	local tw, th = surface.GetTextSize( "Voice Channel: " )
	surface.SetTextPos( 5, ScrH()-h-9-th*0.50 )
	surface.DrawText( "Voice Channel: " )
	
	local voicechannel = GAMEMODE.ConVars.VoiceChannel:GetInt()
	surface.SetTextColor( voicechannel == 1 and color or Color(250,250,0,255) )
	surface.DrawText( voicechannel == 0 and "Public" or "Team" )
	
	surface.SetTextColor( 255, 255, 255, 255 )
	
	-- Right side
	if doammo or donade then
		local firemode_extend = 0
		if doammo and IsValid( wep ) and wep.FireSelect == 1 then firemode_extend = 37 end
		
		local h = math.max( (doammo and 36 or 0) + (donade and 36 or 0), 39 )
		
		surface.SetDrawColor( 0, 0, 0, 100 )
		surface.DrawRect( ScrW()-w-firemode_extend, ScrH()-h, w+firemode_extend, h )
		
		surface.SetDrawColor( color.r*0.50, color.g*0.50, color.b*0.50, 100 )
		surface.SetTexture( TEX_GRADIENT_BOTTOMRIGHT )
		surface.DrawTexturedRect( ScrW()-w-firemode_extend, ScrH()-h, w+firemode_extend, h_actual )
		
		surface.SetDrawColor( 200, 200, 200, 200 )
		surface.SetTexture( TEX_GRADIENT_RIGHT )
		surface.DrawTexturedRect( ScrW()-w-firemode_extend, ScrH()-h+1, w+firemode_extend, 1 )
		surface.SetTexture( TEX_GRADIENT_BOTTOM )
		surface.DrawTexturedRect( ScrW()-w+1-firemode_extend, ScrH()-h+1, 1, h-1 )
	end
	
	local x, y = sw-w, sh-h
	local bar = 27
	
	if donade and TEX_HUDICONS[nadeclass] then
		surface.SetTexture( TEX_HUDICONS[nadeclass] )
		surface.SetDrawColor( 255, 255, 255, 255 )
		for i = 1, (nadeclass == "weapon_sh_c4" and 1 or ply:GetAmmoCount( "grenade" )) do
			surface.DrawTexturedRect( sw-20*i-14, sh-34-(doammo and 32 or 0), 32, 32 )
		end
	end
	
	if doammo then
		local ammoflash = math.sin( RealTime() * 10 )
		local ammo 		= (wep:Clip1()/wep.Primary.ClipSize)
		local ammodelta = (w-12) / wep.Primary.ClipSize
		local ammocolor = (ammo < 0.25 and ColorBlend( ammoflash, Color(255,0,0,255), Color(150,150,150,100) )) or Color(150,150,150,100)
		DrawBar( x+7, y+40, w-12, bar, ammo, true, ammocolor, 1 )
		
		if ammodelta > 2 then
			surface.SetTexture( TEX_GRADIENT_BOTTOM )
			for i = 1, wep.Primary.ClipSize do
				surface.SetDrawColor( 0, 0, 0, 120*(-i/wep.Primary.ClipSize+1) )
				surface.DrawTexturedRect( x+w-6-ammodelta*i, y+40, 1, bar )
			end
		end
		
		if ammo == 0 then
			surface.SetDrawColor( 255, 50, 50, 255*((ammoflash+1)*0.50) )
			surface.DrawLine( x+7, y+40, x+w-5, y+40 )
			surface.DrawLine( x+w-5, y+40, x+w-5, y+bar+40 )
			surface.DrawLine( x+7, y+bar+40, x+w-5, y+bar+40 )
			surface.DrawLine( x+7, y+40, x+7, y+bar+40 )
		end
		
		local str 			= "x "..math.ceil( ply:GetAmmoCount(wep:GetPrimaryAmmoType()) / wep.Primary.ClipSize )
		local tw, th 		= surface.GetTextSize( str )
		local mag_x, mag_y 	= sw-15-tw, y+39+bar*0.50-th*0.50

		surface.SetFont( "Trebuchet19" )
		surface.SetTextColor( 255, 255, 255, 255 )
		surface.SetTextPos( mag_x, mag_y )
		surface.DrawText( str )
		
		if IsValid( wep ) and wep.FireSelect == 1 then
			surface.SetDrawColor( 0, 0, 0, 100 )
			surface.DrawRect( x-27, y+40, 27, 27 )
			
			if wep.Primary.Automatic then
				surface.SetDrawColor( 0, 0, 0, 200 )
				surface.DrawRect( x-27+12, y+48, 5, 5 )
				surface.DrawRect( x-27+8, y+55, 5, 5 )
				surface.DrawRect( x-27+16, y+55, 5, 5 )
				
				surface.SetDrawColor( 255, 255, 255, 200 )
				surface.DrawRect( x-27+13, y+49, 3, 3 )
				surface.DrawRect( x-27+9, y+56, 3, 3 )
				surface.DrawRect( x-27+17, y+56, 3, 3 )
			else
				surface.SetDrawColor( 0, 0, 0, 200 )
				surface.DrawRect( x-27+12, y+52, 5, 5 )
				
				surface.SetDrawColor( 255, 255, 255, 200 )
				surface.DrawRect( x-27+13, y+53, 3, 3 )
			end
		end
	end
end