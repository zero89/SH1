AddCSLuaFile()

SWEP.HoldType				= "duel"
SWEP.PrintName				= "Dual Berettas"
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.Slot					= 1
SWEP.Base					= "weapon_corebase"
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_elite.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_elite.mdl"
SWEP.ViewModelFOV			= 70
SWEP.UseHands				= true
SWEP.WeaponSkin				= "weapon_elite"
SWEP.Primary.Sound			= Sound("csgo/elite/elite-1.wav")
SWEP.Primary.Recoil			= 0.4
SWEP.Primary.Damage			= 8
SWEP.Primary.Cone			= 0.05
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.125
SWEP.Primary.DefaultClip	= 52
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "smg1"
SWEP.IronSightsPos			= Vector(-5.2, 0, 4.25)
SWEP.IronSightsAng			= Vector(-2.8, -5.3, 0)
SWEP.ShouldZoom				= false
SWEP.ZoomFOV				= 35
SWEP.ZoomFOVScale			= 0.56
SWEP.RunArmOffset 			= Vector(2.723, -12.035, -10.660)
SWEP.RunArmAngle 			= Vector(70, 0, 0)
SWEP.WMOffsetPos			= { up = -2, right = 0.8, forward = 4.5 }
SWEP.WMOffsetAng			= { up = 3, right = 90, forward = 178 }
SWEP.SprintEnabled			= false
SWEP.IconLetter				= "s"
SWEP.ADSEnabled				= false
SWEP.DoneFirstGun			= false

function SWEP:PrimaryAttack()

	if not IsFirstTimePredicted() then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	
	if not self:CanPrimaryAttack() then return end
	
	self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel)
	
	self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone())
	
	self:TakePrimaryAmmo(1)
	
	if not self.DoneFirstGun then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.DoneFirstGun = true
	else
		self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		self.DoneFirstGun = false
	end
	
	if(self:Clip1() <= 0) then
		self:Reload()
	end
	
	local owner = self.Owner
	
	if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end
	
	owner:ViewPunch(Angle(math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0))


end

function SWEP:SecondaryAttack()

	/*self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	
	if not self:CanSecondaryAttack() then return end
	
	self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel)
	
	self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone())
	
	self:TakePrimaryAmmo(1)
	
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	
	if(self:Clip1() <= 0) then
		self:Reload()
	end
	
	local owner = self.Owner
	
	if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end
	
	owner:ViewPunch(Angle(math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0))*/

end

if(CLIENT) then
	killicon.AddFont("weapon_elite", "Core_CSD", "s", Color(255, 255, 255))
end