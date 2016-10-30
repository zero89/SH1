if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "w"
	SWEP.ViewModelFlip		= false	
	SWEP.ViewModelFOV		= 60

	killicon.AddFont("weapon_sh_m4a2", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "M4A1-S"
SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "none"
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_m4a1.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_m4a1.mdl"
SWEP.Primary.Sound 			= Sound("csgo/m4a1/m4a1-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 11
SWEP.Primary.Recoil 		= 0.6
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.008
SWEP.Primary.ClipSize 		= 20
SWEP.Primary.Delay 			= 0.105
SWEP.Primary.DefaultClip 	= 20
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "ar2"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.Recoil 				= 2
SWEP.RMod					= 1
SWEP.SlideLocks				= 0
SWEP.FireSelect				= 1
SWEP.Look					= 1
SWEP.CycleSpeed				= 1
SWEP.IronCycleSpeed			= 0
SWEP.RKick					= 10
SWEP.RRise					= -0.02
SWEP.RSlide					= 0.005
SWEP.LastAmmoCount 			= 0
SWEP.IronsightCorrection 	= 0
SWEP.IronSightsPos 			= Vector(-5.270, -5.628, 0.120)
SWEP.IronSightsAng 			= Vector(1.235, -0.091, -1.407)
SWEP.DistantSound			= "m4.mp3"
SWEP.AuxViewModel 			= "models/weapons/tfa_csgo/c_m4a1.mdl"
SWEP.AuxIronSightsPos 		= Vector(-4.721, -4.73, 1.90)
SWEP.AuxIronSightsAng 		= Vector(1.3, -0.1, 0)
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_m4a1s"
SWEP.WMOffsetPos			= { up = -2, right = 0.8, forward = 6 }
SWEP.WMOffsetAng			= { up = 1, right = 90, forward = 178 }
SWEP.VElements 				= { }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["rds"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/rds.mdl",  
		bone 					= "v_weapon.m4a1_s_parent", 
		pos 					= Vector(-0.25, -7.2, 0.50), 
		angle 					= Angle(-90, 88.5, 0), 
		size 					= 0.50, 
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		AuxIronSightsPos		= Vector(-5.25, -0, -0.25),
		AuxIronSightsAng 		= Vector(0.65, 0, -1),
		RRise 					= 0.001,
		RSlide 					= 0,
		skin 					= 0, 
		bodygroup 				= {} 
	}
}