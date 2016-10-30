if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	SWEP.PrintName 			= "MP5"
	SWEP.IconLetter 		= "x"

	killicon.AddFont("weapon_sh_mp5a4", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "MP5"
SWEP.HoldType				= "ar2"
SWEP.PrintName				= "MP5"
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Slot					= 0
SWEP.Base					= "weapon_sh_base"
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_mp5.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_mp5.mdl"
SWEP.ViewModelFOV			= 65
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_mp5"
SWEP.Primary.Sound			= Sound("TFA_CSGO_MP5.1")
SWEP.Primary.Recoil			= 0.2
SWEP.ModelRunAnglePreset	= 2
SWEP.Primary.Damage			= 9
SWEP.Primary.Cone			= 0.01
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.090
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.IronSightsPos 			= Vector(-3.881, 0, 1.238)
SWEP.IronSightsAng 			= Vector(0, -0.015, 0)
SWEP.ShouldZoom				= false
SWEP.WMOffsetPos			= { up = 0.5, right = 1, forward = 3 }
SWEP.WMOffsetAng			= { up = 0, right = 3, forward = 180 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "f_frame", 
		pos 				= Vector(-0,-4,15.5), 
		angle 				= Angle(90,0,0), 
		size 				= 0.7, 
		color 				= Color(255, 255, 255, 255),
		surpresslightning 	= false,  
		skin 				= 0, 
		bodygroup 			= {} 
	},
	["rds"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/rds.mdl",  
		bone 					= "f_frame", 
		pos 					= Vector(0, -4.00, -3), 
		angle 					= Angle(-90, 90, 0), 
		size 					= 0.75, 
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		AuxIronSightsPos		= Vector(-4, -4.643, 0.25),
		AuxIronSightsAng 		= Vector(0.35, -0.38, -0),
		RRise 					= 0.001,
		RSlide 					= 0,
		skin 					= 0, 
		bodygroup 				= {} 
	}
}