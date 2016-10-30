if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "pistol"
elseif (CLIENT) then
	
	SWEP.IconLetter 	= "y"
	SWEP.ViewModelFlip	= false

	killicon.AddFont("weapon_sh_p228", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "P250"
SWEP.EjectDelay				= 0.05
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_p250.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_p250.mdl"
SWEP.Primary.Sound 			= Sound("csgo/p250/p250-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 9
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 13
SWEP.Primary.Delay 			= 0.105
SWEP.Primary.DefaultClip 	= 13
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "pistol"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos 			= Vector(-2.721, 0, 0.68)
SWEP.IronSightsAng 			= Vector(1, 0.27, 0)
SWEP.DistantSound			= "p228.mp3"
SWEP.Subsonic				= true
SWEP.DotVis					= -1.4
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_p250"
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
		pos 				= Vector(0, -2.50, 7), 
		angle 				= Angle(-90,0,0), 
		size 				= 0.7, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	},
	["rds"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/mrds.mdl",  
		bone 				= "v_weapon.p250_parent", 
		pos 				= Vector(2.80, -1.12, 1), 
		angle 				= Angle(-90,90,0),
		AuxIronSightsPos 	= Vector(-2.82, -9.716, 0.65),
		AuxIronSightsAng 	= Vector(0.502, 0, 0),
		size 				= 0.11, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}