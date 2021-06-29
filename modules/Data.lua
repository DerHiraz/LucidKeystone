local _, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale("LucidKeystone")

Addon.fontColor = {
    yellow  = "|cffffd100%s|r",
    green   = "|cff4cff00%s|r",
    blue    = "|cff009dd5%s|r",
    red     = "|cffe22b2a%s|r",
    lucid   = "|cff71478E%s|r",
    grey    = "|cff787878%s|r",
    black   = "|cff000000%s|r",
    orange  = "|cffff7d0a%s|r", 
}

Addon.sparkleEffect = {
    [1]  = {animation = 165433},    -- None
    [2]  = {animation = 1097298},   -- Low Sparkle
    [3]  = {animation = 1004197},   -- High Sparkle
    [4]  = {animation = 1522788},   -- Thunder
    [5]  = {animation = 1384104},   -- Fairy
    [6]  = {animation = 654238},    -- Meteor
    [7]  = {animation = 841273},    -- Fire
    [8]  = {animation = 1322288},   -- Digital
    [9]  = {animation = 978543},    -- Awakened
    [10] = {animation = 310425},    -- Prideful
    [11] = {animation = 165880},    -- Tormented
}

Addon.TormentedMobs = {179446, 179892, 179891, 179890}

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
    --[possible 383] = {ShortName = L["Upper"]},
    --[possible 384] = {ShortName = L["Lower"]},
}

Addon.keyID = {
    [138019] = true, -- Legion
    [158923] = true, -- BfA
    [180653] = true, -- Shadowlands
    [151086] = true, -- Tournament
}

Addon.ScoreColors = {
    [0]    = {r = 0.68, g = 0.68, b = 0.68, hex = "afafaf"},
    [100]  = {r = 1.00, g = 1.00, b = 1.00, hex = "ffffff"}, 
    [200]  = {r = 0.90, g = 1.00, b = 0.88, hex = "e5ffe0"},
    [300]  = {r = 0.81, g = 1.00, b = 0.78, hex = "ceffc7"}, 
    [400]  = {r = 0.72, g = 1.00, b = 0.68, hex = "b8ffae"},  
    [500]  = {r = 0.63, g = 1.00, b = 0.58, hex = "a0ff95"},  
    [600]  = {r = 0.55, g = 1.00, b = 0.48, hex = "8bff7b"},  
    [700]  = {r = 0.45, g = 1.00, b = 0.38, hex = "74ff61"}, 
    [800]  = {r = 0.37, g = 1.00, b = 0.28, hex = "5eff48"},  
    [900]  = {r = 0.28, g = 1.00, b = 0.18, hex = "47ff2e"}, 
    [1000] = {r = 0.12, g = 1.00, b = 0.00, hex = "1eff00"}, 
    [1100] = {r = 0.09, g = 0.88, b = 0.19, hex = "18e030"}, 
    [1200] = {r = 0.07, g = 0.76, b = 0.36, hex = "11c35c"}, 
    [1300] = {r = 0.05, g = 0.65, b = 0.54, hex = "0ca689"}, 
    [1400] = {r = 0.02, g = 0.54, b = 0.71, hex = "058ab5"}, 
    [1500] = {r = 0.00, g = 0.44, b = 0.87, hex = "0070dd"},
    [1600] = {r = 0.22, g = 0.36, b = 0.89, hex = "395ce3"}, 
    [1700] = {r = 0.44, g = 0.28, b = 0.91, hex = "7148e8"}, 
    [1800] = {r = 0.64, g = 0.21, b = 0.93, hex = "a335ee"},
    [1900] = {r = 0.74, g = 0.29, b = 0.66, hex = "bd4ba9"}, 
    [2000] = {r = 0.84, g = 0.38, b = 0.40, hex = "d76066"}, 
    [2100] = {r = 0.95, g = 0.45, b = 0.14, hex = "f17424"}, 
    [2200] = {r = 1.00, g = 0.50, b = 0.00, hex = "ff8000"},
}

