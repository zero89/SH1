if (SERVER) then
	AddCSLuaFile("shared.lua")

elseif (CLIENT) then
	SWEP.DrawAmmo			= true
	
	SWEP.IconLetter 		= "x"

	killicon.AddFont("weapon_sh_bizon", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "PP-Bizon"
SWEP.HoldType				= "smg"
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Slot					= 0
SWEP.Base					= "weapon_sh_base"
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_bizon.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_bizon.mdl"
SWEP.ViewModelFOV			= 50
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_bizon"
SWEP.Primary.Sound			= Sound("csgo/bizon/bizon-1.wav")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 8
SWEP.Primary.Cone			= 0.05
SWEP.Primary.ClipSize		= 64
SWEP.Primary.Delay			= 0.08
SWEP.Primary.DefaultClip	= 192
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.IronSightsPos			= Vector(-5.085, -7.639, 0.799)
SWEP.IronSightsAng			= Vector(0.72, -0.02, 0)
SWEP.ShouldZoom				= false
SWEP.ZoomFOV				= 35
SWEP.ZoomFOVScale			= 0.56
SWEP.WMOffsetPos			= { up = -4.5, right = 0.5, forward = 9}
SWEP.WMOffsetAng			= { up = 0, right = 78, forward = 178 }
SWEP.StatTrak				= true

SWEP.VElements = 
{
	["suppressor"] = 
	{ 
		type = "Model", 
		model = "models/weapons/suppressor.mdl",  
		bone = "v_weapon.bizon_Parent", 
		pos = Vector(0, -3.15, 17), 
		angle = Angle(-90,0,0), 
		size = 0.7, 
		color = Color(255, 255, 255, 255), 
		surpresslightning = false, 
		skin = 0, 
		bodygroup = {} 
	},
	["rds"] =
	{ 
		type = "Model", 
		model = "models/weapons/rds.mdl", 
		bone = "v_weapon.bizon_Parent", 
		pos = Vector(0.00, -3.85, 8.50), 
		angle = Angle(-90,90,0), 
		size = 0.60, 
		color = Color(255, 255, 255, 255), 
		surpresslightning = false, 
		skin = 0, 
		bodygroup = {},
		AuxIronSightsPos = Vector(-5.10, -9.664, -0.20),
		AuxIronSightsAng = Vector(1.4, 0, 0)
	}
}