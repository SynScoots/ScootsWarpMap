ScootsWarpMap = {
    ['version'] = '1.1.3',
    ['frames'] = {
        ['master'] = CreateFrame('Frame', 'ScootsWarpMap-Master', UIParent)
    },
    ['buttons'] = {},
    ['outlandIndexes'] = {
        [53] = true, -- Hellfire Peninsula
        [54] = true, -- Zangarmarsh
        [55] = true, -- Nagrand
        [56] = true, -- Terokkar Forest
        [57] = true, -- Shadowmoon Valley
        [58] = true, -- Blade's Edge Mountains
        [59] = true, -- Netherstorm
        [60] = true, -- Shattrath City
    },
    ['hasInit'] = false,
    ['uiBuilt'] = false,
}

ScootsWarpMap.updateLoop = function()
    if(CustomHasTeleport and TPortData) then
        ScootsWarpMap.hasInit = true
        ScootsWarpMap.frames.master:SetScript('onUpdate', nil)
    end
end

SLASH_SCOOTSWARPMAP1 = '/scootswarpmap'
SlashCmdList['SCOOTSWARPMAP'] = function(...)
    if(ScootsWarpMap.hasInit) then
        if(ScootsWarpMap.uiBuilt == false) then
            ScootsWarpMap.buildUi()
            ScootsWarpMap.uiBuilt = true
        end
        
        if(ScootsWarpMap.frames.master:IsVisible()) then
            ScootsWarpMap.frames.master:Hide()
        else
            ScootsWarpMap.placeSpells()
            ScootsWarpMap.frames.master:Show()
        end
    end
end

