local PANEL = {}

PANEL.blur 	= Material("pp/blurscreen")

function PANEL:Init()

	self:SetSize(300, 160)
	self:SetPos(10, ScrH() - 170)
	self:AddControls()
	
end

function PANEL:AddControls()

	self.PlayerCharacter = vgui.Create("DModelPanel", self)
	self.PlayerCharacter:SetSize(64, 64)
	self.PlayerCharacter:SetModel("models/player/group01/male_03.mdl")
	self.PlayerCharacter:SetPos(10, 20)
	self.PlayerCharacter:SetAnimated(true)
	self.PlayerCharacter.LayoutEntity = function() end
	
	local eyepos = self.PlayerCharacter.Entity:GetBonePosition(self.PlayerCharacter.Entity:LookupBone("ValveBiped.Bip01_Head1"))
	eyepos:Add(Vector(0, 0, 2))
	
	self.PlayerCharacter:SetLookAt(eyepos)
	self.PlayerCharacter:SetCamPos(eyepos - Vector(-15, 0, 0))
	self.PlayerCharacter.Entity:SetEyeTarget(eyepos-Vector(-15, 0, 0))
	self.PlayerCharacter:SetFOV(60)
	
	local origPaint = self.PlayerCharacter.Paint
	
	self.PlayerCharacter.Paint = function(pnl, w, h)
	
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 200))
	
		origPaint(pnl, w, h)
	
	end

end

function PANEL:Think()

	if(IsValid(self.PlayerCharacter)) then
	
		local plyMdl = LocalPlayer():GetModel()
		
		if(plyMdl == "models/player.mdl") then
			plyMdl = "models/player/group01/male_03.mdl"
		end
		
		if(self.PlayerCharacter:GetModel() ~= plyMdl) then
			self.PlayerCharacter:SetModel(plyMdl)
		end
	
	end

end

function PANEL:Paint(w,h)

	local ply = LocalPlayer()
	local currentLevel = 1

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(self.blur)
	
	local x,y = self:ScreenToLocal(0, 0)
	
	//Blur Box
	self.blur:SetFloat("$blur", 2)
	self.blur:Recompute()
	render.UpdateScreenEffectTexture()
	surface.DrawTexturedRect(x, y, ScrW(), ScrH(), Color(0, 0, 0, 100))
	draw.RoundedBoxEx(4, 0, 0, w, 100, Color(0, 0, 0, 220), true, true, false, false)
	
	//Player Name
	draw.SimpleText(ply:Name(), "Core_MainFont_24", 84, 15, Color(255, 255, 255))
	
	//Money Icon
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Material("icon16/money.png"))
	surface.DrawTexturedRect(84, 40, 16, 16)
	
	//Money Text
	draw.SimpleText(string.Comma(ply:GetNWInt("stat_money")).." $WZ", "Core_MainFont_15", 110, 40, Color(255, 255, 255))
	
	//Weapon Icon
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Material("icon16/sound.png"))
	surface.DrawTexturedRect(84, 65, 16, 16)
	
	local voicechannel = GAMEMODE.ConVars.VoiceChannel:GetInt()
	
	//Weapon Text
	draw.SimpleText(voicechannel == 0 and "Public" or "Team", "Core_MainFont_15", 110, 65, Color(255, 255, 255))
	
	//Info box
	draw.RoundedBoxEx(4, 0, 100, w, 60, Color(43,49,54), false, false, true, true)
	
	//Draw Seperation Lines
	surface.SetDrawColor(0, 0, 0, 100)
	surface.DrawLine(100, 100, 100, 160)
	surface.DrawLine(200, 100, 200, 160)
	
	local healthText = math.Clamp(ply:Health(), 0, 100).."%"
	
	surface.SetFont("Core_MainFont_24")
	local tw, th = surface.GetTextSize(healthText)
	
	local healthTextPos = 100 / 2 - tw / 2
	
	//Health
	draw.SimpleText(healthText, "Core_MainFont_24", healthTextPos, 110, Color(255, 255, 255))
	draw.SimpleText("Health", "Core_MainFont_15", 35, 135, Color(255, 255, 255, 100))
	
	//Current Level
	local levelText = "0"
	
	if IsValid(LocalPlayer()) and LocalPlayer().GetActiveWeapon then
	
		local wep = LocalPlayer():GetActiveWeapon()
		
		if wep.GetStatTrakKills then
		
			local tmpKills = wep:GetStatTrakKills()
			
			levelText = tmpKills
		
		end
	
	end
	
	tw, th = surface.GetTextSize(levelText)
	
	local levelTextPos = 290 / 2 - tw / 2
	
	draw.SimpleText(levelText, "Core_MainFont_24", levelTextPos, 110, Color(255, 255, 255))
	draw.SimpleText("StatTrak™ Kills", "Core_MainFont_15", 110, 135, Color(255, 255, 255, 100))
	
	//Props Spawned
	local propText = ply:GetCount("props").."/"..GetConVarNumber("sbox_maxprops")
	tw, th = surface.GetTextSize(propText)
	
	local propTextPos = 480 / 2 - tw / 2
	
	draw.SimpleText(propText, "Core_MainFont_24", propTextPos, 110, Color(255, 255, 255))
	draw.SimpleText("Props Spawned", "Core_MainFont_15", 210, 135, Color(255, 255, 255, 100))

end

derma.DefineControl("sh_playerhud", "", PANEL, "Panel")