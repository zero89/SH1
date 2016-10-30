--[[-------------------------------------------------------

Fight to Survive: Stronghold by RoaringCow, TehBigA is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License. 
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, 
444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

---------------------------------------------------------]]

--[[
	GM13 Changes

	UNKNOWN - UNKNOWN:
		usermessage - > net
		datastream - > net
		Fixed Timers
		Cleaned Code
	
	TehBigA - 10/23/12:
		Fixed returning props and entities to players on reconnect
		Added prop deletion after 120 seconds of disconnect
		Player hull adjusted to 48 high when ducking - Fixes head clipping bug
]]

local function PlayerCountInSphere( pos, radius, ignore )
	local count = 0

	for _, v in ipairs( ents.FindInSphere(pos, radius) ) do
		if v != ignore and v:GetClass() == "prop_physics" then count = count +1 end
	end

	return count
end

function GM:OnStrongholdProfileLoaded(ply)

	if not ply.UserProfileLoaded then
		ply:Kick("Inventory Services are unavailable. Please reconnect")
		return
	end
	
	local tbl = 
	{
		Items		= ply.UserProfile["sh_items"],
		LastEquip	= ply.UserProfile["sh_lastequip"],
		Licenses	= ply.UserProfile["sh_inventory"],
		Loadouts	= ply.UserProfile["sh_loadouts"]
	}
	
	self:SetupInventory(ply, tbl)

end

hook.Add("MOTDPlayerAccepted", "StrongholdMOTDPlayerAccepted", function(ply) MsgN("MOTD Accepted") GAMEMODE:OnStrongholdProfileLoaded(ply) end)

function GM:SetupInventory(ply, tbl)

	if not tbl.Items then
		tbl.Items = {}
	end

	if(table.Count(tbl.Items) == 0) then
	
		tbl.Items =
		{
			["buckshot"] 	= { type=3, count=1000 },
			["ar2"] 		= { type=3, count=1000 },
			["smg1"] 		= { type=3, count=1000 },
			["pistol"] 		= { type=3, count=1000 },
		}
	
	end
	
	ply.Items 		= tbl.Items
	ply.Loadouts 	= tbl.Loadouts
	ply.Licenses 	= tbl.Licenses
	ply.SoldWeapons	= {}
	
	if ply.Licenses == nil then
		ply.Licenses = {}
	end
	
	if ply.Loadouts == nil then
		ply.Loadouts = {}
	end
	
	if not ply.Licenses[1] then ply.Licenses[1] = {} end
	if not ply.Licenses[2] then ply.Licenses[2] = {} end
	if not ply.Licenses[5] then ply.Licenses[5] = {} end
	
	if not ply.Licenses[1]["weapon_sh_mp5a4"] then
		ply.Licenses[1]["weapon_sh_mp5a4"] = -1
	end
	
	if not ply.Licenses[2]["weapon_sh_p228"] then
		ply.Licenses[2]["weapon_sh_p228"] = -1
	end

	ply:SetLoadoutPrimary(tbl.LastEquip and tbl.LastEquip.primary or "")
	ply:SetLoadoutSecondary(tbl.LastEquip and tbl.LastEquip.secondary or "")
	ply:SetLoadoutExplosive(tbl.LastEquip and tbl.LastEquip.explosive or "")
	
	ply:SetInitialized(INITSTATE_OK)
	
	GAMEMODE.Net:SendClientItems(ply)
	GAMEMODE.Net:SendClientLoadouts(ply)
	GAMEMODE.Net:SendClientLicenses(ply)
	GAMEMODE.Net:BroadcastMarkerUpdate()
	
	ply:ConCommand("sh_loadout")


end

function GM:CreateDefaultInventory(ply)

	ply.Items =
	{
		["buckshot"]	= { type = 3, count = 1000 },
		["ar2"]			= { type = 3, count = 1000 },
		["smg1"]		= { type = 3, count = 1000 },
		["pistol"]		= { type = 3, count = 1000 }
	}
	
	ply.Loadouts = {}
	ply.SoldWeapons = {}
	ply.Licenses = 
	{
		[1] =
		{
			["weapon_sh_mp5a4"] = -1
		},
		[2] =
		{
			["weapon_sh_p228"] = -1
		},
		[5] ={}
	}
	
	ply:SetLoadoutPrimary("weapon_sh_mp5a4")
	ply:SetLoadoutSecondary("weapon_sh_p228")
	ply:SetLoadoutExplosive("")

	ply:SetInitialized(INITSTATE_OK)
	
	GAMEMODE.Net:SendClientItems(ply)
	GAMEMODE.Net:SendClientLoadouts(ply)
	GAMEMODE.Net:SendClientLicenses(ply)
	GAMEMODE.Net:BroadcastMarkerUpdate()
	
	ply:ConCommand("sh_loadout")
	