ScootsWarpMap.buildUi = function()
    tinsert(UISpecialFrames, ScootsWarpMap.frames.master:GetName())
    local tileSize = 256
    local azerothMapWidth = tileSize * 3.914
    local azerothMapHeight = tileSize * 2.61
    
    -- ###

    ScootsWarpMap.frames.master:Hide()
    ScootsWarpMap.frames.master:EnableMouse(true)
    ScootsWarpMap.frames.master:SetFrameStrata('HIGH')
    ScootsWarpMap.frames.master:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
    ScootsWarpMap.frames.master:SetSize(1024, azerothMapHeight + 52)
    ScootsWarpMap.frames.master:SetMovable(true)
    
    ScootsWarpMap.frames.master.borderTop = ScootsWarpMap.frames.master:CreateTexture(nil, 'ARTWORK')
    ScootsWarpMap.frames.master.borderTop:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Background-Top')
    ScootsWarpMap.frames.master.borderTop:SetPoint('TOPLEFT', 0, 0)
    ScootsWarpMap.frames.master.borderTop:SetSize(1024, 32)
    
    ScootsWarpMap.frames.master.borderLeft = ScootsWarpMap.frames.master:CreateTexture(nil, 'ARTWORK')
    ScootsWarpMap.frames.master.borderLeft:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Background-Left')
    ScootsWarpMap.frames.master.borderLeft:SetPoint('TOPLEFT', ScootsWarpMap.frames.master.borderTop, 'BOTTOMLEFT', 0, 0)
    ScootsWarpMap.frames.master.borderLeft:SetSize(8, 1024)
    
    ScootsWarpMap.frames.master.borderRight = ScootsWarpMap.frames.master:CreateTexture(nil, 'ARTWORK')
    ScootsWarpMap.frames.master.borderRight:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Background-Right')
    ScootsWarpMap.frames.master.borderRight:SetPoint('TOPRIGHT', ScootsWarpMap.frames.master.borderTop, 'BOTTOMRIGHT', -15, 0)
    ScootsWarpMap.frames.master.borderRight:SetSize(8, 1024)
    
    ScootsWarpMap.frames.master.borderBottom = ScootsWarpMap.frames.master:CreateTexture(nil, 'ARTWORK')
    ScootsWarpMap.frames.master.borderBottom:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Background-Bottom')
    ScootsWarpMap.frames.master.borderBottom:SetPoint('BOTTOMLEFT', 0, 0)
    ScootsWarpMap.frames.master.borderBottom:SetSize(1024, 32)
    
    ScootsWarpMap.frames.azerothMap = CreateFrame('Frame', 'ScootsWarpMap-Map', ScootsWarpMap.frames.master)
    ScootsWarpMap.frames.azerothMap:SetPoint('BOTTOMLEFT', ScootsWarpMap.frames.master, 'BOTTOMLEFT', 5, 29)
    ScootsWarpMap.frames.azerothMap:SetSize(azerothMapWidth, azerothMapHeight)
    
    -- ###
    
    ScootsWarpMap.frames.title = CreateFrame('Frame', 'ScootsWarpMap-Title', ScootsWarpMap.frames.master)
    ScootsWarpMap.frames.title:SetPoint('TOPLEFT', ScootsWarpMap.frames.master, 'TOPLEFT', 4, -3)
    ScootsWarpMap.frames.title:SetSize(982, 18)
    ScootsWarpMap.frames.title:EnableMouse(true)
    ScootsWarpMap.frames.title:RegisterForDrag('LeftButton')
    
    ScootsWarpMap.frames.title:SetScript('OnDragStart', function()
        ScootsWarpMap.frames.master:StartMoving()
    end)
    
    ScootsWarpMap.frames.title:SetScript('OnDragStop', function()
        ScootsWarpMap.frames.master:StopMovingOrSizing()
    end)
    
    ScootsWarpMap.frames.title.text = ScootsWarpMap.frames.title:CreateFontString(nil, 'OVERLAY')
    ScootsWarpMap.frames.title.text:SetFontObject('GameFontHighlight')
    ScootsWarpMap.frames.title.text:SetPoint('LEFT', ScootsWarpMap.frames.title, 'LEFT', 2, 0)
    ScootsWarpMap.frames.title.text:SetJustifyH('LEFT')
    ScootsWarpMap.frames.title.text:SetText('ScootsWarpMap')
    
    ScootsWarpMap.frames.title.version = ScootsWarpMap.frames.title:CreateFontString(nil, 'OVERLAY')
    ScootsWarpMap.frames.title.version:SetFontObject('GameFontHighlightSmall')
    ScootsWarpMap.frames.title.version:SetTextColor(0.596, 0.984, 0.596)
    ScootsWarpMap.frames.title.version:SetPoint('BOTTOMLEFT', ScootsWarpMap.frames.title.text, 'BOTTOMRIGHT', 2, 0)
    ScootsWarpMap.frames.title.version:SetJustifyH('LEFT')
    ScootsWarpMap.frames.title.version:SetText(ScootsWarpMap.version)
    
    -- ##
    
    ScootsWarpMap.frames.azerothMap.learned = ScootsWarpMap.frames.title:CreateFontString(nil, 'OVERLAY')
    ScootsWarpMap.frames.azerothMap.learned:SetFontObject('GameFontHighlightSmall')
    ScootsWarpMap.frames.azerothMap.learned:SetTextColor(0.12, 1, 0)
    ScootsWarpMap.frames.azerothMap.learned:SetPoint('TOPLEFT', ScootsWarpMap.frames.azerothMap, 'TOPLEFT', 16, -10)
    ScootsWarpMap.frames.azerothMap.learned:SetJustifyH('LEFT')
    
    ScootsWarpMap.frames.azerothMap.mastered = ScootsWarpMap.frames.title:CreateFontString(nil, 'OVERLAY')
    ScootsWarpMap.frames.azerothMap.mastered:SetFontObject('GameFontHighlightSmall')
    ScootsWarpMap.frames.azerothMap.mastered:SetTextColor(0, 0.44, 0.87)
    ScootsWarpMap.frames.azerothMap.mastered:SetPoint('TOPLEFT', ScootsWarpMap.frames.azerothMap.learned, 'BOTTOMLEFT', 0, 0)
    ScootsWarpMap.frames.azerothMap.mastered:SetJustifyH('LEFT')
    
    ScootsWarpMap.frames.azerothMap.attuned = ScootsWarpMap.frames.title:CreateFontString(nil, 'OVERLAY')
    ScootsWarpMap.frames.azerothMap.attuned:SetFontObject('GameFontHighlightSmall')
    ScootsWarpMap.frames.azerothMap.attuned:SetTextColor(0.64, 0.21, 0.93)
    ScootsWarpMap.frames.azerothMap.attuned:SetPoint('TOPLEFT', ScootsWarpMap.frames.azerothMap.mastered, 'BOTTOMLEFT', 0, 0)
    ScootsWarpMap.frames.azerothMap.attuned:SetJustifyH('LEFT')
    
    ScootsWarpMap.frames.azerothMap.unlearned = ScootsWarpMap.frames.title:CreateFontString(nil, 'OVERLAY')
    ScootsWarpMap.frames.azerothMap.unlearned:SetFontObject('GameFontHighlightSmall')
    ScootsWarpMap.frames.azerothMap.unlearned:SetTextColor(0.62, 0.62, 0.62)
    ScootsWarpMap.frames.azerothMap.unlearned:SetPoint('TOPLEFT', ScootsWarpMap.frames.azerothMap.attuned, 'BOTTOMLEFT', 0, 0)
    ScootsWarpMap.frames.azerothMap.unlearned:SetJustifyH('LEFT')
    
    -- ###
    
    ScootsWarpMap.frames.closeButton = CreateFrame('Button', 'ScootsWarpMap-CloseButton', ScootsWarpMap.frames.master, 'UIPanelCloseButton')
    ScootsWarpMap.frames.closeButton:SetSize(32, 32)
    ScootsWarpMap.frames.closeButton:SetPoint('TOPRIGHT', ScootsWarpMap.frames.master, 'TOPRIGHT', -10, 4)
    
    ScootsWarpMap.frames.closeButton:SetScript('OnClick', function()
        ScootsWarpMap.frames.master:Hide()
    end)
    
    -- ###
    
    ScootsWarpMap.frames.closeButton = CreateFrame('Button', 'ScootsWarpMap-MarkButton', ScootsWarpMap.frames.master, 'UIPanelButtonTemplate')
    ScootsWarpMap.frames.closeButton:SetSize(100, 20)
    ScootsWarpMap.frames.closeButton:SetPoint('BOTTOMLEFT', ScootsWarpMap.frames.master, 'BOTTOMLEFT', 8, 7)
    ScootsWarpMap.frames.closeButton:SetText('Mark')
    
    ScootsWarpMap.frames.closeButton:SetScript('OnClick', function()
        CustomMarkDo()
        ScootsWarpMap.frames.master:Hide()
    end)
    
    -- ###
    
    local tileMap = {
        {0, 0}, {1, 0}, {2, 0}, {3, 0},
        {0, 1}, {1, 1}, {2, 1}, {3, 1},
        {0, 2}, {1, 2}, {2, 2}, {3, 2},
    }
    
    for tileIndex, tilePos in ipairs(tileMap) do
        ScootsWarpMap.frames.azerothMap['tile-' .. tostring(tileIndex)] = ScootsWarpMap.frames.azerothMap:CreateTexture(nil, 'ARTWORK')
        ScootsWarpMap.frames.azerothMap['tile-' .. tostring(tileIndex)]:SetTexture('Interface\\WorldMap\\World\\World' .. tostring(tileIndex))
        ScootsWarpMap.frames.azerothMap['tile-' .. tostring(tileIndex)]:SetPoint('TOPLEFT', tileSize * tilePos[1], 0 - (tileSize * tilePos[2]))
        ScootsWarpMap.frames.azerothMap['tile-' .. tostring(tileIndex)]:SetSize(tileSize, tileSize)
    end
    
    -- ###
    
    ScootsWarpMap.frames.outlandMap = CreateFrame('Frame', 'ScootsWarpMap-Map', ScootsWarpMap.frames.azerothMap)
    ScootsWarpMap.frames.outlandMap:SetPoint('CENTER', ScootsWarpMap.frames.azerothMap, 'CENTER', tileSize / 16, 0 - (tileSize / 4))
    
    tileSize = 80
    ScootsWarpMap.frames.outlandMap:SetSize(tileSize * 3.914, tileSize * 2.61)
    
    ScootsWarpMap.frames.outlandMap.border = ScootsWarpMap.frames.outlandMap:CreateTexture(nil, 'BORDER')
    ScootsWarpMap.frames.outlandMap.border:SetTexture(0.35, 0.35, 0.55, 0.45)
    ScootsWarpMap.frames.outlandMap.border:SetPoint('TOPLEFT', -2, 2)
    ScootsWarpMap.frames.outlandMap.border:SetPoint('BOTTOMRIGHT', 2, -2)
    
    for tileIndex, tilePos in ipairs(tileMap) do
        ScootsWarpMap.frames.outlandMap['tile-' .. tostring(tileIndex)] = ScootsWarpMap.frames.outlandMap:CreateTexture(nil, 'ARTWORK')
        ScootsWarpMap.frames.outlandMap['tile-' .. tostring(tileIndex)]:SetTexture('Interface\\WorldMap\\Expansion01\\Expansion01' .. tostring(tileIndex))
        ScootsWarpMap.frames.outlandMap['tile-' .. tostring(tileIndex)]:SetPoint('TOPLEFT', tileSize * tilePos[1], 0 - (tileSize * tilePos[2]))
        ScootsWarpMap.frames.outlandMap['tile-' .. tostring(tileIndex)]:SetSize(tileSize, tileSize)
    end
