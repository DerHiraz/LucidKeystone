local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale("LucidKeystone")
local AddonLib = LibStub("AceAddon-3.0"):GetAddon("LucidKeystone")
local Module = {
    Config = AddonLib:GetModule("Config"),
    Timer = AddonLib:NewModule("Timer", "AceConsole-3.0"),
}
local db
local activeRun = false

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Preview Defaults
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local previewSettings = {
    ZoneID      = 381,
    time        = 1529,
    level       = 16,
    deaths      = 7,
    mobPerc     = 89.72,
    mobCurPerc  = 2.64,
    tormCount   = 3,
    bosses      = {
                "|cff777777"..L["Johnny Awesome defeated"].."   1/1   |cff4cff00|r", 
                "|cff777777"..L["Innocent Cat defeated"].."   1/1   |cff4cff00|r", 
                "|r|r"..L["Pink fluffy Unicorn defeated"].."   0/1", 
                "|r"..L["Hello Kitty defeated"].."   0/1",
                },
    bossesTwo   = {
                "|cff777777"..L["Johnny Awesome defeated"].."   1/1   |cff4cff0007:03|r", 
                "|cff777777"..L["Innocent Cat defeated"].."   1/1   |cff4cff0023:16|r", 
                "|r|r"..L["Pink fluffy Unicorn defeated"].."   0/1", 
                "|r"..L["Hello Kitty defeated"].."   0/1",
                },
    bossesAbs   = {
                "|cff777777"..L["Johnny Awesome defeated"].."   1/1   |cff4cff0007:03   |cff4fc3f7[06:41]|r", 
                "|cff777777"..L["Innocent Cat defeated"].."   1/1   |cff4cff0023:16   |cff4fc3f7[24:26]|r", 
                "|r|r"..L["Pink fluffy Unicorn defeated"].."   0/1", 
                "|r"..L["Hello Kitty defeated"].."   0/1",
                },
    bossesRel   = {
                "|cff777777"..L["Johnny Awesome defeated"].."   1/1   |cff4cff0007:03   |cff4fc3f7[+00:22]|r", 
                "|cff777777"..L["Innocent Cat defeated"].."   1/1   |cff4cff0023:16   |cff4fc3f7[-01:10]|r", 
                "|r|r"..L["Pink fluffy Unicorn defeated"].."   0/1", 
                "|r"..L["Hello Kitty defeated"].."   0/1",
                },
    deathlog    = {
                [CreateAtlasMarkup("UI-Frame-HealerIcon").." |cff006fdc"..L["Thrall"].."|r"] = 2,
                [CreateAtlasMarkup("UI-Frame-DpsIcon").." |cffa9d271"..L["Sylvanas"].."|r"] = 1,
                [CreateAtlasMarkup("UI-Frame-TankIcon").." |cffc59a6c"..L["Garrosh"].."|r"] = 1,
                [CreateAtlasMarkup("UI-Frame-DpsIcon").." |cffc31d39"..L["Arthas"].."|r"] = 2,
                [CreateAtlasMarkup("UI-Frame-DpsIcon").." |cff3ec6ea"..L["Jaina"].."|r"] = 1,
                },
    dungeonName = Addon.MapID,
    affixIcon   = {
                [1]   = {icon = 463570,},  --Overflowing
                [2]   = {icon = 135994},  --Skittish
                [3]   = {icon = 451169},  --Volcanic
                [4]   = {icon = 1029009}, --Necrotic
                [5]   = {icon = 136054},  --Teeming
                [6]   = {icon = 132345},  --Raging
                [7]   = {icon = 132333},  --Bolstering
                [8]   = {icon = 136124},  --Sanguine
                [9]   = {icon = 236401},  --Tyrannical
                [10]  = {icon = 463829},  --Fortified
                [11]  = {icon = 1035055}, --Bursting
                [12]  = {icon = 132090},  --Grievous
                [13]  = {icon = 2175503}, --Explosive
                [14]  = {icon = 136025},  --Quaking
                [15]  = {icon = 132739},  --Relentless
                [16]  = {icon = 2032223}, --Infested
                [117] = {icon = 2446016}, --Reaping
                [119] = {icon = 237565},  --Beguiling
                [120] = {icon = 442737},  --Awakened
                [121] = {icon = 3528307}, --Prideful
                [122] = {icon = 135946},  --Inspiring
                [123] = {icon = 135945},  --Spiteful
                [124] = {icon = 136018},  --Storming
                [128] = {icon = 3528304}, --Tormented
                },
    AffixNil    = {
                [1]={
                    id=9,
                    seasonID=0
                    },
                [2]={
                    id=7,
                    seasonID=0
                    },
                [3]={
                    id=4,
                    seasonID=0
                    },
                [4]={
                    id=121,
                    seasonID=0
                    }
                },
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  General Tables and Arrays
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local imgfile = {
    --Normal
    [1] = "lk_bg_None",
    [2] = "lk_bg_Blizzard",
    [3] = "lk_bg_Horde",
    [4] = "lk_bg_Alliance",
    [5] = "lk_bg_Marble",
    [6] = "lk_bg_Color",
    [7] = "lk_bg_DarkGlass",
    [10] = "lk_bg_Paradox",
    --Affix
    [21] = "lk_bg_Awakened",
    [22] = "lk_bg_Prideful",
    [23] = "lk_bg_Tormented",
    --Covenants
    [31] = "lk_bg_Kyrian",
    [32] = "lk_bg_Necrolord",
    [33] = "lk_bg_NightFae",
    [34] = "lk_bg_Venthyr",
}

local timeThrottle = nil

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Function Section
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function MovableCheck()
    LucidKeystoneFrame:SetMovable(db.profile.unlock)
end

-- Get Time for active Run
local function GetElapsedTime()
    local _, elapsed_time = GetWorldElapsedTime(1)
    
    if elapsed_time then
        local last_elapsed_time = elapsed_time
        return elapsed_time
    end
    return last_elapsed_time
end

-- Deaths in active Run
local function GetDeaths()
    local deaths = C_ChallengeMode.GetDeathCount()
    local names = {}
    local num = {}

    if not db.profile.holdStart then
        Addon.DeathLog = previewSettings.deathlog
    end
    for k,v in Addon.spairs(Addon.DeathLog, function(t,a,b) return t[b] < t[a] end) do
        if k then
            table.insert(names, k)
            table.insert(num, v)
        end
    end
    return deaths or 0, names, num
end

-- Mob Count for active Run
local function GetMobCount()
    local _,_,steps = C_Scenario.GetStepInfo()
    -- last scenario step is the mob count
    local _, _, _, percent, total, _, _, current = C_Scenario.GetCriteriaInfo(steps)
    if current then
        current = tonumber(string.sub(current, 1, string.len(current) - 1))
    end
    return current or 0, total or 1, percent or 0
end

-- Bosses Killed in active Run
local function UpdateBosses()
    local f = LucidKeystoneFrame
    local before = db.profile.bestBeforeStart
    if db.profile.bosses == 2 then

        -- Simple display for Bosses
        local simple = {}
        for i = 1, 10 do
            local _,_,_,kill,killOf = C_Scenario.GetCriteriaInfo(i)
            if killOf == 1 then
                table.insert(simple, kill)
            end
        end

        local count = 0
        for _,v in ipairs(simple) do
            if v == 1 then
                count = count + 1
            end
        end
        f.textBosses:SetText(count.."/"..#simple)
        db.profile.GetBossesMSG = count.."/"..#simple
    elseif db.profile.bosses == 3 then

        -- Extended display for Bosses
        local extended = {}
        local level = C_ChallengeMode.GetActiveKeystoneInfo()
        local mapID = db.profile.GetActiveChallengeMapID
        for i = 1, 10 do
            local name,_,_,kill,killOf,_,_,_,_,_,killTime = C_Scenario.GetCriteriaInfo(i)
            local _, selina = GetWorldElapsedTime(1)
            if killOf == 1 then
                name = name.."   "..kill.."/"..killOf
                if kill == killOf then
                    name = "|cff777777"..name
                    if db.profile.dungeonBestBoss[mapID][level][i].duration > (selina - killTime) then
                        db.profile.dungeonBestBoss[mapID][level][i].duration = selina - killTime
                    end
                    if db.profile.timeStamp then
                        local before = 100000
                        local plus = false
                        if db.profile.bestBefore == 2 or db.profile.bestBefore == 4 then
                            before = db.profile.bestBeforeStart[i]
                        elseif (db.profile.bestBefore == 3 or db.profile.bestBefore == 5) and db.profile.bestBeforeStart[i] < 100000 then
                            before = selina - killTime - db.profile.bestBeforeStart[i]
                            plus = true
                        end

                        if before < 100000 then
                            before = "  ["..Addon.TimeFormat(before,plus).."]|r"
                        else
                            before = "|r"
                        end
                        
                        killTime = date("%M:%S", selina - killTime)
                        name = name.."   |cff4cff00"..killTime.."|cff4fc3f7"..before
                    end
                end
                table.insert(extended, name.."|r")
            end
        end
        --she's the girl i fell in love with
        f.textBosses:SetText(table.concat(extended, "|r\n"))
    end
end

-- Update Season Adds

function Addon.UpdateSeasonAdds()
    Module.Config:SeasonMobs()
end

-- Update mobs in Mobcount
local function UpdateMobs()
    local current, total = GetMobCount()
    local before = current / total * 100
    local red, time, new, cur, cur2 = false, GetTime(), "", "", ""
    local _,affix = C_ChallengeMode.GetActiveKeystoneInfo()
    local colorBefore, colorInd, colorRed = "FFffffff", "ff4cff00", "ffe22b2a"
    local strBefore = string.format("|c%s%.2f%%|r", colorBefore, before)

    -- Turn Color to red for prideful
    if ((before < 20 and db.profile.PullCheck+before >= 20) or
    (before < 40 and db.profile.PullCheck+before >= 40) or
    (before < 60 and db.profile.PullCheck+before >= 60) or
    (before < 80 and db.profile.PullCheck+before >= 80) or
    (before < 100 and db.profile.PullCheck+before >= 100)) and affix[4] == 121 then
        cur = string.format("\n|c%s+%.2f%%|r", colorRed, db.profile.currentPullCount)
        cur2 = string.format("\n|c%s%.2f%%|r", colorRed, db.profile.currentPullCount+before)
        Addon.DoubleCheck = true
        if not db.profile.sound and db.profile.pridefulAlertT and IsAddOnLoaded("MythicDungeonTools") --[[and affix[4] == 121]] and Addon.DoubleCheck and Addon.DoubleCheckCount >= 2 then
            if not timeThrottle or time-timeThrottle > 90 then
                timeThrottle = time
                db.profile.sound = true
                PlaySoundFile(AceGUIWidgetLSMlists.sound[db.profile.pridefulAlertSound], "Master")
                Addon.DoubleCheck = false
                Addon.DoubleCheckCount = 0
            end
        end

        red = true
    else
        db.profile.sound = false
        cur = string.format("\n|c%s+%.2f%%|r", colorInd, db.profile.currentPullCount)
        cur2 = string.format("\n|c%s%.2f%%|r", colorInd, db.profile.currentPullCount+before)
    end
    
    local f = LucidKeystoneFrame
    db.profile.GetPull = string.format("%.2f",before)

    if db.profile.MobPercStep then

        if db.profile.MobPullConf == 2 and db.profile.currentPullCount > 0 then
            strBefore = strBefore..cur
        elseif db.profile.MobPullConf == 3 and db.profile.currentPullCount > 0 then
            strBefore = strBefore..cur2
        end
        f.textMobs:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 15, "OUTLINE")
        f.textMobs:SetText(strBefore)
    else
        if db.profile.MobPullConf == 2 and db.profile.currentPullCount > 0 then
            if red then
                new = string.format("\n|c%s+%d|r", colorRed, db.profile.currentPullCount)
            else
                new = string.format("\n|c%s+%d|r", colorInd, db.profile.currentPullCount)
            end
        elseif db.profile.MobPullConf == 3 and db.profile.currentPullCount > 0 then
            if red then
                new = string.format("\n|c%s%d|r", colorRed, db.profile.currentPullCount+current)
            else
                new = string.format("\n|c%s%d|r", colorInd, db.profile.currentPullCount+current)
            end
        end
        f.textMobs:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 13, "OUTLINE")
        f.textMobs:SetText(current.." / "..total..new)
    end
    local bar = LucidKeystoneFrameBarPerc
    if db.profile.invertPerc then
        bar:SetValue(100-before)
    else
        bar:SetValue(before)
    end
