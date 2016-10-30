if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.ViewModelFOV		= 60
	SWEP.IconLetter 		= "n"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_scout", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "Scout"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base					= "weapon_sh_sniperbase"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_scout.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_scout.mdl"
SWEP.Primary.Sound 			= Sound("csgo/ssg08/ssg08-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= math.Rand (15,25)
SWEP.Primary.Recoil 		= 1
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 10
SWEP.Primary.Delay 			= 1.2
SWEP.Primary.DefaultClip 	= 10
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "ar2"
SWEP.IronSightZoom			= 30
SWEP.UseScope				= true
SWEP.FireSelect 			= 0
SWEP.Sniper					= false
SWEP.RMod					= 1
SWEP.RKick					= 5
SWEP.DistantSound			= "scout.mp3"
SWEP.IronSightsPos 			= Vector(-5.500, -14.700, -9)
SWEP.IronSightsAng 			= Vector(1.802, 0.774, 0)
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_scout"
SWEP.BuiltInScope			= true
SWEP.WMOffsetPos			= { up = 0.7, right = 0.5, forward = 1.0 }
SWEP.WMOffsetAng			= { up = 0, right = -9, forward = 180 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.ssg08_parent", 
		pos 				= Vector(1.30, -1.90, 30), 
		angle 				= Angle(-90, 0, 0), 
		size 				= 0.715, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}