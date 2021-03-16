local AddonName, Addon = ...

local media = "Interface\\AddOns\\"..AddonName.."\\media\\"

--Logo
Addon.LOGO_LOCATION     = media.."Textures\\lk_logo"
Addon.LOGO              = media.."Textures\\logo"

--Textures
Addon.TEX_UTILS         = media.."Textures\\utils.blp"

--Fonts
Addon.FONT_KOZUKA       = media.."Fonts\\KozGoPr6N-Light.ttf"
Addon.FONT_FIRA         = media.."Fonts\\FiraMono-Medium.ttf"

--Bars
Addon.BAR_PARTICLES     = media.."Statusbars\\particles"
Addon.BAR_DREAM         = media.."Statusbars\\dream"

--Sounds
Addon.SOUND_DEATH       = media.."Sounds\\StopDeath.ogg"

--Backgrounds
Addon.lk_bg_None1       = media.."Textures\\lk_None"
Addon.lk_bg_None2       = media.."Textures\\lk_None2"
Addon.lk_bg_Blizzard1   = media.."Textures\\lk_Blizzard"
Addon.lk_bg_Blizzard2   = media.."Textures\\lk_Blizzard2"
Addon.lk_bg_Horde1      = media.."Textures\\lk_Horde"
Addon.lk_bg_Horde2      = media.."Textures\\lk_Horde2"
Addon.lk_bg_Alliance1   = media.."Textures\\lk_Alliance"
Addon.lk_bg_Alliance2   = media.."Textures\\lk_Alliance2"
Addon.lk_bg_Marble1     = media.."Textures\\lk_Marble"
Addon.lk_bg_Marble2     = media.."Textures\\lk_Marble2"
Addon.lk_bg_Color1      = media.."Textures\\lk_Color"
Addon.lk_bg_Color2      = media.."Textures\\lk_Color2"
Addon.lk_bg_DarkGlass1  = media.."Textures\\lk_DarkGlass"
Addon.lk_bg_DarkGlass2  = media.."Textures\\lk_DarkGlass2"
Addon.lk_bg_Awakened1   = media.."Textures\\lk_Awakened"
Addon.lk_bg_Awakened2   = media.."Textures\\lk_Awakened2"
Addon.lk_bg_Prideful1   = media.."Textures\\lk_Prideful"
Addon.lk_bg_Prideful2   = media.."Textures\\lk_Prideful2"
Addon.lk_bg_Paradox1    = media.."Textures\\lk_Paradox"
Addon.lk_bg_Paradox2    = media.."Textures\\lk_Paradox2"
--Addon.lk_bg_Domination1 = media.."Textures\\lk_Domination"
--Addon.lk_bg_Domination2 = media.."Textures\\lk_Domination2"
Addon.lk_bg_Kyrian1      = media.."Textures\\lk_Kyrian"
Addon.lk_bg_Kyrian2      = media.."Textures\\lk_Kyrian2"
Addon.lk_bg_Necrolord1   = media.."Textures\\lk_Necrolord"
Addon.lk_bg_Necrolord2   = media.."Textures\\lk_Necrolord2"
Addon.lk_bg_NightFae1    = media.."Textures\\lk_NightFae"
Addon.lk_bg_NightFae2    = media.."Textures\\lk_NightFae2"
Addon.lk_bg_Venthyr1     = media.."Textures\\lk_Venthyr"
Addon.lk_bg_Venthyr2     = media.."Textures\\lk_Venthyr2"

local LSM = LibStub("LibSharedMedia-3.0")
LSM:Register("font", "Kozuka Gothic Light", Addon.FONT_KOZUKA, LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western + LSM.LOCALE_BIT_zhCN + LSM.LOCALE_BIT_zhTW + LSM.LOCALE_BIT_koKR)
LSM:Register("font", "Fira Mono Medium", Addon.FONT_FIRA, LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western)
LSM:Register("statusbar", "Lucid Keystone Particles", Addon.BAR_PARTICLES)
LSM:Register("statusbar", "Lucid Keystone Dream", Addon.BAR_DREAM)
LSM:Register("sound", "Stop Death", Addon.SOUND_DEATH)