end

-- Timer Function for active Run
local function bootlegRepeatingTimer()
    if db.profile.start then
        local time = GetElapsedTime()
        local _,_,maxTime = C_ChallengeMode.GetMapUIInfo(db.profile.GetActiveChallengeMapID)
        if Addon.DoubleCheck == true then
            Addon.DoubleCheckCount = Addon.DoubleCheckCount + 1
            UpdateMobs()
            if Addon.DoubleCheckCount >= 3 then
                Addon.DoubleCheck = false
            end
        end
        db.profile.GetCurrentTime = Addon.TimeFormat(time).."/"..Addon.TimeFormat(maxTime)

        if not maxTime then
            return
        else
            local level = C_ChallengeMode.GetActiveKeystoneInfo()
            local f = LucidKeystoneFrame
            local bar = LucidKeystoneFrameBar
            local timeSmall = time

            -- Main Timer
            if db.profile.mainTimer == 2 then
                time = maxTime-time
            end
            if db.profile.mainTimer == 1 then
                timeSmall = maxTime-timeSmall
            end

            -- Smart Timer Only
            if db.profile.smartTimer then
                local timer = time
                if db.profile.mainTimer == 2 then
                    timer = timeSmall
                end
                if f.textTimerOne:IsShown() then
                    f.textTimerOne:Hide()
                    f.textTimerThree:Hide()
                end

                local smartTime
                local plus3 = maxTime*0.6-timer
                local plus2 = maxTime*0.8-timer
                local plus1 = maxTime-timer
                local plusSmartOne = Addon.TimeFormat(maxTime-timer)
                
                if plus3 >= 0 then smartTime = "+3\n"..Addon.TimeFormat(plus3) elseif
                plus2 >= 0 then smartTime = "+2\n"..Addon.TimeFormat(plus2) elseif
                plus1 >= 0 then smartTime = "+1\n"..Addon.TimeFormat(plus1) elseif
                plus1 <= 0 then smartTime = L["Over by"].." |cffC43333"..plusSmartOne
                end
                f.textTimerTwo:SetText(smartTime)
            else
                local timer = time
                if db.profile.mainTimer == 2 then
                    timer = timeSmall
                end
                f.textTimerOne:SetText("+1\n"..Addon.TimeFormat(maxTime))
                f.textTimerTwo:SetText("+2\n"..Addon.TimeFormat(maxTime*0.8-timer))
                f.textTimerThree:SetText("+3\n"..Addon.TimeFormat(maxTime*0.6-timer))
            end
            
            -- Set Timer to Frame
            local grave = CreateAtlasMarkup("poi-graveyard-neutral")
            bar:SetMinMaxValues(0,maxTime)
            if db.profile.mainTimer == 1 then
                bar:SetValue(maxTime-time)
            elseif db.profile.mainTimer == 2 then
                bar:SetValue(maxTime-timeSmall)
            end
            f.textLevel:SetText(Addon.GetScoreColor(level*100)..level.."|r")
            f.textTimer:SetText(Addon.TimeFormat(time))
            f.textTimerSmall:SetText(Addon.TimeFormat(timeSmall))
            f.textDeaths:SetText(grave.." "..GetDeaths().."\n-"..Addon.TimeFormat(GetDeaths()*5))
            C_Timer.After(1, bootlegRepeatingTimer)
        end
    end
