local AddonName, Addon = ...
local AddonLib = LibStub("AceAddon-3.0"):GetAddon("LucidKeystone")
local Module = AddonLib:NewModule("Config", "AceConsole-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("LucidKeystone")

local db, version, author, notes, title


local fontColor = {
    yellow  = "|cffffd100%s|r",
    blue    = "|cff009dd5%s|r",
    red     = "|cffe22b2a%s|r",
    lucid   = "|cff71478E%s|r",
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Profile Default Settings
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------  Blank Tables
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local dungeonListInt = {
    [244] = 0,
    [245] = 0,
    [246] = 0,
    [247] = 0,
    [248] = 0,
    [249] = 0,
    [250] = 0,
    [251] = 0,
    [252] = 0,
    [353] = 0,
    [369] = 0,
    [370] = 0,
    [375] = 0,
    [376] = 0,
    [377] = 0,
    [378] = 0,
    [379] = 0,
    [380] = 0,
    [381] = 0,
    [382] = 0,
}
local dungeonListTable = {
    [244] = {},
    [245] = {},
    [246] = {},
    [247] = {},
    [248] = {},
    [249] = {},
    [250] = {},
    [251] = {},
    [252] = {},
    [353] = {},
    [369] = {},
    [370] = {},
    [375] = {},
    [376] = {},
    [377] = {},
    [378] = {},
    [379] = {},
    [380] = {},
    [381] = {},
    [382] = {},
}
local bestList = {
    level       = 0,
    duration    = 100000,
    date        = 0,
}
local dungeonListTableBest = {
    [244] = bestList,
    [245] = bestList,
    [246] = bestList,
    [247] = bestList,
    [248] = bestList,
    [249] = bestList,
    [250] = bestList,
    [251] = bestList,
    [252] = bestList,
    [353] = bestList,
    [369] = bestList,
    [370] = bestList,
    [375] = bestList,
    [376] = bestList,
    [377] = bestList,
    [378] = bestList,
    [379] = bestList,
    [380] = bestList,
    [381] = bestList,
    [382] = bestList,
}
local bestListTable = {
    level           = {},
    duration        = {},
    durationTrans   = {},
    date            = {},
}
local historyListTableBest = {
    [244] = bestListTable,
    [245] = bestListTable,
    [246] = bestListTable,
    [247] = bestListTable,
    [248] = bestListTable,
    [249] = bestListTable,
    [250] = bestListTable,
    [251] = bestListTable,
    [252] = bestListTable,
    [353] = bestListTable,
    [369] = bestListTable,
    [370] = bestListTable,
    [375] = bestListTable,
    [376] = bestListTable,
    [377] = bestListTable,
    [378] = bestListTable,
    [379] = bestListTable,
    [380] = bestListTable,
    [381] = bestListTable,
    [382] = bestListTable,
}
local statDB = {
    deaths = 0,
    volcanic = 0,
    pride = 0,
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------  Defaults
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local defaults = {
    global = {
        --global defaults
        statistic = statDB,
    },
    profile = {
        --character defaults
        statistic       = statDB,
        colorit         = {
                            r = 0,
                            g = 0.7,
                            b = 0.5,
                            a = 0.8,
                        },
        customKeyColor  = {
                            r = 1,
                            g = 1,
                            b = 1,
                            a = 1,
                        },
        timerBarColor   = {
                            r = 0,
                            g = 0.7,
                            b = 1,
                            a = 1,
                        },
        mobBarColor     = {
                            r = 0.5,
                            g = 1,
                            b = 0,
                            a = 1,
                        },
        timeStamp       = true,
        keyColor        = true,
        plusOne         = true,
        plusTwo         = true,
        plusThree       = true,
        smartTimer      = false,
        history         = true,
        autoPlace       = true,
        unlock          = false,
        pridefulAlert   = false,
        postCom         = false,
        autoPost        = false,
        autoRole        = false,
        start           = false,
        invertPerc      = false,
        MobPercStep     = true,
        background      = 2,
        sparkle         = 3,
        bosses          = 3,
        affix           = 1,
        dungeonName     = 1,
        mainTimer       = 1,
        mobCount        = 1,
        fpoint          = "TOPRIGHT",
        TimerBarStyle   = "Lucid Keystone Particles",
        MobBarStyle     = "Lucid Keystone Particles",
        FontStyle       = "Kozuka Gothic Light",
        fxof            = -140,
        fyof            = 0,
        expansion       = GetExpansionLevel(),
        season          = C_MythicPlus.GetCurrentSeason(),
        runs            = {
                            [7] = { --expansion
                                [1] = { -- season
                                    [1] = dungeonListInt,
                                    [2] = dungeonListInt,
                                },
                                [2] = {
                                    [1] = dungeonListInt,
                                    [2] = dungeonListInt,
                                },
                                [3] = {
                                    [1] = dungeonListInt,
                                    [2] = dungeonListInt,
                                },
                                [4] = {
                                    [1] = dungeonListInt,
                                    [2] = dungeonListInt,
                                },
                            },
                            [8] = { --expansion
                                [1] = { -- season
                                    [1] = dungeonListInt,
                                    [2] = dungeonListInt,
                                },
                                [2] = {
                                    [1] = dungeonListInt,
                                    [2] = dungeonListInt,
                                },
                                [3] = {
                                    [1] = dungeonListInt,
                                    [2] = dungeonListInt,
                                },
                                [4] = {
                                    [1] = dungeonListInt,
                                    [2] = dungeonListInt,
                                },
                            },
                        },
        avglvl          = {
                            [7] = { --expansion
                                [1] = { -- season
                                    [1] = dungeonListTable,
                                },
                                [2] = {
                                    [1] = dungeonListTable,
                                },
                                [3] = {
                                    [1] = dungeonListTable,
                                },
                                [4] = {
                                    [1] = dungeonListTable,
                                },
                            },
                            [8] = { --expansion
                                [1] = { -- season
                                    [1] = dungeonListTable,
                                },
                                [2] = {
                                    [1] = dungeonListTable,
                                },
                                [3] = {
                                    [1] = dungeonListTable,
                                },
                                [4] = {
                                    [1] = dungeonListTable,
                                },
                            },
                        },
        bestIntime      = {
                            [7] = {
                                [1] = dungeonListTableBest,
                                [2] = dungeonListTableBest,
                                [3] = dungeonListTableBest,
                                [4] = dungeonListTableBest,
                            },
                            [8] = {
                                [1] = dungeonListTableBest,
                                [2] = dungeonListTableBest,
                                [3] = dungeonListTableBest,
                                [4] = dungeonListTableBest,
                            },
                        },
        bestOvertime    = {
                            [7] = {
                                [1] = dungeonListTableBest,
                                [2] = dungeonListTableBest,
                                [3] = dungeonListTableBest,
                                [4] = dungeonListTableBest,
                            },
                            [8] = {
                                [1] = dungeonListTableBest,
                                [2] = dungeonListTableBest,
                                [3] = dungeonListTableBest,
                                [4] = dungeonListTableBest,
                            },
                        },
        dungeonHistory  = {
                            [7] = {
                                [1] = historyListTableBest,
                                [2] = historyListTableBest,
                                [3] = historyListTableBest,
                                [4] = historyListTableBest,
                            },
                            [8] = {
                                [1] = historyListTableBest,
                                [2] = historyListTableBest,
                                [3] = historyListTableBest,
                                [4] = historyListTableBest,
                            },
                        },
    },
}

--Backdrop
local backdroplist = {
    [1] = L["None"],
    [2] = L["Blizzard Default"],
    [3] = L["Horde"],
    [4] = L["Alliance"],
    [5] = L["Simple"],
    [6] = L["Color It"],
    [7] = L["Dark Glass"],
    [8] = L["Awakened"],
    [9] = L["Prideful"],
    [10] = L["Paradox"],
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Reset Function
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function ResetConfig()
    local exclude = {
        Runs = db.profile.runs,
        Avg = db.profile.avglvl,
        Intime = db.profile.bestIntime,
        Overtime = db.profile.bestOvertime,
        history = db.profile.dungeonHistory,
        stats = db.profile.statistic,
        season = db.profile.season,
    }
    db:RegisterDefaults(defaults)
    db:ResetProfile()
    db.profile.runs = exclude.Runs
    db.profile.avglvl = exclude.Avg
    db.profile.bestIntime = exclude.Intime
    db.profile.bestOvertime = exclude.Overtime
    db.profile.dungeonHistory = exclude.history
    db.profile.statistic = exclude.stats
    db.profile.season = exclude.season
    LibStub("AceConfigRegistry-3.0"):NotifyChange("LucidKeystone")
    StaticPopup_Show("LucidKeystone_ReloadPopup")
    Module:ToggleFrames()
end

function Module:GetOption(option)
    return db.profile[option]
end
function Module:SetOption(option, val)
        db.profile[option] = val
    if val == false then
        for k, v in pairs(db.profile) do
            if k == "colorit" then
                db.global.colorit = {
                    r = db.profile.colorit.r,
                    g = db.profile.colorit.g,
                    b = db.profile.colorit.b,
                    a = db.profile.colorit.a,
                }
            elseif k == "customKeyColor" then
                db.global.customKeyColor = {
                    r = db.profile.customKeyColor.r,
                    g = db.profile.customKeyColor.g,
                    b = db.profile.customKeyColor.b,
                    a = db.profile.customKeyColor.a,
                }
            else
                db.global[k] = v
            end
        end
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  General Functions
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Timeformats
local function TimeFormat(time,dayInd)
    local format_minutes = "%.2d:%.2d"
    local format_hours = "%d:%.2d:%.2d"
    local format_days = "%d:%.2d:%.2d:%.2d"
    local prefix = ""
    if time < 0 then
        time = time * -1
        prefix = "-"
    end
    local seconds = time % 60 -- seconds/min
    local minutes = math.floor((time / 60) % 60) -- min/hr
    local hours = math.floor((time / 3600) % 24)
    local days = math.floor(time/86400)
    
    if not dayInd then
        if hours == 0 then
            return prefix .. string.format(format_minutes, minutes, seconds)
        else
            return prefix .. string.format(format_hours, hours, minutes, seconds)
        end
    else
        return prefix .. string.format(format_days, days, hours, minutes, seconds)
    end
end

--Stars
local function GetStarsSymbol(time, zoneID)
    local _,_,maxTime = C_ChallengeMode.GetMapUIInfo(zoneID)
    if time == 0 then
        return ""
    elseif time < maxTime*0.6 then
        return CreateAtlasMarkup("tradeskills-star")..CreateAtlasMarkup("tradeskills-star")..CreateAtlasMarkup("tradeskills-star")
    elseif time < maxTime*0.8 then
        return CreateAtlasMarkup("tradeskills-star")..CreateAtlasMarkup("tradeskills-star")
    elseif time < maxTime then
        return CreateAtlasMarkup("tradeskills-star")
    else
        return CreateAtlasMarkup("tradeskills-star-off")
    end
end

local function ToggleAutoRole()
    if db.profile.autoRole then
        LFDRoleCheckPopupAcceptButton:SetScript("OnShow", function()
            LFDRoleCheckPopupAcceptButton:Click()
        end)
        LFGListApplicationDialog:SetScript("OnShow", function()
            LFGListApplicationDialog.SignUpButton:Click()
        end)
    else
        LFDRoleCheckPopupAcceptButton:SetScript("OnShow", nil)
        LFGListApplicationDialog.SignUpButton:SetScript("OnShow", nil)
    end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Dungeon Tab Information
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Best for Dungeon Intime
local function dungeonInfo(zoneID)
    local inTimeLevel, inTimeDur, inTimeDate, inTimeStars
    local expansion = db.profile.expansion
    local season = db.profile.season
    local intime = db.profile.bestIntime[expansion][season][zoneID]

    if intime.level == 0 then
        inTimeLevel = ""
        inTimeDur = ""
        inTimeStars = ""
        inTimeDate = ""
    else
        inTimeLevel = intime.level
        inTimeDur = TimeFormat(intime.duration)
        inTimeStars = " "..GetStarsSymbol(intime.duration, zoneID)
        inTimeDate = intime.date
    end

    local runPerc
    if db.profile.runs[expansion][season][1][zoneID] == 0 then
        runPerc = 0
    else
        runPerc = 100*db.profile.runs[expansion][season][1][zoneID]/(db.profile.runs[expansion][season][1][zoneID]+db.profile.runs[expansion][season][2][zoneID])
    end
    return "\n"..fontColor.blue:format(L[" < Intime Info >"])
    .."\n\n"..fontColor.yellow:format(L["Season Best: "])..inTimeLevel
    .."\n"..fontColor.yellow:format(L["Status: "])..inTimeStars
    .."\n"..fontColor.yellow:format(L["Completion Time: "])..inTimeDur
    .."\n"..fontColor.yellow:format(L["Date: "])..inTimeDate
    .."\n"..fontColor.yellow:format(L["Runs: "])..db.profile.runs[expansion][season][1][zoneID].."  ("..string.format("%.1f", runPerc).."%)"
end

-- Best for Dungeon Overtime
local function dungeonInfo2(zoneID)
    local overTimeLevel, overTimeDur, overTimeDate
    local expansion = db.profile.expansion
    local season = db.profile.season
    local overtime = db.profile.bestOvertime[expansion][season][zoneID]

    if overtime.level == 0 then
        overTimeLevel = ""
        overTimeDur = ""
        overTimeDate = ""
    else
        overTimeLevel = overtime.level
        overTimeDur = TimeFormat(overtime.duration)
        overTimeDate = overtime.date
    end

    return "\n"..fontColor.blue:format(L[" < Overtime Info >"])
    .."\n\n"..fontColor.yellow:format(L["Season Best: "])..overTimeLevel
    .."\n"..fontColor.yellow:format(L["Completion Time: "])..overTimeDur
    .."\n"..fontColor.yellow:format(L["Date: "])..overTimeDate
    .."\n"..fontColor.yellow:format(L["Runs: "])..db.profile.runs[expansion][season][2][zoneID]
    .."\n "
end

-- Runs for Dungeons
local function dungeonInfo3(zoneID)
    local expansion = db.profile.expansion
    local season = db.profile.season

    local runs = db.profile.runs[expansion][season][1][zoneID] + db.profile.runs[expansion][season][2][zoneID]
    return "\n\n"..fontColor.yellow:format(L["Total Runs: "])..runs.."\n\n"
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Dungeon Tab Total Information for Character
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Total Runs
local function TotalRuns()
    local expansion = db.profile.expansion
    local season = db.profile.season
    local zones = {375,376,377,378,379,380,381,382}
    local runs = 0
    local levels = 0
    local win = 0
    local loss = 0
    local zoneRuns = {}
    local zoneNames = {}
    local zoneLevels = {}

    for i = 1, #zones do
        runs = runs + db.profile.runs[expansion][season][1][zones[i]] + db.profile.runs[expansion][season][2][zones[i]]
        win = win + db.profile.runs[expansion][season][1][zones[i]]
        loss = loss + db.profile.runs[expansion][season][2][zones[i]]
        local dungeonRuns = db.profile.runs[expansion][season][1][zones[i]] + db.profile.runs[expansion][season][2][zones[i]]
        local name = C_ChallengeMode.GetMapUIInfo(zones[i])
        local avgLvl = 0

        for _,v in ipairs(db.profile.avglvl[expansion][season][1][zones[i]]) do
            --levels = levels + v
            avgLvl = avgLvl + v
        end
        if #db.profile.avglvl[expansion][season][1][zones[i]] ~= 0 then
            avgLvl = avgLvl/#db.profile.avglvl[expansion][season][1][zones[i]]
        end

        avgLvl = string.format("%.1f", avgLvl)

        table.insert(zoneNames, name)
        table.insert(zoneRuns, dungeonRuns)
        table.insert(zoneLevels, avgLvl)
    end
    for i = 1, #zones do
        levels = levels + zoneLevels[i]
    end
    levels = levels/#zones

    if loss == 0 then loss = 1 end
    win = string.format("%.2f", win/loss)

    return fontColor.yellow:format(L["Total Runs: "])..runs, zoneNames, zoneRuns, fontColor.yellow:format(L["Avg. Level: "])..string.format("%.1f", levels), zoneLevels, fontColor.yellow:format(L["Intime/Overtime Ratio: "])..win
end

-- Simple String split function
function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    if #result == 2 then
        table.insert(result, 1, 0)
    end
    return result
end

-- Time Spent in MPlus
local function TimeSpend()
    local zones = {375,376,377,378,379,380,381,382}
    local expansion = db.profile.expansion
    local season = db.profile.season
    local result = 0
    local runs = 0
    local resultPer = 0

    for i = 1, #zones do
        local duration = db.profile.dungeonHistory[expansion][season][zones[i]].durationTrans
        for n = 1, #duration do
            local split = split(duration[n],":")
            result = result+split[1]*(3600/1)+split[2]*(60/1)+split[3]
        end
    end
    for i = 1, #zones do
        runs = runs + db.profile.runs[expansion][season][1][zones[i]] + db.profile.runs[expansion][season][2][zones[i]]
    end

    if runs >= 1 then
        runs = TimeFormat(result/runs)
    end
    result = split(TimeFormat(result,true),":")

    return result, runs
end

-- Title Information for Dungeon
----Avg. Level for Dungeon
local function GetTitle(zoneID)
    local expansion = db.profile.expansion
    local season = db.profile.season
    local name = C_ChallengeMode.GetMapUIInfo(zoneID)
    local avgLvl = 0
    for _,v in ipairs(db.profile.avglvl[expansion][season][1][zoneID]) do
        avgLvl = avgLvl + v
    end
    if #db.profile.avglvl[expansion][season][1][zoneID] ~= 0 then
        avgLvl = avgLvl/#db.profile.avglvl[expansion][season][1][zoneID]
    end
    return fontColor.yellow:format(" "..name.."\n\n "..L["Avg. Level: "])..string.format("%.1f", avgLvl).."\n", name
end

local mapID = {
    -- BFA
    [244] = {ShortName = "AD"},
    [245] = {ShortName = "FH"},
    [246] = {ShortName = "TD"},
    [247] = {ShortName = "ML"},
    [248] = {ShortName = "WM"},
    [249] = {ShortName = "KR"},
    [250] = {ShortName = "ToS"},
    [251] = {ShortName = "UR"},
    [252] = {ShortName = "SotS"},
    [353] = {ShortName = "SoB"},
    [369] = {ShortName = "Yard"},
    [370] = {ShortName = "Work"},
    -- Shadowlands
    [375] = {ShortName = "Mists"},
    [376] = {ShortName = "NW"},
    [377] = {ShortName = "DOS"},
    [378] = {ShortName = "HoA"},
    [379] = {ShortName = "PF"},
    [380] = {ShortName = "SD"},
    [381] = {ShortName = "SoA"},
    [382] = {ShortName = "ToP"}, 
}

-- Dungeon Runs History as Table in Dungeon Tab
local function GetHistoryTable(zoneID)
    local expansion = db.profile.expansion
    local season = db.profile.season
    local level, duration, date
    if db.profile.dungeonHistory[expansion][season][zoneID].level[1] == nil then
        level = {L["Nothing to see here"]}
        duration = {""}
        date = {""}
    else
        level = db.profile.dungeonHistory[expansion][season][zoneID].level
        duration = db.profile.dungeonHistory[expansion][season][zoneID].durationTrans
        date = db.profile.dungeonHistory[expansion][season][zoneID].date
    end

    local historyTable = {
        [1] = level,
        [2] = duration,
        [3] = date,
    }
    return historyTable
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Dungeon loop
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Default Dungeon ID's
local zoneTable
if GetExpansionLevel() == 7 then
    zoneTable = {244,245,246,247,248,249,250,251,252,353,369,370}
else
    zoneTable = {375,376,377,378,379,380,381,382}
end
local dungeonTable = {}

--Loop for Dungeons in Dungeon Tab
for i = 1, #zoneTable do
    local ord = i*10
    local tablefor = {
        type = "group",
        name = mapID[zoneTable[i]].ShortName,
        desc = function() return select(2,GetTitle(zoneTable[i])) end, 
        order = ord,
        args = {
            --Portrait
            dungeon = {
                order = 10,
                name = "",
                type = "description",
                image = function()
                    local _,_,_,did = C_ChallengeMode.GetMapUIInfo(zoneTable[i])
                    return did
                end,
                imageWidth = 64,
                imageHeight = 64,
                width = 0.4,
            },
            --Name for Dungeon
            dungeonText = {
                order = 20,
                fontSize = "large",
                name = function()
                    return GetTitle(zoneTable[i])
                end,
                type = "description",
                width = 2,
            },
            --Avg. Level
            dungeonText2 = {
                order = 30,
                fontSize = "medium",
                name = function()
                    return dungeonInfo(zoneTable[i])
                end,
                type = "description",
                width = 1.5,
            },
            --Best Intime
            dungeonText3 = {
                order = 40,
                fontSize = "medium",
                name = function()
                    return dungeonInfo2(zoneTable[i])
                end,
                type = "description",
                width = 1,
            },
            --Best Overtime
            dungeonText4 = {
                order = 50,
                fontSize = "medium",
                name = function()
                    return dungeonInfo3(zoneTable[i])
                end,
                type = "description",
                width = "full",
            },
            --Table for completed Dungeons
            historyRuns = {
                type = "group",
                name = L["Dungeon History"],
                inline = true,
                order = 60,
                args = {
                    --Header
                    ----Level
                    historylevelT = {
                        order = 1,
                        fontSize = "medium",
                        name = fontColor.yellow:format(L["Level"]),
                        type = "description",
                        width = 1,
                    },
                    ----Time
                    historytimeT = {
                        order = 2,
                        fontSize = "medium",
                        name = fontColor.yellow:format(L["Time"]),
                        type = "description",
                        width = 1,
                    },
                    ----Date
                    historydateT = {
                        order = 3,
                        fontSize = "medium",
                        type = "description",
                        name = fontColor.yellow:format(L["Date"]),
                        width = 1,
                    },
                    -- Seperator
                    historyS = {
                        order = 4,
                        type = "header",
                        name = "",
                        width = "half",
                    },
                    -- Table Levels
                    historylevel = {
                        order = 10,
                        fontSize = "medium",
                        name = function()
                            return table.concat(GetHistoryTable(zoneTable[i])[1],"\n\n")
                        end,
                        type = "description",
                        width = 1,
                    },
                    -- Table Times
                    historytime = {
                        order = 20,
                        fontSize = "medium",
                        name = function()
                            return table.concat(GetHistoryTable(zoneTable[i])[2],"\n\n")
                        end,
                        type = "description",
                        width = 1,
                    },
                    -- Table Dates
                    historydate = {
                        order = 30,
                        fontSize = "medium",
                        name = function()
                            return table.concat(GetHistoryTable(zoneTable[i])[3],"\n\n")
                        end,
                        type = "description",
                        width = 1,
                    },
                },
            },
        },
    }
    table.insert(dungeonTable, tablefor)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  CONFIG MENU
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local function AddConfig()
    local options =
    {
        name = function()
            --Title Info by Addon
            if InterfaceOptionsFrame:IsShown() then
                return ""
            else
                if (IsAddOnLoaded("ElvUI")) then
                    local space = " "
                    local new = ""
                    for i = 1, 140 do
                        new = new..space
                    end
                    return new
                else
                    return "Lucid Keystone"
                end
            end
        end,
        type = "group",
        childGroups = "tab",
        get = get_set,
        set = get_set,
        args = {
            --Header in Options
            logo = {
                order = 10,
                type = "description",
                name = "",
                image = Addon.LOGO_LOCATION,
                imageWidth = 256,
                imageHeight = 64,
                width = 1.6
            },
            preview = {
                type = "group",
                name = " ",
                inline = true,
                order = 20,
                args = {
                    -- Buttons
                    previewButton = {
                        order = 10,
                        name = L["Preview"],
                        desc = L["Click to emulate the timer."],
                        type = "execute",
                        func = function()
                                Module:ToggleTest()
                        end,
                        width = 0.8,
                    },
                    versionButton = {
                        order = 20,
                        name = L["Version Check"],
                        desc = L["Check for updates."],
                        type = "execute",
                        confirm = true,
                        confirmText = fontColor.yellow:format(L["Version Check"]).."\n\n\n"..version.."\n ",
                        func = function() return end,
                        width = 0.8,
                    },
                    resetButton = {
                        order = 30,
                        name = L["Reset to Defaults"],
                        confirm = true,
                        confirmText = L["You really want reset to defaults?"].."\n\n"..fontColor.red:format(L["This does not affect your Dungeon stats."]),
                        desc = L["Reset all options to their default values."],
                        type = "execute",
                        func = function() ResetConfig() end,
                    },
                    unlock = {
                        type = "toggle",
                        name = CreateAtlasMarkup("AdventureMapIcon-Lock").." "..L["Unlock"],
                        desc = L["Lock or unlock the window"],
                        set = function(_, val)
                            Module:SetOption("unlock", val)
                            Module:UnlockUpdate()
                        end,
                        get = function() return Module:GetOption("unlock") end,
                        width = 0.55,
                        order = 40,
                    },
                },
            },
            --Tab Section
            styleTab = {
                type = "group",
                name = L["Style"],
                childGroups = "tab",
                order = 30,
                args = {
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------  Style Tab
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                    style = {
                        type = "group",
                        name = " ",
                        order = 10,
                        inline = true,
                        args = {
                            styleHeader = {
                                order = 10,
                                name = fontColor.lucid:format(L["Choose your own Style"]),
                                type = "description",
                                fontSize = "large",
                                width = "full",
                            },
                            background = {
                                type = "select",
                                name = L["Background Style"],
                                desc = L["Choose your background style here."],
                                set = function(_, val)
                                    Module:SetOption("background", val)
                                    Module:BackgroundUpdate()
                                end,
                                get = function() return Module:GetOption("background") end,
                                width = 1.2,
                                order = 20,
                                values = backdroplist,
                            },
                            seperator = {
                                order = 30,
                                name = "",
                                type = "description",
                                width = 0.1,
                            },
                            colorit = {
                                type = "color",
                                name = L["Color It"],
                                desc = "",
                                hasAlpha = true,
                                set = function(_, r, g, b, a)
                                    Module:SetOption("colorit", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a })
                                    Module:BackgroundUpdate()
                                end,
                                get = function()
                                    local color = Module:GetOption("colorit")
                                    return color["r"], color["g"], color["b"], color["a"]
                                end,
                                disabled = function() return db.profile.background ~= 6 end,
                                width = 1.2,
                                order = 40,
                            },
                            sparkle = {
                                type = "select",
                                name = L["Sparkle Effect"],
                                desc = L["Gives you a sparkle effect on the bar."],
                                set = function(_, val)
                                    Module:SetOption("sparkle", val)
                                    Module:SparkleUpdate()
                                end,
                                get = function() return Module:GetOption("sparkle") end,
                                width = 1.2,
                                order = 50,
                                values = {
                                    [1] = L["None"],
                                    [2] = L["Low Sparkle"],
                                    [3] = L["High Sparkle"],
                                    [4] = L["Thunder"],
                                    [5] = L["Fairy"],
                                    [6] = L["Meteor"],
                                    [7] = L["Fire"],
                                    [8] = L["Digital"],
                                    [9] = L["Awakened"],
                                    [10] = L["Prideful"],
                                },
                            },
                        },
                    },
                },
            },
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------  Display Tab
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            displayTab = {
                type = "group",
                name = L["Display"],
                childGroups = "tab", 
                order = 40,
                args = {
                    displayTimer = {
                        type = "group",
                        name = " ",
                        order = 10,
                        inline = true,
                        args = {
                            displayTimerHeader = {
                                order = 10,
                                name = fontColor.lucid:format(L["Timer"]),
                                type = "description",
                                fontSize = "large",
                                width = "full",
                            },
                            mainTimer = {
                                type = "select",
                                name = L["Main Timer"],
                                desc = "",
                                set = function(_, val)
                                    Module:SetOption("mainTimer", val)
                                    Module:TimerText()
                                end,
                                get = function() return Module:GetOption("mainTimer") end,
                                width = 1.2,
                                order = 20,
                                values = {
                                    [1] = L["Time Passed"],
                                    [2] = L["Time Remaining"],
                                },
                            },
                            TimerBarColor = {
                                type = "color",
                                name = L["Timer Bar Color"],
                                desc = "",
                                hasAlpha = false,
                                set = function(_, r, g, b, a)
                                    Module:SetOption("timerBarColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a })
                                    Module:SetTimerBarColor()
                                end,
                                get = function()
                                    local color = Module:GetOption("timerBarColor")
                                    return color["r"], color["g"], color["b"], color["a"]
                                end,
                                width = 1.2,
                                order = 30,
                            },
                            TimerBarStyle = {
                                order = 40,
                                name = L["Bar Style"],
                                type = "select",
                                width = 1.2,
                                dialogControl = "LSM30_Statusbar",
                                values = _G.AceGUIWidgetLSMlists.statusbar,
                                set = function(_, val)
                                    Module:SetOption("TimerBarStyle", val)
                                    Module:UpdateBars()
                                end,
                                get = function() return Module:GetOption("TimerBarStyle") end,
                            },
                            TimerSpace = {
                                order = 50,
                                name = " ",
                                type = "description",
                                width = 2,
                            },
                            plusOne = {
                                type = "toggle",
                                name = L["Show"].." +1",
                                desc = "",
                                set = function(_, val)
                                    Module:SetOption("plusOne", val)
                                    Module:PlusTimer()
                                end,
                                get = function() return Module:GetOption("plusOne") end,
                                disabled = function()
                                    return Module:GetOption("smartTimer")
                                end,
                                width = 1,
                                order = 60,
                            },
                            plusTwo = {
                                type = "toggle",
                                name = L["Show"].." +2",
                                desc = "",
                                set = function(_, val)
                                    Module:SetOption("plusTwo", val)
                                    Module:PlusTimer()
                                end,
                                get = function() return Module:GetOption("plusTwo") end,
                                disabled = function()
                                    return Module:GetOption("smartTimer")
                                end,
                                width = 1,
                                order = 70,
                            },
                            plusThree = {
                                type = "toggle",
                                name = L["Show"].." +3",
                                desc = "",
                                set = function(_, val)
                                    Module:SetOption("plusThree", val)
                                    Module:PlusTimer()
                                end,
                                get = function() return Module:GetOption("plusThree") end,
                                disabled = function()
                                    return Module:GetOption("smartTimer")
                                end,
                                width = 1,
                                order = 80,
                            },
                            smartTimer = {
                                type = "toggle",
                                name = L["Smart Timer"],
                                desc = L["You only see the timer to the next possible\nupgrade."],
                                set = function(_, val)
                                    Module:SetOption("smartTimer", val)
                                    Module:PlusTimer()
                                end,
                                get = function() return Module:GetOption("smartTimer") end,
                                width = 1,
                                order = 90,
                            },
                        },
                    },
                    displayBosses = {
                        type = "group",
                        name = " ",
                        order = 20,
                        inline = true,
                        args = {
                            displayHeader = {
                                order = 10,
                                name = fontColor.lucid:format(L["Bosses"]),
                                type = "description",
                                fontSize = "large",
                                width = "full",
                            },
                            bosses = {
                                type = "select",
                                name = L["Boss Counter"],
                                desc = L["Displays you the killed bosses.\n\ne.g.\n[Simple = 3/4]\n[Extended = Name 0/1]"],
                                set = function(_, val)
                                    Module:SetOption("bosses", val)
                                    Module:BossesText()
                                end,
                                get = function() return Module:GetOption("bosses") end,
                                width = 1.2,
                                order = 20,
                                values = {
                                    [1] = L["None"],
                                    [2] = L["Simple"],
                                    [3] = L["Extended"],
                                },
                            },
                            timeStamp = {
                                type = "toggle",
                                name = L["Timestamp on Bosskill"],
                                desc = L["Gives you a timestamp if you kill a boss."],
                                set = function(_, val)
                                    Module:SetOption("timeStamp", val)
                                    Module:BossesText()
                                end,
                                get = function() return Module:GetOption("timeStamp") end,
                                disabled = function()
                                    return Module:GetOption("bosses") ~= 3
                                end,
                                width = 1.2,
                                order = 30,
                            },
                        },
                    },
                    displayMobs = {
                        type = "group",
                        name = " ",
                        order = 30,
                        inline = true,
                        args = {
                            displayHeaderM = {
                                order = 10,
                                name = fontColor.lucid:format(L["Mob Counter"]),
                                type = "description",
                                fontSize = "large",
                                width = "full",
                            },
                            mobCount = {
                                type = "select",
                                name = L["Mob Counter"],
                                desc = "",
                                set = function(_, val)
                                    Module:SetOption("mobCount", val)
                                    Module:MobBar()
                                    Module:BackgroundUpdate()
                                    Module:BossesText()
                                    Module:AffixText()
                                end,
                                get = function() return Module:GetOption("mobCount") end,
                                width = 1.2,
                                order = 20,
                                values = {
                                    [1] = L["Text only"],
                                    [2] = L["Text and Progress Bar"],
                                },
                            },
                            MobBarColor = {
                                type = "color",
                                name = L["Mob Bar Color"],
                                desc = "",
                                hasAlpha = false,
                                set = function(_, r, g, b, a)
                                    Module:SetOption("mobBarColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a })
                                    Module:SetMobBarColor()
                                end,
                                get = function()
                                    local color = Module:GetOption("mobBarColor")
                                    return color["r"], color["g"], color["b"], color["a"]
                                end,
                                disabled = function() return db.profile.mobCount == 1 end,
                                width = 1.2,
                                order = 30,
                            },
                            MobBarStyle = {
                                order = 40,
                                name = L["Bar Style"],
                                type = "select",
                                width = 1.2,
                                dialogControl = "LSM30_Statusbar",
                                values = _G.AceGUIWidgetLSMlists.statusbar,
                                set = function(_, val)
                                    Module:SetOption("MobBarStyle", val)
                                    Module:UpdateBars()
                                end,
                                get = function() return Module:GetOption("MobBarStyle") end,
                                disabled = function()
                                    return Module:GetOption("mobCount") == 1
                                end,
                            },
                            MobSpace = {
                                order = 50,
                                name = " ",
                                type = "description",
                                width = 2,
                            },
                            invertPerc = {
                                type = "toggle",
                                name = L["Invert Progress Bar"],
                                desc = L["Invert the Progress Bar to count down the percentage."],
                                set = function(_, val)
                                    Module:SetOption("invertPerc", val)
                                    Module:MobBar()
                                end,
                                get = function() return Module:GetOption("invertPerc") end,
                                disabled = function()
                                    return Module:GetOption("mobCount") == 1
                                end,
                                width = 1,
                                order = 60,
                            },
                            MobPercStep = {
                                type = "toggle",
                                name = L["Mob Count in Percent"],
                                desc = L["Shows the Mob Count in Percent instead of the exact Number."],
                                set = function(_, val)
                                    Module:SetOption("MobPercStep", val)
                                    Module:MobUpdateConfig()
                                end,
                                get = function() return Module:GetOption("MobPercStep") end,
                                width = 1,
                                order = 70,
                            },
                        },
                    },
                    displayKey = {
                        type = "group",
                        name = " ",
                        order = 40,
                        inline = true,
                        args = {
                            displayHeaderK = {
                                order = 10,
                                name = fontColor.lucid:format(L["Keylevel"]),
                                type = "description",
                                fontSize = "large",
                                width = "full",
                            },
                            keyColor = {
                                type = "toggle",
                                name = L["Raider.IO Keylevel color"],
                                desc = L["Shows Raider.IO colors as Keylevel."],
                                set = function(_, val)
                                    Module:SetOption("keyColor", val)
                                    Module:KeyLevel()
                                end,
                                disabled = function()
                                    return not IsAddOnLoaded("RaiderIO")
                                end,
                                get = function() return Module:GetOption("keyColor") end,
                                width = 1,
                                order = 20,
                            },
                            customKeyColor = {
                                type = "color",
                                name = L["Custom Key Color"],
                                desc = "",
                                hasAlpha = false,
                                set = function(_, r, g, b, a)
                                    Module:SetOption("customKeyColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a })
                                    Module:KeyLevel()
                                end,
                                get = function()
                                    local color = Module:GetOption("customKeyColor")
                                    return color["r"], color["g"], color["b"], color["a"]
                                end,
                                width = 0.8,
                                order = 30,
                            },
                        },
                    },
                    displayOthers = {
                        type = "group",
                        name = " ",
                        order = 40,
                        inline = true,
                        args = {
                            displayHeaderK = {
                                order = 10,
                                name = fontColor.lucid:format(L["Others"]),
                                type = "description",
                                fontSize = "large",
                                width = "full",
                            },
                            affix = {
                                type = "select",
                                name = L["Display Affix"],
                                desc = L["Display you the current active affix of your run."],
                                set = function(_, val)
                                    Module:SetOption("affix", val)
                                    Module:BossesText()
                                    Module:AffixText()
                                end,
                                get = function() return Module:GetOption("affix") end,
                                width = 1.2,
                                order = 40,
                                values = {
                                    [1] = L["None"],
                                    [2] = L["Text"],
                                    [3] = L["Icon - Button"],
                                    [4] = L["Icon - Left"],
                                    [5] = L["Icon - Right"],
                                },
                            },
                            dungeonName = {
                                type = "select",
                                name = L["Show Name of Dungeon"],
                                desc = L["Show you the name of the current dungeon."],
                                set = function(_, val)
                                    Module:SetOption("dungeonName", val)
                                    Module:DungeonText()
                                end,
                                get = function() return Module:GetOption("dungeonName") end,
                                width = 1.2,
                                order = 70,
                                values = {
                                    [1] = L["None"],
                                    [2] = L["Full Name"],
                                    [3] = L["Short Name"],
                                },
                            },
                        },
                    },
                },
            },
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------  General Tab
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            generalTab = {
                type = "group",
                name = L["General"],
                childGroups = "tab",
                order = 50,
                args = {
                    general = {
                        type = "group",
                        name = " ",
                        order = 10,
                        inline = true,
                        args = {
                            history = {
                                type = "toggle",
                                name = L["History Mode"],
                                desc = "",
                                set = function(_, val)
                                    Module:SetOption("history", val)
                                end,
                                get = function() return Module:GetOption("history") end,
                                width = 1.2,
                                order = 10,
                            },
                            speratorGeneral1 = {
                                order = 20,
                                name = "",
                                type = "description",
                                width = 2,
                            },
                            autoPlace = {
                                type = "toggle",
                                name = L["Keystone Autoplace"],
                                desc = "",
                                set = function(_, val)
                                    Module:SetOption("autoPlace", val)
                                end,
                                get = function() return Module:GetOption("autoPlace") end,
                                width = 1.2,
                                order = 30,
                            },
                            autoRole = {
                                type = "toggle",
                                name = L["Auto Rolecheck"],
                                desc = L["Automatically accept your role at each role check."],
                                set = function(_, val)
                                    Module:SetOption("autoRole", val)
                                    ToggleAutoRole()
                                end,
                                get = function() return Module:GetOption("autoRole") end,
                                width = 1.2,
                                order = 40,
                            },
                            postCom = {
                                type = "toggle",
                                name = L["Activate |cff87ceeb!keys|r Command"],
                                desc = L["Link your Key in chat by typing |cff87ceeb!keys|r in party/raid chat."],
                                set = function(_, val)
                                    Module:SetOption("postCom", val)
                                end,
                                get = function() return Module:GetOption("postCom") end,
                                width = 1.2,
                                order = 60,
                            },
                            autoPost = {
                                type = "toggle",
                                name = L["Autopost your Key"],
                                desc = L["Autopost your Key after finishing a run."],
                                set = function(_, val)
                                    Module:SetOption("autoPost", val)
                                end,
                                get = function() return Module:GetOption("autoPost") end,
                                width = 1.2,
                                order = 70,
                            },
                        },
                    },
                    generalFont = {
                        type = "group",
                        name = " ",
                        order = 20,
                        inline = true,
                        args = {
                            FontStyle = {
                                order = 10,
                                name = L["Font"],
                                type = "select",
                                width = 1.2,
                                dialogControl = "LSM30_Font",
                                values = _G.AceGUIWidgetLSMlists.font,
                                set = function(_, val)
                                    Module:SetOption("FontStyle", val)
                                    Module:UpdateFonts()
                                end,
                                get = function() return Module:GetOption("FontStyle") end,
                            },
                        },
                    },
                },
            },
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------  Dungeon Tab
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            dungeonTab = {
                type = "group",
                name = L["Dungeons"],
                childGroups = "tab",
                order = 60,
                args = {
                    expansion = {
                        type = "select",
                        name = "",
                        desc = "",
                        set = function(_, val)
                            Module:SetOption("expansion", val)
                        end,
                        get = function() return Module:GetOption("expansion") end,
                        width = 0.8,
                        order = 1,
                        values = {
                            [8] = "Shadowlands",
                        },
                    },
                    season = {
                        type = "select",
                        name = "",
                        desc = "",
                        set = function(_, val)
                            Module:SetOption("season", val)
                        end,
                        get = function() return Module:GetOption("season") end,
                        width = 0.6,
                        order = 2,
                        values = {
                            [1] = L["Season"].." 1",
                            [2] = L["Season"].." 2",
                            [3] = L["Season"].." 3",
                            [4] = L["Season"].." 4",
                        },
                    },
                    Dungeon1  = dungeonTable[1],
                    Dungeon2  = dungeonTable[2],
                    Dungeon3  = dungeonTable[3],
                    Dungeon4  = dungeonTable[4],
                    Dungeon5  = dungeonTable[5],
                    Dungeon6  = dungeonTable[6],
                    Dungeon7  = dungeonTable[7],
                    Dungeon8  = dungeonTable[8],
                    Dungeon9  = dungeonTable[9],
                    Dungeon10 = dungeonTable[10],
                    Dungeon11 = dungeonTable[11],
                    Dungeon12 = dungeonTable[12],
                    TotalDungeon = {
                        type = "group",
                        name = L["Total"],
                        order = 130,
                        args = {
                            RunsTitle = {
                                order = 10,
                                fontSize = "large",
                                name = function() return TotalRuns() end,
                                type = "description",
                                width = "full",
                            },
                            TotalRunsTab = {
                                type = "group",
                                name = " ",
                                inline = true,
                                order = 20,
                                args = {
                                    RunsInfoName = {
                                        order = 10,
                                        name = function() return table.concat(select(2,TotalRuns()), ":\n") end,
                                        type = "description",
                                        width = 0.8,
                                    },
                                    RunsInfoRuns = {
                                        order = 20,
                                        name = function() return table.concat(select(3,TotalRuns()), "\n") end,
                                        type = "description",
                                        width = 1.6,
                                    },
                                },
                            },
                            InfoSpace1 = {
                                order = 30,
                                type = "header",
                                name = "",
                                width = "half",
                            },
                            AvgTitle = {
                                order = 40,
                                fontSize = "large",
                                name = function() return select(4,TotalRuns()) end,
                                type = "description",
                                width = "full",
                            },
                            TotalAvgTab = {
                                type = "group",
                                name = " ",
                                inline = true,
                                order = 50,
                                args = {
                                    AvgInfoName = {
                                        order = 10,
                                        name = function() return table.concat(select(2,TotalRuns()), ":\n") end,
                                        type = "description",
                                        width = 0.8,
                                    },
                                    AvgInfoRuns = {
                                        order = 20,
                                        name = function() return table.concat(select(5,TotalRuns()), "\n") end,
                                        type = "description",
                                        width = 1.6,
                                    },
                                },
                            },
                            InfoSpace2 = {
                                order = 60,
                                type = "header",
                                name = "",
                                width = "half",
                            },
                            WLTitle = {
                                order = 70,
                                fontSize = "large",
                                name = function() return select(6,TotalRuns()) end,
                                type = "description",
                                width = "full",
                            },
                            InfoSpace3 = {
                                order = 80,
                                type = "header",
                                name = "",
                                width = "half",
                            },
                            TS = {
                                order = 90,
                                fontSize = "large",
                                name = fontColor.yellow:format(L["Time Spent in Mythic+"]),
                                type = "description",
                                width = "full",
                            },
                            TimeSpendTab = {
                                type = "group",
                                name = " ",
                                inline = true,
                                order = 100,
                                args = {
                                    TimeSpendName = {
                                        order = 10,
                                        name = L["Days:"].."\n"..L["Hours:"].."\n"..L["Minutes:"].."\n"..L["Seconds:"],
                                        type = "description",
                                        width = 0.5,
                                    },
                                    TimeSpendTime = {
                                        order = 20,
                                        name = function() return table.concat(TimeSpend(), "\n") end,
                                        type = "description",
                                        width = 1.6,
                                    },
                                    TimeSpendSep = {
                                        order = 30,
                                        name = " ",
                                        type = "description",
                                        width = "full",
                                    },
                                    TimeSpendPerRun = {
                                        order = 40,
                                        name = "Ø "..L["Per Run:"],
                                        type = "description",
                                        width = 0.5,
                                    },
                                    TimeSpendPerRunCount = {
                                        order = 50,
                                        name = function() return select(2,TimeSpend()) end,
                                        type = "description",
                                        width = 1.6,
                                    },
                                },
                            },
                        },
                    },
                },
            },
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------  About Tab
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            aboutTab = {
                type = "group",
                name = L["About"],
                childGroups = "tab",
                order = 70,
                args = {
                    about = {
                        type = "group",
                        name = " ",
                        order = 10,
                        inline = true,
                        args = {
                            aboutTitle = {
                                order = 10,
                                name = fontColor.yellow:format(L["Title: "])..title,
                                type = "description",
                                width = "full",
                            },
                            aboutVersion = {
                                order = 20,
                                name = fontColor.yellow:format(L["Version: "])..version,
                                type = "description",
                                width = "full",
                            },
                            aboutNotes = {
                                order = 30,
                                name = fontColor.yellow:format(L["Notes: "])..notes,
                                type = "description",
                                width = "full",
                            },
                            aboutAuthor = {
                                order = 40,
                                name = fontColor.yellow:format(L["Author: "])..author,
                                type = "description",
                                width = 1.6
                            },
                            aboutWeb = {
                                order = 50,
                                name = fontColor.yellow:format(L["Website: "]),
                                type = "input",
                                get = function()
                                    return GetAddOnMetadata(AddonName, "X-Website")
                                end,
                                width = "full",
                            },
                            aboutDonate = {
                                order = 60,
                                name = fontColor.yellow:format(L["Donate: "]),
                                type = "input",
                                get = function()
                                    return GetAddOnMetadata(AddonName, "X-Donate")
                                end,
                                width = "full",
                            },
                        },
                    },
                },
            },
        },
    }
    --Add to Blizzard Interface Options
    local AceConfig = LibStub("AceConfig-3.0")
    local AceConfigDialog = LibStub("AceConfigDialog-3.0")
    AceConfig:RegisterOptionsTable(AddonName, options)
    local frame = AceConfigDialog:AddToBlizOptions(AddonName, "Lucid Keystone", nil)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Chat Commands
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Open Addon
for i, v in pairs({"lk", "lucidkeystone"}) do
	_G["SLASH_LK"..i] = "/"..v
end
-- Add April fool
--[[for i, v in pairs({"lkcat"}) do
	_G["SLASH_LKt"..i] = "/"..v
end]]

function SlashCmdList.LK(msg)
    if msg == "" then
        -- Open Config
        ACD:SetDefaultSize(AddonName, 648, 570)
        ACD:Open(AddonName)
    elseif msg == L["played"] or msg == "played" then
        -- Get M+ Time played in Chat
        local days = select(1,TimeSpend()[1]).." "..L["days"]
        local hours = select(1,TimeSpend()[2]).." "..L["hours"]
        local minutes = select(1,TimeSpend()[3]).." "..L["minutes"]
        local seconds = select(1,TimeSpend()[4]).." "..L["seconds"]

        SendSystemMessage(L["Time played this Season in M+: "]..days..", "..hours..", "..minutes..", "..seconds)
    elseif msg == L["preview"] or msg == "preview" then
        -- Load Preview
        Module:ToggleTest()
    elseif msg == L["version"] or msg == "version" then
        -- Get Version in Chat
        SendSystemMessage(L["Version: "]..version)
    elseif msg == L["hilfe"] or msg == "help" then
        -- Get all Commands in Chat
        SendSystemMessage(L["Lucid Keystone Commands:"].."\n/lk\n/lk "..L["played"].."\n/lk "..L["version"].."\n/lk "..L["preview"])
    elseif msg == "deaths" then
        -- Get Deaths Overall
        print("Death Counter in M+")
        print("Profile: "..db.global.statistic.deaths)
        print("----------------------")
    else
        -- Get Error Msg
        SendSystemMessage(L["Invalid Command. Type \"/lk help\" to see all Lucid Keystone Commands."])
    end
end
--[[function SlashCmdList.LKt()
    backdroplist[11] = "April Fool"
end]]

--Initialize function
function Module:OnInitialize()
    db = LibStub("AceDB-3.0"):New("LucidKeystoneDB", defaults)
    version = GetAddOnMetadata(AddonName, "Version")
    author = GetAddOnMetadata(AddonName, "Author")
    notes = GetAddOnMetadata(AddonName, "Notes")
    title = GetAddOnMetadata(AddonName, "Title")
    AddConfig()
    ToggleAutoRole()
    db.profile.initTest = nil
end