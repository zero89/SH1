if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.ViewModelFlip		= false
	SWEP.IconLetter 		= "t"

	killicon.AddFont("weapon_sh_famas", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "FAMAS"
SWEP.MuzzleEffect			= "rifle" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_famas.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_famas.mdl"
SWEP.Primary.Sound 			= Sound("csgo/famas/famas-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.65
SWEP.Primary.Damage 		= 9
SWEP.Primary.NumShots 		= 1
SWEP.ModelRunAnglePreset	= 2
SWEP.Primary.Cone 			= 0.007
SWEP.Primary.ClipSize 		= 25
SWEP.Primary.Delay 			= 0.100
SWEP.Primary.DefaultClip 	= 25
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "ar2"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos 			= Vector(-6.279, -9.849, 1.24)
SWEP.IronSightsAng 			= Vector(-0.3, -0.18, -2.115)
SWEP.DistantSound			= "famas.mp3"
SWEP.WeaponSkin				= "weapon_famas"
SWEP.UseHands				= true
SWEP.VElements 				= {} 
SWEP.WMOffsetPos			= { up = -3.75, right = 0.8, forward = 5 }
SWEP.WMOffsetAng			= { up = 3, right = 86, forward = 178 }
SWEP.StatTrak				= true


SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/suppressor.mdl",  
		bone 					= "v_weapon.FAMAS_parent", 
		pos 					= Vector(0, -2.82, 15), 
		angle 					= Angle(-90, 0, 0), 
		size 					= 0.8,
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		skin 					= 0, 
		bodygroup 				= {} 
	},
	["rds"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/rds.mdl",  
		bone 					= "v_weapon.famas_parent", 
		pos 					= Vector(0.00, -5.4, -0.75), 
		angle 					= Angle(-90, 90, 0), 
		size 					= 0.60, 
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		AuxIronSightsPos		= Vector(-6.25, -0.5, 0.08),
		AuxIronSightsAng 		= Vector(0.65, 0, -1),
		RRise 					= 0.001,
		RSlide 					= 0,
		skin 					= 0, 
		bodygroup 				= {} 
	}
}