end

-- Mobupdate on Preview
function Module.Config:MobUpdateConfig()
    local current, total = 256, 285
    local mobPerc, mobCurPerc = previewSettings.mobPerc, previewSettings.mobCurPerc
    local f = LucidKeystoneFrame
    if db.profile.MobPercStep then
        f.textMobs:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 15, "OUTLINE")
        if db.profile.MobPullConf == 2 and IsAddOnLoaded("MythicDungeonTools") then
            f.textMobs:SetText(mobPerc.."%\n|cff4cff00+"..mobCurPerc.."%|r")
        elseif db.profile.MobPullConf == 3 and IsAddOnLoaded("MythicDungeonTools") then
            f.textMobs:SetText(mobPerc.."%\n|cff4cff00"..mobCurPerc+mobPerc.."%|r")
        else
            f.textMobs:SetText(mobPerc.."%")
        end
    else
        f.textMobs:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 13, "OUTLINE")
        if db.profile.MobPullConf == 2 then
            f.textMobs:SetText(current.." / "..total.."\n|cff4cff00+8|r")
        elseif db.profile.MobPullConf == 3 then
            f.textMobs:SetText(current.." / "..total.."\n|cff4cff00264|r")
        else
            f.textMobs:SetText(current.." / "..total)
        end
    end
end

-- Get Dungeon Name
local function UpdateDungeonName()
    if db.profile.dungeonName == 2 then
        LucidKeystoneFrame.textDungeon:SetText(C_ChallengeMode.GetMapUIInfo(db.profile.GetActiveChallengeMapID))
    elseif db.profile.dungeonName == 3 then
        LucidKeystoneFrame.textDungeon:SetText(previewSettings.dungeonName[db.profile.GetActiveChallengeMapID].ShortName)
    end
end

