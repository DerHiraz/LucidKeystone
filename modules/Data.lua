local _, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale("LucidKeystone")

Addon.fontColor = {
    yellow  = "|cffffd100%s|r",
    green   = "|cff4cff00%s|r",
    blue    = "|cff009dd5%s|r",
    red     = "|cffe22b2a%s|r",
    lucid   = "|cff71478E%s|r",
    grey    = "|cff787878%s|r",
}

Addon.sparkleEffect = {
    [1]  = {animation = 165433},
    [2]  = {animation = 1097298},
    [3]  = {animation = 1004197},
    [4]  = {animation = 1522788},
    [5]  = {animation = 1384104},
    [6]  = {animation = 654238},
    [7]  = {animation = 841273}, --240950
    [8]  = {animation = 1322288},
    [9]  = {animation = 978543},
    [10] = {animation = 310425},
    [11] = {animation = 1135053},
}

Addon.Delimiter = {
    [1] = ".",
    [2] = "/",
    [3] = "-",
}

Addon.MapID = {
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
    [375] = {ShortName = L["Mists"]},
    [376] = {ShortName = L["NW"]},
    [377] = {ShortName = L["DOS"]},
    [378] = {ShortName = L["HoA"]},
    [379] = {ShortName = L["PF"]},
    [380] = {ShortName = L["SD"]},
    [381] = {ShortName = L["SoA"]},
    [382] = {ShortName = L["ToP"]}, 
}

Addon.MDTdungeon = {
    [1663] = 30, -- Halls of Atonement
    [1664] = 30, -- Halls of Atonement
    [1665] = 30, -- Halls of Atonement
    [1666] = 35, -- The Necrotic Wake
    [1667] = 35, -- The Necrotic Wake
    [1668] = 35, -- The Necrotic Wake
    [1669] = 31, -- Mists Of Tirna Scithe
    [1674] = 32, -- Plaguefall
    [1697] = 32, -- Plaguefall
    [1675] = 33, -- Sanguine Depths
    [1676] = 33, -- Sanguine Depths
    [1677] = 29, -- De Other Side
    [1678] = 29, -- De Other Side
    [1679] = 29, -- De Other Side
    [1680] = 29, -- De Other Side
    [1683] = 36, -- Theater Of Pain
    [1684] = 36, -- Theater Of Pain
    [1685] = 36, -- Theater Of Pain
    [1686] = 36, -- Theater Of Pain
    [1687] = 36, -- Theater Of Pain
    [1692] = 34, -- Spires Of Ascension
    [1693] = 34, -- Spires Of Ascension
    [1694] = 34, -- Spires Of Ascension
    [1695] = 34, -- Spires Of Ascension
}

-- Get Base Score by Raider.IO
function Addon.GetBaseScore(level)
    local score
    if level <= 10 then
        score = level * 10
    else
        score = 1.1^(level-10)*100
    end
    return score
end

-- Get Score Color by Raider.IO
function Addon.GetScoreColor(score)
    local ScoreColor
    if (IsAddOnLoaded("RaiderIO")) and db.profile.keyColor then
        local zone = C_ChallengeMode.GetMapTable()
        local rR, rG, rB = RaiderIO.GetScoreColor(score*#zone)
        ScoreColor = string.format("|cff%.2X%.2X%.2X", rR*255, rG*255, rB*255)
    else
        ScoreColor = string.format("|cff%.2X%.2X%.2X", db.profile.customKeyColor.r*255, db.profile.customKeyColor.g*255, db.profile.customKeyColor.b*255)
    end
    return ScoreColor
end

-- Get Stars for Runs
function Addon.GetStars(time, zoneID)
    local _,_,maxTime = C_ChallengeMode.GetMapUIInfo(zoneID)
    if time == 0 then
        return ""
    elseif time < maxTime*0.6 then
        return Addon.fontColor.yellow:format("***")
    elseif time < maxTime*0.8 then
        return Addon.fontColor.yellow:format("**")
    elseif time < maxTime then
        return Addon.fontColor.yellow:format("*")
    else
        return ""
    end
end

-- Get Util Images
function Addon.GetUtilInfo(column,row,IsInText,Size)
    if IsInText then
        local c = 64
        if not Size then
            Size = 12
        end
        local Util =  column*c-c..":"..column*c-1 ..":"..row*c-c..":"..row*c-1
        return "|T"..Addon.TEX_UTILS..":"..Size..":"..Size..":0:0:256:256:"..Util.."|t "
    else
        local c = 0.25
        return {column*c-c,column*c,row*c-c,row*c}
    end
end

-- Addon Msg Keyinfos
function Addon.KeyCommInfo(num)
    if num and db.profile.KeyComm[num] then
        local level, dungeon, bestKey, total = 0, "No Key", 0, 0

        if db.profile.KeyComm[num].key ~= 0 then
            level = db.profile.KeyComm[num].level
            dungeon = C_ChallengeMode.GetMapUIInfo(db.profile.KeyComm[num].key)
        end
        local sender = "|c"..db.profile.KeyComm[num].class..Ambiguate(db.profile.KeyComm[num].sender,"short").."|r"
        return level, dungeon, sender
    else
        return
    end
end

function Addon.KeyCommInfoParty(num)
    local sender, bestKey, total, upgrade = {},{},{},{}
    local size = 10
    for i = 1, #db.profile.KeyComm do
        if db.profile.KeyComm[i] then
            local s = "|c"..db.profile.KeyComm[i].class..Ambiguate(db.profile.KeyComm[i].sender,"short").."|r"
            local b = tonumber(db.profile.KeyComm[i].best[db.profile.KeyComm[num].key])
            local t
            if db.profile.KeyComm[i].totalShare == 0 then
                t = Addon.GetUtilInfo(4,2,true,10)
            else
                if not db.profile.ShareTotal then
                    t = Addon.GetUtilInfo(4,2,true,10)
                else
                    t = tonumber(db.profile.KeyComm[i].total[db.profile.KeyComm[num].key])
                end
            end
            local u = ""
            if not b then b = 0 end
            if not t then t = 0 end
            if b == db.profile.KeyComm[num].level then
                u = Addon.GetUtilInfo(3,2,true,10)
            elseif b > db.profile.KeyComm[num].level then
                u = Addon.GetUtilInfo(2,2,true,10)
            else
                u = Addon.GetUtilInfo(1,2,true,10)
            end
            b = L["Season Best: "]..Addon.fontColor.yellow:format(b)
            t = L["Runs: "]..Addon.fontColor.yellow:format(t)

            table.insert(sender, s)
            table.insert(bestKey, b)
            table.insert(total, t)
            table.insert(upgrade, u)
        end
    end
    return sender, bestKey, total, upgrade
end

-- Time formating for every Timer in Frame
function Addon.TimeFormat(time,plus,dayInd) 
    local format_minutes = "%.2d:%.2d"
    local format_hours = "%d:%.2d:%.2d"
    local format_days = "%d:%.2d:%.2d:%.2d"
    local prefix = " "
    if plus then prefix = "+" end
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