if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "q"
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_ump_45", "CSKillIcons", SWEP.IconLetter,Color(200, 200, 200, 255))
end
SWEP.HoldType				= "smg"
SWEP.PrintName 				= "HK UMP-45"
SWEP.ShellEffect			= "rg_shelleject"
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_ump45.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_ump45.mdl"
SWEP.Primary.Sound 			= Sound("csgo/ump45/ump45-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.45
SWEP.Primary.Damage 		= 9
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.004
SWEP.Primary.ClipSize 		= 25
SWEP.Primary.Delay 			= 0.095
SWEP.Primary.DefaultClip 	= 25
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "smg1"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.RMod					= 1
SWEP.RKick					= 10
SWEP.RRise					= 0.0015
SWEP.RSlide					= 0.001
SWEP.IronSightsPos 			= Vector(-5.11, -12.664, 0.70)
SWEP.IronSightsAng 			= Vector(1.4, 0, 0)
SWEP.SMG					= true
SWEP.DistantSound			= "ump.mp3"
SWEP.Subsonic				= true
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_ump45"
SWEP.WMOffsetPos			= { up = -3.8, right = 0.5, forward = 6 }
SWEP.WMOffsetAng			= { up = 0, right = 80, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type = "Model", 
		model = "models/weapons/suppressor.mdl",  
		bone = "v_weapon.ump45_Parent", 
		pos = Vector(0, -4, 15), 
		angle = Angle(-90,0,0), 
		size = 0.8, 
		color = Color(255, 255, 255, 255), 
		surpresslightning = false, 
		skin = 0, 
		bodygroup = {} 
	},
	["m145"] = 
	{ 
		type = "Model", 
		model = "models/weapons/m145.mdl", 
		bone = "v_weapon.ump45_Parent", 
		pos = Vector(0, -7, 3), 
		angle = Angle(0, 180, 0), 
		size = 0.5, 
		color = Color(255, 255, 255, 255), 
		surpresslightning = false, 
		AuxIronSightsPos = Vector(-5.14, -12.664, 0),
		AuxIronSightsAng = Vector(1.4, 0, 0),
		RRise = 0.001,
		RSlide = 0,
		skin = 0, 
		bodygroup = {} 
	},
	["rds"] =
	{ 
		type = "Model", 
		model = "models/weapons/rds.mdl", 
		bone = "v_weapon.ump45_Parent", 
		pos = Vector(0.05, -5.50, 2.53), 
		angle = Angle(-90,90,0), 
		size = 0.58, 
		color = Color(255, 255, 255, 255), 
		surpresslightning = false, 
		skin = 0, 
		bodygroup = {},
		AuxIronSightsPos = Vector(-5.10, -12.664, 0),
		AuxIronSightsAng = Vector(1.4, 0, 0)
	}
}