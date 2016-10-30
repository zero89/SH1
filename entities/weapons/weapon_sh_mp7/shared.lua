if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	SWEP.DrawAmmo			= true
	
	SWEP.IconLetter 		= "d"

	killicon.AddFont("weapon_sh_mp7", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "MP7"
SWEP.HoldType				= "smg"
SWEP.PrintName				= "MP7"
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Slot					= 1
SWEP.Base					= "weapon_sh_base"
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_mp7.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_mp7.mdl"
SWEP.ViewModelFOV			= 50
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_mp7"
SWEP.Primary.Sound			= Sound("csgo/mp7/mp7-1.wav")
SWEP.Primary.Recoil			= 0.2
SWEP.Primary.Damage			= 6
SWEP.Primary.Cone			= 0.01
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.08
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.IronSightsPos			= Vector(-5.28, -11.256, 0.96)
SWEP.IronSightsAng			= Vector(-0.25, 0.1, -0.704)
SWEP.ShouldZoom				= false
SWEP.ZoomFOV				= 35
SWEP.ZoomFOVScale			= 0.56
SWEP.WMOffsetPos			= { up = -1.6, right = 1, forward = 6.3 }
SWEP.WMOffsetAng			= { up = 0, right = -9, forward = 180 }
SWEP.StatTrak				= true