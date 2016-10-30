--[[-------------------------------------------------------

Fight to Survive: Stronghold by RoaringCow, TehBigA is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License. 
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, 
444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

--[[
	GM13 Changes

	AccessorFuncNW - > PlayerAccessorFuncNW
	usermessage - > net
	datastream - > net

	Cleaned Code
]]

---------------------------------------------------------]]

local grenades = {
	["weapon_sh_c4"]		= true,
	["weapon_sh_smoke"] 	= true,
	["weapon_sh_grenade"] 	= true,
	["weapon_sh_flash"] 	= true
}

INITSTATE_ASKING, INITSTATE_WAITING, INITSTATE_OK = 0, 1, 2

local meta = FindMetaTable( "Player" )

AccessorFuncNW( meta, "m_iInitialized", 		"Initialized", 		INITSTATE_ASKING, 	FORCE_NUMBER )
AccessorFuncNW( meta, "m_fLastSpawn", 			"LastSpawn", 		0, 					FORCE_NUMBER )
AccessorFuncNW( meta, "m_strMapVote", 			"MapVote", 			"",					FORCE_STRING )
AccessorFuncNW( meta, "m_strLoadoutPrimary", 	"LoadoutPrimary", 	"",					FORCE_STRING )
AccessorFuncNW( meta, "m_strLoadoutSecondary", 	"LoadoutSecondary", "",					FORCE_STRING )
AccessorFuncNW( meta, "m_strPrimaryAttachments", 	"PrimaryAttachments", "",			FORCE_STRING )
AccessorFuncNW( meta, "m_strSecondaryAttachments", 	"SecondaryAttachments", "",			FORCE_STRING )
AccessorFuncNW( meta, "m_strLoadoutExplosive", 	"LoadoutExplosive", "",					FORCE_STRING )
AccessorFuncNW( meta, "m_ServerSideRagdoll", 	"RagdollEntity", NULL,					FORCE_ENTITY )
AccessorFuncNW( meta, "m_bIsGod",	 			"God",				false,				FORCE_BOOL )

AccessorFunc( meta, "m_iNextHealthRegen",	"NextHealthRegen",	FORCE_NUMBER )
AccessorFunc( meta, "m_iLastKill", 			"LastKill",			FORCE_NUMBER )
AccessorFunc( meta, "m_vHatPos", 			"HatPos" )
AccessorFunc( meta, "m_aHatAng", 			"HatAng" )

if !meta.oldSetTeam then
	meta.oldSetTeam = meta.SetTeam
	function meta:SetTeam( new )
		local old = self:Team()
		self:oldSetTeam( new )
		gamemode.Call( "OnPlayerChangedTeam", self, old, new )
	end
end

function meta:IsDonator()
	--ErrorNoHalt( "CALLING "..tostring(self)..":IsDonator()" )
	--debug.Trace()
	
	return false
end

local PLAYER_COLOR_MULTIPLIER = 0.80
function meta:GetPlayerColor()
	local col = team.GetColor( self:Team() )
	return Vector( col.r / 255 * PLAYER_COLOR_MULTIPLIER, col.g / 255 * PLAYER_COLOR_MULTIPLIER, col.b / 255 * PLAYER_COLOR_MULTIPLIER )
end

-- To add clientside smoothing
if CLIENT then
	function meta:SetViewOffset( pos )
		self.m_vViewOffset = pos
	end
	
	function meta:SetViewOffsetDucked( pos )
		self.m_vViewOffsetDucked = pos
	end
end

function meta:CreateServerSideRagdoll()
	local ragdoll = ents.Create( "prop_ragdoll" )
	ragdoll:SetModel( self:GetModel() )
	ragdoll:SetPos( self:GetPos() )
	ragdoll:SetAngles( self:GetAngles() )
	ragdoll:Spawn()
	ragdoll:Activate()
	
	ragdoll:SetOwnerEnt( self )
	
	self:SetRagdollEntity( ragdoll )
	
	ragdoll:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local vel = self:GetVelocity()
	for index = 0, ragdoll:GetPhysicsObjectCount() do
		local pos, ang 		= self:GetBonePosition( ragdoll:TranslatePhysBoneToBone(index) )
		local rd_physobj 	= ragdoll:GetPhysicsObjectNum( index )

		if IsValid( rd_physobj ) then
			rd_physobj:SetPos( pos )
			rd_physobj:SetAngles( ang )
			rd_physobj:SetVelocity( vel *(rd_physobj:GetMass() /85) *2 )
		end
	end
	
	table.insert( GAMEMODE.Ragdolls, {ent = ragdoll, time = CurTime()} )
