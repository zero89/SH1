if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 			= "ar2"
elseif (CLIENT) then

	
	SWEP.ViewModelFlip		= false
	SWEP.IconLetter 		= "e"

	killicon.AddFont("weapon_sh_aug", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))

end

SWEP.HoldType				= "smg"
SWEP.PrintName 				= "AUG"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_aug.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_aug.mdl"
SWEP.Primary.Sound 			= Sound("TFA_CSGO_AUG.1")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.5
SWEP.Primary.Damage 		= 10
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Delay 			= 0.110
SWEP.Primary.Cone 			= 0.003
SWEP.Primary.DefaultClip 	= 30
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "ar2"
SWEP.RKick					= 10
SWEP.RRise					= 0
SWEP.RSlide					= 0.015
SWEP.IronSightsPos 			= Vector(-3.56, -7, 0.175) //Vector(-3.30, -13.73, -0)
SWEP.IronSightsAng 			= Vector(-0.63, 0.129, 0) //Vector(0, 1, 0)
SWEP.DistantSound			= "aug.mp3"
SWEP.IronPos				= Vector(-5.13, -12.73, 2.33)
SWEP.IronAng				= Vector(0, 0, 0)
SWEP.IronFrontPos			= Vector(-0.15, 0, 2)
SWEP.WeaponSkin				= "weapon_aug"
SWEP.UseHands				= true
SWEP.RedDotSight			= true
SWEP.WMOffsetPos			= { up = -4.5, right = 0.9, forward = 3.5 }
SWEP.WMOffsetAng			= { up = 2, right = 80, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.aug_Parent", 
		pos 				= Vector(0, -3.50, 14.96), 
		angle 				= Angle(-90, 2, 0), 
		size 				= 0.7, 
		color 				= Color(255, 255, 255, 255),
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}