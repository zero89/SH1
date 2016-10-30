if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	SWEP.PrintName 			= "MP9"
	SWEP.IconLetter 		= "x"

	killicon.AddFont("weapon_sh_mp9", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "MP9"
SWEP.HoldType				= "smg"
SWEP.PrintName				= "MP9"
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Slot					= 0
SWEP.Base					= "weapon_sh_base"
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_mp9.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_mp9.mdl"
SWEP.ViewModelFOV			= 60
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_mp9"
SWEP.Primary.Sound			= Sound("csgo/mp9/mp9-1.wav")
SWEP.Primary.Recoil			= 0.2
SWEP.ModelRunAnglePreset	= 2
SWEP.Primary.Damage			= 6
SWEP.Primary.Cone			= 0.035
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.090
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.IronSightsPos		    = Vector(-4.73, -3.619, 0.72)
SWEP.IronSightsAng          = Vector(0.63, 0.10, -1.407)
SWEP.ShouldZoom				= false
SWEP.WMOffsetPos			= { up = -4.5, right = 0.5, forward = 9 }
SWEP.WMOffsetAng			= { up = 0, right = 78, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/suppressor.mdl",  
		bone 					= "v_weapon.mp9_parent", 
		pos 					= Vector(0, -2.90, 7.1), 
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
		bone 					= "v_weapon.mp9_parent", 
		pos 					= Vector(0, -3.10, -0.80), 
		angle 					= Angle(-90, 90, 0), 
		size 					= 0.60, 
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		AuxIronSightsPos		= Vector(-4.75, -190.643, -0.05),
		AuxIronSightsAng 		= Vector(0.65, 0, -1),
		RRise 					= 0.001,
		RSlide 					= 0,
		skin 					= 0, 
		bodygroup 				= {} 
	},
}