end

function GM:PlayerInitialSpawn( ply )
	-- Setup player settings
	
	if ply:IsBot() then
		ply:SetInitialized( INITSTATE_OK )
		ply:SetTeam( 50 )
		ply:CheckSpawnpoints()
		ply:SetLastSpawn( CurTime() )
		return
	end
	
	ply:SetTeam( TEAM_UNASSIGNED )
	timer.Simple( 1,
		function()
			if !IsValid( ply ) then return end
			SendTeamsToClient( ply )

			local timelimit = GAMEMODE.ConVars.TimeLimit:GetFloat()
			if timelimit > 0 then GAMEMODE:StartCountDown( (timelimit*60)-(CurTime()-GAMEMODE.LastGameReset), "Timelimit is up in", "", "", ply ) end
		end
	)
		
	-- Give back spawnpoints and ammocrates and shit
	timer.Remove( "Cleanup."..ply:UniqueID() )
	
	local uid = ply:UniqueID()
	for _, v in ipairs(ents.GetAll()) do
		if not IsValid( v ) then continue end

		if v:GetOwnerUID() == uid then
			if v.SetPlayer then v:SetPlayer( ply ) end
			v.Owner = ply
			v.PlayerLeft = 0
			
			v:SetOwnerEnt( ply )
			
			local class = v:GetClass()
			if class == "sent_spawnpoint" then
				if !ply.SpawnPoint then ply.SpawnPoint = {} end
				table.insert( ply.SpawnPoint, v )
				ply:AddCount( "spawnpoints", v )
			elseif class == "prop_physics" then
				ply:AddCount( "props", v )
			elseif class == "sent_weaponcrate" then
				ply:AddCount( "sent_weaponcrate", v )
			end
		end
	end

	ply:CheckSpawnpoints()
	ply:SetLastSpawn( CurTime() )
	
	-- Fix voice channel
	ply:ConCommand( "sh_voice_channel 0" )
	
	ply:SetInitialized(INITSTATE_WAITING)
	
end

GM.HandModels = 
{
	[0] 	= "models/weapons/tfa_csgo/hands/ct_arms.mdl",
	[1] 	= "models/weapons/tfa_csgo/hands/ct_arms_fbi.mdl",
	[2] 	= "models/weapons/tfa_csgo/hands/ct_arms_gign.mdl",
	[3] 	= "models/weapons/tfa_csgo/hands/ct_arms_gsg9.mdl",
	[4] 	= "models/weapons/tfa_csgo/hands/ct_arms_idf.mdl",
	[5]	 	= "models/weapons/tfa_csgo/hands/ct_arms_sas.mdl",
	[6] 	= "models/weapons/tfa_csgo/hands/ct_arms_st6.mdl",
	[7] 	= "models/weapons/tfa_csgo/hands/ct_arms_swat.mdl",
	[8] 	= "models/weapons/tfa_csgo/hands/t_arms.mdl",
	[9] 	= "models/weapons/tfa_csgo/hands/t_arms_anarchist.mdl",
	[10] 	= "models/weapons/tfa_csgo/hands/t_arms_balkan.mdl",
	[11] 	= "models/weapons/tfa_csgo/hands/t_arms_leet.mdl",
	[12] 	= "models/weapons/tfa_csgo/hands/t_arms_phoenix.mdl",
	[13] 	= "models/weapons/tfa_csgo/hands/t_arms_professional.mdl",
	[14] 	= "models/weapons/tfa_csgo/hands/t_arms_separatist.mdl",
}

function GM:PlayerSetHandsModel( ply, ent )


	ent:SetModel(table.Random(self.HandModels))


end

