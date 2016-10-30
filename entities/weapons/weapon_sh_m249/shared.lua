if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "z"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_m249", "CSKillIcons", SWEP.IconLetter,Color(200, 200, 200, 255))
end

SWEP.HoldType				= "ar2"
SWEP.PrintName 				= "M249 SAW"
SWEP.MuzzleEffect			= "rifle"
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= false
SWEP.AdminSpawnable 		= false
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_m249.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_m249.mdl"
SWEP.Primary.Sound 			= Sound("csgo/m249/m249-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.9
SWEP.Primary.Damage 		= 5
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.010
SWEP.Primary.ClipSize 		= 100
SWEP.Primary.Delay 			= 0.095
SWEP.Primary.DefaultClip 	= 100
SWEP.Primary.Automatic 		= true
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Primary.Ammo 			= "ar2"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos 			= Vector(-7.915, -16.282, 1.44)
SWEP.IronSightsAng 			= Vector(0.0, -0.45, -1.407)
SWEP.ModelRunAnglePreset	= 1
SWEP.RKick					= 10
SWEP.RRise					= 0
SWEP.RSlide					= -0.0005
SWEP.NoCrossHair			= true
SWEP.DistantSound			= "m4.mp3"
SWEP.WeaponSkin				= "weapon_m249"
SWEP.WMOffsetPos			= { up = -4.75, right = 0.5, forward = 10 }
SWEP.WMOffsetAng			= { up = 3, right = 80, forward = 178}
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 						= "Model", 
		model 						= "models/weapons/suppressor.mdl",
		bone 						= "v_weapon.m249_Parent", 
		pos 						= Vector(0, -4.53, 30), 
		angle 						= Angle(-90, 90, 0), 
		size 						= 0.77, 
		color 						= Color(255, 255, 255, 255), 
		surpresslightning 			= false, 
		skin 						= 0, 
		bodygroup 					= {} 
	},
	["m145"] = 
	{ 
		type 						= "Model", 
		model 						= "models/weapons/m145.mdl", 
		bone 						= "v_weapon.m249_Parent", 
		pos 						= Vector(0.11, -7, 5),
		angle 						= Angle(0, -180, 0), 
		size 						= 0.6, 
		color 						= Color(255, 255, 255, 255), 
		surpresslightning 			= false,  
		AuxIronSightsPos 			= Vector(-7.600, -16.282, 0.50),
		AuxIronSightsAng 			= Vector(0, 0, -1),
		skin = 0, 
		bodygroup = {} 
	},
	["rds"] = 
	{ 
		type 						= "Model", 
		model 						= "models/weapons/rds.mdl", 
		bone 						= "v_weapon.m249_Parent", 
		pos 						= Vector(0.05, -5.4, 0.25), 
		angle 						= Angle(-90, 88.5, -1), 
		size 						= 0.75, 
		color 						= Color(255, 255, 255, 255), 
		surpresslightning 			= false, 
		AuxIronSightsPos 			= Vector(-7.650, -3.282, 0.05),
		AuxIronSightsAng 			= Vector(0, 0, -1),
		skin 						= 0, 
		bodygroup 					= {} 
	}
}