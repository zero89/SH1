if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	SWEP.DrawAmmo			= true
	
	SWEP.IconLetter 		= "m"

	killicon.AddFont("weapon_sh_p90", "CSKillIcons", SWEP.IconLetter,Color(200, 200, 200, 255))
end

SWEP.HoldType				= "rpg"
SWEP.PrintName 				= "FN P90"
SWEP.MuzzleEffect			= "pistol"
SWEP.ShellEffect			= "rg_shelleject_rifle" 
SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "2" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_p90.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_p90.mdl"
SWEP.Primary.Sound 			= Sound("csgo/p90/p90-1.wav")
SWEP.SuppressedSound 		= Sound( "weapons/suppressed_p90.wav")
SWEP.ViewModelFOV			= 65
SWEP.Primary.Recoil 		= 0.3
SWEP.Primary.Damage 		= 7
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.006
SWEP.Primary.ClipSize 		= 50
SWEP.Primary.Delay 			= 0.080
SWEP.Primary.DefaultClip 	= 50
SWEP.Primary.Automatic 		= true
SWEP.SMG					= true
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Primary.Ammo 			= "smg1"
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"
SWEP.RRise					= 0.005
SWEP.IronSightsPos 			= Vector(-5.16, -13.065, -0.32)
SWEP.IronSightsAng 			= Vector(-0.201, 0.173, 0.703)
SWEP.DistantSound			= "p90.mp3"
SWEP.IronPos				= Vector(0.1, 5.3, 3.82)
SWEP.IronAng				= Angle(0, 0, 90)
SWEP.IronFrontPos			= Vector(0, 0, -1.1)
SWEP.WMOffsetPos			= { up = -3.5, right = 1.5, forward = 5 }
SWEP.WMOffsetAng			= { up = 3, right = 70, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/suppressor.mdl",  
		bone 				= "v_weapon.p90_Parent", 
		pos 				= Vector(-0.1, -2.8, 7.25), 
		angle 				= Angle(-90, -90, 0), 
		size 				= 0.75, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	},
	["m145"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/m145.mdl",
		bone 				= "v_weapon.p90_Parent", 
		pos 				= Vector(0, -6.90, 3), 
		angle 				= Angle(0, 180, 0), 
		size 				= 0.5, 
		color 				= Color(255, 255, 255, 255), 
		surpresslightning 	= false, 
		AuxIronSightsPos 	= Vector(-5.10, -13.065, -1.10),
		AuxIronSightsAng 	= Vector(-0.201, 0.173, 0.703),
		skin 				= 0, 
		bodygroup 			= {} 
	},
	["rds"] = 
	{ 
		type 				= "Model", 
		model 				= "models/weapons/rds.mdl", 
		bone 				= "v_weapon.p90_Parent", 
		pos 				= Vector(0, -5, 4), 
		angle 				= Angle(-90, 90, 0), 
		size 				= 0.58,
		color 				= Color(255, 255, 255, 255), 
		AuxIronSightsPos 	= Vector(-5.10, -13.065, -1),
		AuxIronSightsAng 	= Vector(0.65, 0.173, 0.703),
		surpresslightning 	= false, 
		skin 				= 0, 
		bodygroup 			= {} 
	}
}