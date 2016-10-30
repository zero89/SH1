if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "ar2"
elseif (CLIENT) then
	
	SWEP.IconLetter 		= "B"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_xm1014", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "XM1014"
SWEP.ShellEffect			= "rg_shelleject_shotgun" 
SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "2" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= false
SWEP.AdminSpawnable 		= false
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_xm1014.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_xm1014.mdl"
SWEP.Primary.Sound 			= Sound("csgo/xm1014/xm1014-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.7
SWEP.Primary.ClipSize 		= 8
SWEP.Primary.Delay 			= 0.4
SWEP.Primary.DefaultClip 	= 8
SWEP.Primary.NumShots 		= 8
SWEP.Primary.Cone 			= 0.05
SWEP.Primary.Damage 		= 2
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "buckshot"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.RMod					= 1
SWEP.Zoom					= 0
SWEP.RRise					= 0	--Correct for rise during recoil for RMod.
SWEP.RSlide					= 0.002	--Correct for left/right movement during recoil for RMod.
SWEP.IronSightsPos 			= Vector(-4.301, -7.035, 2.72)
SWEP.IronSightsAng 			= Vector(0.535, 0, 0)
SWEP.FireSelect				= 0
SWEP.DistantSound			= "shotty.mp3"
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_xm1014"
SWEP.WMOffsetPos			= { up = -3, right = 1, forward = 9 }
SWEP.WMOffsetAng			= { up = 0, right = 80, forward = 178 }
SWEP.StatTrak				= true