function GM:IsSpawnpointSuitable( ply, spawn, force )
	local pos = spawn:GetPos()
	local dist = (ply:GetPos() - pos):Length()
	
	local blockables = ents.FindInBox( pos + Vector(-32,-32,0), pos + Vector(32,32,72) )
	local count = 0
	for _, v in ipairs(blockables) do
		if IsValid( v ) then
			local class = v:GetClass()
			if class == "player" and v:Alive() then
				count = count + 1
				if force then
					v:GodDisable()
					v:Kill()
				end
			elseif class == "prop_physics" or class == "sent_weaponcrate" then
				v:Remove()
			end
		end
	end

	return force == true or (count == 0 and dist > 1000)
end

local SND_WARPIN = { "items/battery_pickup.wav" } -- Sound("weapons/physcannon/energy_disintegrate4.wav"), Sound("weapons/physcannon/energy_disintegrate5.wav") }
function GM:PlayerSpawn( ply )
	ply:SetHullDuck( Vector(-16,-16,0), Vector(16,16,48) )

	if ply:GetInitialized() != INITSTATE_OK then
		GAMEMODE:PlayerSpawnAsSpectator( ply )
		ply:SetTeam( 50 )
		
		return
	end
	
	local team = ply:Team()
	if (team == TEAM_SPECTATOR or team == TEAM_UNASSIGNED) and !ply:IsBot() then
		GAMEMODE:PlayerSpawnAsSpectator( ply )
		if team == TEAM_UNASSIGNED then
			ply:ConCommand( "sh_loadout" )
			ply:ConCommand( "sh_help" )
			ply:SetTeam( 50 )
		end
		return
	end

	if self.GameOver then
		ply:SetVelocity( Vector(0,0,0) )
		ply:Lock()
		ply:Freeze( true )
		
		GAMEMODE.Net:SendGameOver( ply, self.GameOverTeam, self.GameOverWinner, self.GameOverModels )
	end
	
	ply:Extinguish()

	ply:UnSpectate()
	hook.Call( "PlayerLoadout", GAMEMODE, ply )
	hook.Call( "PlayerSetModel", GAMEMODE, ply )

	ply.spawnpos = ply:GetPos()
	ply.spawnang = ply:GetAngles()
	ply.ents = {}
	GAMEMODE:SetPlayerSpeed( ply, 150, 300 )
	
	ply:SetLastSpawn( CurTime() )
	if not ply:CheckSpawnpoints() then
		local spawnprot = GAMEMODE.ConVars.ImmuneTime:GetInt()
		if spawnprot > 0 then
			ply:SetGod( true )
			ply:GodEnable()
			ply:SetColor( Color(255,255,255,200) )
			ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			timer.Create( "SpawnProt_".. ply:EntIndex(), spawnprot, 1, function()
				if IsValid(ply) then
					ply:SetGod( false )
					ply:GodDisable()
					ply:SetMaterial( "" )
					ply:SetColor( Color(255,255,255,255) )

					GAMEMODE.Net:SendSpawnProtection( ply, false )
				end
			end )
			
			GAMEMODE.Net:SendSpawnProtection( ply, true )
		end
	end
	
	ply:SetViewOffset( Vector(0,0,59) )
	ply:SetViewOffsetDucked( Vector(0,0,40) )
	
	-- Death effects cleanup
	if IsValid( ply.DroppedWeapon ) then
		ply.DroppedWeapon:Remove()
	end
	
	ply:SetupHands()
	
	ply:SetCustomCollisionCheck(true)
	
	GAMEMODE.Net:SendPlayerSpawned( ply )
	
end

function GM:PlayerSetModel( ply )
	local cl_playermodel = string.lower( ply:GetInfo("cl_playermodel") )
	local modelname = self.ValidPlayerModels[cl_playermodel] or self.DefaultPlayerModel
	util.PrecacheModel( modelname )

	if !table.HasValue( self.ValidPlayerModels, modelname ) then
		modelname = self.DefaultPlayerModel
	end
	
	ply:SetModel( modelname )
end

