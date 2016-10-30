--[[-------------------------------------------------------

Fight to Survive: Stronghold by RoaringCow, TehBigA is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License. 
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, 
444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

---------------------------------------------------------]]

--[[
	GM13 Changes
	
	Added:
		hook sh_hitdetection(nil)
	Removed:
	Updated:
		net code
		surface.CreateFont now uses font data
	Changed:
		cleaned code
]]--

local font_data = {
	["gbux_bigbold"] = {
		font 	= "DermaDefault",
		size 	= 14,
		weight 	= 700
	},
	["gbux_defaultbold"] = {
		font 	= "DermaDefault",
		size 	= 12,
		weight 	= 700
	},
	["gbux_default"] = {
		font 	= "DermaDefault",
		size 	= 12,
		weight 	= 500
	},
	["DeathCamera"] = {
		font 	= "coolvetica",
		size 	= 48,
		weight 	= 700
	},
}

surface.CreateFont( "gbux_bigbold", 	font_data.gbux_bigbold )
surface.CreateFont( "gbux_defaultbold", font_data.gbux_defaultbold )
surface.CreateFont( "gbux_default", 	font_data.gbux_default )
surface.CreateFont( "DeathCamera", font_data.DeathCamera )
surface.CreateFont( "Trebuchet19", {
	font = "Trebuchet MS",
	size = 19,
	weight = 700
} )

local TEX_GRADIENT_TOP		= surface.GetTextureID( "vgui/gradient-u" )
local TEX_GRADIENT_BOTTOM	= surface.GetTextureID( "vgui/gradient-d" )
local TEX_HITDETECTION		= surface.GetTextureID( "hitdetection2" )

-- Hint stuff
GM.HintBar				= {}
GM.HintBar.CurColor		= 1 -- Using a color index for cached colors above
GM.HintBar.CurMsg		= ""
GM.HintBar.LastColor	= 1 -- ^
GM.HintBar.LastMsg		= ""
GM.HintBar.LastChange	= 0
GM.HintBar.FadeTime		= 2.00

-- Cached colors
GM.CachedColors 	= {}
GM.CachedColors[1] 	= Color( 255, 255, 255, 255 ) -- White
GM.CachedColors[2] 	= Color( 127, 127, 127, 255 ) -- Grey
GM.CachedColors[3] 	= Color( 255,   0,   0, 255 ) -- Red
GM.CachedColors[4] 	= Color(   0, 255,   0, 255 ) -- Green
GM.CachedColors[5] 	= Color(   0,   0, 255, 255 ) -- Blue
GM.CachedColors[6] 	= Color( 255, 255,   0, 255 ) -- Yellow
GM.CachedColors[7] 	= Color( 255, 128,   0, 255 ) -- Orange
GM.CachedColors[8] 	= Color(   0, 128, 255, 255 ) -- Teal
GM.CachedColors[9] 	= Color(   0, 255, 255, 255 ) -- Aqua
GM.CachedColors[10]	= Color( 255,   0, 255, 255 ) -- Violet

-- Hit detection stuff
GM.HitDetection					= {}
GM.HitDetection.HitTime			= 0
GM.HitDetection.HitTimeDuration	= 0.10

