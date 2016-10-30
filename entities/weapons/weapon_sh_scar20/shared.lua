if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "i"
	SWEP.ViewModelFlip		= false

	killicon.AddFont("weapon_sh_scar20", "CSKillIcons", SWEP.IconLetter,Color(200, 200, 200, 255) )
end

SWEP.PrintName 				= "SCAR-20"
SWEP.MuzzleEffect			= "sniper"
SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "2" 
SWEP.Base 					= "weapon_sh_sniperbase"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_scar20.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_scar20.mdl"
SWEP.Primary.Sound			= Sound("csgo/scar20/scar20_unsil-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 16
SWEP.Primary.Recoil 		= 0.8
SWEP.Primary.Cone 			= 0.002
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 20
SWEP.Primary.Delay 			= .30
SWEP.Primary.DefaultClip 	= 20
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "ar2"
SWEP.IronSightZoom			= 4
SWEP.DrawParabolicSights	= false	
SWEP.IronSightsPos 			= Vector(-5.04, -5.683, -7)
SWEP.IronSightsAng 			= Vector(0, 0, 0)
SWEP.DistantSound			= "g3sg1.mp3"
SWEP.WeaponSkin				= "weapon_scar20"
SWEP.UseHands				= true
SWEP.BuiltInScope			= true
SWEP.WMOffsetPos			= { up = -4, right = 0.8, forward = 8 }
SWEP.WMOffsetAng			= { up = 3, right = 0, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
}