function GM:PlayerLoadout( ply )

	if not ply:Alive() then return end

	if ply:Alive() then
		ply:AddItem( "pistol", ply:GetAmmoCount("pistol") )
		ply:AddItem( "smg1", ply:GetAmmoCount("smg1") )
		ply:AddItem( "buckshot", ply:GetAmmoCount("buckshot") )
		ply:AddItem( "ar2", ply:GetAmmoCount("ar2") )
		ply:AddItem( "rpg_round", ply:GetAmmoCount("rpg_round") )
		
		if ply:GetSpawnedLoadoutExplosive() and ply:GetSpawnedLoadoutExplosive() ~= NULL then
			if IsValid( ply:GetWeapon(ply:GetSpawnedLoadoutExplosive()) ) then
				ply:AddItem( ply:GetSpawnedLoadoutExplosive(), ply:GetAmmoCount("grenade") )
			end
		end
	end
	
	ply:StripWeapons()
	ply:RemoveAllAmmo()

	local pistol 	= math.Clamp( ply:GetItemCount("pistol"), 		0, 50 )
	local smg1 		= math.Clamp( ply:GetItemCount("smg1"), 		0, 100 )
	local buckshot 	= math.Clamp( ply:GetItemCount("buckshot"), 	0, 40 )
	local ar2 		= math.Clamp( ply:GetItemCount("ar2"), 			0, 100 )
	local rpg_round = math.Clamp( ply:GetItemCount("rpg_round"), 	0, 2 )
	
	ply:GiveAmmo( pistol,   	"pistol",   	true )
	ply:GiveAmmo( smg1,     	"smg1",    		true )
	ply:GiveAmmo( buckshot, 	"buckshot", 	true )
	ply:GiveAmmo( ar2,      	"ar2",      	true )
	ply:GiveAmmo( rpg_round,    "rpg_round",	true )
	
	ply:AddItem( "pistol", 		pistol*-1, 		4 )
	ply:AddItem( "smg1", 		smg1*-1, 		4 )
	ply:AddItem( "buckshot", 	buckshot*-1, 	4 )
	ply:AddItem( "ar2", 		ar2*-1, 		4 )
	ply:AddItem( "rpg_round", 	rpg_round*-1, 	4 )
	
	local getprimary, getsecondary = ply:GetLoadoutPrimary(), ply:GetLoadoutSecondary()
	local getPattachments, getSattachments = ply:GetPrimaryAttachments(), ply:GetSecondaryAttachments()
	local primarytime, secondarytime = ply:GetLicenseTimeLeft( 1, getprimary ), ply:GetLicenseTimeLeft( 2, getsecondary )
	--print(getPattachments, getSattachments)
	local primary = ""
	local secondary = ""
	local explosive, explosive_ammo = ply:GetLoadoutExplosive() or "", 0
	
	if getprimary != "" then
		if primarytime == -1 or primarytime > 0 then
			primary = getprimary
		else
			primary = "weapon_sh_mp5a4"
			-- ply:SendMessage( "Your primary weapon's license has run out!" )
		end
	end
	
	if getsecondary != "" then
		if secondarytime == -1 or secondarytime > 0 then
			secondary = getsecondary
		else
			secondary = "weapon_sh_p228"
			-- ply:SendMessage( "Your secondary weapon's license has run out!" )
		end
	end
	
	if primary == "" then
		ply:SendMessage( "No primary weapon selected, equipping default." )
		primary = "weapon_sh_mp5a4"
		ply:SetLoadoutPrimary( primary )
	end
	
	if secondary == "" then
		ply:SendMessage( "No secondary weapon selected, equipping default." )
		secondary = "weapon_sh_p228"
		ply:SetLoadoutSecondary( secondary )
	end
	
	if explosive == "" then
		--ply:SendMessage( "No explosive selected, equipping default." )
		explosive = "weapon_sh_grenade"
		ply:SetLoadoutExplosive( explosive )
	end

	local explosive_ammo = ply:GetItemCount( explosive )
	local explosive_max = self.Explosives[explosive].ammo

	if explosive_ammo > 0 then
		ply:Give( explosive )
		if explosive_ammo > 1 then
			local given_amt = math.min( explosive_ammo, explosive_max )
			ply:AddItem( explosive, given_amt*-1, 3 )
			ply:GiveAmmo( given_amt-1, "grenade", true )
		else
			ply:AddItem( explosive, -1, 3 )
		end
	end

	ply:Give( secondary )
	ply:SelectWeapon( secondary )
	
	ply:Give(ply:GetKnife())
	
	ply:Give( primary )
	ply:SelectWeapon( primary )
	
	ply:Give( "weapon_sh_doormod" )
	--ply:Give( "weapon_sh_uplink" )
	ply:Give( "weapon_sh_tool" )
	
	if(ply:IsAdmin()) then
		ply:Give("weapon_sh_remover")
	end
	
	GAMEMODE.Net:SendClientItems( ply )
	
	ply:SetSpawnedLoadoutPrimary( primary )
	ply:SetSpawnedLoadoutSecondary( secondary )
	ply:SetSpawnedLoadoutExplosive( explosive )
	--self:DoAttachments(ply)
	--print(ply:GetPrimaryAttachments())