local function GetBestBefore()
    local level, mapID = C_ChallengeMode.GetActiveKeystoneInfo(), db.profile.GetActiveChallengeMapID
    local newLevel = 1
    db.profile.bestBeforeStart = {}
    for i = 1, 10 do
        local _,_,_,_,killOf = C_Scenario.GetCriteriaInfo(i)
        if killOf == 1 then
            local before
            if db.profile.bestBefore == 2 or db.profile.bestBefore == 3 then
                for n = 1, level do
                    if db.profile.dungeonBestBoss[mapID][n][i].duration < 100000 then
                        newLevel = n
                    end
                end
            end
            if db.profile.dungeonBestBoss[mapID][newLevel][i].duration < 100000 then
                before = db.profile.dungeonBestBoss[mapID][newLevel][i].duration
            else
                before = 100000
            end
            table.insert(db.profile.bestBeforeStart, before)
        end
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Event Handler 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function eventHandler(self, e, ...)
    if e == "CHALLENGE_MODE_START" then
        local p = db.profile
        Module.Config.ToggleFrames()
        ObjectiveTrackerFrame:Hide()
        LucidKeystoneFrame:Show()
        p.start = true
        p.currentPull = 0.0
        p.currentPullCount = 0.0
        p.PullCheck = 0.0
        p.KillTimes = {}
        p.sound = false
        p.GetActiveChallengeMapID = C_ChallengeMode.GetActiveChallengeMapID()
        UpdateDungeonName()
        bootlegRepeatingTimer()
        UpdateBosses()
        GetBestBefore()
    end
    if (e == "SCENARIO_CRITERIA_UPDATE" or e == "CHALLENGE_MODE_START") and db.profile.start then
        UpdateMobs()
        UpdateBosses()
    end
    if e == "ZONE_CHANGED_NEW_AREA" then
        if db.profile.start then
            db.profile.start = false
            db.profile.holdStart = nil
            Addon.DeathLog = {}
            ObjectiveTrackerFrame:Show()
            LucidKeystoneFrame:Hide()
        end
        if GetElapsedTime() > 0 then
            db.profile.start = true
            Module.Config.ToggleFrames()
            ObjectiveTrackerFrame:Hide()
            LucidKeystoneFrame:Show()
            bootlegRepeatingTimer()
            UpdateMobs()
            UpdateDungeonName()
            UpdateBosses()
            Module.Config:SeasonMobs()
        end

        if db.profile.start == false then
            if ObjectiveTrackerFrame:IsShown() == false then
                ObjectiveTrackerFrame:Show()
            end
            LucidKeystoneFrame:Hide()
            db.profile.holdStart = nil
            Addon.DeathLog = {}
        end
    end
    if e == "CHALLENGE_MODE_COMPLETED" then
        local _, level, time = C_ChallengeMode.GetCompletionInfo()
        local f = LucidKeystoneFrame
        local bar = LucidKeystoneFrameBar
        local _,_,maxTime = C_ChallengeMode.GetMapUIInfo(db.profile.GetActiveChallengeMapID)
        time = time/1000
        bar:SetMinMaxValues(0,maxTime)
        bar:SetValue(maxTime-time)
        f.textMobs:SetText("100.00%")
        f.textLevel:SetText(Addon.GetScoreColor(level*100)..level.."|r")
        f.textTimer:SetText(Addon.TimeFormat(time))
        f.textTimerSmall:SetText(Addon.TimeFormat(maxTime-time))
        f.textTimerOne:SetText("+1\n"..Addon.TimeFormat(maxTime))
        f.textTimerTwo:SetText("+2\n"..Addon.TimeFormat(maxTime*0.8-time))
        f.textTimerThree:SetText("+3\n"..Addon.TimeFormat(maxTime*0.6-time))
        db.profile.currentPull = 0.0
    end
    if e == "COMBAT_LOG_EVENT_UNFILTERED" and db.profile.start and db.profile.MobPullConf ~= 1 and IsAddOnLoaded("MythicDungeonTools") then
        db.profile.currentPull = 0.0
        db.profile.PullCheck = 0.0
        
        for i = 1, 40 do
            local unit = "nameplate"..i
            if UnitExists(unit) and UnitAffectingCombat(unit) then
                
                local weight = nil
                local preset = MDT:GetCurrentPreset()
                local isTeeming = MDT:IsPresetTeeming(preset)
                local npcIdStr = select(6, strsplit("-", UnitGUID(unit)))
                local npcId = tonumber(npcIdStr or "0") or 0
                local count, max, maxTeeming = MDT:GetEnemyForces(npcId)

                if (count ~= nil and max ~= nil and maxTeeming ~= nil) then
                    if (isTeeming) then
                        weight = count/maxTeeming
                    else
                        weight = count/max
                    end
                    weight = weight*100
                    if (weight and weight > 0) then
                        db.profile.PullCheck = db.profile.currentPull+weight
                    end
                    if db.profile.MobPercStep then
                        if (weight and weight > 0) then
                                db.profile.currentPull = db.profile.currentPull+weight
                        end
                    else
                        db.profile.currentPull = db.profile.currentPull+count
                    end
                end
            end
        end
        db.profile.currentPullCount = db.profile.currentPull
        UpdateMobs()
    end
    if e == "PLAYER_REGEN_ENABLED" and db.profile.start and db.profile.MobPullConf then
        db.profile.currentPull = 0.0
        db.profile.PullCheck = 0.0
    end

    --Test Event
    --[[if e == "PLAYER_STOPPED_MOVING" then
        -- do test stuff kappa
    end
    if e == "PLAYER_STARTED_MOVING" then
        -- do test stuff kappa
    end]]
end


local function GetMaxTime()
    local zone_id = C_ChallengeMode.GetActiveChallengeMapID()
    if zone_id then
        local _, _, max_time = C_ChallengeMode.GetMapUIInfo(zone_id)
        local last_max_time = max_time
        return max_time
    end
    return last_max_time
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Set Frames for Timer
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[[
        #Background Frame       = LucidKeystoneFrame
            Level                   = textLevel
            Timer                   = textTimer
            Timer Small             = textTimerSmall
            Deaths                  = textDeaths
            Mobcount                = textMobs
            Bosses                  = textBosses
            Dungeonname             = textDungeon
            Affix                   = textAffix
            Timer +1                = textTimerOne
            Timer +2                = textTimerTwo
            Timer +3                = textTimerThree
        #Progress Bar               = LucidKeystoneFrameBar
        #Progress Bar Mobs          = LucidKeystoneFrameBarPerc
        #Normal Spark               = LucidKeystoneFrameSpark
        #Normal Mob Spark           = LucidKeystoneFrameSparkPerc
        #Sparkle Effect             = LucidKeystoneFrameSparkle
]]