-- --------------------------------------------------------------------------------------------------------------
--[[ Hide things we don't want ]]--

local BlockedHUDElements = { "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudDamageIndicator" }
function GM:HUDShouldDraw( element )
	return !table.HasValue( BlockedHUDElements, element )
end

function GM:HUDDrawTargetID() end

-- --------------------------------------------------------------------------------------------------------------
--[[ Things that always draw ]]--

function GM:HUDPaint()
	if self.GameOver then return end
	local x, y = 5, 100

	self.BaseClass:HUDPaint()
	
	if not IsValid( LocalPlayer() ) then return end

	local initstate = LocalPlayer():GetInitialized()
	if initstate == INITSTATE_OK then
		self:HUD_Ammo()
		self:HUD_Player()
		self:DrawHitIndicator()
		//self:DrawKillCam()
	end
	
	//draw.RoundedBox(0, ScrW() / 2 - 5 / 2, ScrH() / 2 - 5 / 1, 5, 5, Color(255, 0, 0))
	
	self.Map:PaintMarkers()
	self:GetVersion()
	self:Compass()
end

function GM:HUD_Player()

	local ply = LocalPlayer()

	if not self.PlayerHUD then
		self.PlayerHUD = vgui.Create("sh_playerhud")
	end
	
	if IsValid(self.PlayerHUD) then
	
		if not ply:Alive() then
			self.PlayerHUD:SetVisible(false)
		else
			self.PlayerHUD:SetVisible(true)
		end
	
	end

end

function GM:HUD_Ammo()

	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	local shouldDrawAmmo = (IsValid(wep) and wep:Clip1() != -1 and wep.Primary.ClipSize != -1)
	
	if(shouldDrawAmmo) then
	
		//Weapon HUD
		draw.RoundedBox(4, ScrW() - 210, ScrH() - 70, 200, 60, Color(43,49,54))
		//Seperation Line
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawLine(ScrW() - 110, ScrH() - 70, ScrW() - 110, ScrH() - 10)
		
		//Current Clip
		draw.SimpleText("Magazine", "Core_MainFont_15", ScrW() - 185, ScrH() - 30, Color(255, 255, 255, 100))
		
		clipText = math.Clamp(wep:Clip1(), 0, 9999)
		
		surface.SetFont("Core_MainFont_24")
		local tw, th = surface.GetTextSize(clipText)
		local clipPos = ScrW() - 320 / 2 - tw / 2
		
		draw.SimpleText(clipText, "Core_MainFont_24", clipPos, ScrH() - 60, Color(255, 255, 255))
		
		//Reserve
		draw.SimpleText("Reserve", "Core_MainFont_15", ScrW() - 79, ScrH() - 30, Color(255, 255, 255, 100))
		
		reserveText = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
		
		surface.SetFont("Core_MainFont_24")
		tw, th = surface.GetTextSize(reserveText)
		local resPos = ScrW() - 120 / 2 - tw / 2
		
		draw.SimpleText(reserveText, "Core_MainFont_24", resPos, ScrH() - 60, Color(255, 255, 255))
	
	end

end

function GM:Compass()
	if !GAMEMODE.ConVars.HUDCompass:GetBool() then return end
	local colComp = Color(
		self.ConVars.HUDComRed:GetFloat(), 
		self.ConVars.HUDComGreen:GetFloat(),
		self.ConVars.HUDComBlue:GetFloat(),
		255
	)
	local Speed = GAMEMODE.ConVars.HUDComSpeed:GetFloat()
	local TickDist = GAMEMODE.ConVars.HUDComTD:GetFloat()
	local Hight = GAMEMODE.ConVars.HUDComPosY:GetFloat()
	local Width = GAMEMODE.ConVars.HUDComPosX:GetFloat()
	local EyeAngle = LocalPlayer():EyeAngles().yaw*Speed
	local Alpha = 1-math.abs((EyeAngle)/180)
	local addline, addline2, encircle, longtick = 0,0,0,0
	local Degrees = math.Round(180-(EyeAngle/Speed))
	local Center = Degrees > 99 and 10 or Degrees > 9 and 6 or 3
	draw.SimpleText("^","DebugFixed",ScrW()*Width-3,ScrH()*(Hight),Color( colComp.r, colComp.g, colComp.b, 255 ))
	draw.SimpleText(Degrees,"DebugFixed",ScrW()*Width-Center,ScrH()*Hight+5,Color( colComp.r, colComp.g, colComp.b, 255 ))
	surface.SetDrawColor( colComp.r, colComp.g, colComp.b, 255 *Alpha )--255, 255, 255, 255*Alpha )
	draw.SimpleText("S","DebugFixed",(EyeAngle-4)+ScrW()*Width,ScrH()*(Hight-0.024),Color( colComp.r, colComp.g, colComp.b, 255*Alpha ))
	surface.DrawLine(EyeAngle+ScrW()*Width, ScrH()*Hight, EyeAngle+ScrW()*Width, ScrH()*(Hight-0.01))
	
	for i=1, 36*Speed do
		addline = math.Round(addline + 10/(Speed/TickDist))
		encircle = EyeAngle + addline*Speed
		Alpha = 1-math.abs((encircle)/(180))
		
		if addline == 90 or addline == 180 or addline == 270 then 
			longtick = 0.01
			if addline == 90 then 
				draw.SimpleText("E","DebugFixed",(EyeAngle-4)+ScrW()*Width+addline*Speed,ScrH()*(Hight-0.024),Color( colComp.r, colComp.g, colComp.b, 255*Alpha ))
			elseif addline == 180 then
				draw.SimpleText("N","DebugFixed",(EyeAngle-4)+ScrW()*Width+addline*Speed,ScrH()*(Hight-0.024),Color( colComp.r, colComp.g, colComp.b, 255*Alpha ))
			elseif addline == 270 then
				draw.SimpleText("W","DebugFixed",(EyeAngle-4)+ScrW()*Width+addline*Speed,ScrH()*(Hight-0.024),Color( colComp.r, colComp.g, colComp.b, 255*Alpha ))
			end
		else 
			longtick = 0.005 
		end
		
		surface.SetDrawColor( colComp.r, colComp.g, colComp.b, 255 *Alpha )--255, 255, 255, 255*Alpha )
		surface.DrawLine(EyeAngle+ScrW()*Width+addline*Speed, ScrH()*Hight, EyeAngle+ScrW()*Width+addline*Speed, ScrH()*(Hight-longtick))
	end

	for i=1, 36*Speed do
		addline2 = math.Round(addline2 - 10/(Speed/TickDist))
		encircle = EyeAngle + addline2*Speed
		Alpha = 1-math.abs((encircle)/(180))
		
		if addline2 == -90 or addline2 == -180 or addline2 == -270 then 
			longtick = 0.01
			if addline2 == -90 then 
				draw.SimpleText("W","DebugFixed",(EyeAngle-4)+ScrW()*Width+addline2*Speed,ScrH()*(Hight-0.024),Color( colComp.r, colComp.g, colComp.b, 255*Alpha ))
			elseif addline2 == -180 then
				draw.SimpleText("N","DebugFixed",(EyeAngle-4)+ScrW()*Width+addline2*Speed,ScrH()*(Hight-0.024),Color( colComp.r, colComp.g, colComp.b, 255*Alpha ))
			elseif addline2 == -270 then
				draw.SimpleText("E","DebugFixed",(EyeAngle-4)+ScrW()*Width+addline2*Speed,ScrH()*(Hight-0.024),Color( colComp.r, colComp.g, colComp.b, 255*Alpha ))
			end
		else 
			longtick = 0.005 
		end
		
		surface.SetDrawColor( colComp.r, colComp.g, colComp.b, 255 *Alpha )--255, 255, 255, 255*Alpha )
		surface.DrawLine(EyeAngle+ScrW()*Width+addline2*Speed, ScrH()*Hight, EyeAngle+ScrW()*Width+addline2*Speed, ScrH()*(Hight-longtick))
	end
