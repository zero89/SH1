if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "z"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_negev", "CSKillIcons", SWEP.IconLetter,Color(200, 200, 200, 255))
end

SWEP.HoldType				= "ar2"
SWEP.PrintName 				= "Negev"
SWEP.MuzzleEffect			= "rifle"
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= false
SWEP.AdminSpawnable 		= false
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_negev.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_negev.mdl"
SWEP.Primary.Sound 			= Sound("csgo/negev/negev-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 1.1
SWEP.Primary.Damage 		= 5
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.012
SWEP.Primary.ClipSize 		= 100
SWEP.Primary.Delay 			= 0.080
SWEP.Primary.DefaultClip 	= 100
SWEP.Primary.Automatic 		= true
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Primary.Ammo 			= "ar2"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos = Vector(-7.86, -7.158, 2.28)
SWEP.IronSightsAng = Vector(-0.401, -0.25, -1.716)
SWEP.ModelRunAnglePreset	= 1
SWEP.RKick					= 12
SWEP.RRise					= 0
SWEP.RSlide					= -0.0005
SWEP.NoCrossHair			= true
SWEP.DistantSound			= "m4.mp3"
SWEP.WeaponSkin				= "weapon_negev"
SWEP.WMOffsetPos			= { up = 0.5, right = 1, forward = 3 }
SWEP.WMOffsetAng			= { up = 4, right = -3, forward = 180 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 						= "Model", 
		model 						= "models/weapons/suppressor.mdl",
		bone 						= "v_weapon.negev_Parent", 
		pos 						= Vector(0, -5.12, 22), 
		angle 						= Angle(-90, 90, 0), 
		size 						= 0.80, 
		color 						= Color(255, 255, 255, 255), 
		surpresslightning 			= false, 
		skin 						= 0, 
		bodygroup 					= {} 
	},
	["rds"] = 
	{ 
		type 						= "Model", 
		model 						= "models/weapons/rds.mdl", 
		bone 						= "v_weapon.negev_Parent", 
		pos 						= Vector(-0.25, -4.2, -1.5), 
		angle 						= Angle(-90, 88.5, -1), 
		size 						= 0.90, 
		color 						= Color(255, 255, 255, 255), 
		surpresslightning 			= false, 
		AuxIronSightsPos 			= Vector(-7.900, -5.282, 0.75),
		AuxIronSightsAng 			= Vector(0, 0, -1),
		skin 						= 0, 
		bodygroup 					= {} 
	}
}