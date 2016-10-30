if(CLIENT) then
    surface.CreateFont("content_prefix",
    {
        font    = "Helvetica",
        size    = 17,
        weight  = 800
    })

    surface.CreateFont("content_text",
    {
        font    = "Helvetica",
        size    = 17,
        weight  = 400
    })

    local aimEntity = nil
	local test = 0
    function PropOwnerViewer_Think()
        aimEntity = LocalPlayer():GetEyeTrace().Entity or nil
    end

    function PropOwnerViewer_HUDPaint()
        if(not IsValid(aimEntity)) then return end
        if(not (aimEntity:GetClass() == "prop_physics")) then return end
		if not LocalPlayer():IsAdmin() then return end

        local owner = aimEntity.OwnerName or "?"
        local text_prefix = "Prop Owner:"

        surface.SetFont("content_prefix")
        local text_prefix_w, text_prefix_h = surface.GetTextSize(text_prefix)
        surface.SetFont("content_text")
        local owner_w, owner_h = surface.GetTextSize(owner)

        local text_prefix_pos =
        {
            x = (ScrW() / 2) - text_prefix_w,
            y = ScrH() - text_prefix_h - 40
        }

        local owner_pos =
        {
            x = text_prefix_pos.x + text_prefix_w + 3,
            y = ScrH() - text_prefix_h - 40
        }

        surface.SetDrawColor(0, 0, 0, 200)
        draw.RoundedBox(2, text_prefix_pos.x - 4, text_prefix_pos.y - 3, text_prefix_w + owner_w + 6 + 4, text_prefix_h + 6, Color(0, 0, 0, 200))

        surface.SetFont("content_prefix")
        surface.SetTextColor(255, 255, 255, 255)
        surface.SetTextPos(text_prefix_pos.x, text_prefix_pos.y)
        surface.DrawText(text_prefix)

        surface.SetFont("content_text")
        surface.SetTextColor(180, 180, 180, 255)
        surface.SetTextPos(owner_pos.x, owner_pos.y)
        surface.DrawText(owner)
    end

    function ReceivePropOwner(len)
        ent = net.ReadEntity()
        ply = net.ReadString()

        ent.OwnerName = ply
    end
    net.Receive("PropOwnerViewer_SendPropOwner", ReceivePropOwner)

    function ReceiveOldProps(len)
        tbl = net.ReadTable()

        for _, entry in pairs(tbl) do
            entry.Prop.OwnerName = entry.Owner
        end
    end
    net.Receive("PropOwnerViewer_SendOldProps", ReceiveOldProps)

    hook.Remove("PropOwnerViewer_Think")
    hook.Remove("PropWownerViewer_HUDPaint")

    hook.Add("Think", "PropOwnerViewer_Think",    PropOwnerViewer_Think)
    hook.Add("HUDPaint", "PropOwnerViewer_HUDPaint", PropOwnerViewer_HUDPaint)
end

if(SERVER) then
    PROPS = {}

    function PropOwnerViewer_PlayerSpawnedProp(ply, model, ent)
        if(!IsValid(ent) or !IsValid(ply)) then return end

        if(ent:GetClass() == "prop_physics") then
            table.insert(PROPS, { Prop = ent, Owner = ply:Name() }) -- Insert the prop into the table

            for _, v in pairs(player.GetAll()) do -- Check and send the owner information to admins
                if(v:IsAdmin() or v:IsSuperAdmin()) then
                    timer.Simple(0.1, function()
                        net.Start("PropOwnerViewer_SendPropOwner")
                            net.WriteEntity(ent)
                            net.WriteString(ply:Name())
                        net.Send(v)
                    end)
                end
            end
        end
    end
    util.AddNetworkString("PropOwnerViewer_SendPropOwner")

    function PropOwnerViewer_PlayerInitialSpawn(ply)
	
        if(IsValid(ply)) then
		
            for k, entry in pairs(PROPS) do
                if(!IsValid(entry.Prop)) then
					MsgN("Prop no longer valid. Removing!")
                    table.remove(PROPS, k)
                end
            end
        end
		
    end
    util.AddNetworkString("PropOwnerViewer_SendOldProps")
	
	function PropOwnerViewer_AdminAuthenticated(ply, level)

		net.Start("PropOwnerViewer_SendOldProps")
		net.WriteTable(PROPS)
		net.Send(ply)
	
	end

    hook.Remove("PropOwnerViewer_PlayerSpawnedProp")
    hook.Remove("PropOwnerViewer_PlayerInitialSpawn")

    hook.Add("PlayerSpawnedProp",   "PropOwnerViewer_PlayerSpawnedProp",  PropOwnerViewer_PlayerSpawnedProp)
    hook.Add("PlayerInitialSpawn",  "PropOwnerViewer_PlayerInitialSpawn", PropOwnerViewer_PlayerInitialSpawn)
	hook.Add("OnAdminAuthenticated", "PropOwnerViewer_OnAdminAuthenticated", PropOwnerViewer_AdminAuthenticated)
end
