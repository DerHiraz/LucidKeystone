local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale("LucidKeystone")
local AddonLib = LibStub("AceAddon-3.0"):GetAddon("LucidKeystone")
local Module = {
    Config = AddonLib:GetModule("Config"),
    Stat = AddonLib:NewModule("Stat", "AceConsole-3.0"),
}
local db

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Function Section
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Event Handler 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function eventHandler(self, e, ...)
    --Player died in active Run
    if e == "PLAYER_DEAD" and db.profile.start then
        local deaths = db.profile.StartDeaths

        deaths = deaths + 1

        db.profile.StartDeaths = deaths
    end
    if e == "CHALLENGE_MODE_START" then
        --Set MapID of active Run
        db.profile.GetActiveChallengeMapID = C_ChallengeMode.GetActiveChallengeMapID()
        db.profile.StartDeaths = 0
        db.profile.StartVolcanic = 0
        db.profile.DoubleCheckCount = 0
        db.profile.DoubleCheck = false
        local _, affix = C_ChallengeMode.GetActiveKeystoneInfo()
        if affix[3] == 3 then
            db.profile.VolcanicCheck = true
        end
    end
    if e == "CHALLENGE_MODE_COMPLETED" then
        local _, level, time, onTime = C_ChallengeMode.GetCompletionInfo()
        local expansion = GetExpansionLevel()
        local season = C_MythicPlus.GetCurrentSeason()
        local seasonNew
        if season >= 5 then
            seasonNew = season - 4
            season = seasonNew
        end
        local runs = db.profile.runs[expansion][season]
        local today = C_DateAndTime.GetCurrentCalendarTime()
        time = time/1000

        if onTime then
            local bestIntime = db.profile.bestIntime[expansion][season][db.profile.GetActiveChallengeMapID]

            runs[1][db.profile.GetActiveChallengeMapID] = runs[1][db.profile.GetActiveChallengeMapID] +1
            if (bestIntime.level == level and bestIntime.duration > time) or bestIntime.level < level then
                bestIntime.level = level
                bestIntime.duration = time
                bestIntime.date = today.monthDay..Addon.Delimiter[db.profile.DateFormatSep]..today.month..Addon.Delimiter[db.profile.DateFormatSep]..today.year
            end
        else
            local bestOvertime = db.profile.bestOvertime[expansion][season][db.profile.GetActiveChallengeMapID]

            runs[2][db.profile.GetActiveChallengeMapID] = runs[2][db.profile.GetActiveChallengeMapID] +1
            if (bestOvertime.level == level and bestOvertime.duration > time) or bestOvertime.level < level then
                bestOvertime.level = level
                bestOvertime.duration = time
                bestOvertime.date = today.monthDay..Addon.Delimiter[db.profile.DateFormatSep]..today.month..Addon.Delimiter[db.profile.DateFormatSep]..today.year
            end
        end
        local translit = Addon.TimeFormat(time)
        local stars = Addon.GetStars(time,db.profile.GetActiveChallengeMapID)
        table.insert(db.profile.dungeonHistory[expansion][season][db.profile.GetActiveChallengeMapID].level, 1, "+"..level..stars)
        table.insert(db.profile.dungeonHistory[expansion][season][db.profile.GetActiveChallengeMapID].durationTrans, 1, translit)
        table.insert(db.profile.dungeonHistory[expansion][season][db.profile.GetActiveChallengeMapID].date, 1, today.monthDay..Addon.Delimiter[db.profile.DateFormatSep]..today.month..Addon.Delimiter[db.profile.DateFormatSep]..today.year)
        table.insert(db.profile.avglvl[expansion][season][1][db.profile.GetActiveChallengeMapID],level)

        local deathsProfile = db.profile.statistic.deaths
        db.profile.statistic.deaths = db.profile.StartDeaths + deathsProfile
        db.profile.statistic.volcanic = db.profile.statistic.volcanic + db.profile.StartVolcanic
        db.profile.start = false
        db.profile.StartDeaths = nil
        db.profile.StartVolcanic = nil
        db.profile.VolcanicCheck = nil
    end
    if e == "COMBAT_LOG_EVENT_UNFILTERED" and db.profile.start and db.profile.VolcanicCheck then
        local _, message, _, _, _, _, _, _, destName, _, _, spellid = CombatLogGetCurrentEventInfo()
        local name = ""
        local char = UnitName("player")
        if destName then
            name = Ambiguate(destName, "short")
            if message == "SPELL_DAMAGE" and spellid == 209862 and name == char then
                db.profile.StartVolcanic = db.profile.StartVolcanic + 1
            end
        end
    end
end

-- Set Events
local function ToggleStatFrame()
    LucidKeystoneStatFrame = CreateFrame("Frame", "LucidKeystoneStatFrame", UIParent)
    local stat = LucidKeystoneStatFrame
    stat:SetScript("OnEvent", eventHandler)
    stat:RegisterEvent("PLAYER_DEAD")
    stat:RegisterEvent("CHALLENGE_MODE_START")
    stat:RegisterEvent("CHALLENGE_MODE_COMPLETED")
    stat:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

--Initialize function
function Module.Stat:OnInitialize()
    db = LibStub("AceDB-3.0"):New("LucidKeystoneDB", defaults)
    ToggleStatFrame()
end