local function ToggleLucidKeystoneFrame()
    --Background Frame
    LucidKeystoneFrame = CreateFrame("Frame", "LucidKeystoneFrame", UIParent)
    local bg = LucidKeystoneFrame
    bg:SetFrameStrata("LOW")
    bg:SetMovable(false)
    bg:EnableMouse(false)
    bg:SetWidth(512)
    bg:SetHeight(256)
    bg:SetScale(db.profile.ScaleStyle)
    t = bg:CreateTexture(nil,"BACKGROUND")
    t:SetAllPoints(bg) 
    bg.texture = t
    bg:SetPoint(db.profile.fpoint, db.profile.fxof, db.profile.fyof)
    bg:SetScript("OnEvent", eventHandler)
    bg:Hide()

    --Events
    bg:RegisterEvent("CHALLENGE_MODE_START")
    bg:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    bg:RegisterEvent("WORLD_STATE_TIMER_START")
    bg:RegisterEvent("SCENARIO_CRITERIA_UPDATE")
    bg:RegisterEvent("CHALLENGE_MODE_COMPLETED")
    bg:RegisterEvent("PLAYER_STARTED_MOVING")
    bg:RegisterEvent("PLAYER_STOPPED_MOVING")
    bg:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    bg:RegisterEvent("PLAYER_REGEN_ENABLED")

    -- Text Frames
    bg.textLevel = bg:CreateFontString()
    bg.textLevel:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle],38,"OUTLINE")
    bg.textLevel:SetPoint("CENTER",-117,13)
    bg.textTimer = bg:CreateFontString()
    bg.textTimer:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 26, "OUTLINE")
    bg.textTimer:SetTextColor(0, 0.72, 1, 1)
    bg.textTimer:SetPoint("LEFT",208,32)
    bg.textTimer:SetJustifyH("LEFT")
    bg.textTimerSmall = bg:CreateFontString()
    bg.textTimerSmall:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 12, "OUTLINE")
    bg.textTimerSmall:SetTextColor(1, 1, 1, 1)
    bg.textTimerSmall:SetPoint("LEFT",290,24)
    bg.textTimerSmall:SetJustifyH("LEFT")
    bg.textDeaths = bg:CreateFontString()
    bg.textDeaths:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    bg.textDeaths:SetTextColor(0.7, 0, 0.1, 1)
    bg.textDeaths:SetPoint("CENTER",111,30)
    bg.textMobs = bg:CreateFontString()
    bg.textMobs:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 15, "OUTLINE")
    bg.textMobs:SetTextColor(1, 1, 1, 1)
    bg.textMobs:SetPoint("CENTER",111,-2)
    bg.textBosses = bg:CreateFontString()
    bg.textBosses:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 12, "OUTLINE")
    bg.textBosses:SetTextColor(1, 1, 1, 1)
    bg.textBosses:SetJustifyH("LEFT")
    bg.textDungeon = bg:CreateFontString()
    bg.textDungeon:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    bg.textDungeon:SetTextColor(1, 1, 1, 1)
    bg.textDungeon:SetJustifyH("CENTER")
    bg.textAffix = bg:CreateFontString()
    bg.textAffix:SetTextColor(1, 1, 1, 1)
    bg.textAffix:SetJustifyH("CENTER")
    bg.SeasonAdds = bg:CreateFontString()
    bg.SeasonAdds:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 12, "OUTLINE")
    bg.SeasonAdds:SetTextColor(0.3, 0.3, 0.3, 1)
    --bg.SeasonAdds:SetTextColor(1, 1, 1, 1)
    bg.SeasonAdds:SetPoint("CENTER",-117,-13)

    bg.textTimerOne = bg:CreateFontString()
    bg.textTimerOne:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    bg.textTimerOne:SetTextColor(1, 1, 1, 1)
    bg.textTimerOne:SetPoint("CENTER",-60,-5)
    bg.textTimerTwo = bg:CreateFontString()
    bg.textTimerTwo:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    bg.textTimerTwo:SetTextColor(1, 1, 1, 1)
    bg.textTimerTwo:SetPoint("CENTER",-6,-5)
    bg.textTimerThree = bg:CreateFontString()
    bg.textTimerThree:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    bg.textTimerThree:SetTextColor(1, 1, 1, 1)
    bg.textTimerThree:SetPoint("CENTER",48,-5)

    LucidKeystoneFrameDeaths = CreateFrame("Frame", "LucidKeystoneFrameDeaths", LucidKeystoneFrame)
    local dFrame = LucidKeystoneFrameDeaths
    dFrame:SetPoint("CENTER",111,30)
    dFrame:SetWidth(55)
    dFrame:SetHeight(30)
    dFrame:SetMovable(false)
    dFrame:EnableMouse(true)
    dFrame:SetScript("OnEnter", function() 
        GameTooltip:SetOwner(dFrame, "ANCHOR_TOPLEFT",55,-40)
        GameTooltip:AddLine(L["Detailed deaths"].."\n ")
        GameTooltip:AddDoubleLine(table.concat(select(2,GetDeaths()),"\n"),table.concat(select(3,GetDeaths()),"\n"),1,1,1,1,1,1)
        GameTooltip:Show()
    end)
    dFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    maxTime = select(3, C_ChallengeMode.GetMapUIInfo(previewSettings.ZoneID))

    --Timer Bar
    LucidKeystoneFrameBar = CreateFrame("statusbar","LucidKeystoneFrameBar",LucidKeystoneFrame)
    local bar = LucidKeystoneFrameBar
    bar:SetPoint("CENTER",-4,-28)
    bar:SetFrameStrata("BACKGROUND")
    bar:SetWidth(284)
    bar:SetHeight(12)
    bar:SetMinMaxValues(0,maxTime)
    bar:SetValue(maxTime-previewSettings.time)
    bar:SetClipsChildren(true)
    bar:SetOrientation("HORIZONTAL")
    bar:SetStatusBarTexture(AceGUIWidgetLSMlists.statusbar[db.profile.TimerBarStyle])
    bar:SetStatusBarColor(db.profile.timerBarColor.r, db.profile.timerBarColor.g, db.profile.timerBarColor.b, 1)

    bar.b = bar:CreateTexture(nil, "BACKGROUND")
    bar.b:SetTexture(Addon.BAR_PARTICLES)
    bar.b:SetAllPoints(true)
    bar.b:SetVertexColor(0, 0, 0, 0.5)

    --Mob Perc Bar
    LucidKeystoneFrameBarPerc = CreateFrame("statusbar","LucidKeystoneFrameBarPerc",LucidKeystoneFrame)
    local barP = LucidKeystoneFrameBarPerc
    barP:SetPoint("CENTER",-4,-43)
    barP:SetFrameStrata("BACKGROUND")
    barP:SetWidth(284)
    barP:SetHeight(12)
    barP:SetMinMaxValues(0,100)
    barP:SetOrientation("HORIZONTAL")
    barP:SetStatusBarTexture(AceGUIWidgetLSMlists.statusbar[db.profile.MobBarStyle])
    barP:SetStatusBarColor(db.profile.mobBarColor.r, db.profile.mobBarColor.g, db.profile.mobBarColor.b, 1)

    barP.b = barP:CreateTexture(nil, "BACKGROUND")
    barP.b:SetTexture(Addon.BAR_PARTICLES)
    barP.b:SetAllPoints(true)
    barP.b:SetVertexColor(0, 0, 0, 0.5)
    barP:Hide()

    --Normal Timer Spark
    LucidKeystoneFrameSpark = CreateFrame("Frame","LucidKeystoneFrameSpark",LucidKeystoneFrameBar)
    local spark = LucidKeystoneFrameSpark
    spark:SetPoint("RIGHT", bar:GetStatusBarTexture(), "RIGHT", 6, 0)-- Castbar:GetStatusBarTexture(), 'RIGHT', 0, 0
    spark:SetWidth(12)
    spark:SetHeight(20)
    tex = spark:CreateTexture("LKFStex","ARTWORK")
    tex:SetAllPoints(spark)
    tex:SetBlendMode("ADD")
    tex:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    spark.texture = tex

    --Normal Perc Spark
    LucidKeystoneFrameSparkPerc = CreateFrame("Frame","LucidKeystoneFrameSparkPerc",LucidKeystoneFrameBarPerc)
    local sparkp = LucidKeystoneFrameSparkPerc
    sparkp:SetPoint("RIGHT", barP:GetStatusBarTexture(), "RIGHT", 6, 0)-- Castbar:GetStatusBarTexture(), 'RIGHT', 0, 0
    sparkp:SetWidth(12)
    sparkp:SetHeight(20)
    texp = sparkp:CreateTexture("LKFSPtex","ARTWORK")
    texp:SetAllPoints(sparkp)
    texp:SetBlendMode("ADD")
    texp:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    sparkp.texture = tex

    --Timer Bar Sparkle Effect
    LucidKeystoneFrameSparkle = CreateFrame("PlayerModel","LucidKeystoneFrameSparkle",LucidKeystoneFrameBar)
    local sparkle = LucidKeystoneFrameSparkle
    sparkle:ClearTransform()
    sparkle:SetPosition(-1,1.5,0,0)
    sparkle:SetPoint("RIGHT", bar:GetStatusBarTexture(), "RIGHT", -1, 0)-- Castbar:GetStatusBarTexture(), 'RIGHT', 0, 0
    sparkle:SetSize(150,12)
    sparkle:SetAlpha(1)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Other Functions
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Set Keylevel
function Module.Config:KeyLevel()
    local level = previewSettings.level
    local f = LucidKeystoneFrame
    if db.profile.start == false then
        f.textLevel:SetText(Addon.GetScoreColor(level*100)..level.."|r")
    end
