if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "w"
	SWEP.ViewModelFlip		= false	
	SWEP.ViewModelFOV		= 60

	killicon.AddFont("weapon_sh_m4a2", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "M4A4"
SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "none"
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_m4a4.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_m4a4.mdl"
SWEP.Primary.Sound 			= Sound("csgo/m4a1/m4a1_unsil-1.wav")
SWEP.SuppressedSound		= Sound("csgo/m4a1/m4a1-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 11
SWEP.Primary.Recoil 		= 0.5
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.015
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Delay 			= 0.095
SWEP.Primary.DefaultClip 	= 30
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
SWEP.RKick					= 5
SWEP.RRise					= -0.009
SWEP.RSlide					= 0.005
SWEP.LastAmmoCount 			= 0
SWEP.IronsightCorrection 	= 0
SWEP.IronSightsPos 			= Vector(-5.1725, -9.648, 0.855)
SWEP.IronSightsAng 			= Vector(-0.25, -0.2, -2.112)
SWEP.DistantSound			= "m4.mp3"
-- SWEP.AuxViewModel 			= "models/weapons/c_csgo_m4a1.mdl"
SWEP.AuxIronSightsPos 		= Vector(-4.32, -4.73, 1.90)
SWEP.AuxIronSightsAng 		= Vector(1.3, -0.1, 0)
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_m4a4"
SWEP.WMOffsetPos			= { up = -3.5, right = 0.8, forward = 6 }
SWEP.WMOffsetAng			= { up = 3, right = 90, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.M4A1_Parent", 
		pos 				= Vector(-0.10, -5.10, 20), 
		angle 				= Angle(-90,0,0), 
		size 				= 0.8, 
		color 				= Color(255, 255, 255, 255),
		surpresslightning 	= false,  
		skin 				= 0, 
		bodygroup 			= {} 
	},
	
	["rds"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/rds.mdl",  
		bone 					= "v_weapon.M4A1_Parent", 
		pos 					= Vector(0.15, -5.0, 0.75), 
		angle 					= Angle(-90, 88.5, 0), 
		size 					= 0.2, 
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		AuxIronSightsPos		= Vector(-5.01, -0, -0.25),
		AuxIronSightsAng 		= Vector(0.25, 0, -1),
		RRise 					= 0.001,
		RSlide 					= 0,
		skin 					= 0, 
		bodygroup 				= {} 
	}
}