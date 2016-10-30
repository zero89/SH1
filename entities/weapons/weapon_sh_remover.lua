AddCSLuaFile()

SWEP.PrintName				= "Prop Remover"
SWEP.Base					= "weapon_base"
SWEP.ViewModelFOV			= 80
SWEP.Slot					= 3
SWEP.SlotPos				= 1
SWEP.UseHands				= true
SWEP.Spawnable				= false
SWEP.ViewModel				= "models/weapons/c_toolgun.mdl"
SWEP.WorldModel				= "models/weapons/w_toolgun.mdl"
SWEP.AnimPrefix				= "python"
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= true
SWEP.ViewModelFlip			= false
SWEP.Primary.Sound			= Sound("Airboat.FireGunRevDown")
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 1
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.15
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipMax		= -1

function SWEP:OwnerChanged()

end

function SWEP:DoShootEffect( hitpos, hitnormal, entity, physbone, bFirstTimePredicted )

	self.Weapon:EmitSound(self.Primary.Sound)
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 	-- View model animation
	
	-- There's a bug with the model that's causing a muzzle to 
	-- appear on everyone's screen when we fire this animation. 
	self.Owner:SetAnimation( PLAYER_ATTACK1 )			-- 3rd Person Animation
	
	if ( !bFirstTimePredicted ) then return end
	
	local effectdata = EffectData()
		effectdata:SetOrigin( hitpos )
		effectdata:SetNormal( hitnormal )
		effectdata:SetEntity( entity )
		effectdata:SetAttachment( physbone )
	util.Effect( "selection_indicator", effectdata )	
	
	local effectdata = EffectData()
		effectdata:SetOrigin( hitpos )
		effectdata:SetStart( self.Owner:GetShootPos() )
		effectdata:SetAttachment( 1 )
		effectdata:SetEntity( self.Weapon )
	util.Effect( "ToolTracer", effectdata )
	
end

function SWEP:DoRemoveEntity(Entity)

	if (!Entity) then return false end
	if (!Entity:IsValid()) then return false end
	if (Entity:IsPlayer()) then return false end

	// Nothing for the client to do here
	if ( CLIENT ) then return true end

	// Remove all constraints (this stops ropes from hanging around)
	constraint.RemoveAll( Entity )
	
	// Remove it properly in 1 second
	timer.Simple( 1, function() if IsValid( Entity ) then Entity:Remove() end end )
	
	// Make it non solid
	Entity:SetNotSolid( true )
	Entity:SetMoveType( MOVETYPE_NONE )
	Entity:SetNoDraw( true )
	
	// Send Effect
	local ed = EffectData()
		ed:SetEntity( Entity )
	util.Effect( "entity_remove", ed, true, true )
	
	return true

end

function SWEP:PrimaryAttack()

	//This is where shit happens.
	
	local ply 	= self.Owner
	local pos	= ply:GetShootPos()
	local trace = util.TraceLine({start=pos,endpos=pos+500*ply:GetAimVector(),mask=bit.bor(CONTENTS_SOLID,CONTENTS_MOVEABLE,CONTENTS_MONSTER,CONTENTS_WINDOW,CONTENTS_DEBRIS,CONTENTS_GRATE,CONTENTS_AUX),filter=ply})

	if(!trace.Entity) then return end
	if(!trace.Entity:IsValid()) then return end
	if(trace.Entity:IsPlayer()) then return end
	

	self:DoShootEffect(trace.HitPos, trace.HitNormal, trace.Entity, trace.PhysicsBone, IsFirstTimePredicted())
	
	// Client can bail out now.
	if (CLIENT) then return true end
	
	local ConstrainedEntities 	= constraint.GetAllConstrainedEntities(trace.Entity)
	local Count 				= 0
	
	for _, Entity in pairs( ConstrainedEntities ) do
	
		if(self:DoRemoveEntity(Entity)) then
			Count = Count + 1
		end

	end
	
end

function SWEP:SecondaryAttack()
	//nope.exe
end

function SWEP:Reload()

	if(SERVER) then
	
		SHTOOLS:GiveToolGunBack(self.Owner)
	
	end

	return //reload? haha

end

function SWEP:Deploy()
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:DrawHUD()

	draw.SimpleTextOutlined("You are using the admin tool. Press [R] to bring back the tool gun", "Core_MainFont_40", ScrW() / 2, ScrH() - 300, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))

end