end

ScootsWarpMap.placeSpells = function()
    local azerothWidth, azerothHeight = ScootsWarpMap.frames.azerothMap:GetSize()
    local outlandWidth, outlandHeight = ScootsWarpMap.frames.outlandMap:GetSize()
    
    local map = {
        -- Kalimdor
        [29] = {0.140, 0.120}, -- Silithus
        [30] = {0.190, 0.150}, -- Un'Goro Crater
        [31] = {0.240, 0.150}, -- Tanaris
        [32] = {0.220, 0.220}, -- Thousand Needles
        [33] = {0.130, 0.240}, -- Feralas
        [34] = {0.130, 0.360}, -- Desolace
        [35] = {0.170, 0.340}, -- Mulgore
        [36] = {0.170, 0.375}, -- Thunder Bluff
        [37] = {0.230, 0.400}, -- The Barrens
        [38] = {0.250, 0.290}, -- Dustwallow Marsh
        [39] = {0.140, 0.460}, -- Stonetalon Mountains
        [40] = {0.265, 0.420}, -- Durotar
        [41] = {0.265, 0.470}, -- Orgrimmar
        [42] = {0.200, 0.500}, -- Ashenvale
        [43] = {0.300, 0.520}, -- Azshara
        [44] = {0.260, 0.620}, -- Winterspring
        [45] = {0.200, 0.600}, -- Felwood
        [46] = {0.170, 0.620}, -- Darkshore
        [47] = {0.220, 0.670}, -- Moonglade
        [48] = {0.150, 0.720}, -- Teldrassil
        [49] = {0.120, 0.700}, -- Darnassus
        [50] = {0.070, 0.580}, -- Azuremyst Isle
        [51] = {0.045, 0.590}, -- The Exodar
        [52] = {0.040, 0.650}, -- Bloodmyst Isle
        
        -- Eastern Kingdoms
        [0]  = {0.850, 0.825}, -- Isle of Quel'Danas
        [1]  = {0.855, 0.720}, -- Eversong Woods
        [2]  = {0.855, 0.665}, -- Ghostlands
        [3]  = {0.850, 0.590}, -- Eastern Plaguelands
        [4]  = {0.790, 0.590}, -- Western Plaguelands
        [5]  = {0.725, 0.580}, -- Tirisfal Glades
        [6]  = {0.750, 0.575}, -- Undercity
        [7]  = {0.730, 0.540}, -- Silverpine Forest
        [8]  = {0.760, 0.540}, -- Alterac Mountains
        [9]  = {0.760, 0.505}, -- Hillsbrad Foothills
        [10] = {0.830, 0.530}, -- The Hinterlands
        [11] = {0.820, 0.470}, -- Arathi Highlands
        [12] = {0.810, 0.410}, -- Wetlands
        [13] = {0.830, 0.360}, -- Loch Modan
        [14] = {0.762, 0.360}, -- Ironforge
        [15] = {0.740, 0.340}, -- Dun Morogh
        [16] = {0.840, 0.310}, -- Badlands
        [17] = {0.800, 0.320}, -- Searing Gorge
        [18] = {0.800, 0.270}, -- Burning Steppes
        [19] = {0.820, 0.230}, -- Redridge Mountains
        [20] = {0.770, 0.230}, -- Elwynn Forest
        [21] = {0.745, 0.240}, -- Stormwind
        [22] = {0.727, 0.180}, -- Westfall
        [23] = {0.770, 0.180}, -- Duskwood
        [24] = {0.800, 0.180}, -- Deadwind Pass
        [25] = {0.830, 0.190}, -- Swamp of Sorrows
        [26] = {0.820, 0.150}, -- Blasted Lands
        [27] = {0.760, 0.110}, -- Stranglethorn Vale
        [28] = {0.860, 0.755}, -- Silvermoon City
        [72] = {0.780, 0.295}, -- Blackrock Mountain
        
        -- Outland
        [53] = {0.540, 0.420}, -- Hellfire Peninsula
        [54] = {0.310, 0.470}, -- Zangarmarsh
        [55] = {0.270, 0.300}, -- Nagrand
        [56] = {0.470, 0.210}, -- Terokkar Forest
        [57] = {0.620, 0.150}, -- Shadowmoon Valley
        [58] = {0.360, 0.680}, -- Blade's Edge Mountains
        [59] = {0.550, 0.760}, -- Netherstorm
        [60] = {0.400, 0.300}, -- Shattrath City
        
        -- Northrend
        [71] = {0.410, 0.750}, -- Borean Tundra
        [61] = {0.620, 0.680}, -- Howling Fjord
        [62] = {0.610, 0.750}, -- Grizzly Hills
        [63] = {0.590, 0.830}, -- Zul'Drak
        [64] = {0.550, 0.860}, -- The Storm Peaks
        [65] = {0.525, 0.795}, -- Crystalsong Forest
        [66] = {0.500, 0.810}, -- Dalaran
        [67] = {0.480, 0.870}, -- Icecrown
        [68] = {0.510, 0.760}, -- Dragonblight
        [69] = {0.460, 0.780}, -- Wintergrasp
        [70] = {0.440, 0.830}, -- Sholazar Basin
    }
    
    ScootsWarpMap.counts = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0,
    }
    
    for _, warp in ipairs(TPortData) do
        local button = ScootsWarpMap.getWarpButton(warp)
        
        if(ScootsWarpMap.outlandIndexes[warp.index] == nil) then
            button:SetPoint('BOTTOMLEFT', ScootsWarpMap.frames.azerothMap, 'BOTTOMLEFT', map[warp.index][1] * azerothWidth, map[warp.index][2] * azerothHeight)
        else
            button:SetPoint('BOTTOMLEFT', ScootsWarpMap.frames.outlandMap, 'BOTTOMLEFT', map[warp.index][1] * outlandWidth, map[warp.index][2] * outlandHeight)
        end
    end
    
    ScootsWarpMap.frames.azerothMap.learned:SetText('Learned: ' .. tostring(ScootsWarpMap.counts[1]))
    ScootsWarpMap.frames.azerothMap.mastered:SetText('Mastered: ' .. tostring(ScootsWarpMap.counts[2]))
    ScootsWarpMap.frames.azerothMap.attuned:SetText('Attuned: ' .. tostring(ScootsWarpMap.counts[3]))
    ScootsWarpMap.frames.azerothMap.unlearned:SetText('Unlearned: ' .. tostring(ScootsWarpMap.counts[0]))
