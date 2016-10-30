/* MAIN OUTTER PANEL */
local PANEL = {}

function PANEL:Init()

	gui.EnableScreenClicker(true)

	self:SetSize(ScrW(), ScrH())

	self:AddControls()
	
end

function PANEL:AddControls()

	self.Container = vgui.Create("Panel", self)
	self.Container:SetSize(self:GetWide() / 1.1, self:GetTall())
	self.Container:SetPos(0 - self.Container:GetWide(), 0)
	self.Container:MoveTo(self:GetWide() / 2 - self.Container:GetWide() / 2, 0, 0.5)
	
	self.LoadoutTitle = vgui.Create("CELabel", self.Container)
	self.LoadoutTitle:SetColor(Color(255, 255, 255))
	self.LoadoutTitle:SetFont("Core_MainFont_50")
	self.LoadoutTitle:SetText("Loadout")
	self.LoadoutTitle:SetPos(0, 10)
	self.LoadoutTitle:SizeToContents()
	
	//Primary Weapon
	self.catPrimary = vgui.Create("sh_loadoutmenu_wepcat", self.Container)
	self.catPrimary:SetPos(0, self:GetTall() / 2 - self.catPrimary:GetTall() / 2)
	self.catPrimary.OnClick = function()
		self:ShowPrimaryWeapons()
	end
	
	self.catPLbl = vgui.Create("CELabel", self.Container)
	self.catPLbl:SetColor(Color(255, 255, 255))
	self.catPLbl:SetFont("Core_MainFont_30")
	self.catPLbl:SetText("Primary")
	self.catPLbl:SetPos(0, self.Container:GetTall() / 2 - self.catPrimary:GetTall() / 2 - 40)
	self.catPLbl:SizeToContents()
	
	//Secondary Weapon
	self.catSecondary = vgui.Create("sh_loadoutmenu_wepcat", self.Container)
	self.catSecondary:SetPos(self.Container:GetWide() / 2 - self.catSecondary:GetWide() / 2, self.Container:GetTall() / 2 - self.catSecondary:GetTall() / 2)
	
	self.catSLbl = vgui.Create("CELabel", self.Container)
	self.catSLbl:SetColor(Color(255, 255, 255))
	self.catSLbl:SetFont("Core_MainFont_30")
	self.catSLbl:SetText("Secondary")
	self.catSLbl:SetPos(self.Container:GetWide() / 2 - self.catSecondary:GetWide() / 2, self.Container:GetTall() / 2 - self.catSecondary:GetTall() / 2 - 40)
	self.catSLbl:SizeToContents()

	//Explosive
	
	self.catExpl = vgui.Create("sh_loadoutmenu_wepcat", self.Container)
	self.catExpl:SetPos(self.Container:GetWide() - self.catExpl:GetWide(), self.Container:GetTall() / 2 - self.catExpl:GetTall() / 2)

	self.catELbl = vgui.Create("CELabel", self.Container)
	self.catELbl:SetColor(Color(255, 255, 255))
	self.catELbl:SetFont("Core_MainFont_30")
	self.catELbl:SetText("Explosive")
	self.catELbl:SetPos(self.Container:GetWide() - self.catExpl:GetWide(), self.Container:GetTall() / 2 - self.catExpl:GetTall() / 2 - 40)
	self.catELbl:SizeToContents()
	
	self:RefreshLoadout()
	
end

function PANEL:RefreshLoadout()

	local ply 			= LocalPlayer()
	local primary 		= ply:GetLoadoutPrimary()
	local secondary 	= ply:GetLoadoutSecondary()
	local explosive 	= ply:GetLoadoutExplosive()
	
	local primInfo 		= GAMEMODE.PrimaryWeapons[primary]
	
	self.catPrimary:SetWeapon(primInfo.name, primInfo.model)
	
	local secInfo		= GAMEMODE.SecondaryWeapons[secondary]
	
	self.catSecondary:SetWeapon(secInfo.name, secInfo.model)

	local explInfo 		= GAMEMODE.Explosives[explosive]
	
	self.catExpl:SetWeapon(explInfo.name, explInfo.model)
	
end

function PANEL:RemoveLoadoutScreen()

	if(IsValid(self.Container)) then
		self.Container:Remove()
		self.Container = nil
	end

end

function PANEL:ShowLoadoutScreen()

	if(IsValid(self.Container)) then
		self:RemoveLoadoutScreen()
	end
	
	self:AddControls()

end

