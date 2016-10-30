if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "f"
	SWEP.ViewModelFlip		= false
	SWEP.ViewModelFOV		= 55

	killicon.AddFont("weapon_sh_deagle", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "Desert Eagle"
SWEP.MuzzleAttachment		= "1" 
SWEP.MuzzleEffect			= "rifle"
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_deagle.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_deagle.mdl"
SWEP.Primary.Sound 			= Sound("csgo/deagle/deagle-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 24
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 7
SWEP.Primary.Delay 			= 0.35
SWEP.Primary.DefaultClip 	= 7
SWEP.Primary.Recoil 		= 1.0
SWEP.RRise					= 0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "pistol"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos 			= Vector(-3.76, -5.628, 0.28)
SWEP.IronSightsAng 			= Vector(0.68, 0.30, 0)
SWEP.DistantSound			= "deagle.mp3"
SWEP.SlideLockPos			= Vector(0,0,-1.5)
SWEP.DotVis					= -1
SWEP.WeaponSkin				= "weapon_deagle"
SWEP.UseHands				= true
SWEP.ModelRunAnglePreset	= 3
SWEP.WMOffsetPos			= { up = -3.5, right = 0.8, forward = 6 }
SWEP.WMOffsetAng			= { up = 3, right = 90, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = {
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.deagle_parent", 
		pos 				= Vector(0, -2.50, 9.40), 
		angle 				= Angle(-90, 0, 0), 
		size 				= 0.8, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	},
	["rds"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/mrds.mdl",  
		model 				= "models/weapons/mrds.mdl",  
		bone 				= "v_weapon.deagle_parent", 
		pos 				= Vector(3.20, -1.40, 2), 
		angle 				= Angle(-90, 90, 0),
		AuxIronSightsPos 	= Vector(-3.85, -4.362, 0.38),
		AuxIronSightsAng 	= Vector(0, 0, 0),
		size 				= 0.13, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}