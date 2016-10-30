--[[-------------------------------------------------------

Fight to Survive: Stronghold by RoaringCow, TehBigA is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License. 
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, 
444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

---------------------------------------------------------]]

local PANEL = {}

function PANEL:Init()

	self:SetSize(750, 550)
	self:SetTitle("Team Menu")
	self:SetIcon("icon16/group.png")
	self:Center()
	self:MakePopup()
	self:SetDeleteOnClose(false)
	self:SetVisible(true)
	
	self:AddControls()
	self:UpdateList()
	
end

function PANEL:AddControls()

	self.TeamsList = vgui.Create( "sh_teamlistview", self )
	function self.TeamsList.OnRowSelected( panel, lineid, line )
		self.JoinPanel:SetTeam( line:GetTeam() )
	end
	
	self.Refresh = vgui.Create( "DButton", self )
	self.Refresh:SetText("Refresh List")
	self.Refresh:SetImage("icon16/arrow_refresh.png")
	function self.Refresh.DoClick()
		self:UpdateList()
	end
	
	self.Sections = vgui.Create("DPropertySheet", self) //vgui.Create("sh_propertysheet", self)
	
	self.JoinPanel = vgui.Create("sh_teamjoinpanel", self.Sections)
	self.JoinPanel:SetFrame(self)
	self.Sections:AddSheet("Selected Team", self.JoinPanel, "icon16/group.png")
	
	self.CreatePanel = vgui.Create("sh_teamcreatepanel", self.Sections)
	self.Sections:AddSheet("Create team", self.CreatePanel, "icon16/group_add.png")
	
	self.ManagePanel = vgui.Create("sh_teammanagepanel", self.Sections)
	self.Sections:AddSheet("Manage team", self.ManagePanel, "icon16/pencil.png")
	
	self.PasswordLabel = vgui.Create("CELabel", self)
	self.PasswordLabel:SetText("Password:")
	self.Password = vgui.Create("DTextEntry", self)
	
	self.Join = vgui.Create("DButton", self)
	self.Join:SetText("Join")
	self.Join:SetImage("icon16/add.png")
	
	function self.Join.DoClick()
		if self.m_iCurrentTeam == -1 then return end
		RunConsoleCommand( "sh_jointeam", (GAMEMODE.Teams[self.m_iCurrentTeam] and GAMEMODE.Teams[self.m_iCurrentTeam].Name or ""), self.Password:GetValue() )
	end
	
	self.Leave = vgui.Create( "DButton", self )
	self.Leave:SetText("Leave")
	self.Leave:SetImage("icon16/door_open.png")
	function self.Leave:DoClick()
		RunConsoleCommand("sh_leaveteam")
	end
	
	self.m_iCurrentTeam = -1
	self.m_LastUpdate = 0

end

function PANEL:Open()
	self:UpdateList()
	self:Center()
	self:SetVisible( true )
	self:MakePopup()
	RestoreCursorPosition()
end

function PANEL:Close()
	RememberCursorPosition()
	self:SetVisible(false)
end

function PANEL:OnKeyCodePressed( key )
	if key == KEY_F1 then
		self:Close()
	end
end

function PANEL:UpdateList()
	for i, _ in pairs(GAMEMODE.Teams) do
		local found = false
		for _, line in pairs(self.TeamsList.Lines) do
			if line:GetTeam() == i then found = true end
		end
		if !found then self.TeamsList:AddTeam( i ) end
	end
	for i, line in pairs(self.TeamsList.Lines) do
		local index = line:GetTeam()
		local tbl = GAMEMODE.Teams[index]
		if !tbl then
			self.TeamsList:RemoveLine( i )
		else
			line:SetColumnText( 3, (IsValid(tbl.Leader) and tbl.Leader:GetName() or "<No Leader>") )
			line:SetColumnText( 4, #team.GetPlayers(index) )
			line:SetColumnText( 5, team.TotalFrags(index) )
			line:SetColumnText( 6, team.TotalDeaths(index) )
		end
	end
end

function PANEL:PerformLayout(w, h)

	self:WindowBasePerformLayout()
	
	self.TeamsList:SetPos(5, 5)
	self.TeamsList:SetSize( w-20, 150 )
	
	self.Refresh:SetPos(w - 125, 160)
	self.Refresh:SetSize(110, 20)
	
	self.Sections:SetPos(5, 180)
	self.Sections:SetSize(w-20, 280)
	
	self.PasswordLabel:SizeToContents()
	self.PasswordLabel:SetTall(22)
	self.PasswordLabel:SetPos(10, h-73)
	
	self.Password:SetSize(150, 22)
	self.Password:SetPos(self.PasswordLabel:GetWide()+23, h-73)
	
	self.Join:SetSize(70, 22)
	self.Join:SetPos((self.PasswordLabel:GetWide()+178), h-73)
	
	self.Leave:SetSize(80, 22)
	self.Leave:SetPos((self.PasswordLabel:GetWide()+253), h-73)
	
end

vgui.Register("sh_teammenu", PANEL, "corecontrol_window")