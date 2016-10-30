-- This script and all files associated with it and the name 'StraySwordsman' are protected by copyright infringement laws.
--   Paranoia Instinctive ®2013 StraySwordsman 2012®
--   You must ask the permission of StraySwordsman for use of this script.
--   By using this script with my permission, you acknowledge that I may take your permission back at any time rendering you to be unable to use it.
-- Let the script begin.

-- Some edits by Render.
if SERVER then
	AddCSLuaFile ( "shared.lua" )
end

if CLIENT then
	SWEP.Slot	   = 0
	SWEP.SlotPos   = 1
	SWEP.ViewModelFOV = 72
	SWEP.ViewModelFlip = false -- true = right hand holds gun
	SWEP.DrawCrosshair = false		-- set false if you want no crosshair
end

SWEP.Base 		= "weapon_base"
SWEP.PrintName 	= "RPG"
---Standard GMod Values, feel free to add more
SWEP.HoldType			= "rpg"
SWEP.Category 			= "RPG"
SWEP.Primary.Delay		= 0.45
SWEP.Primary.Recoil		= 20
SWEP.Primary.Automatic	= false
SWEP.Primary.Damage		= 0
SWEP.Primary.Cone		= 0.02
SWEP.Primary.Ammo		= "RPG_Round"
SWEP.HeadshotMultiplier = 1
SWEP.AutoSwitchTo		= true
SWEP.DrawCrosshair 		= false
SWEP.Spawnable 			= true -- Whether regular players can see it
SWEP.AdminSpawnable 	= true -- Whether Admins/Super Admins can see it

-- Ammo: How to:
SWEP.Primary.Empty			= Sound( "Weapon_Shotgun.Empty" )
SWEP.Primary.ClipSize 		= 1
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.ClipMax 		= 3
SWEP.Primary.Round 			= ("sent_rocket") -- This is the entity that's created upon fire.
SWEP.Primary.RPM 			= 14.2 -- Rounds per minute
SWEP.IronSightsPos			= Vector(-7.778, -7.24, -3)
SWEP.IronSightsAng			= Vector(2.71, -1.8, -3.8)
SWEP.ViewModel  			= "models/weapons/rend_rpg/v_model/v_rend_rpg.mdl"
SWEP.WorldModel 			= "models/weapons/rend_rpg/w_model/w_rend_rpg.mdl"
-- Custom input functions --

function SWEP:OnRemove() -- Removes timer on weapon removal (IE. Round restart.)
	timer.Destroy("rpgIdle")
end

function SWEP:Idle() -- Timer function for idle.
local rpg_vm = self.Owner:GetViewModel()
	if IsValid(self.Owner) then
	timer.Destroy("rpgIdle")
		timer.Create("rpgIdle", 4.5, 0, function()
			self:idleChoose();
		end)
	else
		timer.Destroy("rpgIdle")
	end
end

function SWEP:idleChoose() -- Check ammo, chooses Idle animation.
	if IsValid(self.Owner) then
	local rpg_vm = self.Owner:GetViewModel()
		if self.Owner:GetActiveWeapon():Clip1() == 0 then 
			rpg_vm:SetSequence(rpg_vm:LookupSequence("idle_empty")) 
		end
		if self.Owner:GetActiveWeapon():Clip1() > 0 then 
			rpg_vm:SetSequence(rpg_vm:LookupSequence("idle")) 
		end
	else
		timer.Destroy("rpgIdle")
	end
end

function SWEP:PrimaryAttack() -- Attack hook.
	if self:CanPrimaryAttack() and not self.Owner:KeyPressed(IN_SPEED) then
		timer.Destroy("rpgIdle"); -- Kills timer to stop it from calling idle animation in the middle of fire anim.
		local rpg_vm = self.Owner:GetViewModel()
		local pos2 = self.Owner:GetShootPos()
		self:FireRocket()
		self.Weapon:EmitSound("weapons/rpg/ren_rpg_fire.wav")
		util.ScreenShake(pos2, 10, 2, 0.1, 200)
		self.Weapon:TakePrimaryAmmo(1)
		rpg_vm:SetSequence(rpg_vm:LookupSequence("shoot1"))
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self.Owner:MuzzleFlash()
		self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/70))
		self:Idle() -- Runs timer for idle anims.
	end
