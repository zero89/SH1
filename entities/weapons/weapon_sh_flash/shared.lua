local GRENADE_COOK_TIME = 2

if SERVER then
	AddCSLuaFile ("shared.lua")
	SWEP.Weight 			= 1
	SWEP.AutoSwitchTo 		= false
	SWEP.AutoSwitchFrom 	= false
end

if CLIENT then
	
	SWEP.DrawAmmo 			= true
	SWEP.DrawCrosshair 		= false
	SWEP.ViewModelFOV		= 65
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false

	SWEP.IconLetter 		= "P"
	killicon.AddFont( "weapon_sh_flash", "CSKillIcons", SWEP.IconLetter, Color(200, 200, 200, 255))
end

SWEP.PrintName 				= "FLASH GRENADE"
SWEP.Instructions 			= "Stun grenades are used to confuse, disorient, \nor distract a potential threat. \nA stun grenade can seriously degrade the \ncombat effectiveness of affected personnel \nfor up to a minute. \n\nLeft click to throw your grenade on a long distance \nRight click to throw your grenade on a short distance"

SWEP.Base 					= "weapon_sh_grenade"

SWEP.Contact 				= ""
SWEP.Purpose 				= ""

SWEP.Spawnable 				= false
SWEP.AdminSpawnable 		= false

SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_flash.mdl" 
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_flash.mdl"

SWEP.ThrowForce					= 2000

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= 1
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "grenade"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= true
SWEP.Secondary.Ammo 		= "none"

SWEP.GrenadeClass			= "sent_flashgrenade"
SWEP.Cookable				= true
SWEP.CookableDamage			= true
SWEP.UseHands				= true

// SWEP.DefaultMaterial			= "materials/models/weapons/csgo/m84_flashbang_grenade.vtf"