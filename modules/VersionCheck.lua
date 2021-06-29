local AddonLib = LibStub("AceAddon-3.0"):GetAddon("LucidKeystone")
local Module = {
    VersionC = AddonLib:NewModule("VersionCheck", "AceConsole-3.0"),
}

function Module.VersionC:OnInitialize()
    db = LibStub("AceDB-3.0"):New("LucidKeystoneDB", defaults)
end