end

function meta:SaveData()
	if self:GetInitialized() != INITSTATE_OK then Msg( "Trying to save uninitialized player! ["..self:GetName().."]" ) return end
	
	//MsgN("Save User Profile (Stronghold)")
	

	
	/*
	//PrintTable(data)
	
	local sendData = util.Base64Encode(util.TableToJSON(data))
	
	INVENTORY:MethodRequest("saveshdata", { steamid = self:SteamID64(), shdata = sendData }, function(data)
		MsgN("Save Response: "..data)
	end,
	function()
		MsgN("Failed to save SH Data for: "..self:Name())
	end)*/

end


function GM:StrongholdUserProfileSave(ply)

	MsgN("[USER PROFILE] Saving Stronghold Data")
	
	local data 		= {}
	data.Loadouts 	= ply.Loadouts
	data.Items		= table.Copy(ply.Items)
	
	for k,v in pairs(data.Items) do
	
		local ammo = k
		
		if grenades[k] and ply:GetWeapon(k) ~= NULL then
			ammo = "grenade"
		end
		
		local additional = ply:GetAmmoCount(ammo)
		data.Items[k].count = data.Items[k].count + additional
	
	end
	
	data.Licenses 		= ply.Licenses
	data.SoldWeapons	= ply.SoldWeapons or {}
	data.LastEquip =
	{
		primary 	= ply:GetLoadoutPrimary(),
		secondary 	= ply:GetLoadoutSecondary(),
		explosive 	= ply:GetLoadoutExplosive()
	}

	ply.SoldWeapons = {} //Clear
	
	ply.UserProfile["sh_inventory"] 	= data.Licenses
	ply.UserProfile["sh_lastequip"]		= data.LastEquip
	ply.UserProfile["sh_items"]			= data.Items
	ply.UserProfile["sh_removeitems"]	= data.SoldWeapons

end

hook.Add("UserProfileSave", "StrongholdUserProfileSave", function(ply) GAMEMODE:StrongholdUserProfileSave(ply) end)

function meta:IsBot()
	for _, v in ipairs( player.GetBots() ) do
		if v == self then return true end
	end

	return false
end

function meta:SendMessage( msg, title, msgsnd )
	msg 	= sql.SQLStr( msg, true )
	title 	= sql.SQLStr( title or "Stronghold", true )

	if SERVER then
		self:SendLua( [[chat.AddText(Color(200,200,200,255),"]]..title..[[: ",Color(200,50,50,255),"]]..msg..[[")]] )

		if msgsnd == true then
			self:SendLua( [[surface.PlaySound("buttons/button15.wav")]] )
		elseif msgsnd == false then
			self:SendLua( [[surface.PlaySound("buttons/button16.wav")]] )
		end
	else
		chat.AddText( Color(200, 200, 200, 255), title..": ", Color(200, 50, 50, 255), msg )

		if msgsnd == true then
			surface.PlaySound( "buttons/button15.wav" )
		elseif msgsnd == false then
			surface.PlaySound( "buttons/button16.wav" )
		end
	end
end

-- ----------------------------------------------------------------------------------------------------

g_SBoxObjects = {}

function meta:CheckLimit( str )
	if game.SinglePlayer() then return true end
	
	local c = GetConVarNumber( "sbox_max".. str, 0 )
	if c < 0 then return true end
	if self:GetCount( str ) > c -1 then self:LimitHit( str ) return false end

	return true
end

function meta:GetCount( str, minus )
	if CLIENT then
		return self:GetNWInt( "Count.".. str, 0 )
	end

	minus = minus or 0

	if !self:IsValid() then return end

	local key = self:UniqueID()
	local tab = g_SBoxObjects[key]
	
	if !tab or !tab[str] then 
		self:SetNWInt( "Count.".. str, 0 )
		return 0 
	end

	local c = 0
	for k, v in pairs( tab[str] ) do
		if v:IsValid() then 
			c = c +1
		else
			tab[str][k] = nil
		end
	end

	self:SetNWInt( "Count.".. str, c -minus )

	return c
end

