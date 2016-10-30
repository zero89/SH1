--[[-------------------------------------------------------

Fight to Survive: Stronghold by RoaringCow, TehBigA is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License. 
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, 
444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

---------------------------------------------------------]]
local PANEL = {}

function PANEL:Init()
	self:SetTitle("Loadout")
	self:SetIcon("icon16/bomb.png")
	self:SetDeleteOnClose( false )
	self:SetSize(900, 800)
	
	self.LoadoutPanel = vgui.Create( "sh_loadoutpanel", self)
	
	self.CloseButton = vgui.Create("DButton", self)
	self.CloseButton:SetSize(100, 30)
	self.CloseButton:SetImage("icon16/tick.png")
	self.CloseButton:SetText("Done")
	self.CloseButton:SetPos(0, 0)
	self.CloseButton.DoClick = function() self:Close() end
	
	self.buyLabel = vgui.Create("CELabel", self)
	self.buyLabel:SetText("To buy additional weapons, Press [F3] to open to store")
	self.buyLabel:SetPos(0, 0)
	self.buyLabel:SizeToContents()
	
end

function PANEL:Refresh()
	self.LoadoutPanel:DoRefreshLicenses()
end

function PANEL:RefreshLicenses()
	self.LoadoutPanel:DoRefreshLicenses()
end

function PANEL:RefreshShop()
end

function PANEL:RefreshHats()
end

function PANEL:Open()
	self:Refresh()
	self:Center()
	self:SetVisible( true )
	self:MakePopup()
	RestoreCursorPosition()
end

function PANEL:Close()
	RememberCursorPosition()
	self:SetVisible( false )
	RunConsoleCommand("sh_closedloadoutmenu")
end

function PANEL:OnKeyCodePressed( key )
	if key == KEY_F2 then
		self:Close()
	end
end

function PANEL:PerformLayout(w, h)

	self:WindowBasePerformLayout()
	
	self.LoadoutPanel:SetPos(5, 5)
	self.LoadoutPanel:SetSize(w - 20, h-100)
	
	self.CloseButton:SetPos(w - self.CloseButton:GetWide() - 20, h - self.CloseButton:GetTall() - 50)
	self.buyLabel:SetPos(190, h - 75)

end

vgui.Register( "sh_loadoutmenu", PANEL, "corecontrol_window" )