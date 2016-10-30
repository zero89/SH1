local matBlur 	= Material("pp/blurscreen")
local MAIN 		= {}
local HEADER 	= {}
local TEAM		= {}
local PROW		= {}

/* BASE SCOREBOARD */

function MAIN:Init()

	self:SetSize(ScrW() / 1.2, ScrH() - 220)
	self:SetPos(ScrW() / 2 - self:GetWide() / 2, 40)

	self:AddControls()
	
end

function MAIN:AddControls()

	self.Container = vgui.Create("Panel", self)
	self.Container:Dock(FILL)
	self.Container:DockMargin(10, 60, 10, 10)
	
	self.Header = vgui.Create("cl_scoreboard_header", self.Container)
	self.Header:Dock(TOP)
	self.Header:SetTall(32)
	self.Header:DockMargin(0, 0, 5, 10)
	
	self.Content = vgui.Create("DScrollPanel", self.Container)
	self.Content:Dock(FILL)
	
	self.TeamList = {}
	
	for id,v in pairs(team.GetAllTeams()) do
	
		if(v.Joinable) then
		
			local teamEnt 	= self.TeamList[id]
			local plyCount 	= #team.GetPlayers(id)
			
			if(IsValid(teamEnt)) then
		
				if(plyCount == 0) then
					teamEnt:Remove()
					self.TeamList[id] = nil
				end
			
			else
			
				if(plyCount > 0) then
					self:AddTeam(id)
				end
			
			end
		
		end
	
	end

end

function MAIN:AddTeam(id)

	local sTeam = vgui.Create("cl_scoreboard_team", self.Content)
	sTeam:SetInfo(id)
	sTeam:Dock(TOP)
	sTeam:DockMargin(0, 0, 5, 5)
	
	self.TeamList[id] = sTeam

end

function MAIN:Paint(w, h)

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(matBlur)
	
	local x,y = self:ScreenToLocal(0, 0)
	
	matBlur:SetFloat("$blur", 4)
	matBlur:Recompute()
	render.UpdateScreenEffectTexture()
	surface.DrawTexturedRect(x, y, ScrW(), ScrH(), Color(43,49,54,100))
	matBlur:SetFloat("$blur", 2)
	matBlur:Recompute()
	render.UpdateScreenEffectTexture()
	surface.DrawTexturedRect(x, y, ScrW(), ScrH(), Color(43,49,54,100))
	
	draw.RoundedBox(4, 0, 0, w, h, Color(43,49,54,200))
	
	draw.SimpleText(GetHostName(), "Core_MainFont_30", 10, 15)

end

vgui.Register("cl_scoreboard_main", MAIN, "EditablePanel")

/* HEADER */

function HEADER:Init()

	self.muteCol = vgui.Create("Panel", self)
	self.muteCol:Dock(RIGHT)
	self.muteCol:SetWidth(50)

	self.PingLabel = vgui.Create("CELabel", self)
	self.PingLabel:SetColor(Color(255, 255, 255))
	self.PingLabel:Dock(RIGHT)
	self.PingLabel:SetText("Ping")
	self.PingLabel:SetWidth(100)
	self.PingLabel:SetContentAlignment(5)
	
	self.deathsLabel = vgui.Create("CELabel", self)
	self.deathsLabel:SetColor(Color(255, 255, 255))
	self.deathsLabel:Dock(RIGHT)
	self.deathsLabel:SetText("Deaths")
	self.deathsLabel:SetWidth(100)
	self.deathsLabel:SetContentAlignment(5)
	
	self.killsLabel = vgui.Create("CELabel", self)
	self.killsLabel:SetColor(Color(255, 255, 255))
	self.killsLabel:Dock(RIGHT)
	self.killsLabel:SetText("Kills")
	self.killsLabel:SetWidth(100)
	self.killsLabel:SetContentAlignment(5)
	
	self.scoreLabel = vgui.Create("CELabel", self)
	self.scoreLabel:SetColor(Color(255, 255, 255))
	self.scoreLabel:Dock(RIGHT)
	self.scoreLabel:SetText("Score")
	self.scoreLabel:SetWidth(100)
	self.scoreLabel:SetContentAlignment(5)
	
	self.nameLabel = vgui.Create("CELabel", self)
	self.nameLabel:SetColor(Color(255, 255, 255))
	self.nameLabel:Dock(LEFT)
	self.nameLabel:SetText("Name")
	self.nameLabel:DockMargin(30, 0, 0, 0)
	self.nameLabel:SetWidth(100)
	self.nameLabel:SetContentAlignment(5)
	