end

function GM:DoAttachments(ply)
	--lol wtf does this even do\
	--print "\n\n\n\n\n\n\n\n WTF"
	--print( debug.traceback() )
end

function GM:DoPlayerDeath( ply, attacker, dmginfo, bSpectate )
	-- Retrieve ammo
	--[[ply:AddItem( "pistol", 		ply:GetAmmoCount("pistol") )
	ply:AddItem( "smg1", 		ply:GetAmmoCount("smg1") )
	ply:AddItem( "buckshot", 	ply:GetAmmoCount("buckshot") )
	ply:AddItem( "ar2", 		ply:GetAmmoCount("ar2") )
	ply:AddItem( "rpg_round", 	ply:GetAmmoCount("rpg_round") )]]
	
	if ply:GetSpawnedLoadoutExplosive() and IsValid( ply:GetWeapon(ply:GetSpawnedLoadoutExplosive()) ) then
		ply:AddItem( ply:GetSpawnedLoadoutExplosive(), ply:GetAmmoCount("grenade") )
	end
	
	GAMEMODE.Net:SendClientItems( ply )
	--print(table.ToString(ply.Attachments))
	if bSpectate then return end

	-- Death effects
	local wep = ply:GetActiveWeapon()
	local wepSkin = wep.WeaponSkin
	
	if IsValid( wep ) and (!wep.Primed or wep.Primed == 0) then
		local wepfx = ents.Create( "prop_physics" )
		
		local model = wep.WorldModel or string.gsub(wep:GetModel(),"v_","w_")
		local pos, ang
		local attachid = ply:LookupAttachment( "anim_attachment_RH" )
		if attachid != 0 then
			local posang = ply:GetAttachment( attachid )
			pos = posang.Pos
			ang = posang.Ang
		else
			pos = wep:GetPos() +Vector(0,0,45) +10 *ply:GetForward()
			ang = wep:GetAngles()
		end
		
		if model == "models/weapons/w_rocket_launcher.mdl" then
			ang:RotateAroundAxis( ang:Up(), 180 )
		end
		
		local wepSkinMat = SH_STORE:GetEquippedSkin(ply, wepSkin)
		
		if wepSkinMat ~= false then
			wepfx:SetMaterial(wepSkinMat)
		end
		
		wepfx:SetModel( model )
		wepfx:SetPos( pos )
		wepfx:SetAngles( ang )
		
		wepfx:Spawn()
		wepfx:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		wepfx:SetVelocity( ply:GetVelocity() )
		wepfx:SetHealth( 1000 )
		wepfx:SetMaxHealth( 1000 )
		
		ply.DroppedWeapon = wepfx
		timer.Simple( 30,
			function()
				if IsValid( wepfx ) then
					wepfx:Remove()
				end
			end
		)
	end

	--ply:CreateServerSideRagdoll()
	ply:CreateRagdoll()

	ply:AddDeaths( 1 )

	if IsValid( attacker ) and attacker:IsPlayer() and ply != attacker then
		attacker:AddFrags( 1 )
	end
	ply:StripWeapons()

end

