if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "b"

	killicon.AddFont("weapon_sh_ak47", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "AK-47"
SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "2" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_ak47.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_ak47.mdl"
SWEP.ViewModelFlip			= false
SWEP.ViewModelFOV			= 60
SWEP.Primary.Sound 			= Sound("csgo/ak47/ak47-1.wav")
SWEP.Primary.Damage 		= 12
SWEP.Primary.Recoil 		= 0.9
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.002
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Delay 			= 0.145
SWEP.Primary.DefaultClip 	= 60
SWEP.Primary.Automatic 		= true
SWEP.ModelRunAnglePreset	= 1
SWEP.Primary.Ammo 			= "ar2"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.RMod					= 1
SWEP.RKick					= 10
SWEP.RRise					= -0.004
SWEP.IronSightsPos 			= Vector(-4.980, -8.643, 0.62) //Vector(-5.1, -4.643, 0.40)
SWEP.IronSightsAng 			= Vector(1.175, 0.125, -1.407) //Vector(1.53, 0, -3)
SWEP.BoltBone				= "v_weapon.AK47_bolt"
SWEP.WeaponSkin				= "weapon_ak47"
SWEP.UseHands				= true
SWEP.Heavy					= true
SWEP.WMOffsetPos			= { up = -1.6, right = 1.2, forward = 6 }
SWEP.WMOffsetAng			= { up = 7, right = 83, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/suppressor.mdl",  
		bone 					= "v_weapon.AK47_parent", 
		pos 					= Vector(0, -3.53, 26), 
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
		bone 					= "v_weapon.AK47_parent", 
		pos 					= Vector(0, -4.10, 3), 
		angle 					= Angle(-90, 90, 0), 
		size 					= 0.55, 
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		AuxIronSightsPos		= Vector(-5.07, -4.643, 0.40),
		AuxIronSightsAng 		= Vector(0.65, 0, -3),
		RRise 					= 0.001,
		RSlide 					= 0,
		skin 					= 0, 
		bodygroup 				= {} 
	},
	["m145"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/m145.mdl",  
		bone 					= "v_weapon.AK47_parent", 
		pos 					= Vector(0, -5.60, 6), 
		angle 					= Angle(0, 180, 0), 
		size 					= 0.48, 
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		AuxIronSightsPos 		= Vector(-5.07, -4.643, 0.40),
		AuxIronSightsAng 		= Vector(0.35, 0, -3),
		RRise 					= 0.002,
		RSlide 					= 0.0004,
		skin 					= 0, 
		bodygroup 				= {} 
	}
}