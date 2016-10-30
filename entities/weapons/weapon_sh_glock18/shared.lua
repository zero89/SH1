if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType			= "pistol"
elseif (CLIENT) then
	
	SWEP.IconLetter 		= "c"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_glock18", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end
	
SWEP.PrintName 				= "Glock-18"
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_glock18.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_glock18.mdl"
SWEP.Primary.Sound 			= Sound("csgo/glock18/glock18-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 7
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 19
SWEP.Primary.Delay 			= 0.160
SWEP.Primary.DefaultClip 	= 19
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "pistol"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.FireSelect				= 1
SWEP.RRise					= 0.005
SWEP.IronSightsPos 			= Vector(-2.76, -3.433, 1.1)
SWEP.IronSightsAng 			= Vector(0.6, 0.15, 0)
SWEP.DistantSound			= "glock.mp3"
SWEP.Subsonic				= true
SWEP.SlideLockPos			= Vector(1.2,-0.35,0.05)
SWEP.DotVis					= -0.9
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_glock"
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
		pos 				= Vector(0, -2.3, 7), 
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
		pos 				= Vector(-2.9, -0.73, 0), 
		angle 				= Angle(90,-90,0),
		AuxIronSightsPos 	= Vector(-2.79, -6.299, 1.1),
		AuxIronSightsAng 	= Vector(0, 0, 0),
		size 				= 0.115, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}