function GM:PlayerDeath( ply, inflictor, killer )
	-- BASE GAMEMODE GM:PlayerDeath( ply, inflictor, killer )

	
	ply.NextSpawnTime = CurTime()
	ply.DeathTime = CurTime()
	
	if !IsValid( inflictor ) and IsValid( killer ) then
		inflictor = killer
	end

	-- Convert the inflictor to the weapon that they're holding if we can.
	-- This can be right or wrong with NPCs since combine can be holding a 
	-- pistol but kill you by hitting you with their arm.
	if inflictor and inflictor == killer and (inflictor:IsPlayer() or inflictor:IsNPC()) then
		inflictor = inflictor:GetActiveWeapon()
		if !inflictor or inflictor == NULL then inflictor = killer end
	end
	
	if killer == ply then
		umsg.Start( "PlayerKilledSelf" )
			umsg.Entity( ply )
		umsg.End()
		
		MsgAll( killer:Nick() .. " suicided!\n" )
	elseif killer:IsPlayer() then
		umsg.Start( "PlayerKilledByPlayer" )
			umsg.Entity( ply )
			umsg.String( inflictor:GetClass() )
			umsg.Entity( killer )
			umsg.Bool( ply.WasHeadshot or false )
		umsg.End()
		
		MsgAll( killer:Nick() .. " killed " .. ply:Nick() .. " using " .. inflictor:GetClass() .. "\n" )
	else
		umsg.Start( "PlayerKilled" )
			umsg.Entity( ply )
			umsg.String( inflictor:GetClass() )
			umsg.String( killer:GetClass() )
		umsg.End()
		
		MsgAll( ply:Nick() .. " was killed by " .. killer:GetClass() .. "\n" )
	end
	
	-- ----------------------------------------------------------------------------------------------------
	
	--See sv_networking.lua, GM.Net:SendPlayerKilled
	-- umsg.Start( "sh_killed", ply )
	-- 	umsg.Entity( killer )
	-- umsg.End()
	GAMEMODE.Net:SendPlayerKilled( ply, killer )
	
	ply:AddStatistic("deaths", 1)
	
	local livedfor = CurTime() - (tonumber( ply:GetLastSpawn() ) or 0)
	if livedfor > tonumber(ply:GetStatistic( "longestalive", 0)) then
		ply:SetStatistic( "longestalive", livedfor )
	end
	
	if IsValid(killer) and killer:IsPlayer() and killer ~= ply then
		killer:AddScoreEvent("Player Killed", 100, true, true, false, "OW$")
	end
	
	if IsValid( killer ) and killer:IsPlayer() and ply != killer and (!IsValid(ply.LastKiller) or ply.LastKiller ~= killer or CurTime() - (ply.LastKillerTime or 0) > 61) then -- LastKillerTime > 61 to make sure the multiplier does not increase

		killer:AddStatistic("kills", 1)
	
		if killer:Alive() then
			killer:SetLastKill( CurTime() )
			ply.LastKiller = killer
			ply.LastKillerTime = CurTime()
		
		end
	end
	GAMEMODE.Net:SendSpawnDelay( ply, GAMEMODE.ConVars.RespawnTime:GetFloat() )
	timer.Remove( "Suicide_"..ply:EntIndex() )
	ply.Suiciding = false
	
	ply:SetDSP( 0 )
	return true
end

function GM:PlayerDeathThink( ply )
	if self.GameOver or (ply.NextSpawnTime and ply.NextSpawnTime > CurTime() - GAMEMODE.ConVars.RespawnTime:GetFloat()) then return end

	if ( ply:KeyPressed( IN_ATTACK ) or ply:KeyPressed( IN_ATTACK2 ) or ply:KeyPressed( IN_JUMP ) ) then
		ply:Spawn()
	end
end

function GM:CanPlayerSuicide( ply )
	if not self.GameOver and !ply.Suiciding and ply:Alive() and ply:Team() != TEAM_SPECTATOR and ply:Team() != TEAM_UNASSIGNED then
		ply.Suiciding = true
		ply:SendMessage( "Suiciding in 3 seconds...", "Stronghold", false )
		
		timer.Create( "Suicide_".. ply:EntIndex(), 3, 1,
			function()
				if IsValid( ply ) then
					ply:Kill()
					ply.Suiciding = false
				end
			end
		)
	end

	return false
end

function GM:PlayerCanPickupWeapon(ply, wep)
	if ply:HasWeapon( "weapon_sh_tool" ) then return end
	return true
end

function GM:PlayerConnect( name, address ) 
end

function GM:PlayerDisconnected( ply )
	local index = ply:Team()
	
	if index > 50 then
		CCLeaveTeam( ply, {true} )
	end
	
	if CLIENT then
		for k, wep in pairs( ply.Weapons ) do
			wep:Remove()
		end
	end
	
	ply:SaveData()
	
	-- Delete props after 2 minutes
	local uid = ply:UniqueID()
	timer.Create( "Cleanup."..uid, 120, 1, function()
		for _, v in ipairs(ents.FindByClass("prop_physics")) do
			if v:GetOwnerUID() == uid then
				v:Remove()
			end
		end
	end )
end

