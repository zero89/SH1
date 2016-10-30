if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "shotgun"
elseif (CLIENT) then
	SWEP.PrintName 		= "Nova"
	SWEP.IconLetter 	= "k"
	SWEP.ViewModelFlip	= false

	killicon.AddFont("weapon_sh_pumpshotgun", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "Nova"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_nova.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_nova.mdl"
SWEP.Primary.Sound 			= Sound("csgo/nova/nova-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 0.7
SWEP.Primary.Damage 		= 3
SWEP.Primary.NumShots 		= 8
SWEP.Primary.Cone 			= 0.08
SWEP.Primary.ClipSize 		= 8
SWEP.Primary.Delay 			= 0.90
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
SWEP.IronSightsPos 			= Vector(-4.27, -6.061, 2.677)
SWEP.IronSightsAng 			= Vector(-0.216, 0, 0)
SWEP.DistantSound			= "shotty.mp3"
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_nova"
SWEP.WMOffsetPos			= { up = -3, right = 1, forward = 9 }
SWEP.WMOffsetAng			= { up = 0, right = 80, forward = 178 }
SWEP.RedDotSight			= false
SWEP.StatTrak				= true
SWEP.VElements =
{
	["suppressor"] = 
	{ 
		type 					= "Model", 
		model 					= "models/weapons/suppressor.mdl",  
		bone 					= "v_weapon.nova_parent", 
		pos 					= Vector(0, -1.65, 28.5), 
		angle 					= Angle(-90, 0, 0), 
		size 					= 0.8,
		color 					= Color(255, 255, 255, 255),
		surpresslightning 		= false, 
		skin 					= 0, 
		bodygroup 				= {} 
	}
}