if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType			= "pistol"
elseif (CLIENT) then
	
	SWEP.IconLetter 		= "u"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_p2000", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "P2000"
SWEP.EjectDelay				= 0.05
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_p2000.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_p2000.mdl"
SWEP.Primary.Sound			= Sound("csgo/hkp2000/hkp2000-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 9
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 20
SWEP.Primary.Delay 			= 0.120
SWEP.Primary.DefaultClip 	= 20
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "pistol"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos 			= Vector(-2.721, 0, 0.92)
SWEP.IronSightsAng 			= Vector(0.662, 0.3, 0)
SWEP.DistantSound			= "fiveseven.mp3"
SWEP.SlideLockPos			= Vector(-1.3,0,0)
SWEP.DotVis					= -0.75
SWEP.WeaponSkin				= "weapon_p2000"
SWEP.UseHands				= true
SWEP.StatTrak				= true