-- sv_alltalk 1 overrides this hook
function GM:PlayerCanHearPlayersVoice( ply, other )
	local channel 		= ply:GetInfoNum( "sh_voice_channel", 1 )
	local channel_other = other:GetInfoNum( "sh_voice_channel", 1 )
	local alwayspublic 	= ply:GetInfoNum( "sh_voice_alwayshearpublic", 0 )
	local alwaysteam 	= ply:GetInfoNum( "sh_voice_alwayshearteam", 0 )
	
	if (channel == 1 and channel_other == 1 and ply:Team() == other:Team()) or channel == 0 and channel_other == 0 then
		return true
	elseif channel_other == 0 and channel == 1 and alwayspublic == 1 then
		return true
	elseif channel_other == 1 and channel == 0 and alwaysteam == 1 and ply:Team() == other:Team() then
		return true
	end
	
	return false
end

-- ---------------------------------------------------------------------------------------------------- --
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! DO NOT FUCKING TOUCH THIS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! THIS WAS A BITCH TO TRACK DOWN !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --
-- !!!!!! GARRY FIX YOUR DOUBLE GM:ScalePlayerDamage CALL THAT ALSO ADDS ORIGINAL DAMAGE BACK ON !!!!!! --
-- ---------------------------------------------------------------------------------------------------- --
function GM:ScalePlayerDamage( ply, hitgroup, dmginfo, dont_ignore )
	--local original = dmginfo:GetDamage()
	
	if hitgroup == HITGROUP_HEAD then
		dmginfo:ScaleDamage( 20 )
		ply.WasHeadshot = true
	else
		ply.WasHeadshot = false
	end

	if hitgroup == HITGROUP_CHEST or
			hitgroup == HITGROUP_STOMACH or
			hitgroup == HITGROUP_GENERIC or
			hitgroup == HITGROUP_CHEST			then
		dmginfo:ScaleDamage( 4 )
	end

	-- ALL FOUR LIMBS DAMNIT
	if hitgroup == HITGROUP_LEFTARM or
			hitgroup == HITGROUP_RIGHTARM or
			hitgroup == HITGROUP_LEFTLEG or
			hitgroup == HITGROUP_RIGHTLEG or
			hitgroup == HITGROUP_GEAR then
		dmginfo:ScaleDamage( 3 )
	end
	
	-- WHY ORIGINAL ADDED?!
	--dmginfo:SetDamage( dmginfo:GetDamage()-original )
end

function GM:PlayerHurt( ply, attacker, healthleft, healthtaken )
	ply:SetNextHealthRegen( CurTime()+5 )
	
	ply:AddStatistic("dmgtaken", math.floor(healthtaken))
	
	if IsValid( attacker ) and attacker:IsPlayer() then
		
		attacker:AddStatistic("dmginflicted", math.floor(healthtaken))
		--See sv_networking.lua, GM.Net:SendHitDetect
		-- umsg.Start( "sh_hitdetection", attacker )
		-- umsg.End()
		GAMEMODE.Net:SendHitDetect( attacker )
	end
end

function GM:PlayerTraceAttack( ply, dmginfo, dir, trace )
	if SERVER then
		local wep = ply:GetActiveWeapon()
		
		if IsValid( wep ) and wep.ScaleByDistance then
			local dist = (trace.HitPos -trace.StartPos):Length()
		end
	end

	return false
end

function GM:PlayerUse( ply, ent )
	return true
end

-- ---------------------------------------------------------------------------------------------------- --
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --
-- ---------------------------------------------------------------------------------------------------- --

function GM.FreezePlayers( freeze )
	for _, v in ipairs( player.GetAll() ) do
		if freeze then
			v:SetVelocity( Vector(0) )
			v:Lock()
			v:Freeze( true )
		else
			v:UnLock()
			v:Freeze( false )
		end
	end
end

function GM.SpectatePlayers( spectate, ent, respawn )
	for _, v in ipairs( player.GetAll() ) do
		if spectate then
			v:Spectate( IsValid(ent) and 5 or 6 )
			v:SpectateEntity( ent )
			v:SetMoveType( MOVETYPE_NOCLIP )
		else
			v:UnSpectate()
			if respawn then v:Spawn() end
		end
	end
end

-- Does not clean ammo infomation!
function GM.StripPlayers()
	for _, v in ipairs( player.GetAll() ) do
		v:StripWeapons()
	end
end