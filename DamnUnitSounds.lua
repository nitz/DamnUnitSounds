--[[
	Shadow, Mal'Ganis (US)
]]

local Sounds = select(2, ...)

-- Focus sounds
function Sounds:PLAYER_FOCUS_CHANGED()
	if( UnitExists("focus") ) then
		if( UnitIsEnemy("focus", "player") ) then
			PlaySound(SOUNDKIT.IG_CREATURE_AGGRO_SELECT)
		elseif( UnitIsFriend("player", "focus") ) then
			PlaySound(SOUNDKIT.IG_CHARACTER_NPC_SELECT)
		else
			PlaySound(SOUNDKIT.IG_CREATURE_NEUTRAL_SELECT)
		end
	else
		PlaySound(SOUNDKIT.INTERFACE_SOUND_LOST_TARGET_UNIT)
	end
end

-- Target sounds
function Sounds:PLAYER_TARGET_CHANGED()
	if( UnitExists("target") ) then
		if( UnitIsEnemy("target", "player") ) then
			PlaySound(SOUNDKIT.IG_CREATURE_AGGRO_SELECT)
		elseif( UnitIsFriend("player", "target") ) then
			PlaySound(SOUNDKIT.IG_CHARACTER_NPC_SELECT)
		else
			PlaySound(SOUNDKIT.IG_CREATURE_NEUTRAL_SELECT)
		end
	else
		PlaySound(SOUNDKIT.INTERFACE_SOUND_LOST_TARGET_UNIT)
	end
end

-- PVP flag sounds
local announcedPVP
function Sounds:UNIT_FACTION(unit, ...)
	if( unit ~= "player" ) then return end

	if( UnitIsPVPFreeForAll("player") or UnitIsPVP("player") ) then
		if( not announcedPVP ) then
			announcedPVP = true
			PlaySound(SOUNDKIT.IG_PVP_UPDATE)
		end
	else
		announcedPVP = nil
	end
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("UNIT_FACTION")
frame:SetScript("OnEvent", function(self, event, ...)
	Sounds[event](Sounds, ...)
end)