end

function SWEP:FireRocket() -- Rocket spawn function, refers to outside lua ent (self.primary.round).
	local aim = self.Owner:GetAimVector()
	local side = aim:Cross(Vector(0,0,1))
	local up = side:Cross(aim)
	local pos = self.Owner:GetShootPos() + side * 6 + up * -5
	
if SERVER then
	local rocket = ents.Create(self.Primary.Round)
		if !rocket:IsValid() then return false end
		rocket:SetAngles(aim:Angle()+Angle(0,0,0))
		rocket:SetPos(pos)
		rocket:SetOwner(self.Owner)
		rocket:Spawn()
		rocket:Activate()
	end
end

--function SWEP:SecondaryAttack()	
--end
--function SWEP:SecondaryAttack() -- Ironsight function.
--	if not self.IronSightsPos then return end
--	if self.Weapon:GetNextSecondaryFire() > CurTime() then return end	
--	bIronsights = not self:GetIronsights()	
--	self:SetIronsights( bIronsights )	
--	self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
--end

function SWEP:PreDrop() -- Remove ironsights before drop.
	self:SetIronsights(false, self.Owner)	
	return self.BaseClass.PreDrop(self)
end

function SWEP:Reload() -- Checks ammo and clip before reloading.
	if self.Owner:GetAmmoCount(self.Primary.Ammo) != 0 && self.Owner:GetActiveWeapon():Clip1() != 1 then
		timer.Destroy("rpgIdle");
		local rpg_vm = self.Owner:GetViewModel()
		self.Weapon:DefaultReload( ACT_VM_RELOAD )
		self.Weapon:EmitSound("weapons/rpg/ren_rpg_reload.wav")
		rpg_vm:SetSequence(rpg_vm:LookupSequence("reload"))
		self:SetIronsights(false, self.Owner)
		self:Idle()
	end	
end

function SWEP:Deploy() -- Checks ammo and clip to choose draw sequence.
	self:SetHoldType("rpg")
	local rpg_vm = self.Owner:GetViewModel()
	self.Weapon:SetNextPrimaryFire(CurTime() + 1.7)
	self:SetIronsights(false, self.Owner)
	self.Weapon:EmitSound("weapons/rpg/ren_rpg_draw.wav")	
	self:Idle()
		if self.Owner:GetActiveWeapon():Clip1() == 0 then
			rpg_vm:SetPlaybackRate( 0.84 )
			rpg_vm:SetSequence(rpg_vm:LookupSequence("draw_empty"))
		end
		if self.Owner:GetActiveWeapon():Clip1() > 0 then
			rpg_vm:SetPlaybackRate( 0.84 )
			rpg_vm:SetSequence(rpg_vm:LookupSequence("draw"))
		end
	return true
end

function SWEP:Holster() -- Kills idle function timer to stop it from malfunctioning when swapping weapon quickly.
	self:SetIronsights(false, self.Owner)
	timer.Destroy("rpgIdle");
	return true
end

local IRONSIGHT_TIME = 0.25

/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end


/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )

	self.Weapon:SetNetworkedBool( "Ironsights", b )

end


SWEP.NextSecondaryAttack = 0
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	bIronsights = !self.Weapon:GetNetworkedBool( "Ironsights", false )
	
	self:SetIronsights( bIronsights )
	
	self.NextSecondaryAttack = CurTime() + 0.3
	
end

/*---------------------------------------------------------
	DrawHUD
	
	Just a rough mock up showing how to draw your own crosshair.
	
---------------------------------------------------------*/


/*---------------------------------------------------------
	onRestore
	Loaded a saved game (or changelevel)
---------------------------------------------------------*/
function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	self:SetIronsights( false )
	
end