function meta:AddCount( str, ent )
	if SERVER then
		local key 				= self:UniqueID()
		g_SBoxObjects[key] 		= g_SBoxObjects[key] or {}
		g_SBoxObjects[key][str] = g_SBoxObjects[key][str] or {}
		local tab 				= g_SBoxObjects[key][str]
		
		if IsValid( ent ) then
			table.insert( tab, ent )
			self:GetCount( str )
			ent:CallOnRemove( "GetCountUpdate", function(ent, ply, str) ply:GetCount(str, 1) end, self, str )
		end
	end
end

function meta:LimitHit( str )
	self:SendLua( "GAMEMODE:LimitHit( '".. str.. "' )" )
end

local tracepositions = { Vector(0) }
for i = 1, 16 do
	table.insert( tracepositions, Vector(math.cos(math.pi/8*i)*17,math.sin(math.pi/8*i)*17,0) )
end

function meta:IsColliding( ent, filter )
	return PlayerHullIsColliding( self:GetPos(), self:Crouching(), ent, {self} )
end

function PlayerHullIsColliding( pos, crouching, ent, filter )
	for _, start in ipairs( tracepositions ) do
		local adjstart 	= start +pos
		local trace 	= util.TraceLine( {
			start = adjstart,
			endpos = adjstart +Vector( 0, 0, (crouching and 37 or 73) ),
			filter = filter
		} )

		if trace.Entity == ent then
			return true
		end
	end

	return false
end

-- ----------------------------------------------------------------------------------------------------

--  LIST OF STATISTICS   --
-- LOCATED IN SHARED.LUA --

function meta:AddStatistic(event, amt)

	if CLIENT then return end
	
	if self:IsBot() then return end
	
	event = string.lower(event)
	
	if not GAMEMODE.StatisticsEventNames[event] then
		MsgN("Invalid event tried to be set: "..event)
		return
	end
	
	self.Stats.gamemodes.sh[event] = self.Stats.gamemodes.sh[event] + (amt or 1)
	
end

function meta:SetStatistic(event, amt) //Deprecated
	
	if CLIENT then return end
	
	if self:IsBot() then return end 
	
	event = string.lower(event)
	
	if not GAMEMODE.StatisticsEventNames[event] then return end
	
	self.Stats.gamemodes.sh[event] = amt
	
end

function meta:GetStatistic(event, default) //Deprecated

	event = string.lower(event)
	
	if not GAMEMODE.StatisticsEventNames[event] then
		return
	end
	
	return self.Stats.gamemodes.sh[event]
end

function meta:GetStatistics() //Deprecated
	//return self.Statistics or {}
end

if SERVER then
	function meta:SendStatistics( ply ) //Deprecated
		//if !self.Statistics then self.Statistics = {} end
		//GAMEMODE.Net:SendClientStats( ply, self )
	end

	concommand.Add( "sh_requeststats",
		function( ply, _, args )
			//local other = Entity( tonumber(args[1]) )
			//if IsValid( other ) then other:SendStatistics( ply ) end
		end ) //Deprecated
		
	function meta:SaveStatistics()
		//if self:GetInitialized() != INITSTATE_OK then return end
	end //Deprecated
end

-- ----------------------------------------------------------------------------------------------------
AccessorFunc( meta, "m_strSpawnedLoadoutPrimary", "SpawnedLoadoutPrimary" )
AccessorFunc( meta, "m_strSpawnedLoadoutSecondary", "SpawnedLoadoutSecondary" )
AccessorFunc( meta, "m_strSpawnedLoadoutExplosive", "SpawnedLoadoutExplosive" )

AccessorFunc( meta, "m_strSpawnedPAttachments", "SpawnedPAttachments" )
AccessorFunc( meta, "m_strSpawnedSAttachments", "SpawnedSAttachments" )

function meta:SetLoadout( name )
	if !self.Loadouts then self.Loadouts = {} end
	
	if self.Loadouts[name] then
		self.m_strLoadoutPrimary = self.Loadouts[name].primary
		self.m_strLoadoutSecondary = self.Loadouts[name].secondary
		self.m_strLoadoutExplosive = self.Loadouts[name].explosive
	end
end

function meta:EditLoadout( name, primary, secondary, explosive )
	if !self.Loadouts then self.Loadouts = {} end
	
	if !GAMEMODE.PrimaryWeapons[primary] or !GAMEMODE.SecondaryWeapons[secondary] or !GAMEMODE.Explosives[explosive] then return end
	self.Loadouts[name] = { primary=primary, secondary=secondary, explosive=explosive }