end

function Module.Config:SeasonMobs()
    --if db.profile.tormentedInd and C_MythicPlus.GetCurrentAffixes() and C_MythicPlus.GetCurrentAffixes()[4].id == 128 then
    if db.profile.tormentedInd and Addon.GetSeasonInfo() == 2 then
        local count = previewSettings.tormCount
        if db.profile.start then count = Addon.TormentedKilled end
        local new = ""
        for i = 1, 4 do
            if count >= i then
                new = new..Addon.GetIcon(8,db.profile.tormentedStyle,true)
            else
                new = new..Addon.GetIcon(8,db.profile.tormentedStyle)
            end
        end
        
        local f = LucidKeystoneFrame
        if db.profile.start == false or (db.profile.start and C_ChallengeMode.GetActiveKeystoneInfo() >= 10) then
            f.SeasonAdds:SetText(new)
        else
            f.SeasonAdds:SetText("")
        end
    else
        local f = LucidKeystoneFrame
        f.SeasonAdds:SetText("")
    end
end

function Module.Config:Scale()
    LucidKeystoneFrame:SetScale(db.profile.ScaleStyle)
end

-- Set Timer Bar Color
function Module.Config:SetTimerBarColor()
    LucidKeystoneFrameBar:SetStatusBarColor(db.profile.timerBarColor.r,db.profile.timerBarColor.g,db.profile.timerBarColor.b,1)
    LKFStex:SetVertexColor(db.profile.timerBarColor.r,db.profile.timerBarColor.g,db.profile.timerBarColor.b,1)
end
function Module.Config:SetMobBarColor()
    LucidKeystoneFrameBarPerc:SetStatusBarColor(db.profile.mobBarColor.r,db.profile.mobBarColor.g,db.profile.mobBarColor.b,1)
    LKFSPtex:SetVertexColor(db.profile.mobBarColor.r,db.profile.mobBarColor.g,db.profile.mobBarColor.b,1)
end

-- Set Text for Timers
function Module.Config:TimerText()
    local maxTime, time, deaths, mobPerc
    if activeRun then
        maxTime = GetMaxTime()
        time = GetElapsedTime()
        deaths = 0
        mobPerc = 10
    else
        maxTime = select(3, C_ChallengeMode.GetMapUIInfo(previewSettings.ZoneID))
        time = previewSettings.time
        deaths = previewSettings.deaths
        mobPerc = previewSettings.mobPerc
        mobCurPerc = previewSettings.mobCurPerc
    end
    -- I wish she will return my love
    local test = CreateAtlasMarkup("poi-graveyard-neutral")
    local timeSmall = time
    local mobPercPlus = ""
    local f = LucidKeystoneFrame
    if db.profile.mainTimer == 2 then
        time = maxTime-time
    end
    if db.profile.mainTimer == 1 then
        timeSmall = maxTime-timeSmall
    end
    if db.profile.start == false then
        f.textTimer:SetTextColor(0, 0.72, 1, 1)
        f.textTimer:SetText(Addon.TimeFormat(time))
        f.textTimerSmall:SetText(Addon.TimeFormat(timeSmall))
        f.textDeaths:SetText(test.." "..deaths.."\n-"..Addon.TimeFormat(deaths*5))
        -- sadly, she dont love me back. but i will dont stop
        if db.profile.MobPercStep then
            f.textMobs:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 15, "OUTLINE")
            if db.profile.MobPullConf == 2 and IsAddOnLoaded("MythicDungeonTools") then
                f.textMobs:SetText(mobPerc.."%\n|cff4cff00+"..mobCurPerc.."%|r")
            elseif db.profile.MobPullConf == 3 and IsAddOnLoaded("MythicDungeonTools") then
                f.textMobs:SetText(mobPerc.."%\n|cff4cff00"..mobCurPerc+mobPerc.."%|r")
            else
                f.textMobs:SetText(mobPerc.."%")
            end
        else
            f.textMobs:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 13, "OUTLINE")
            f.textMobs:SetText(256 .." / ".. 285)
        end
    end
end

