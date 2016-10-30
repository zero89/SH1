if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.ViewModelFOV		= 60
	SWEP.ViewModelFlip		= false
	SWEP.IconLetter 		= "r"

	killicon.AddFont("weapon_sh_awp", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "AWP"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_sniperbase"
SWEP.Spawnable 				= false
SWEP.AdminSpawnable 		= false
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_awp.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_awp.mdl"
SWEP.Primary.Sound 			= Sound("csgo/awp/awp1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 80
SWEP.Primary.Recoil 		= 2
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 5
SWEP.Primary.Delay 			= 1.6
SWEP.Primary.Cone 			= 0.005
SWEP.Primary.DefaultClip 	= 5
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "ar2"
SWEP.DrawParabolicSights	= false
SWEP.FireSelect				= 0
SWEP.DistantSound			= "awp.mp3"
SWEP.IronSightsPos 			= Vector(-5.53, -2.700, -20)
SWEP.IronSightsAng 			= Vector(1.802, 0.774, 0)
SWEP.IronPos				= Vector(0.06, 4.05, 3.4)
SWEP.IronAng				= Angle(0, 0, 90)
SWEP.IronFrontPos			= Vector(0, 0, 1.5)
SWEP.WeaponSkin				= "weapon_awp"
SWEP.UseHands				= true
SWEP.UseScope				= true
SWEP.BuiltInScope			= true
SWEP.WMOffsetPos			= { up = -2.5, right = 1, forward = 5.5 }
SWEP.WMOffsetAng			= { up = 0, right = -9, forward = 180 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.awp_parent", 
		pos 				= Vector(0, -3.50, 38), 
		angle 				= Angle(-90,0,0), 
		size 				= 1.0, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}