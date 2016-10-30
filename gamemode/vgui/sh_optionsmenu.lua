--[[-------------------------------------------------------

Fight to Survive: Stronghold by RoaringCow, TehBigA is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License. 
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, 
444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

---------------------------------------------------------]]
local PANEL = {}

function PANEL:Init()
	self:SetTitle( "Stronghold: Options Menu" )
	self:SetDeleteOnClose( false )
	self:SetIcon("icon16/cog.png")
	
	self.Sections = {}
	self.Options = vgui.Create( "DPanelList", self )
	self.Options:EnableVerticalScrollbar( true )
	self.Options:SetPadding( 2 )
	
	self.CloseButton = vgui.Create( "DButton", self )
	self.CloseButton:SetText( "Close" )
	function self.CloseButton.DoClick()
		self:Close()
	end
end

function PANEL:Open()
	self:Center()
	self:SetVisible( true )
	self:MakePopup()
	RestoreCursorPosition()
end

function PANEL:Close()
	RememberCursorPosition()
	self:SetVisible( false )
end

function PANEL:AddSection( name )
	local panel = vgui.Create( "DForm", self )
	panel:SetName( name )
	self.Sections[name] = panel
	self.Options:AddItem( panel )
end

function PANEL:AddOption( section, control, ... )
	if !self.Sections[section] then
		self:AddSection( section )
	end

	return self.Sections[section][control]( self.Sections[section], ... )
end

function PANEL:OnKeyCodePressed( key )
	if key == KEY_F4 then
		self:Close()
	end
end

function PANEL:PerformLayout( w, h )
	
	self:WindowBasePerformLayout()
	
	self.Options:SetPos( 0, 0 )
	self.Options:SetSize( w-10, h-44 )
	
	self.CloseButton:SetSize( 60, 22 )
	self.CloseButton:SetPos( w-71, h-33 )
end

vgui.Register( "sh_optionsmenu", PANEL, "corecontrol_window" )