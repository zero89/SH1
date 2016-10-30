if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "pistol"
elseif (CLIENT) then
	
	SWEP.IconLetter 	= "a"
	SWEP.CSMuzzleFlashes	= false
	SWEP.ViewModelFOV		= 60
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_tec9", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "Tec-9"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_tec9.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_tec9.mdl"
SWEP.Primary.Sound 			= Sound("csgo/tec9/tec9-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.7
SWEP.Primary.Cone 			= 0.010
SWEP.Primary.Damage 		= 9
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 24
SWEP.Primary.Delay 			= 0.1
SWEP.Primary.DefaultClip 	= 24
SWEP.RKick					= 2
SWEP.RRise					= 5
SWEP.RSlide					= -0.015
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "pistol"
SWEP.IronSightsPos 			= Vector(-5.08, 0, 2.759)
SWEP.IronSightsAng 			= Vector(-0.494, 0.142, 0)
SWEP.DistantSound			= nil
SWEP.Subsonic				= true
SWEP.DotVis					= -1
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_tec9"
SWEP.WMOffsetPos			= { up = -2, right = 0.8, forward = 4.5 }
SWEP.WMOffsetAng			= { up = 3, right = 90, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model",  
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.tec9_parent", 
		pos 				= Vector(0, -3.4, 11.5), 
		angle 				= Angle(-90,0,0), 
		size 				= 0.7, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}