end

function HEADER:Paint(w,h)

	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))

end

vgui.Register("cl_scoreboard_header", HEADER, "EditablePanel")

/* TEAM PANELS */

function TEAM:Init()

	self.teamID			= 0
	self.teamName 		= "Unknown Team"
	self.teamColor 		= Color(255, 255, 255)
	self.playerCount	= 0
	self.APlayerCount	= 0
	self.teamMembers	= {}
	self.scoreEntries	= {}
	self:SetTall(30)
	
	self.PlayerList = vgui.Create("Panel", self)
	self.PlayerList:Dock(FILL)
	self.PlayerList:DockMargin(0, 35, 0, 0)
	
end

function TEAM:SetInfo(id)

	self.teamID 	= id
	self.teamName 	= team.GetName(id)
	self.teamColor	= team.GetColor(id)
	
	self:AddPlayers()

end

function TEAM:AddPlayers()
	
	for id, ply in pairs(player.GetAll()) do
		
		if(ply:Team() == self.teamID) then
		
			if(IsValid(ply._ScoreEntry)) then continue end
			
			local scoreEnt = vgui.Create("cl_scoreboard_prow", self.PlayerList)
			scoreEnt:Setup(ply)
			scoreEnt:Dock(TOP)
			scoreEnt:DockMargin(0, 0, 0, 2)
			
			ply._ScoreEntry = scoreEnt
			
			self.playerCount = self.playerCount + 1
			self.APlayerCount = self.APlayerCount + 1
		
		end
	
	end
	
	self:InvalidateLayout()

end

function TEAM:Think()
	
	local teams = team.GetAllTeams()
	
	if not teams[self.teamID] then //Remove disbanded teams
		self:Remove()
		return
	end

end

function TEAM:PerformLayout()

	if not self.doneFirst then
		self.playerCount 	= self.playerCount + 1
		self.doneFirst 		= true
	end
	
	self:SetTall(self.playerCount * 32)

end

function TEAM:Paint(w,h)

	self.teamColor.a = 80

	draw.RoundedBox(0, 0, 0, w, h, self.teamColor)
	
	draw.SimpleText(self.teamName.." ("..self.APlayerCount.." players)", "Core_MainFont_20", 5, 6, Color(255, 255, 255))

end

vgui.Register("cl_scoreboard_team", TEAM, "EditablePanel")

/* PLAYER ROW */