end

function meta:GetLoadout( name )
	if !self.Loadouts then self.Loadouts = {} end
	return self.Loadouts[name]
end

function meta:GetLoadouts()
	if !self.Loadouts then self.Loadouts = {} end
	return self.Loadouts
end

function meta:RemoveLoadout( name )
	if !self.Loadouts then self.Loadouts = {} end
	
	self.Loadouts[name] = nil
end

function meta:SaveLoadouts()
	if self:GetInitialized() != INITSTATE_OK then return end
	if !self.Loadouts then self.Loadouts = {} end
	self:SaveData()
end

-- ----------------------------------------------------------------------------------------------------
function meta:GetLicenses( type )
	if !self.Licenses then self.Licenses = { [1]={weapon_sh_mp5a4=-1}, [2]={weapon_sh_p228=-1} } end
	return type == nil and self.Licenses or self.Licenses[type]
end

function meta:GetLicense( type, class )
	if !self.Licenses then self.Licenses = { [1]={weapon_sh_mp5a4=-1}, [2]={weapon_sh_p228=-1} } end
	return self.Licenses[type] and self.Licenses[type][class] or nil
end

function meta:SetLicenseTime( type, class, time )
	if !self.Licenses then self.Licenses = { [1]={weapon_sh_mp5a4=-1}, [2]={weapon_sh_p228=-1} } end
	
	if type == 1 or type == 2 or type == 5 or type == 6 or type == 7 then
		if !self.Licenses[type] then self.Licenses[type] = {} end
		self.Licenses[type][class] = time
		
		self:SaveLicenses()
	end
end

function meta:GetLicenseTimeLeft( type, class )
	if !self.Licenses then self.Licenses = { [1]={weapon_sh_mp5a4=-1}, [2]={weapon_sh_p228=-1} } end
	
	if type == 1 or type == 2 or type == 5 or type == 6 or type == 7 then
		local ostime = os.time()
		if !self.Licenses[type] then self.Licenses[type] = {} end
		if self.Licenses[type][class] == -1 then
			return -1
		else
			return math.max( 0, (self.Licenses[type][class] or 0)-ostime )
		end
	end
	
	return 0
end

function meta:AddLicenseTime( type, class, time )
	if !self.Licenses then self.Licenses = { [1]={weapon_sh_mp5a4=-1}, [2]={weapon_sh_p228=-1} } end
	
	if type == 1 or type == 2 or type == 5 or type == 6 or type == 7 then
		if !self.Licenses[type] then self.Licenses[type] = {} end
		
		if self.Licenses[type][class] and self.Licenses[type][class] - os.time() < 0 then self.Licenses[type][class] = nil end
		self.Licenses[type][class] = (self.Licenses[type][class] or os.time()) + time
		
		self:SaveLicenses()
	end
end

function meta:RemoveLicense( type, class )
	if !self.Licenses then self.Licenses = { [1]={weapon_sh_mp5a4=-1}, [2]={weapon_sh_p228=-1} } end
	
	if type == 1 or type == 2 or type == 5 or type == 6 or type == 7 then
		if !self.Licenses[type] then self.Licenses[type] = {} end
		self.Licenses[type][class] = nil
		table.insert(self.SoldWeapons, class)
		
		self:SaveLicenses()
	end
end

function meta:SaveLicenses()
	if self:GetInitialized() != INITSTATE_OK then return end
	if !self.Licenses then self.Licenses = { [1]={weapon_sh_mp5a4=-1}, [2]={weapon_sh_p228=-1} } end
	self:SaveData()
end

-- ----------------------------------------------------------------------------------------------------
function meta:GetMoney()

	if(CLIENT) then
		return self:GetNWInt("stat_money", 0)
	else
		return tonumber(self.Stats.money) //Can be a string when retreived.
	end
	
end

function meta:AddMoney(amt)

	if(CLIENT) then
		return
	end
	
	self:ModifyMoney(amt, true)
	
end

function meta:SetMoney(amt) //Deprecated
end

function meta:SaveMoney() //Deprecated
end

function meta:GetMultiplier()
	if !self.Multiplier then self.Multiplier = 0 end
	return self.Multiplier
end

function meta:AddMultiplier( amt )
	if !self.Multiplier then self.Multiplier = 0 end
	self.Multiplier = math.max( 0, self.Multiplier + amt )
end

function meta:SetMultiplier( amt )
	self.Multiplier = amt
