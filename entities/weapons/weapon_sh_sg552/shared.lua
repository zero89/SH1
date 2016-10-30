if SERVER then
	AddCSLuaFile("shared.lua")
elseif CLIENT then
	
	SWEP.ViewModelFOV		= 60
	SWEP.IconLetter 		= "A"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_sg552", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "SG 553"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_sg556.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_sg556.mdl"
SWEP.Primary.Sound 			= Sound("csgo/sg556/sg556-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 9
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Recoil			= 0.4
SWEP.Primary.Cone 			= 0.005
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Delay 			= 0.100
SWEP.Primary.DefaultClip 	= 30
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "ar2"
SWEP.DistantSound			= "sg552.mp3"
SWEP.RSlide					= 0.0010
SWEP.RRise					= 0.001
SWEP.IronSightsPos 			= Vector(-5.10, -9.594, -3)
SWEP.IronSightsAng 			= Vector(-1.829, 0.065, 0)
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_sg553"
SWEP.RedDotSight			= false
SWEP.WMOffsetPos			= { up = -4, right = 0.9, forward = 9 }
SWEP.WMOffsetAng			= { up = 5, right = 83, forward = 178 }
SWEP.UseScope				= true
SWEP.BuiltInScope			= true
SWEP.Use3DScope				= false
SWEP.RTMaterialOverride		= 1
SWEP.RTOpaque				= true
SWEP.ScopeOverlayTransforms = { 0, 0 }
SWEP.ScopeReticule_Scale 	= {1, 1}
SWEP.ScopeAngleTransforms	= 
{
	{"P", 89.3},
	{"Y", 0.15}
}
SWEP.ScopeOverlayTransformMultiplier = 0.8
SWEP.StatTrak				= true

local cd = {}

function SWEP:RTCode()

	if !self.myshadowmask then self.myshadowmask = Material(self.ScopeShadow and self.ScopeShadow or "vgui/scope_shadowmask") end
	if !self.myreticule then self.myreticule = Material(self.ScopeReticule and self.ScopeReticule or "scope/gdcw_scopesightonly") end
	if !self.mydirt then self.mydirt = Material(self.ScopeDirt and self.ScopeDirt or "vgui/scope_dirt") end

	local vm = self.Owner:GetViewModel()
	
	if !self.LastOwnerPos then self.LastOwnerPos = self.Owner:GetShootPos() end
	
	local owoff = self.Owner:GetShootPos() - self.LastOwnerPos
	
	self.LastOwnerPos = self.Owner:GetShootPos()
	
	
	local att = vm:GetAttachment(3)
	if !att then return end
	
	local pos = att.Pos - owoff
	
	local scrpos = pos:ToScreen()
	
	scrpos.x = scrpos.x - ScrW() /2 + self.ScopeOverlayTransforms[1]
	scrpos.y = scrpos.y - ScrH() /2 + self.ScopeOverlayTransforms[2]
	
	--scrpos.x = scrpos.x * ( 2 - self.CLIronSightsProgress*1 )
	--scrpos.y = scrpos.y * ( 2 - self.CLIronSightsProgress*1 )
	
	scrpos.x = scrpos.x * self.ScopeOverlayTransformMultiplier
	scrpos.y = scrpos.y * self.ScopeOverlayTransformMultiplier
	
	if !self.scrpos then self.scrpos = scrpos end
	
	self.scrpos.x = math.Approach( self.scrpos.x, scrpos.x, (scrpos.x-self.scrpos.x)*FrameTime()*10 )
	self.scrpos.y = math.Approach( self.scrpos.y, scrpos.y, (scrpos.y-self.scrpos.y)*FrameTime()*10 )
	
	scrpos = self.scrpos
	
	render.OverrideAlphaWriteEnable( true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-512,-512,1024,1024)
	render.OverrideAlphaWriteEnable( true, true)
	
	local ang = EyeAngles()
	
	local AngPos = self.Owner:GetViewModel():GetAttachment(3)
	
	if AngPos then
	
		ang = AngPos.Ang
		for k,v in pairs(self.ScopeAngleTransforms) do
			if v[1] == "P" then
				ang:RotateAroundAxis(ang:Right(),v[2])				
			elseif v[1] == "Y" then
				ang:RotateAroundAxis(ang:Up(),v[2])			
			elseif v[1] == "R" then
				ang:RotateAroundAxis(ang:Forward(),v[2])		
			end
		end
	end
	
	cd.angles = ang
	cd.origin = self.Owner:GetShootPos()
	
	if !self.RTScopeOffset then self.RTScopeOffset = {0,0} end
	if !self.RTScopeScale then self.RTScopeScale = {1,1} end
	
	local rtow,rtoh = self.RTScopeOffset[1], self.RTScopeOffset[2]
	local rtw,rth = 512 * self.RTScopeScale[1], 512 * self.RTScopeScale[2]
	
	cd.x = 0
	cd.y = 0
	cd.w = rtw
	cd.h = rth
	cd.fov = 20
	cd.drawviewmodel = false
	cd.drawhud = false
	
	render.Clear( 0, 0, 0, 255, true, true )
	
	render.SetScissorRect(0+rtow,0+rtoh,rtw+rtow,rth+rtoh,true)
	//if self.CLIronSightsProgress>0.01 and self.Scoped_3D then
		render.RenderView(cd)
	//end
	render.SetScissorRect(0,0,rtw,rth,false)
	
	render.OverrideAlphaWriteEnable( false, true)	
	
	cam.Start2D()
		draw.NoTexture()
		surface.SetMaterial(self.myshadowmask)
		surface.SetDrawColor(color_white)
		//if self:Do3DScopeOverlay() then
			surface.DrawTexturedRect(scrpos.x+rtow,scrpos.y+rtoh,rtw,rth)
		//end
		surface.SetMaterial(self.myreticule)
		local tmpborderw = rtw*(1-self.ScopeReticule_Scale[1])/2
		local tmpborderh = rth*(1-self.ScopeReticule_Scale[2])/2
		surface.DrawTexturedRect(rtow+tmpborderw,rtoh+tmpborderh,rtw-tmpborderw*2,rth-tmpborderh*2)		
		surface.SetDrawColor(color_black)
		draw.NoTexture()
		//surface.DrawRect(scrpos.x-2048+rtow, -1024+rtoh, 2048, 2048)
		//surface.DrawRect(scrpos.x+rtw+rtow, -1024+rtoh, 2048, 2048)
		//surface.DrawRect(-1024+rtow, scrpos.y-2048+rtoh, 2048, 2048)
		//surface.DrawRect(-1024+rtow, scrpos.y+rth+rtoh, 2048, 2048)
		//surface.SetDrawColor(ColorAlpha(color_black,255-255*( math.Clamp( 0.1-0.75,0,0.25 )*4 ) ) )
		/*surface.DrawRect(-1024+rtow, -1024+rtoh,2048,2048)
		surface.SetMaterial(self.mydirt)
		surface.SetDrawColor(ColorAlpha(color_white,128))
		surface.DrawTexturedRect(0,0,rtw,rth)
		surface.SetDrawColor(ColorAlpha(color_white,64))
		surface.DrawTexturedRectUV(rtow,rtoh,rtw,rth,2,0,0,2)*/
	cam.End2D()

end

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl", 
		bone 				= "v_weapon.sg556_Parent", 
		pos 				= Vector(0,-7,0), 
		angle 				= Angle(0,0,0), 
		size 				= 0.85, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	},
}