end

local Fetched
local Recieved
function GM:GetVersion()

	

end
concommand.Add("sh_getversion", GM.GetVersion)

function GM:DrawWaitingInfo( state )
	local str
	if state == INITSTATE_WAITING then
		str = "Receiving information"
	else
		str = "Requesting information"
	end

	surface.SetFont( "DeathCamera" )
	local tw, th = surface.GetTextSize( str )
	if not tw then return end --!!!!!!
	
	local sw, sh = ScrW(), ScrH()
	local x, y, w, h = 0, math.floor(sh*0.50-th*0.50-10), sw, th+20
	surface.SetDrawColor( 0, 0, 0, 220 )
	surface.DrawRect( 0, 0, sw, sh )
	surface.DrawRect( x, y, w, h )
	surface.SetDrawColor( 200, 200, 200, 120 )
	surface.DrawRect( x, y+1, w, 1 )
	surface.DrawRect( x, y+h-2, w, 1 )
	
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( sw*0.50-tw*0.50, y+15 )
	surface.DrawText( str )
end

function GM:DrawHitIndicator()
	local delta = CurTime() - GAMEMODE.HitDetection.HitTime
	if delta > GAMEMODE.HitDetection.HitTimeDuration or not GAMEMODE.ConVars.HitIndicator:GetBool() then return end
	
	surface.SetTexture( TEX_HITDETECTION )
	surface.SetDrawColor(
		GAMEMODE.ConVars.HitRed:GetInt(),
		GAMEMODE.ConVars.HitGreen:GetInt(),
		GAMEMODE.ConVars.HitBlue:GetInt(),
		( (-delta/GAMEMODE.HitDetection.HitTimeDuration) + 1 ) * 255
	)
	surface.DrawTexturedRect(
		ScrW()*0.50-math.Clamp(16+(delta*300),16,32),
		ScrH()*0.50-math.Clamp(16+(delta*300),16,32),
		math.Clamp(32+(delta*600),32,64),
		math.Clamp(32+(delta*600),32,64)
	)