-- Set the Timers
function Module.Config:PlusTimer()
    local f = LucidKeystoneFrame
    local maxTime = select(3, C_ChallengeMode.GetMapUIInfo(previewSettings.ZoneID))
    local time = previewSettings.time
    if db.profile.smartTimer then
        f.textTimerOne:Hide()
        f.textTimerTwo:Show()
        f.textTimerThree:Hide()
        if db.profile.start == false then
            local smartTime
            local plus3 = maxTime*0.6-time
            local plus2 = maxTime*0.8-time
            local plus1 = maxTime-time
            local plusSmartOne = Addon.TimeFormat(maxTime-time)
            
            if plus3 >= 0 then smartTime = "+3\n"..Addon.TimeFormat(plus3) elseif
            plus2 >= 0 then smartTime = "+2\n"..Addon.TimeFormat(plus2) elseif
            plus1 >= 0 then smartTime = "+1\n"..Addon.TimeFormat(plus1) elseif
            plus1 <= 0 then smartTime = L["Over by"].." |cffC43333"..plusSmartOne
            end
            f.textTimerTwo:SetText(smartTime)
        end
    else
        if db.profile.start == false then
            f.textTimerOne:SetText("+1\n"..Addon.TimeFormat(maxTime))
            f.textTimerTwo:SetText("+2\n"..Addon.TimeFormat(maxTime*0.8-time))
            f.textTimerThree:SetText("+3\n"..Addon.TimeFormat(maxTime*0.6-time))
        end

        if db.profile.plusOne then f.textTimerOne:Show() else f.textTimerOne:Hide() end
        if db.profile.plusTwo then f.textTimerTwo:Show() else f.textTimerTwo:Hide() end
        if db.profile.plusThree then f.textTimerThree:Show() else f.textTimerThree:Hide() end
    end
end

-- Update Bosses
function Module.Config:BossesText()
    local f = LucidKeystoneFrame
    local offset = 0
    local xof = 1
    local yof = -195

    if db.profile.mobCount == 1 then
        offset = 15
    end
    if db.profile.affix == 2 or db.profile.affix == 3 then
        offset = offset-10
    end

    if db.profile.bosses == 2 then
        --f.textBosses:SetPoint("CENTER",60,39)
        f.textBosses:SetPoint("TOP",60,-83)
        if db.profile.start == false then
            f.textBosses:SetText("2/4")
        else
            UpdateBosses()
        end
    elseif db.profile.bosses == 3 and db.profile.timeStamp then
        xof = -4
        yof = yof+offset
        --f.textBosses:SetPoint("CENTER",xof,yof)
        f.textBosses:SetPoint("TOP",xof,yof)
        if db.profile.start == false then
            if db.profile.bestBefore == 2 or db.profile.bestBefore == 4 then
                f.textBosses:SetText(table.concat(previewSettings.bossesAbs, "|r\n"))
            elseif db.profile.bestBefore == 3 or db.profile.bestBefore == 5 then
                f.textBosses:SetText(table.concat(previewSettings.bossesRel, "|r\n"))
            else
                f.textBosses:SetText(table.concat(previewSettings.bossesTwo, "|r\n"))
            end
        else
            UpdateBosses()
        end
    elseif db.profile.bosses == 3 and not db.profile.timeStamp then
        xof = -4
        yof = yof+offset
        --f.textBosses:SetPoint("CENTER",xof,yof)
        f.textBosses:SetPoint("TOP",xof,yof)
        if db.profile.start == false then
            f.textBosses:SetText(table.concat(previewSettings.bosses, "|r\n"))
        else
            UpdateBosses()
        end
    else
        f.textBosses:SetText("")
    end
end

-- Get Affixes
function Module.Config:AffixText()
    local f = LucidKeystoneFrame
    local offset = 0
    local wAffix = C_MythicPlus.GetCurrentAffixes()
    local affixTable = {}

    if not wAffix then
        wAffix = previewSettings.AffixNil
    end

    --[[if C_ChallengeMode.IsChallengeModeActive() then
		wAffix = C_MythicPlus.GetCurrentAffixes()
	elseif not C_ChallengeMode.IsChallengeModeActive() then
		wAffix = previewSettings.AffixNil
	end]]

    if db.profile.mobCount == 1 then
        offset = 15
    end
    if db.profile.affix == 2 then
        f.textAffix:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 11, "OUTLINE")
        f.textAffix:SetPoint("CENTER",0,-66+offset)
        for ids = 1, #wAffix do
            local id = wAffix[ids].id
            local name = C_ChallengeMode.GetAffixInfo(id)
            table.insert(affixTable, name)
        end
        f.textAffix:SetText("|cffC45EFF"..table.concat(affixTable, "|r - |cffC45EFF"))
    elseif db.profile.affix == 3 or db.profile.affix == 4 or db.profile.affix == 5 then
        for ids = 1, #wAffix do
            local id = wAffix[ids].id
            id = previewSettings.affixIcon[id].icon
            table.insert(affixTable, "|T"..id..":0|t ") 
        end
        if db.profile.affix == 3 then
            f.textAffix:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 16, "OUTLINE")
            f.textAffix:SetPoint("CENTER",0,-66+offset)
            f.textAffix:SetText(table.concat(affixTable, " "))
        end
        if db.profile.affix == 4 then
            f.textAffix:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 22, "OUTLINE")
            f.textAffix:SetPoint("CENTER",-164,4)
            f.textAffix:SetText(table.concat(affixTable, "\n"))
        end
        if db.profile.affix == 5 then
            f.textAffix:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 22, "OUTLINE")
            f.textAffix:SetPoint("CENTER",165,4)
            f.textAffix:SetText(table.concat(affixTable, "\n"))
        end
    else
        f.textAffix:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 11, "OUTLINE")
        f.textAffix:SetText("")
    end
end

-- Get Dungeon Text
function Module.Config:DungeonText()
    local f = LucidKeystoneFrame
    local name = C_ChallengeMode.GetMapUIInfo(previewSettings.ZoneID)
    if db.profile.dungeonName == 3 then
        f.textDungeon:SetPoint("CENTER",-116,38)
        if db.profile.start == false then
            f.textDungeon:SetText(previewSettings.dungeonName[previewSettings.ZoneID].ShortName)
        else
            UpdateDungeonName()
        end
    elseif db.profile.dungeonName == 2 then
        f.textDungeon:SetPoint("CENTER",0,65)
        if db.profile.start == false then
            f.textDungeon:SetText(name)
        else
            UpdateDungeonName()
        end
    else
        f.textDungeon:SetText("")
    end
end

