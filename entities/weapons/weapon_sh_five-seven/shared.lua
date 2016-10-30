if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType			= "pistol"
elseif (CLIENT) then
	
	SWEP.IconLetter 		= "u"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_five-seven", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end
SWEP.PrintName 				= "Five SeveN"
SWEP.EjectDelay				= 0.05
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_fiveseven.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_fiveseven.mdl"
SWEP.Primary.Sound 			= Sound("csgo/fiveseven/fiveseven-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 9
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 20
SWEP.Primary.Delay 			= 0.105
SWEP.Primary.DefaultClip 	= 20
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "pistol"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos 			= Vector(-2.700, -5.026, 0.55)
SWEP.IronSightsAng 			= Vector(0.95, 0.324, 0)
SWEP.DistantSound			= "fiveseven.mp3"
SWEP.SlideLockPos			= Vector(-1.3,0,0)
SWEP.DotVis					= -0.75
SWEP.WeaponSkin				= "weapon_fiveseven"
SWEP.UseHands				= true
SWEP.WMOffsetPos			= { up = -2, right = 0.8, forward = 4.5 }
SWEP.WMOffsetAng			= { up = 3, right = 90, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.p250_parent", 
		pos 				= Vector(0, -2.5, 6.5), 
		angle 				= Angle(-90,0,0), 
		size 				= 0.6,
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin = 0, 
		bodygroup = {} 
	},
	["rds"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/mrds.mdl",  
		bone 				= "v_weapon.p250_parent", 
		pos 				= Vector(3.45, -0.53, 1), 
		angle 				= Angle(-90,90,0),
		AuxIronSightsPos 	= Vector(-2.68, -9.716, 0.70),
		AuxIronSightsAng 	= Vector(0, 0.38, 0),
		size 				= 0.14, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}