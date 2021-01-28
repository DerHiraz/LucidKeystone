local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale("LucidKeystone")
local AddonLib = LibStub("AceAddon-3.0"):GetAddon("LucidKeystone")
local Module = {
    Config = AddonLib:GetModule("Config"),
    General = AddonLib:NewModule("General", "AceConsole-3.0"),
}
local db

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  General Tables
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local msgTable = {
    L["Let the fun begin and good luck!"].."|r",
    L["Okay, lets go!"].."|r",
    L["C'mon mate, rock that key."].."|r",
    L["This Dungeon can be hard, but you will rock that one."].."|r",
    L["Fair enough."].."|r",
    L["Btw, the key is not a lie."].."|r",
    L["Leeeeeeeeeeeeeeeroy!"].."|r",
    L["Millions of years of evolution vs. your fist... lets go!"].."|r",
    L["Keep calm and blame it on the lag."].."|r",
    L["If the Key don't scare your, then it's too low."],
    L["Don't stop until you're Proud."],
    L["Keep in mind, you only fail when you wipe."],
    L["Don't forget to stay hydrated."],
    L["Play. Kill. Deplete. Repeat."],
}

local loot = {
    [2] = 187,
    [3] = 190,
    [4] = 194,
    [5] = 194,
    [6] = 197,
    [7] = 200,
    [8] = 200,
    [9] = 200,
    [10] = 203,
    [11] = 203,
    [12] = 207,
    [13] = 207,
    [14] = 207,
    [15] = 210,
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Function Section
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Option for Autoplace the Keystone into Podestal
local function AutoPlaceKey()
    local auto = db.profile.autoPlace
    local instance = IsInInstance()
    if auto and instance then
        for bag = 0, NUM_BAG_SLOTS do
            for slot = 1, GetContainerNumSlots(bag) do
                local _, _, _, _, _, _, itemName = GetContainerItemInfo(bag, slot)
                
                if itemName and itemName:match("keystone:") then
                    PickupContainerItem(bag, slot)
                    
                    if (CursorHasItem()) then
                        C_ChallengeMode.SlotKeystone()
                    end
                end
            end
        end
    end
end

-- Start Message for the Run
local function GetStartMsg()
    if db.profile.history then
        PlaySound(111365,"Master")
        SELECTED_CHAT_FRAME:AddMessage("|cffff80ff[|cff4859A8Lucid Keystone|cffff80ff]: "..msgTable[math.random(1, #msgTable)]);
    end
end

-- Keypost Function
---- Find Keystone in Bags
local keyID = {
    [138019] = true, -- Legion
    [158923] = true, -- BfA
    [180653] = true, -- Shadowlands
    [151086] = true, -- Tournament
}

local keystone = nil
local function KeyPost(force,guild)
        for bag = 0, NUM_BAG_SLOTS do
            local numSlots = GetContainerNumSlots(bag)
            for slot = 1, numSlots do
                local link, _, _, itemID = select(7, GetContainerItemInfo(bag, slot))
                if keyID[itemID] then
                    if force or (keystone and keystone ~= link) then
                        if guild then
                            SendChatMessage(link, "GUILD")
                        else
                            SendChatMessage(link, "PARTY")
                        end                    
                    end
                    keystone = link
                    return
                end
            end
    end
end

local function OnTooltipSetItem(tooltip, ...)
    name, link = GameTooltip:GetItem()
    if (link == nil) then return end
    local itemString = string.match(link, "item[%-?%d:]+")
    local id = tonumber(string.match(link, "^.-:(%d+):"))




    if id and id == 180653 then
        if not lineAdded then
            --tooltip:AddLine(" ") --blank line
            --tooltip:AddLine("blablabla")
            lineAdded = true
        end
    end
end

local function OnTooltipCleared(tooltip, ...) lineAdded = false end

local function SetHyperlink_Hook(self, hyperlink, text, button)

    local itemString = string.match(hyperlink, "item[%-?%d:]+")
    local id = tonumber(string.match(link, "^.-:(%d+):"))

    if id and id == 180653 then
        --ItemRefTooltip:AddLine(" ") --blank line
        --ItemRefTooltip:AddLine("MyNoteTest")
        ItemRefTooltip:Show()
    end

end
GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
GameTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
hooksecurefunc("ChatFrame_OnHyperlinkShow", SetHyperlink_Hook)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Event Section
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function eventHandler(self, e, ...)
    -- Autoplace Function
    if e == "CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN" then
        AutoPlaceKey()
    end

    -- Start Message Function
    if e == "CHALLENGE_MODE_START" then
        GetStartMsg()
    end

    -- Keypost Function
    if e == "BAG_UPDATE" then
        if db.profile.postCom then
            KeyPost()
        end
    end
    if e == "CHAT_MSG_PARTY" or e == "CHAT_MSG_PARTY_LEADER" then
        if (select(1, ...) == "!keys" or select(1, ...) == "!Keys") and db.profile.postCom then
            KeyPost(true)
        end
    end
    if e == "CHALLENGE_MODE_COMPLETED" then
        if db.profile.autoPost then
            KeyPost(true)
        end
    end
    if e == "CHAT_MSG_GUILD" then
        if (select(1, ...) == "!keys" or select(1, ...) == "!Keys") and db.profile.postCom then
            KeyPost(true, true)
        end
    end

    -- First Use Function
    if e == "PLAYER_LOGIN" and db.profile.InitTest then
        message("hi")
        db.profile.InitTest = false
    end

end

-- Set Events
local function ToggleGeneralFrame()
    LucidKeystoneGeneralFrame = CreateFrame("Frame", "LucidKeystoneGeneralFrame", UIParent)
    local general = LucidKeystoneGeneralFrame
    general:SetScript("OnEvent", eventHandler)
    general:RegisterEvent("CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN")
    general:RegisterEvent("CHALLENGE_MODE_START")
    general:RegisterEvent("CHALLENGE_MODE_COMPLETED")
    general:RegisterEvent("BAG_UPDATE")
    general:RegisterEvent("CHAT_MSG_PARTY")
    general:RegisterEvent("CHAT_MSG_PARTY_LEADER")
    general:RegisterEvent("CHAT_MSG_GUILD")
    general:RegisterEvent("PLAYER_LOGIN")
end

--Initialize function
function Module.General:OnInitialize()
    db = LibStub("AceDB-3.0"):New("LucidKeystoneDB", defaults)
    ToggleGeneralFrame()
end