end

function meta:SendMoneyAndMultiplier()
	//GAMEMODE.Net:SendMoneyAndMultiplier( self )
end

-- ----------------------------------------------------------------------------------------------------
function meta:GetItems()
	if !self.Items then self.Items = {} end
	return self.Items
end

function meta:GetItem( item )
	if !self.Items then self.Items = {} end
	return self.Items[item]
end

function meta:GetItemCount( item )
	if !self.Items then self.Items = {} end
	return self.Items[item] and self.Items[item].count or 0
end

function meta:OwnsSHWeapon(type, item)

	local guns = {}

	if self.Licenses ~= nil then
		guns = self.Licenses
	end

	if guns[type][item] == nil then
		return false
	end
	
	if guns[type][item] == -1 or guns[type][item] > os.time() then
		return true
	end
	
	return false

end

-- If type is nil, the method will try and figure it out, otherwise 0
function meta:SetItem( type, item, count )
	if !self.Items then self.Items = {} end
	count = math.max( 0, count )
	
	if !self.Items[item] then
		if type == nil then
			type = 0
			
			if GAMEMODE.Explosives[item] then
				type = 3
			elseif GAMEMODE.Ammo[item] then
				type = 4
			end
		end
		
		self.Items[item] = { type=type, count=count }
	else
		self.Items[item].count = count
	end
	
	GAMEMODE.Net:SendClientItem( self, item )
end

-- If the item doesn't exist, or if type is nil, the method will try and figure out the type, otherwise 0
function meta:AddItem( item, count, type )
	if !self.Items then self.Items = {} end
	if !self.Items[item] then
		if type == nil then
			type = 0
			
			if GAMEMODE.Explosives[item] then
				type = 3
			elseif GAMEMODE.Ammo[item] then
				type = 4
			end
		end
		
		self.Items[item] = { type=type, count=math.max( 0, count ) }
	else
		self.Items[item].count = math.max( 0, self.Items[item].count + count )
	end
	
	GAMEMODE.Net:SendClientItem( self, item )
end

function meta:BuyItem( type, class, amount )
	if !IsValid( self ) or GAMEMODE.GameOver then return end

	if type == 1 and GAMEMODE.PrimaryWeapons[class] then
		local cost = (amount == 2 and GAMEMODE.PrimaryWeapons[class].price or GAMEMODE.PrimaryWeapons[class].price*0.10)

		if cost > 0 and self:GetMoney() >= cost then
			if amount == 2 then
				self:SetLicenseTime( 1, class, -1 )
			else
				self:AddLicenseTime( 1, class, 3600 )
			end

			GAMEMODE.Net:SendClientLicense( self, type, class )
			self:AddMoney( -cost )
		end
	elseif type == 2 and GAMEMODE.SecondaryWeapons[class] then
		local cost = (amount == 2 and GAMEMODE.SecondaryWeapons[class].price or GAMEMODE.SecondaryWeapons[class].price*0.10)

		if cost > 0 and self:GetMoney() >= cost then
			if amount == 2 then
				self:SetLicenseTime( 2, class, -1 )
			else
				self:AddLicenseTime( 2, class, 3600 )
			end

			GAMEMODE.Net:SendClientLicense( self, type, class )
			self:AddMoney( -cost )
		end
	elseif type == 3 and GAMEMODE.Explosives[class] then
		local cost = GAMEMODE.Explosives[class].price * amount
		
		if cost > 0 and self:GetMoney() >= cost then
			self:AddItem( class, amount, 3 )
			self:AddMoney( -cost )
			GAMEMODE.Net:SendClientItem( self, class )
		end
	elseif type == 4 and GAMEMODE.Ammo[class] then
		local cost = GAMEMODE.Ammo[class].price * amount
		
		if cost > 0 and self:GetMoney() >= cost then
			self:AddItem( class, amount, 4 )
			self:AddMoney( -cost )
			GAMEMODE.Net:SendClientItem( self, class )
		end
	elseif type == 5 and GAMEMODE.Hats[class] then
		local cost = GAMEMODE.Hats[class].price
		
		if cost > 0 and self:GetMoney() >= cost then
			self:AddLicenseTime( 5, class, 86400 )
			GAMEMODE.Net:SendClientLicense( self, type, class )
			self:AddMoney( -cost )
		end
	end
	
	self:SendMoneyAndMultiplier()
end