function PANEL:ShowPrimaryWeapons()

	self.Container:MoveTo(0 - self.Container:GetWide(), 0, 0.5, 0, -1, function()
		self:RemoveLoadoutScreen()
	end)
	
	self.PrimaryContainer = vgui.Create("Panel", self)
	self.PrimaryContainer:SetSize(self:GetWide() / 1.1, self:GetTall())
	self.PrimaryContainer:SetPos(self:GetWide(), 0)
	self.PrimaryContainer:MoveTo(self:GetWide() / 2 - self.PrimaryContainer:GetWide() / 2, 0, 0.5)
	
	local titleLbl = vgui.Create("CELabel", self.PrimaryContainer)
	titleLbl:SetFont("Core_MainFont_50")
	titleLbl:SetColor(Color(255, 255, 255))
	titleLbl:SetText("Primary Weapon")
	titleLbl:SetPos(0, 10)
	titleLbl:SizeToContents()
	
	local weaponsList = vgui.Create("DScrollPanel", self.PrimaryContainer)
	weaponsList:SetPos(0, 70)
	weaponsList:SetSize(self.PrimaryContainer:GetWide(), self.PrimaryContainer:GetTall() - 120)
	
	for k,v in pairs(GAMEMODE.PrimaryWeapons) do
	
		local wep = vgui.Create("sh_loadoutmenu_item", weaponsList)
	
	end
	
	local backButton = vgui.Create("DButton", self)
	backButton:SetSize(100, 30)
	backButton:SetPos(self.PrimaryContainer:GetWide() - backButton:GetWide(), self.PrimaryContainer:GetTall() - backButton:GetTall() - 10)
	backButton:SetText("Back")
	backButton.DoClick = function()
		
		self.PrimaryContainer:MoveTo(self:GetWide(), 0, 0.5, 0, -1, function()
			self.PrimaryContainer:Remove()
		end)
		
		self:ShowLoadoutScreen()
		
	end
	
end

function PANEL:ShowSecondaryWeapons()

end

function PANEL:ShowExplosiveWeapons()


end

function PANEL:OnMousePressed(key)

	if(key == MOUSE_LEFT) then
		gui.EnableScreenClicker(false)
		self:Remove()
	end

end

function PANEL:Paint(w,h)

	Derma_DrawBackgroundBlur(self)
	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))

end

vgui.Register("sh_loadoutmenu2", PANEL, "EditablePanel")

/* Weapon Category */

local PANEL = {}

function PANEL:Init()

	self:SetSize(250, 300)
	self:SetCursor("hand")
	self:AddControls()
end

function PANEL:AddControls()

	self.MdlHandle = vgui.Create("DModelPanel", self)
	self.MdlHandle:SetSize(self:GetWide(), 100)
	self.MdlHandle:SetPos(0, 10)
	self.MdlHandle:SetModel("models/weapons/csgo_world/w_rif_ak47.mdl")
	
	local PrevMins, PrevMaxs = self.MdlHandle.Entity:GetRenderBounds()
	self.MdlHandle:SetCamPos(PrevMins:Distance(PrevMaxs) * Vector (1.1, 1, 1))
	self.MdlHandle:SetLookAt((PrevMaxs + PrevMins) / 2)
	self.MdlHandle:SetFOV(40)
	self.MdlHandle.LayoutEntity = function(ent) end
	self.MdlHandle.RunAnimation = function() end
	
	self.weaponName = vgui.Create("CELabel", self)
	self.weaponName:SetFont("Core_MainFont_24")
	self.weaponName:SetColor(Color(255, 255, 255))
	self.weaponName:SetText("%WEAPON_NAME%")
	self.weaponName:SizeToContents()
	self.weaponName:SetPos(self:GetWide() / 2 - self.weaponName:GetWide() / 2, 110)
	
end

function PANEL:OnMousePressed(key)

	if(key == MOUSE_LEFT) then
		self:OnClick()
	end

end

function PANEL:OnClick()

end

function PANEL:SetWeapon(weaponName, weaponMDL)

	self.MdlHandle:SetModel(weaponMDL)
	self.weaponName:SetText(weaponName)
	self.weaponName:SizeToContents()

	self:InvalidateLayout()
	
end

function PANEL:PerformLayout()

	self.weaponName:SetPos(self:GetWide() / 2 - self.weaponName:GetWide() / 2, 110)

end

function PANEL:Paint(w,h)

	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))

	surface.SetDrawColor(Color(255, 255, 255, 50))
	surface.DrawRect(0, 0, w, 1)
	surface.DrawRect(w-1, 0, 1, h)
	surface.DrawRect(0, h-1, w, 1)
	surface.DrawRect(0, 0, 1, h)

end

vgui.Register("sh_loadoutmenu_wepcat", PANEL, "EditablePanel")

/* LOADOUT ITEM */

local PANEL = {}

function PANEL:Init()

	self:Dock(TOP)
	self:DockMargin(0, 0, 0, 10)
	self:SetTall(40)
	self:AddControls()
	
end

function PANEL:AddControls()

end

function PANEL:SetWeapon(PrintName, MDL, SWEPName)

end

function PANEL:PerformLayout()

end

function PANEL:Paint(w, h)

	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))

	surface.SetDrawColor(Color(255, 255, 255, 50))
	surface.DrawRect(0, 0, w, 1)
	surface.DrawRect(w-1, 0, 1, h)
	surface.DrawRect(0, h-1, w, 1)
	surface.DrawRect(0, 0, 1, h)

end

vgui.Register("sh_loadoutmenu_item", PANEL, "EditablePanel")