function PROW:Init()

	self:SetTall(30)

	self.RankImage = vgui.Create("DImage", self)
	self.RankImage:Dock(LEFT)
	self.RankImage:SetSize(25, 25)
	self.RankImage:SetImage("owgaming/rankimages/0.png")
	self.RankImage:DockMargin(5, 5, 5, 5)
	
	self.AvatarContainer = vgui.Create("DButton", self)
	self.AvatarContainer:Dock(LEFT)
	self.AvatarContainer:SetSize(22, 22)
	self.AvatarContainer:DockMargin(5, 5, 5, 5)
	self.AvatarContainer.DoClick = function()
	
		self.Player:ShowProfile()
	
	end
	
	self.Avatar = vgui.Create("AvatarImage", self.AvatarContainer)
	self.Avatar:SetSize(22, 22)
	self.Avatar:SetMouseInputEnabled(false)
	
	self.countryContainer = vgui.Create("Panel", self)
	self.countryContainer:Dock(LEFT)
	self.countryContainer:DockMargin(5, 9, 0, 5)
	self.countryContainer:SetSize(16, 11)
	
	self.countryFlag = vgui.Create("DImage", self.countryContainer)
	self.countryFlag:SetImage("flags16/us.png")
	self.countryFlag:SetSize(16, 11)
	self.countryFlag:DockMargin(0, 4, 0, 2)
	
	self.Name = vgui.Create("CELabel", self)
	self.Name:Dock(FILL)
	self.Name:SetColor(Color(255, 255, 255))
	self.Name:DockMargin(10, 5, 5, 5)
	self.Name:SetContentAlignment(4)
	self.Name:SizeToContents()
	
	self.MuteContainer = vgui.Create("Panel", self)
	self.MuteContainer:Dock(RIGHT)
	self.MuteContainer:SetWidth(50)
	self.MuteContainer:SetContentAlignment(5)
	
	self.MuteButton = vgui.Create("DImageButton", self.MuteContainer)
	self.MuteButton:SetSize(16, 16)
	self.MuteButton:SetPos(5, 5)
	self.MuteButton:SetImage("icon16/sound.png")
	self.MuteButton.DoClick = function()
	
		if IsValid(self.Player) and self.Player != LocalPlayer() then
			self.Player:SetMuted(not self.Player:IsMuted())
		end
	
	end
	
	self.Ping = vgui.Create("CELabel", self)
	self.Ping:Dock(RIGHT)
	self.Ping:SetColor(Color(255, 255, 255))
	self.Ping:SetWidth(100)
	self.Ping:SetText("999")
	self.Ping:DockMargin(0, 0, 0, 0)
	self.Ping:SetContentAlignment(5)
	
	self.Deaths = vgui.Create("CELabel", self)
	self.Deaths:Dock(RIGHT)
	self.Deaths:SetColor(Color(255, 255, 255))
	self.Deaths:SetWidth(100)
	self.Deaths:SetText("0")
	self.Deaths:DockMargin(0, 0, 0, 0)
	self.Deaths:SetContentAlignment(5)
	
	self.Kills = vgui.Create("CELabel", self)
	self.Kills:Dock(RIGHT)
	self.Kills:SetColor(Color(255, 255, 255))
	self.Kills:SetWidth(100)
	self.Kills:SetText("0")
	self.Kills:DockMargin(0, 0, 0, 0)
	self.Kills:SetContentAlignment(5)
	
	self.Score = vgui.Create("CELabel", self)
	self.Score:Dock(RIGHT)
	self.Score:SetColor(Color(255, 255, 255))
	self.Score:SetWidth(100)
	self.Score:SetText("0")
	self.Score:DockMargin(0, 0, 0, 0)
	self.Score:SetContentAlignment(5)
	
	self.DisplayCoin = vgui.Create("DImage", self)
	self.DisplayCoin:Dock(RIGHT)
	self.DisplayCoin:SetWidth(25)
	//self.DisplayCoin:SetImage("owgaming/coins/service_medal_2016_lvl1.png")
	self.DisplayCoin:DockMargin(10, 2, 0, 2)
	
	self.VIPStatus = vgui.Create("Panel", self)
	self.VIPStatus:Dock(RIGHT)
	self.VIPStatus:SetWidth(120)
	self.VIPStatus.Paint = function(pnl, w, h)
		//draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
	end

end

function PROW:Think()

	if not IsValid(self.Player) then
		self:Remove()
		return
	end

	if(self.Player != LocalPlayer()) then
	
		local muted = self.Player:IsMuted()
		
		self.MuteButton:SetImage(muted and "icon16/sound_mute.png" or "icon16/sound.png")
	
	else
		self.MuteButton:Hide()
	end

end