function meta:SaveItems()
	if self:GetInitialized() != INITSTATE_OK then return end
	if !self.Items then self.Items = {} end
	self:SaveData()
end

-- ----------------------------------------------------------------------------------------------------
--[[
	Type 6 = Primary Attachments
	Type 7 = Secondary Attachments

	Struct
	Player.Licenses[ intType ] = {
		["weapon_sh_ak47suppressor"] = -1,
		["weapon_sh_ak47rds"] = -1,
	}
]]--

function meta:BuyAttachment( intType, strWepClass, strAttachment )
	if intType ~= 6 and intType ~= 7 then return end
	if type( strAttachment ) ~= "string" or not GAMEMODE.WeaponAttachments[strAttachment] then return false end

	if type( strWepClass ) ~= "string" then return end
	if intType == 6 and not GAMEMODE.PrimaryWeapons[strWepClass] then return end
	if intType == 7 and not GAMEMODE.SecondaryWeapons[strWepClass] then return end

	if self:HasAttachment( intType, strWepClass, strAttachment ) then return end

	local atdata = GAMEMODE.WeaponAttachments[strAttachment]
	local name = strWepClass.. strAttachment

	if atdata.cost > 0 and self:GetMoney() >= atdata.cost then
		self:SetLicenseTime( intType, name, -1 )

		GAMEMODE.Net:SendClientLicense( self, intType, name )
		self:AddMoney( -atdata.cost )
	end
end

function meta:HasAttachment( intType, strWepClass, strAttachment )
	if self.Licenses then
		return (self.Licenses[intType] and self.Licenses[intType][strWepClass.. strAttachment]) or false
	end

	return false
end

-- ----------------------------------------------------------------------------------------------------

AccessorFunc( meta, "m_strHatName", "HatName" )

function meta:EnableHat( strHatName )
	self:SetHatName( strHatName )
	GAMEMODE.Net:EnableHat( self, strHatName )
end

-- ----------------------------------------------------------------------------------------------------

function meta:CheckSpawnpoints( nosetpos, tried, tries )
	local tries = tries or 0
	local tried = {}
	
	if tries > self:GetCount("spawnpoints") and self:GetCount("spawnpoints") != 0 then
		self:SendMessage( "Mobile spawn area obstructed!", "Spawnpoint", false )
		return false
	end

	if self.SpawnPoint and table.Count( self.SpawnPoint ) > 0 then
		local ent = table.Random( self.SpawnPoint )
		if (!IsValid( ent ) and IsValid( self )) or table.HasValue( tried, ent ) then
			for k, v in pairs(self.SpawnPoint) do if v == ent then self.SpawnPoint[k] = nil end end
			tries = tries + 1
			return self:CheckSpawnpoints( nosetpos, tried, tries )
		end
		
		local spawnpos
		local pos, up = ent:GetPos(), ent:GetAngles():Up()
		
		if up.z < -0.70 then
			local zscale = (up.z+1) * 3
			spawnpos = (ent:GetPos() + (3+(20*zscale)) * up) - Vector( 0, 0, 72 )
		else
			local zscale = (-up.z+1) * 3
			spawnpos = ent:GetPos() + (3+(20*zscale)) * up
		end
		
		local filter = ents.FindByClass( "sent_spawnpoint" )
		table.Add( filter, ents.FindByClass("prop_ragdoll") )

		for _, start in ipairs( tracepositions ) do
			local adjstart = start + spawnpos
			local trace = util.TraceLine( {
					start = adjstart,
					endpos = adjstart +Vector( 0, 0, (self:Crouching() and 37 or 73) ),
					filter = filter
				}
			)

			if IsValid(trace.Entity) and trace.Entity:GetClass() == "prop_physics" then
				trace.Entity:TakeDamage( 5 )
			end
		end

		for _, start in ipairs(tracepositions) do
			local adjstart = start + spawnpos
			local trace = util.TraceLine( {
					start = adjstart,
					endpos = adjstart + Vector( 0, 0, (self:Crouching() and 37 or 73) ),
					filter = filter
				}
			)
				
			if trace.Fraction < 0.95 then
				table.insert( tried, ent )
				tries = tries + 1
				return self:CheckSpawnpoints( nosetpos, tried, tries )
			end
		end
		
		if !nosetpos then
			self:SetPos( spawnpos )
			return true
		end
	elseif !self.SpawnPoint then
		self.SpawnPoint = {}
	end
	
	return false
end