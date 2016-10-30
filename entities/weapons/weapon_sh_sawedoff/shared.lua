if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "shotgun"
elseif (CLIENT) then
	SWEP.PrintName 		= "Sawed-Off"
	SWEP.IconLetter 	= "k"
	SWEP.ViewModelFlip	= false

	killicon.AddFont("weapon_sh_sawedoff", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "Sawed-Off"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_sawedoff.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_sawedoff.mdl"
SWEP.Primary.Sound 			= Sound("csgo/sawedoff/sawedoff-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.9
SWEP.Primary.Damage 		= 5
SWEP.Primary.NumShots 		= 7
SWEP.Primary.Cone 			= 0.12
SWEP.Primary.ClipSize 		= 8
SWEP.Primary.Delay 			= 0.85
SWEP.Primary.DefaultClip 	= 8
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "buckshot"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.RMod					= 0
SWEP.Zoom					= 0
SWEP.FireSelect				= 0
SWEP.IronCycleSpeed			= 1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos 			= Vector(-4.281, -3.237, 1.759)
SWEP.IronSightsAng 			= Vector(0.703, -0.005, 0)
SWEP.DistantSound			= "shotty.mp3"
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_sawedoff"
SWEP.WMOffsetPos			= { up = -3, right = 1, forward = 9 }
SWEP.WMOffsetAng			= { up = 0, right = 80, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements =
{
	["suppressor"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/suppressor.mdl",  
		bone 					= "v_weapon.sawedoff_parent", 
		pos 					= Vector(0, -1.65, 22), 
		angle 					= Angle(-90, 0, 0), 
		size 					= 0.8,
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		skin 					= 0, 
		bodygroup 				= {} 
	}
}