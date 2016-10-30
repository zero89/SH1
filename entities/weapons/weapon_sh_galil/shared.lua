if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "ar2"
elseif (CLIENT) then
	
	SWEP.IconLetter 		= "v"
	SWEP.ViewModelFlip	= false

	killicon.AddFont("weapon_sh_galil", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "GALIL AR"
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_galil.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_galil.mdl"
SWEP.Primary.Sound 			= Sound("csgo/galilar/galil-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.4
SWEP.Primary.Damage 		= 8
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.015
SWEP.Primary.ClipSize 		= 35
SWEP.Primary.Delay 			= 0.100
SWEP.Primary.DefaultClip 	= 35
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "ar2"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.RMod					= 1
SWEP.RRise					= 0.0
SWEP.IronSightsPos 			= Vector(-5.323, -11.457, 1.639)
SWEP.IronSightsAng 			= Vector(-0.1, 0, 0)
SWEP.DistantSound			= "galil.mp3"
SWEP.WeaponSkin				= "weapon_galil"
SWEP.UseHands				= true
SWEP.WMOffsetPos			= { up = -3.5, right = 0.8, forward = 6 }
SWEP.WMOffsetAng			= { up = 3, right = 84, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] =
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.galilar_parent", 
		pos 				= Vector(0, -3.3, 24), 
		angle 				= Angle(-90,0,0), 
		size 				= 0.74, 
		color 				= Color(255, 255, 255, 255),
		surpresslightning 	= false, 
		skin 				= 0,
		bodygroup 			= {} 
	},
	["rds"] = 
	{ 
		type 				= "Model", 	
		model 				= "models/weapons/rds.mdl",  
		bone 				= "v_weapon.galilar_parent", 
		pos 				= Vector(0, -4, 4), 
		angle 				= Angle(-90, 90, 0), 
		size 				= 0.55, 
		color 				= Color(255, 255, 255, 255),
		surpresslightning 	= false, 
		AuxIronSightsPos 	= Vector(-5.33, -5.693, 1.04),
		AuxIronSightsAng 	= Vector(0,0,0),
		RRise 				= 0.001,
		RSlide 				= 0,
		skin 				= 0, 
		bodygroup 			= {} 
	},
	["m145"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/m145.mdl",  
		bone 				= "v_weapon.galilar_parent", 
		pos 				= Vector(0, -5.6, 3), 
		angle 				= Angle(0, -180, 0), 
		size 				= 0.48, 
		color 				= Color(255, 255, 255, 255),
		surpresslightning 	= false, 
		AuxIronSightsPos 	= Vector(-5.33, -5.693, 0.8),
		AuxIronSightsAng 	= Vector(0,0,0),
		RRise 				= 0.002,
		RSlide 				= 0,
		skin 				= 0, 
		bodygroup 			= {} 
	}
}