Addon.Loot = {
    Mplus = {
        [2]  = 226,
        [3]  = 226,
        [4]  = 226,
        [5]  = 229,
        [6]  = 229,
        [7]  = 233,
        [8]  = 236,
        [9]  = 236,
        [10] = 239,
        [11] = 242,
        [12] = 246,
        [13] = 246,
        [14] = 249,
        [15] = 252,
    },
    Raid = {
        [14] = 226, -- normal
        [15] = 239, -- heroic
        [16] = 252, -- mythic
        [17] = 213, -- lfr
    },
    PvP = {
        [0] = 220, -- unranked
        [1] = 226, -- combatant
        [2] = 233, -- challenger
        [3] = 240, -- rival
        [4] = 246, -- duelist
    },
}

Addon.Supporter = {
    --====Developer
    ["Hiraz-Thrall"]            = "dev",
    ["Hirazhunt-Thrall"]        = "dev",
    ["Hiraz-Blackrock"]         = "dev",
    ["Derhiraz-Blackrock"]      = "dev",
    ["Derhiraz-Kazzak"]         = "dev",
    ["Hiraz-Kazzak"]            = "dev",
    --====Special
    -- Panix
    ["Panixdh-Thrall"]          = "special",
    ["Panìx-Thrall"]            = "special",
    ["Panixdk-Thrall"]          = "special",
    -- Psei
    ["Psei-Thrall"]             = "special",
    ["Davada-Thrall"]           = "special",
    ["Skyhorn-Thrall"]          = "special",
    -- Deralja
    ["Deralja-Thrall"]          = "special",
    ["Lenahja-Thrall"]          = "special",
    ["Sinahja-Thrall"]          = "special",
    -- Sinchi
    ["Drumms-Thrall"]           = "special",
    ["Sinchi-Thrall"]           = "special",
    ["Cazari-Thrall"]           = "special",
    -- Mero
    ["Merorida-Thrall"]         = "special",
    ["Merotasty-Thrall"]        = "special",
    ["Meromorphsis-Thrall"]     = "special",
    -- Para
    ["Pararog-Kazzak"]          = "special",
    ["Purplerog-Kazzak"]        = "special",
    ["Páradôx-Kazzak"]          = "special",
    -- Raiby
    ["Raibsen-Blackrock"]       = "special",
    ["Yarnandil-Blackrock"]     = "special",
    --====Translator
    -- Neo
    ["灵魂复苏-血色十字军"]       = "translator", -- CN and TW translation
    ["Lhfs-Illidan"]            = "translator",
}

-- Get Score Color
function Addon.GetScoreColor(score,force)
    local scoreC = score
    local wrap
    if score >= 2200 then scoreC = 2200 end
    if db.profile.keyColor or force then
        local color = Addon.ScoreColors[scoreC-scoreC % 100]
        wrap = string.format("|cff%.2X%.2X%.2X", color.r*255, color.g*255, color.b*255)
    else
        wrap = string.format("|cff%.2X%.2X%.2X", db.profile.customKeyColor.r*255, db.profile.customKeyColor.g*255, db.profile.customKeyColor.b*255)
    end
    return wrap
end

-- Sort function for Arrays
function Addon.spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
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

function Addon.BadgeInfo(Size,badge)
    local icon = ""
    local setting = ":"..Size..":"..Size..":0:0:0:64:64:0:1:0:1|t "
    if badge == "dev" then
        icon = "|T"..Addon.badge_dev..setting
    elseif badge == "special" then
        icon = "|T"..Addon.badge_special..setting
    elseif badge == "translator" then
        icon = "|T"..Addon.badge_translator..setting
    end
    return icon
end

function Addon.GetIcon(Size,num,kill)
    local icon = ""
    local c = "86:86:86"
    if kill then 
        c = db.profile.tormentedColor.r*255 .. ":" .. db.profile.tormentedColor.g*255 .. ":" .. db.profile.tormentedColor.b*255
    end
    local setting = ":"..Size..":"..Size..":0:0:32:32:0:32:0:32:"..c.."|t "
    if num == 1 then
        icon = "|T"..Addon.TORCIRCLE..setting
    elseif num == 2 then
        icon = "|T"..Addon.TORSQUARE..setting
    end
    return icon
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