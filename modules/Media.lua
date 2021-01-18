local AddonName, Addon = ...

--Logo
Addon.LOGO_LOCATION     = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_logo"
Addon.LOGO              = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\logo"
Addon.FONT_KOZUKA       = "Interface\\AddOns\\"..AddonName.."\\media\\Fonts\\KozGoPr6N-Light.ttf"
Addon.BAR_PARTICLES     = "Interface\\AddOns\\"..AddonName.."\\media\\Statusbars\\particles"

--Backgrounds
Addon.lk_bg_None1       = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_None"
Addon.lk_bg_None2       = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_None2"
Addon.lk_bg_Blizzard1   = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Blizzard"
Addon.lk_bg_Blizzard2   = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Blizzard2"
Addon.lk_bg_Horde1      = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Horde"
Addon.lk_bg_Horde2      = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Horde2"
Addon.lk_bg_Alliance1   = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Alliance"
Addon.lk_bg_Alliance2   = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Alliance2"
Addon.lk_bg_Simple1     = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Simple"
Addon.lk_bg_Simple2     = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Simple2"
Addon.lk_bg_Color1      = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Color"
Addon.lk_bg_Color2      = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Color2"
Addon.lk_bg_DarkGlass1  = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_DarkGlass"
Addon.lk_bg_DarkGlass2  = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_DarkGlass2"
Addon.lk_bg_Awakened1   = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Awakened"
Addon.lk_bg_Awakened2   = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Awakened2"
Addon.lk_bg_Prideful1   = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Prideful"
Addon.lk_bg_Prideful2   = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Prideful2"
Addon.lk_bg_Paradox1    = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Paradox"
Addon.lk_bg_Paradox2    = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Paradox2"
Addon.lk_bg_Cat1        = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Cat"
Addon.lk_bg_Cat2        = "Interface\\AddOns\\"..AddonName.."\\media\\Textures\\lk_Cat2"

local LSM = LibStub("LibSharedMedia-3.0")
LSM:Register("font", "Kozuka Gothic Light", Addon.FONT_KOZUKA, LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western)
LSM:Register("statusbar", "Lucid Keystone Particles", Addon.BAR_PARTICLES)
