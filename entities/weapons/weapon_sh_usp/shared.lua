if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "pistol"
elseif (CLIENT) then
	
	SWEP.IconLetter 	= "a"
	SWEP.CSMuzzleFlashes	= false
	SWEP.ViewModelFOV		= 60
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_usp", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "USP-S"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_usp.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_usp.mdl"
SWEP.Primary.Sound 			= Sound("csgo/usp/usp1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.5
SWEP.Primary.Damage 		= 9
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 12
SWEP.Primary.Delay 			= 0.170
SWEP.Primary.DefaultClip 	= 12
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "pistol"
SWEP.IronSightsPos 			= Vector(-2.84, -7.84, 1.48)
SWEP.IronSightsAng 			= Vector(-0.571, 0.008, 0)
SWEP.DistantSound			= nil
SWEP.Subsonic				= true
SWEP.DotVis					= -1
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_usps"
SWEP.WMOffsetPos			= { up = -2.5, right = 0.8, forward = 7 }
SWEP.WMOffsetAng			= { up = 1, right = 90, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["rds"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/mrds.mdl",  
		bone 				= "v_weapon.223_parent", 
		pos 				= Vector(3.25, -1.32, 1), 
		angle 				= Angle(-90,90,0),
		AuxIronSightsPos 	= Vector(-2.82, -5.612, 1.15),
		AuxIronSightsAng 	= Vector(0, 0, 0),
		size 				= 0.13, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}