function PROW:Setup(ply)

	if not IsValid(ply) then
		self:Remove()
		return
	end

	self.Player = ply
	
	self.Avatar:SetPlayer(ply)
	self.Name:SetText(ply:Nick())
	self.Name:SizeToContents()
	
	if ply:GetNWBool("isVIP", false) and not ply:GetNWBool("VIP.HideStatus", false) then 
	
		local VIPLevel 	= ply:GetNWInt("VIPLevel", 1)
		local VIPInfo 	= VIPINFO[VIPLevel]
		local VIPIcon	= getVIPIcon(ply)
		
		self.VIPIcon = vgui.Create("DImage", self.VIPStatus)
		self.VIPIcon:SetSize(16, 16)
		self.VIPIcon:SetPos(5, 7)
		self.VIPIcon:SetImage(VIPIcon)
		
		self.VIPText = vgui.Create("CELabel", self.VIPStatus)
		self.VIPText:SetColor(VIPInfo.color)
		self.VIPText:SetText(VIPInfo.name)
		self.VIPText:SizeToContents()
		self.VIPText:SetPos(31, 7)
		self.VIPText:SetExpensiveShadow(1, Color(0, 0, 0))
	
	end

end

function PROW:Paint(w,h)

	if(!IsValid(self.Player)) then
		self:Remove()
		return
	end
	
	if(self.RankNum == nil || self.RankNum != self.Player:GetNWInt("stat_rank", 0)) then
		self.RankNum = self.Player:GetNWInt("stat_rank", 0)
		self.RankImage:SetImage("owgaming/rankimages/"..self.RankNum..".png")
	end
		
	if(self.NumPing == nil || self.NumPing != self.Player:Ping()) then
		self.NumPing = self.Player:Ping()
		self.Ping:SetText(self.NumPing)
	end
	
	if(self.NumKills == nil || self.NumKills != self.Player:Frags()) then
		self.NumKills = self.Player:Frags()
		self.Kills:SetText(self.NumKills)
	end
	
	if(self.NumDeaths == nil || self.NumDeaths != self.Player:Deaths()) then
		self.NumDeaths = self.Player:Deaths()
		self.Deaths:SetText(self.NumDeaths)
	end
	
	if(self.NumScore == nil || self.NumScore != self.Player:GetNWInt("stat_currentScore", 0)) then
		self.NumScore = self.Player:GetNWInt("stat_currentScore", 0)
		self.Score:SetText(self.NumScore)
	end
	
	if(self.Country == nil || self.Country != getCountryFlag(self.Player)) then
	
		self.Country = getCountryFlag(self.Player)
		self.countryFlag:SetImage(self.Country)
	
	end
	
	if(self.VIPColor == nil || self.VIPColor != util.JSONToTable(self.Player:GetNWString("VIP.ScoreboardColor", util.TableToJSON(Color(255, 255, 255))))) then
	
		if self.Player:IsGoldVIP() then 
		
			local goldColor = self.Player:GetNWString("VIP.ScoreboardColor", util.TableToJSON(Color(255, 255, 255)))
			local convColor = util.JSONToTable(goldColor)
		
			self.VIPColor = convColor
		
			self.Name:SetColor(convColor)
		
		end
	
	end
	
	if(self.DisplayCoinData == nil || self.DisplayCoinData != self.Player:GetNWInt("m_DisplayCoin", 0)) then
	
		self.DisplayCoinData = self.Player:GetNWInt("m_DisplayCoin", 0)
		
		if self.DisplayCoinData > 0 then
		
			local coinITEM = SH_STORE:GetItem(self.DisplayCoinData)
			
			if coinITEM != nil then
			
				self.DisplayCoin:SetImage(coinITEM.InventoryImage)
			
			end
		
		else
			self.DisplayCoin.m_Material = false
		end
	
	end
	
	self:SetZPos((self.NumScore * - 50) + self.NumDeaths)
	
	draw.RoundedBox(0, 0, 0, w, h, Color(5, 5, 5, 100))

end

vgui.Register("cl_scoreboard_prow", PROW, "EditablePanel")

/* SCOREBOARD CODE */
local scorePanel = nil

function GM:ScoreboardShow()

	if not IsValid(scorePanel) then
		scorePanel = vgui.Create("cl_scoreboard_main")
	end
	
	if(IsValid(scorePanel)) then
		scorePanel:Show()
		scorePanel:MakePopup()
		scorePanel:SetKeyboardInputEnabled(false)
	end
	
	return false

end

function GM:ScoreboardHide()

	if(IsValid(scorePanel)) then
		//scorePanel:Hide()
		scorePanel:Remove()
		scorePanel = nil
	end

end