end

local SpawnDelay = 0
hook.Add( "sh_spawndelay", "cl_hud", function( bDelay )
	SpawnDelay = bDelay
end )

function GM:DrawKillCam()
	local killer = GAMEMODE.KillCam.Killer
	if !IsValid( killer ) then return end
	
	local sw, sh = ScrW(), ScrH()
	local RespawnTime = GAMEMODE.KillCam.LastKilled + SpawnDelay
	
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawRect( 0, sh*0.65-75, sw, 150 )
	if RespawnTime > CurTime() then
		local str = "Respawn in: "..math.floor(RespawnTime - CurTime() + 1).." Seconds"
		surface.SetFont( "DeathCamera" )
		local tw, th = surface.GetTextSize( str )
		surface.SetTextColor( 255, 50, 50, 255 )
		surface.SetTextPos( sw*0.50-tw*0.50, sh*0.61-th*0.50 )
		surface.DrawText( str )
	else
		local str = "Click or press Spacebar to spawn!"
		surface.SetFont( "DeathCamera" )
		local tw, th = surface.GetTextSize( str )
		surface.SetTextColor( 50, 255, 50, 255 )
		surface.SetTextPos( sw*0.50-tw*0.50, sh*0.61-th*0.50 )
		surface.DrawText( str )
	end
	
	local str = "You were killed by "..(killer.GetName and killer:GetName() or killer:GetClass()).."!"
	surface.SetFont( "DeathCamera" )
	local tw, th = surface.GetTextSize( str )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( sw*0.50-tw*0.50, sh*0.65-th*0.50 )
	surface.DrawText( str )
	
	local hp, hpmax = math.max(0,killer:Health()), (killer:IsPlayer() and 100 or killer:GetMaxHealth())
	local scale = math.Clamp( hp/ hpmax, 0, 1 )
	local x, y, w, h = math.floor(sw*0.50)-150, math.floor(sh*0.65)+30, 300, 30
	draw.RoundedBox( 4, x, y, w, h, Color(20,20,20,150) )
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawRect( x+5, y+5, w-10, h-10 )
	surface.SetDrawColor( 255*(-scale+1), 255*scale, 0, 200 )
	surface.DrawRect( x+5, y+5, (w-10)*scale, h-10 )
	
	surface.SetFont( "Trebuchet19" )
	
	local str = "HP:"
	local tw, th = surface.GetTextSize( str )
	local hp_x, hp_y = x+10, y+h*0.50-th*0.50
	surface.SetTextColor( 0, 0, 0, 255 )
	surface.SetTextPos( hp_x+1, hp_y+1 )
	surface.DrawText( str )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( hp_x, hp_y )
	surface.DrawText( str )
	
	local tw, th = surface.GetTextSize( hp )
	local hp_x, hp_y = math.max(x+5+(w-10)*scale-tw-5,x+35), y+h*0.50-th*0.50
	surface.SetTextColor( 0, 0, 0, 255 )
	surface.SetTextPos( hp_x+1, hp_y+1 )
	surface.DrawText( hp )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( hp_x, hp_y )
	surface.DrawText( hp )
end

local PlayerVoicePanels = nil
function GM:PlayerStartVoice( ply )
	if !IsValid( g_VoicePanelList ) then return end
	
	-- Damnit Garry...
	if PlayerVoicePanels == nil then
		_, PlayerVoicePanels = debug.getupvalue( self.BaseClass.PlayerStartVoice, 1 )
	end
	
	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )
	
	if IsValid( PlayerVoicePanels[ply] ) then
		if PlayerVoicePanels[ply].fadeAnim then
			PlayerVoicePanels[ ply].fadeAnim:Stop()
			PlayerVoicePanels[ply].fadeAnim = nil
		end
		
		PlayerVoicePanels[ ply ]:SetAlpha( 255 )
		
		return
	end
	
	if !IsValid( ply ) then return end
	
	local pnl = g_VoicePanelList:Add( "sh_voicenotify" )
	pnl:Setup( ply )
	
	PlayerVoicePanels[ply] = pnl
end