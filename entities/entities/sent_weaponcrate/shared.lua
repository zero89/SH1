--[[
	Changes

	TehBigA - 10/23/12:
		Standardized owner information - No longer uses ENT.SteamID and uses ENT:<Get/Set>Owner<Ent/UID>
]]

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Weapon Crate"
ENT.Author			= "RoaringCow"

ENT.Spawnable			= false
ENT.AdminSpawnable		= false
ENT.AutomaticFrameAdvance = true 

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

ENT.OpenSnd = Sound( "AmmoCrate.Open" )
ENT.CloseSnd = Sound( "AmmoCrate.Close" )

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos
	local ent = ents.Create( "sent_weaponcrate" )
	
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply
	if !ply.WeaponCrate then ply.WeaponCrate = {} end
	ply.WeaponCrate[self:EntIndex()] = self
	
	
	return ent
end

function ENT:Initialize(ply)
	self.Created = CurTime()

	self:SetModel( "models/items/ammocrate_smg2.mdl" )
	self:SetSolid( SOLID_BBOX )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_NONE )
	if CLIENT then
		if true then return end
		-- This is broken, wtf
	
		local wmodel = ClientsideModel( "models/weapons/w_pist_glock18.mdl" )
		--wmodel:SetModel( "models/weapons/w_pist_glock18.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(1,-20,0) )
		wmodel:SetLocalAngles( Angle(0,180,90) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_pist_p228.mdl" )
		--wmodel:SetModel( "models/weapons/w_pist_p228.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(-12,-20,0) )
		wmodel:SetLocalAngles( Angle(0,0,90) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_pist_deagle.mdl" )
		--wmodel:SetModel( "models/weapons/w_pist_deagle.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(0,-17,0) )
		wmodel:SetLocalAngles( Angle(0,20,90) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_pist_elite_single.mdl" )
		--wmodel:SetModel( "models/weapons/w_pist_elite_single.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(13,-12,0) )
		wmodel:SetLocalAngles( Angle(0,200,90) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_smg_ump45.mdl" )
		--wmodel:SetModel( "models/weapons/w_smg_ump45.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(5,-25,5) )
		wmodel:SetLocalAngles( Angle(10,-180,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_smg_p90.mdl" )
		--wmodel:SetModel( "models/weapons/w_smg_p90.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(6,-22,5) )
		wmodel:SetLocalAngles( Angle(10,-180,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_smg_tmp.mdl" )
		--wmodel:SetModel( "models/weapons/w_smg_tmp.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(15,-21,5) )
		wmodel:SetLocalAngles( Angle(10,-180,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_smg_mac10.mdl" )
		--wmodel:SetModel( "models/weapons/w_smg_mac10.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(15,-19,5) )
		wmodel:SetLocalAngles( Angle(10,-180,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()


	--rifles
		local wmodel = ClientsideModel( "models/weapons/w_snip_awp.mdl" )
		--wmodel:SetModel( "models/weapons/w_snip_awp.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(-16,16,5) )
		wmodel:SetLocalAngles( Angle(10,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_snip_g3sg1.mdl" )
		--wmodel:SetModel( "models/weapons/w_snip_g3sg1.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(-11,16,5) )
		wmodel:SetLocalAngles( Angle(10,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_snip_sg550.mdl" )
		--wmodel:SetModel( "models/weapons/w_snip_sg550.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(-9,18,5) )
		wmodel:SetLocalAngles( Angle(10,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_rif_galil.mdl" )
		--wmodel:SetModel( "models/weapons/w_rif_galil.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(-7,18,5) )
		wmodel:SetLocalAngles( Angle(10,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_shot_xm1014.mdl" )
		--wmodel:SetModel( "models/weapons/w_shot_xm1014.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(-5,18,5) )
		wmodel:SetLocalAngles( Angle(10,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_shot_m3super90.mdl" )
		--wmodel:SetModel( "models/weapons/w_shot_m3super90.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(-2,18,5) )
		wmodel:SetLocalAngles( Angle(10,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_snip_scout.mdl" )
		--wmodel:SetModel( "models/weapons/w_snip_scout.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(-1,18,5) )
		wmodel:SetLocalAngles( Angle(10,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_smg_mp5.mdl" )
		--wmodel:SetModel( "models/weapons/w_smg_mp5.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(2,18,2) )
		wmodel:SetLocalAngles( Angle(10,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_rif_ak47.mdl" )
		--wmodel:SetModel( "models/weapons/w_rif_ak47.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(5,18,5) )
		wmodel:SetLocalAngles( Angle(5,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_rif_m4a1.mdl" )
		--wmodel:SetModel( "models/weapons/w_rif_m4a1.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(7,18,5) )
		wmodel:SetLocalAngles( Angle(5,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_rif_aug.mdl" )
		--wmodel:SetModel( "models/weapons/w_rif_aug.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(10,17,5) )
		wmodel:SetLocalAngles( Angle(5,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()

		local wmodel = ClientsideModel( "models/weapons/w_rif_sg552.mdl" )
		--wmodel:SetModel( "models/weapons/w_rif_sg552.mdl" )
		wmodel:SetParent( self )
		wmodel:SetLocalPos( Vector(14,17,5) )
		wmodel:SetLocalAngles( Angle(5,-90,0) )
		--wmodel:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		--wmodel:Spawn()
	elseif SERVER then
		local physobj = self:GetPhysicsObject()
		if IsValid( physobj ) then
			physobj:Wake()
			physobj:EnableMotion( false )
		end
		
		self.PlayerLeft = 0
	end
end

function ENT:Use( activator, caller )
	if IsValid( activator ) and activator:IsPlayer() and activator.WeaponLoadout != true then
		local trace = activator:GetEyeTrace()
		if trace.Entity != self or (trace.StartPos-trace.HitPos):Length() > 50 then return end
	
		activator.WeaponLoadout = true
		activator:ConCommand( "sh_loadout" )
		self:Open( ent )
		self.activator = activator
	end
end

function ENT:Open( ply )
	self:ResetSequence(self:LookupSequence( "Open" ))
	if self.Closed then
		self:EmitSound( self.OpenSnd )
	end
	self.Closed = false
end

function ENT:Close()
	if self.Closed or !IsValid( self.activator ) then return end
	local trace = self.activator:GetEyeTrace()
	if trace.Entity != self or (trace.StartPos-trace.HitPos):Length() > 50 then
		self:ResetSequence(self:LookupSequence( "Close" ))
		timer.Simple( 0.5, function() if not IsValid( self ) then return end self:EmitSound( self.CloseSnd ) end )
		self.Closed = true
		self.activator = nil
	end
end

function ENT:Think()
	self:Close()
	
	if SERVER then
		local ply = self.Owner
		if !IsValid( ply ) and self:GetOwnerUID() != nil then
			if self.PlayerLeft == 0 then
				self.PlayerLeft = CurTime()
			elseif CurTime() - self.PlayerLeft > 120 then
				self:Remove()
			end
			return
		end
	end
	self:NextThink(CurTime());  return true; 
end