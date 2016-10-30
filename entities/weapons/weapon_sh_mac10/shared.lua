if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	SWEP.DrawAmmo			= true
	
	SWEP.IconLetter 		= "d"

	killicon.AddFont("weapon_sh_MAC10", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "MAC-10"
SWEP.HoldType				= "pistol"
SWEP.PrintName				= "MAC-10"
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Slot					= 0
SWEP.Base					= "weapon_sh_base"
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_mac10.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_mac10.mdl"
SWEP.ViewModelFOV			= 50
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_mac10"
SWEP.Primary.Sound			= Sound("csgo/mac10/mac10-1.wav")
SWEP.Primary.Recoil			= 0.2
SWEP.Primary.Damage			= 8
SWEP.Primary.Cone			= 0.01
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.075
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.IronSightsPos 			= Vector(-6.14, -12.061, 2.18)
SWEP.IronSightsAng 			= Vector(-0.348, 0.14, -0.968)
SWEP.ShouldZoom				= false
SWEP.ZoomFOV				= 35
SWEP.ZoomFOVScale			= 0.56
SWEP.WMOffsetPos			= { up = -3.75, right = 0.8, forward = 5 }
SWEP.WMOffsetAng			= { up = 3, right = 86, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.mac10_Parent", 
		pos 				= Vector(0, -2.75, 5), 
		angle 				= Angle(-90, 2, 0), 
		size 				= 0.75, 
		color 				= Color(255, 255, 255, 255),
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}