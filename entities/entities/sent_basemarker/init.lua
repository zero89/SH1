AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos
	local ent = ents.Create( "sent_basemarker" )
	
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply
	
	return ent
end

function ENT:Initialize()
	self.Created = CurTime()

	self:SetModel( "models/props_combine/combine_light001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then
		phys:SetMass( 15 )
	end
end

function ENT:Think()
	local hp = self:Health()
	local hpmax = self:GetMaxHealth()
	local c = 255 * (hp / hpmax)
	self:SetHealth(math.Clamp(hp + 1,1,hpmax))
	self:SetColor( Color(c,c,c,255) )
end

