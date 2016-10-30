if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "w"
	SWEP.ViewModelFlip		= false	
	SWEP.ViewModelFOV		= 60

	killicon.AddFont("weapon_sh_cz75", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "CZ-75"
SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "none"
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_cz75.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_cz75.mdl"
SWEP.Primary.Sound 			= Sound("csgo/cz75a/cz75a-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 7
SWEP.Primary.Recoil 		= 0.4
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.004
SWEP.Primary.ClipSize 		= 12
SWEP.Primary.Delay 			= 0.105
SWEP.Primary.DefaultClip 	= 12
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "pistol"
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
SWEP.IronSightsPos			= Vector(-2.82, 0, 0.879)
SWEP.IronSightsAng			= Vector(0.479, -0.02, 0)
SWEP.DistantSound			= "fiveseven.mp3"
SWEP.AuxViewModel 			= "models/weapons/tfa_csgo/c_cz75.mdl"
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_cz75"
SWEP.WMOffsetPos			= { up = -1.6, right = 0.8, forward = 5.5 }
SWEP.WMOffsetAng			= { up = 3, right = 90, forward = 178 }
SWEP.StatTrak				= true


SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.cz_parent", 
		pos 				= Vector(0,-2.40,8), 
		angle 				= Angle(-90,0,0), 
		size 				= 0.55, 
		color 				= Color(255, 255, 255, 255),
		surpresslightning 	= false,  
		skin 				= 0, 
		bodygroup 			= {} 
	},
	["rds"] =
	{ 
		type = "Model", 
		model = "models/weapons/rds.mdl", 
		bone = "v_weapon.cz_Parent", 
		pos = Vector(0.00, -2.10, 0.60), 
		angle = Angle(-90,90,0), 
		size = 0.50, 
		color = Color(255, 255, 255, 255), 
		surpresslightning = false, 
		skin = 0, 
		bodygroup = {},
		AuxIronSightsPos = Vector(-2.80, -8.664, -0.00),
		AuxIronSightsAng = Vector(1.4, 0, 0)
	}
}