function Module.Config:MobBar()
    local bar = LucidKeystoneFrameBarPerc
    maxTime = select(3, C_ChallengeMode.GetMapUIInfo(previewSettings.ZoneID))
    LucidKeystoneFrameBar:SetMinMaxValues(0,maxTime)
    LucidKeystoneFrameBar:SetValue(maxTime-previewSettings.time)
    if db.profile.mobCount == 1 then
        bar:Hide()
    else
        if db.profile.invertPerc then
            bar:SetValue(100-previewSettings.mobPerc)
        else
            bar:SetValue(previewSettings.mobPerc)
        end
        bar:Show()
    end
end

-- Frame Unlock Function
function Module.Config:UnlockUpdate()
    local f = LucidKeystoneFrame
    if db.profile.unlock then
        if f:IsShown() then
            f:EnableMouse(true)
            f:SetScript("OnMouseDown", function(self, button)
                if button == "LeftButton" and not self.isMoving then
                MovableCheck()
                self:StartMoving()
                self.isMoving = true
                end
            end)
            f:SetScript("OnMouseUp", function(self, button)
                if button == "LeftButton" and self.isMoving then
                self:StopMovingOrSizing()
                self.isMoving = false
                db.profile.fpoint = select(1, f:GetPoint())
                db.profile.fxof = select(4, f:GetPoint())
                db.profile.fyof = select(5, f:GetPoint())
                end
            end)
            f:SetScript("OnHide", function(self)
                if ( self.isMoving ) then
                self:StopMovingOrSizing()
                self.isMoving = false
                end
            end)
        else
            f:EnableMouse(false)
            f:SetScript("OnMouseDown",nil)
            f:SetScript("OnMouseUp",nil)
            f:SetScript("OnHide",nil)
        end
    else
        f:EnableMouse(false)
        f:SetScript("OnMouseDown",nil)
        f:SetScript("OnMouseUp",nil)
        f:SetScript("OnHide",nil)
    end
end

-- Update Sparkle Effect
function Module.Config:SparkleUpdate()
    LucidKeystoneFrameSparkle:SetModel(Addon.sparkleEffect[db.profile.sparkle].animation)
end

-- Update Bar Styles
function Module.Config:UpdateBars()
    LucidKeystoneFrameBar:SetStatusBarTexture(AceGUIWidgetLSMlists.statusbar[db.profile.TimerBarStyle])
    LucidKeystoneFrameBarPerc:SetStatusBarTexture(AceGUIWidgetLSMlists.statusbar[db.profile.MobBarStyle])
end

-- Update Timer Font
function Module.Config:UpdateFonts()
    local f = LucidKeystoneFrame
    f.textLevel:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle],38,"OUTLINE")

    f.textTimer:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 26, "OUTLINE")
    f.textTimerSmall:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 12, "OUTLINE")
    f.textDeaths:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    f.textMobs:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 15, "OUTLINE")
    f.textBosses:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 12, "OUTLINE")
    f.textDungeon:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    f.textTimerOne:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    f.textTimerTwo:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    f.textTimerThree:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 14, "OUTLINE")
    f.SeasonAdds:SetFont(AceGUIWidgetLSMlists.font[db.profile.FontStyle], 12, "OUTLINE")
    Module.Config:AffixText()
end

-- Set Backdrop
function Module.Config:BackgroundUpdate()
    --[[local todaydate = C_DateAndTime.GetCurrentCalendarTime()
    local today = todaydate.monthDay .. ".".. todaydate.month
    if today == "5.4" then
        LucidKeystoneFrame.texture:SetTexture(Addon[imgfile[11]..db.profile.mobCount])
    else]]
        -- 1 = Kyrian
        -- 2 = Venthyr
        -- 3 = Night Fae
        -- 4 = Necrolord
    if db.profile.background == 20 then
        LucidKeystoneFrame.texture:SetTexture(Addon[imgfile[23]..db.profile.mobCount]) --Tormented
        LucidKeystoneFrame.texture:SetVertexColor(1,1,1,1)
    elseif db.profile.background == 30 then
        local covenant = C_Covenants.GetActiveCovenantID()
        local num = 31
        if covenant == 2 then
            num = 34
        elseif covenant == 3 then
            num = 33
        elseif covenant == 4 then
            num = 32
        end
        LucidKeystoneFrame.texture:SetTexture(Addon[imgfile[num]..db.profile.mobCount])
        LucidKeystoneFrame.texture:SetVertexColor(1,1,1,1)
    else
        LucidKeystoneFrame.texture:SetTexture(Addon[imgfile[db.profile.background]..db.profile.mobCount])
        if Module.Config:GetOption("background") == 6 then
            LucidKeystoneFrame.texture:SetVertexColor(db.profile.colorit.r,db.profile.colorit.g,db.profile.colorit.b,db.profile.colorit.a)
        else
            LucidKeystoneFrame.texture:SetVertexColor(1,1,1,1)
        end
    end
end

-- General Frame toggle
function Module.Config.ToggleFrames()
    Module.Config:BackgroundUpdate()
    Module.Config:MobUpdateConfig()
    Module.Config:SparkleUpdate()
    Module.Config:KeyLevel()
    Module.Config:Scale()
    Module.Config:BossesText()
    Module.Config:DungeonText()
    Module.Config:MobBar()
    Module.Config:AffixText()
    Module.Config:PlusTimer()
    Module.Config:SetTimerBarColor()
    Module.Config:SetMobBarColor()
    Module.Config:UpdateBars()
    Module.Config:UpdateFonts()
    Module.Config:TimerText()
    Module.Config:SeasonMobs()
end

-- Frame toggle for Preview
function Module.Config:ToggleTest()
    Module.Config.ToggleFrames()
    local bg = LucidKeystoneFrame
    if bg:IsShown() then
        ObjectiveTrackerFrame:Show()
        activeRun = false
        bg:Hide()
    else
        ObjectiveTrackerFrame:Hide()
        bg:Show()
    end
end

--Initialize function
function Module.Timer:OnInitialize()
    db = LibStub("AceDB-3.0"):New("LucidKeystoneDB", defaults)
    ToggleLucidKeystoneFrame()
    if db.profile.start then
        Module.Config:ToggleFrames()
        LucidKeystoneFrame:Show()
        ObjectiveTrackerFrame:Hide()
        UpdateMobs()
        Addon.UpdateSeasonAdds()
        UpdateBosses()
        GetMobCount()
        GetDeaths()
        UpdateDungeonName()
        bootlegRepeatingTimer()
    end
end