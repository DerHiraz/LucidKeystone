local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale("LucidKeystone")
local AddonLib = LibStub("AceAddon-3.0"):GetAddon("LucidKeystone")
local Module = {
    Config = AddonLib:GetModule("Config"),
    Stat = AddonLib:NewModule("Stat", "AceConsole-3.0"),
}
local db

local fontColor = {
    yellow  = "|cffffd100%s|r",
    blue    = "|cff009dd5%s|r",
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Function Section
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Time formating for every Timer in Frame
local function TimeFormat(time) 
    local format_minutes = "%.2d:%.2d"
    local format_hours = "%d:%.2d:%.2d"
    local prefix = " "
    if time < 0 then
        time = time * -1
        prefix = "-"
    end
    local seconds = time % 60 -- seconds/min
    local minutes = math.floor((time / 60) % 60) -- min/hr
    local hours = math.floor(time / 3600)
    if hours == 0 then
        return prefix .. string.format(format_minutes, minutes, seconds)
    else
        return prefix .. string.format(format_hours, hours, minutes, seconds)
    end
end

-- Get Stars for Runs
local function GetStars(time, zoneID)
    local _,_,maxTime = C_ChallengeMode.GetMapUIInfo(zoneID)
    if time == 0 then
        return ""
    elseif time < maxTime*0.6 then
        return fontColor.yellow:format("***")
    elseif time < maxTime*0.8 then
        return fontColor.yellow:format("**")
    elseif time < maxTime then
        return fontColor.yellow:format("*")
    else
        return ""
    end
end

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
                bestIntime.date = today.monthDay.."."..today.month.."."..today.year
            end
        else
            local bestOvertime = db.profile.bestOvertime[expansion][season][db.profile.GetActiveChallengeMapID]

            runs[2][db.profile.GetActiveChallengeMapID] = runs[2][db.profile.GetActiveChallengeMapID] +1
            if (bestOvertime.level == level and bestOvertime.duration > time) or bestOvertime.level < level then
                bestOvertime.level = level
                bestOvertime.duration = time
                bestOvertime.date = today.monthDay.."."..today.month.."."..today.year
            end
        end
        local translit = TimeFormat(time)
        local stars = GetStars(time,db.profile.GetActiveChallengeMapID)
        table.insert(db.profile.dungeonHistory[expansion][season][db.profile.GetActiveChallengeMapID].level, 1, "+"..level..stars)
        table.insert(db.profile.dungeonHistory[expansion][season][db.profile.GetActiveChallengeMapID].durationTrans, 1, translit)
        table.insert(db.profile.dungeonHistory[expansion][season][db.profile.GetActiveChallengeMapID].date, 1, today.monthDay.."."..today.month.."."..today.year)
        table.insert(db.profile.avglvl[expansion][season][1][db.profile.GetActiveChallengeMapID],level)

        local deathsProfile = db.profile.statistic.deaths
        db.profile.statistic.deaths = db.profile.StartDeaths + deathsProfile
        db.profile.start = false
        db.profile.StartDeaths = nil
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
end

--Initialize function
function Module.Stat:OnInitialize()
    db = LibStub("AceDB-3.0"):New("LucidKeystoneDB", defaults)
    ToggleStatFrame()
end