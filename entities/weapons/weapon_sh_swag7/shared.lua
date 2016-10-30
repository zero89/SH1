if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "ar2"
elseif (CLIENT) then
	
	SWEP.IconLetter 	= "k"
	SWEP.ViewModelFlip	= false

	killicon.AddFont("weapon_sh_swag7", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "MAG-7"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_mag7.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_mag7.mdl"
SWEP.Primary.Sound			= Sound("csgo/mag7/mag7-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.7
SWEP.Primary.Damage 		= 3
SWEP.Primary.NumShots 		= 7
SWEP.Primary.Cone 			= 0.10
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
SWEP.IronSightsPos			= Vector(-6.370, -6.231, 3.2)
SWEP.IronSightsAng			= Vector(0.4, 0, -0.779)
SWEP.DistantSound			= "shotty.mp3"
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_mag7"
SWEP.WMOffsetPos			= { up = -3.2, right = 1.0, forward = 6 }
SWEP.WMOffsetAng			= { up = 3, right = 82, forward = 178 }
SWEP.RedDotSight			= false
SWEP.StatTrak				= true