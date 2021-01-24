local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale("LucidKeystone")
local AddonLib = LibStub("AceAddon-3.0"):GetAddon("LucidKeystone")
local Module = {
    Config = AddonLib:GetModule("Config"),
    VersionC = AddonLib:NewModule("VersionCheck", "AceConsole-3.0"),
}

local title

local fontColor = {
    yellow  = "|cffffd100%s|r",
}


function Module.Config:VersionCheck()
    return "test"
end

function Module.VersionC:OnInitialize()
    db = LibStub("AceDB-3.0"):New("LucidKeystoneDB", defaults)
    title = GetAddOnMetadata(AddonName, "Title")
    --VersionCheckFrame()
end
