if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	
	SWEP.IconLetter 		= "f"
	SWEP.ViewModelFlip		= false
	SWEP.ViewModelFOV		= 55

	killicon.AddFont("weapon_sh_deagle", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "R8 Revolver"
SWEP.MuzzleAttachment		= "1" 
SWEP.MuzzleEffect			= "rifle"
SWEP.Base 					= "weapon_sh_base_pistol"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_revolver.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_revolver.mdl"
SWEP.Primary.Sound 			= Sound("weapons/tfa_csgo/revolver/revolver-1_01.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Damage 		= 20
SWEP.Primary.NumShots 		= 1
SWEP.Primary.ClipSize 		= 8
SWEP.Primary.Delay 			= 0.40
SWEP.Primary.DefaultClip 	= 32
SWEP.Primary.Cone 			= 0.0052
SWEP.Primary.Recoil 		= 0.80
SWEP.RRise					= 0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "pistol"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.IronSightsPos 			= Vector(-3.71, -5.628, 0.59)
SWEP.IronSightsAng 			= Vector(0.68, 0.30, 0)
SWEP.DistantSound			= "deagle.mp3"
SWEP.SlideLockPos			= Vector(0,0,-1.5)
SWEP.DotVis					= -1
SWEP.WeaponSkin				= "weapon_r8"
SWEP.UseHands				= true
SWEP.ModelRunAnglePreset	= 3
SWEP.WMOffsetPos			= { up = -3, right = 0.8, forward = 8 }
SWEP.WMOffsetAng			= { up = 3, right = 0, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = {
}