end

ScootsWarpMap.getWarpButton = function(warp)
    if(ScootsWarpMap.buttons[warp.index] == nil) then
        local name, _, icon = GetSpellInfo(warp.icon)
        ScootsWarpMap.buttons[warp.index] = CreateFrame('Button', 'ScootsWarpMap-' .. tostring(warp.index), ScootsWarpMap.frames.azerothMap, 'SecureActionButtonTemplate')
        
        if(ScootsWarpMap.outlandIndexes[warp.index]) then
            ScootsWarpMap.buttons[warp.index]:SetParent(ScootsWarpMap.frames.outlandMap)
        end
        
        ScootsWarpMap.buttons[warp.index]:SetSize(20, 20)
        ScootsWarpMap.buttons[warp.index]:SetAttribute('type', 'spell')
        ScootsWarpMap.buttons[warp.index]:SetAttribute('spell', warp.icon)
        ScootsWarpMap.buttons[warp.index]:RegisterForClicks('AnyUp')
        ScootsWarpMap.buttons[warp.index]:SetNormalTexture(icon)
        
        ScootsWarpMap.buttons[warp.index].glow = ScootsWarpMap.buttons[warp.index]:CreateTexture(nil, 'HIGHLIGHT')
        ScootsWarpMap.buttons[warp.index].glow:SetTexture('Interface\\Buttons\\UI-ActionButton-Border')
        ScootsWarpMap.buttons[warp.index].glow:SetBlendMode('ADD')
        ScootsWarpMap.buttons[warp.index].glow:SetAlpha(1)
        ScootsWarpMap.buttons[warp.index].glow:SetSize(34, 34)
        ScootsWarpMap.buttons[warp.index].glow:SetPoint('CENTER', 0, 0)
        ScootsWarpMap.buttons[warp.index].glow:SetVertexColor(0.3, 0.3, 0.8)
    
        ScootsWarpMap.buttons[warp.index].insetBorder = ScootsWarpMap.buttons[warp.index]:CreateTexture(nil, 'ARTWORK')
        ScootsWarpMap.buttons[warp.index].insetBorder:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Inset')
        ScootsWarpMap.buttons[warp.index].insetBorder:SetPoint('BOTTOM', ScootsWarpMap.buttons[warp.index], 'BOTTOM', 0, 1)
        ScootsWarpMap.buttons[warp.index].insetBorder:SetSize(24, 12)
        ScootsWarpMap.buttons[warp.index].insetBorder:SetVertexColor(0.85, 0.75, 0.45)
    
        ScootsWarpMap.buttons[warp.index].inset = ScootsWarpMap.buttons[warp.index]:CreateTexture(nil, 'OVERLAY')
        ScootsWarpMap.buttons[warp.index].inset:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Inset')
        ScootsWarpMap.buttons[warp.index].inset:SetPoint('BOTTOM', ScootsWarpMap.buttons[warp.index], 'BOTTOM', 0, 1)
        ScootsWarpMap.buttons[warp.index].inset:SetSize(16, 8)
    end
    
    local learned = CustomHasTeleport(warp.index)
    ScootsWarpMap.counts[learned] = ScootsWarpMap.counts[learned] + 1
    
    if(learned == 0) then
        ScootsWarpMap.buttons[warp.index]:Disable()
        ScootsWarpMap.buttons[warp.index]:GetNormalTexture():SetVertexColor(0.4, 0.4, 0.4)
        ScootsWarpMap.buttons[warp.index].inset:SetVertexColor(0.4, 0.4, 0.4)
    else
        ScootsWarpMap.buttons[warp.index]:Enable()
        ScootsWarpMap.buttons[warp.index]:GetNormalTexture():SetVertexColor(1, 1, 1)
        
        local insetR, insetG, insetB = 0.4, 0.4, 0.4
        
        if(learned == 1) then
            insetR, insetG, insetB = 0.132, 1, 0
        elseif(learned == 2) then
            insetR, insetG, insetB = 0, 0.584, 0.957
        else
            insetR, insetG, insetB = 0.704, 0.231, 1
        end
        
        ScootsWarpMap.buttons[warp.index].inset:SetVertexColor(insetR, insetG, insetB)
        
        ScootsWarpMap.buttons[warp.index].level = learned
        
        if(ScootsWarpMap.buttons[warp.index].hooked == nil) then
            ScootsWarpMap.buttons[warp.index]:HookScript('OnEnter', function()
                local haste = GetCombatRatingBonus(CR_HASTE_SPELL)
                local castTime = math.floor(((10 / (1 + (haste / 100))) * 100) + 0.5) / 100
            
                GameTooltip:SetOwner(ScootsWarpMap.buttons[warp.index], 'ANCHOR_TOPLEFT')
                GameTooltip:SetText(warp.name, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
                GameTooltip:AddLine(tostring(castTime) .. ' sec cast', HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, true)
                GameTooltip:AddLine('Teleports the caster to this location.', nil, nil, nil, true)
                
                local learnLevel = '(Learned)'
                local learnLevelR, learnLevelG, learnLevelB = 0.502, 0.502, 0.2
                if(ScootsWarpMap.buttons[warp.index].level == 2) then
                    learnLevel = '(Mastered)'
                    learnLevelR, learnLevelG, learnLevelB = 0.376, 1, 0.376
                elseif(ScootsWarpMap.buttons[warp.index].level == 3) then
                    learnLevel = '(Attuned)'
                    learnLevelR, learnLevelG, learnLevelB = 0.376, 1, 1
                end
                
                GameTooltip:AddLine(learnLevel, learnLevelR, learnLevelG, learnLevelB, true)
                
                GameTooltip:SetSpellByID(warp.icon)
                
                GameTooltip:Show()
            end)
            
            ScootsWarpMap.buttons[warp.index]:HookScript('OnLeave', function()
                GameTooltip:Hide()
            end)
            
            ScootsWarpMap.buttons[warp.index]:SetScript('OnClick', function()
                CustomTeleportName(warp.name)
                ScootsWarpMap.frames.master:Hide()
            end)
        
            ScootsWarpMap.buttons[warp.index].hooked = true
        end
    end
    
    return ScootsWarpMap.buttons[warp.index]
end

ScootsWarpMap.eventHandler = function()
    if(_G['WorldMapFrame'] ~= nil and _G['WorldMapFrame']:IsVisible()) then
        local map = {
            -- Kalimdor
            [1] = {
                [15] = 29, -- Silithus
                [23] = 30, -- Un'Goro Crater
                [17] = 31, -- Tanaris
                [21] = 32, -- Thousand Needles
                [11] = 33, -- Feralas
                [7]  = 34, -- Desolace
                [13] = 35, -- Mulgore
                [22] = 36, -- Thunder Bluff
                [19] = 37, -- The Barrens
                [9]  = 38, -- Dustwallow Marsh
                [16] = 39, -- Stonetalon Mountains
                [8]  = 40, -- Durotar
                [14] = 41, -- Orgrimmar
                [1]  = 42, -- Ashenvale
                [2]  = 43, -- Azshara
                [24] = 44, -- Winterspring
                [10] = 45, -- Felwood
                [5]  = 46, -- Darkshore
                [12] = 47, -- Moonglade
                [18] = 48, -- Teldrassil
                [6]  = 49, -- Darnassus
                [3]  = 50, -- Azuremyst Isle
                [20] = 51, -- The Exodar
                [4]  = 52, -- Bloodmyst Isle
            },
            -- Eastern Kingdoms
            [2] = {
                [15] = 0,  -- Isle of Quel'Danas
                [11] = 1,  -- Eversong Woods
                [12] = 2,  -- Ghostlands
                [9]  = 3,  -- Eastern Plaguelands
                [27] = 4,  -- Western Plaguelands
                [25] = 5,  -- Tirisfal Glades
                [26] = 6,  -- Undercity
                [20] = 7,  -- Silverpine Forest
                [1]  = 8,  -- Alterac Mountains
                [13] = 9,  -- Hillsbrad Foothills
                [24] = 10, -- The Hinterlands
                [2]  = 11, -- Arathi Highlands
                [29] = 12, -- Wetlands
                [16] = 13, -- Loch Modan
                [14] = 14, -- Ironforge
                [7]  = 15, -- Dun Morogh
                [3]  = 16, -- Badlands
                [18] = 17, -- Searing Gorge
                [5]  = 18, -- Burning Steppes
                [17] = 19, -- Redridge Mountains
                [10] = 20, -- Elwynn Forest
                [21] = 21, -- Stormwind
                [28] = 22, -- Westfall
                [8]  = 23, -- Duskwood
                [6]  = 24, -- Deadwind Pass
                [23] = 25, -- Swamp of Sorrows
                [4]  = 26, -- Blasted Lands
                [22] = 27, -- Stranglethorn Vale
                [19] = 28, -- Silvermoon City
            },
            -- Outland
            [3] = {
                [2] = 53, -- Hellfire Peninsula
                [8] = 54, -- Zangarmarsh
                [3] = 55, -- Nagrand
                [7] = 56, -- Terokkar Forest
                [5] = 57, -- Shadowmoon Valley
                [1] = 58, -- Blade's Edge Mountains
                [4] = 59, -- Netherstorm
                [6] = 60, -- Shattrath City
            },
            -- Northrend
            [4] = {
                [1]  = 71, -- Borean Tundra
                [6]  = 61, -- Howling Fjord
                [5]  = 62, -- Grizzly Hills
                [12] = 63, -- Zul'Drak
                [10] = 64, -- The Storm Peaks
                [2]  = 65, -- Crystalsong Forest
                [3]  = 66, -- Dalaran
                [8]  = 67, -- Icecrown
                [4]  = 68, -- Dragonblight
                [11] = 69, -- Wintergrasp
                [9]  = 70, -- Sholazar Basin
            },
        }
        
        local continentId = GetCurrentMapContinent()
        local zoneId = GetCurrentMapZone()
        
        ScootsWarpMap.worldMapWarpIndex = nil
        
        if(continentId ~= nil and continentId ~= 0 and zoneId ~= nil and zoneId ~= 0) then
            if(map[continentId] ~= nil and map[continentId][zoneId] ~= nil) then
                ScootsWarpMap.worldMapWarpIndex = map[continentId][zoneId]
            end
        
            if(ScootsWarpMap.frames.worldMapWarpButton == nil) then
                ScootsWarpMap.frames.worldMapWarpButton = CreateFrame('Button', 'ScootsWarpMap-WarpButton', _G['WorldMapButton'], 'UIPanelButtonTemplate')
                ScootsWarpMap.frames.worldMapWarpButton:SetSize(60, 30)
                ScootsWarpMap.frames.worldMapWarpButton:SetPoint('TOPLEFT', _G['WorldMapButton'], 'TOPLEFT', 5, -5)
                ScootsWarpMap.frames.worldMapWarpButton:SetText('Warp')
                ScootsWarpMap.frames.worldMapWarpButton:Hide()
                
                ScootsWarpMap.frames.worldMapWarpButton.insetBorder = ScootsWarpMap.frames.worldMapWarpButton:CreateTexture(nil, 'ARTWORK')
                ScootsWarpMap.frames.worldMapWarpButton.insetBorder:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Inset')
                ScootsWarpMap.frames.worldMapWarpButton.insetBorder:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Inset')
                ScootsWarpMap.frames.worldMapWarpButton.insetBorder:SetPoint('LEFT', ScootsWarpMap.frames.worldMapWarpButton, 'LEFT', 1, 0)
                ScootsWarpMap.frames.worldMapWarpButton.insetBorder:SetSize(15, 30)
                ScootsWarpMap.frames.worldMapWarpButton.insetBorder:SetRotation((math.pi / 2) * 3)
                ScootsWarpMap.frames.worldMapWarpButton.insetBorder:SetVertexColor(0.85, 0.75, 0.45)

                ScootsWarpMap.frames.worldMapWarpButton.inset = ScootsWarpMap.frames.worldMapWarpButton:CreateTexture(nil, 'OVERLAY')
                ScootsWarpMap.frames.worldMapWarpButton.inset:SetTexture('Interface\\AddOns\\ScootsWarpMap\\Textures\\Inset')
                ScootsWarpMap.frames.worldMapWarpButton.inset:SetPoint('LEFT', ScootsWarpMap.frames.worldMapWarpButton, 'LEFT', 1, 0)
                ScootsWarpMap.frames.worldMapWarpButton.inset:SetSize(11, 22)
                ScootsWarpMap.frames.worldMapWarpButton.inset:SetRotation((math.pi / 2) * 3)
                
                ScootsWarpMap.frames.worldMapWarpButton:SetScript('OnClick', function()
                    for _, warp in pairs(TPortData) do
                        if(warp.index == ScootsWarpMap.worldMapWarpIndex) then
                            CustomTeleportName(warp.name)
                            ToggleFrame(_G['WorldMapFrame'])
                            break
                        end
                    end
                end)
            end
            
            local learned = CustomHasTeleport(ScootsWarpMap.worldMapWarpIndex)
            if(learned == 0) then
                ScootsWarpMap.frames.worldMapWarpButton:Hide()
            else
                if(learned == 1) then
                    insetR, insetG, insetB = 0.132, 1, 0
                elseif(learned == 2) then
                    insetR, insetG, insetB = 0, 0.584, 0.957
                else
                    insetR, insetG, insetB = 0.704, 0.231, 1
                end
                
                ScootsWarpMap.frames.worldMapWarpButton.inset:SetVertexColor(insetR, insetG, insetB)
                ScootsWarpMap.frames.worldMapWarpButton:Show()
            end
        else
            if(ScootsWarpMap.frames.worldMapWarpButton ~= nil) then
                ScootsWarpMap.frames.worldMapWarpButton:Hide()
            end
        end
    end
end

ScootsWarpMap.frames.master:RegisterEvent('WORLD_MAP_UPDATE')

ScootsWarpMap.frames.master:SetScript('OnUpdate', ScootsWarpMap.updateLoop)
ScootsWarpMap.frames.master:SetScript('OnEvent', ScootsWarpMap.eventHandler)