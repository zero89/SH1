if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType 		= "shotgun"
elseif (CLIENT) then
	
	SWEP.IconLetter 	= "k"
	SWEP.Slot 			= 1
	SWEP.ViewModelFlip	= false
	killicon.AddFont("weapon_sh_pumpshotgun2", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "Nova"
SWEP.MuzzleAttachment		= "1" 
SWEP.Base 					= "weapon_sh_base"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
SWEP.ViewModel 				= "models/weapons/c_csgo_nova.mdl"
SWEP.WorldModel 			= "models/weapons/csgo_world/w_shot_nova.mdl"
SWEP.Primary.Sound 			= Sound("csgo/nova/nova-1.wav")
SWEP.ViewModelFOV			= 60
SWEP.Primary.Recoil 		= 5
SWEP.Primary.Damage 		= 7
SWEP.Primary.NumShots 		= 9
SWEP.Primary.Cone 			= 0.05
SWEP.Primary.ClipSize 		= 8
SWEP.Primary.Delay 			= 0.75
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
SWEP.IronSightsPos 			= Vector(-4.54, -4.935, 2.659)
SWEP.IronSightsAng 			= Vector(-1.127, 1.434, 0)
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_nova"

RegisterSWEPSound("Weapon_Cnova.Draw", "csgo/nova/nova_draw.wav")
RegisterSWEPSound("Weapon_Cnova.InsertShell", "csgo/nova/nova_insertshell.wav")
RegisterSWEPSound("Weapon_Cnova.Pump", "csgo/nova/nova_pump.wav")
RegisterSWEPSound("Weapon_Cnova.PumpDuringShot", "csgo/nova/nova_pump.wav")