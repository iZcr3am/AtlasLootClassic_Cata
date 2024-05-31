local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local VendorPrice = {}
AtlasLoot.Data.VendorPrice = VendorPrice
local AL = AtlasLoot.Locales

local PRICE_INFO_LIST = {
    --- Classic
    -- items
    ["burningblossom"] = {
        itemID = 23247
    }, -- Burning Blossom
    ["ancestrycoin"] = {
        itemID = 21100
    }, -- Coin of Ancestry
    ["NecroticRune"] = {
        itemID = 22484
    }, -- Necrotic Rune

    -- others
    ["money"] = {
        func = GetCoinTextureString
    },

    --- BC
    ["holydust"] = {
        itemID = 29735
    }, -- Holy Dust (Aldor)
    ["arcanerune"] = {
        itemID = 29736
    }, -- Holy Dust (Scryers)
    ["SpiritShard"] = {
        itemID = 28558
    }, -- Spirit Shard
    ["HalaaRT"] = {
        itemID = 26044
    }, -- Halaa Research Token
    ["HalaaBT"] = {
        itemID = 26045
    }, -- Halaa Battle Token
    ["MarkOfThrallmar"] = {
        itemID = 24581
    }, -- Mark of Thrallmar
    ["MarkOfHonorHold"] = {
        itemID = 24579
    }, -- Mark of Honor Hold
    ["BoJ"] = {
        itemID = 29434
    }, -- Badge of Justice
    ["glowcap"] = {
        itemID = 24245
    }, -- Glowcap
    ["ApexisC"] = {
        itemID = 32572
    }, -- Apexis Crystal
    ["ApexisS"] = {
        itemID = 32569
    }, -- Apexis Shard
    ["Brewfest"] = {
        itemID = 37829
    }, -- Brewfest Prize Token
    ["sunmote"] = {
        itemID = 34664
    }, -- Sunmote
    -- pvp
    ["honor"] = {
        currencyID = 1901
    }, -- Honor
    ["arena"] = {
        currencyID = 1900
    }, -- Arena
    -- ["honorH"] = { currencyID = 1901 }, -- Honor / Horde
    -- ["honorA"] = { currencyID = 1901 }, -- Honor / Alli
    ["pvpAlterac"] = {
        itemID = 20560
    }, -- Alterac Valley Mark of Honor
    ["pvpWarsong"] = {
        itemID = 20558
    }, -- Warsong Gulch Mark of Honor
    ["pvpArathi"] = {
        itemID = 20559
    }, -- Arathi Basin Mark of Honor
    ["pvpEye"] = {
        itemID = 29024
    }, -- Eye of the Storm Mark of Honor

    --- Wrath
    ["epicurean"] = {
        currencyID = 81
    }, -- Epicurean's Award

    ["championsSeal"] = {
        currencyID = 241
    }, -- Champion's Seal
    ["EmblemOfHeroism"] = {
        currencyID = 395
    }, -- Emblem of Heroism
    ["EmblemOfValor"] = {
        currencyID = 395
    }, -- Emblem of Valor
    ["EmblemOfTriumph"] = {
        currencyID = 395
    }, -- Emblem of Triumph
    ["EmblemOfConquest"] = {
        currencyID = 395
    }, -- Emblem of Conquest
    ["EmblemOfFrost"] = {
        currencyID = 395
    }, -- Emblem of Frost
    ["SiderealEssence"] = {
        currencyID = 2589
    }, -- Sidereal Essence
    ["DefilersScourgestone"] = {
        currencyID = 2711
    }, -- Defiler's Scourgestone

    -- Cata
    ["chefs"] = {
        currencyID = 402
    }, -- Chef's Award

    ["JusticePoints"] = {
        currencyID = 395
    }, -- Justice Points
    ["ValorPoints"] = {
        currencyID = 396
    }, -- Valor Points

    --- PvP
    ["cpvpAlterac"] = {
        currencyID = 121
    }, -- Alterac Valley Mark of Honor
    ["cpvpWarsong"] = {
        currencyID = 125
    }, -- Warsong Gulch Mark of Honor
    ["cpvpArathi"] = {
        currencyID = 122
    }, -- Arathi Basin Mark of Honor
    ["cpvpEye"] = {
        currencyID = 123
    }, -- Eye of the Storm Mark of Honor
    ["cpvpWintergrasp"] = {
        currencyID = 126
    }, -- Wintergrasp Mark of Honor
    ["cpvpIsle"] = {
        currencyID = 321
    }, -- Isle of Conquest Mark of Honor
    ["cpvpStrand"] = {
        currencyID = 124
    } -- Strand of the Ancients Mark of Honor
}

local VENDOR_PRICE_FORMAT = {}
for k, v in pairs(PRICE_INFO_LIST) do
    if v.itemID then
        VENDOR_PRICE_FORMAT[v.itemID] = k .. ":%d"
    elseif v.currencyID and C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(v.currencyID)
        if currencyInfo and currencyInfo.iconFileID then
            VENDOR_PRICE_FORMAT[currencyInfo.iconFileID] = k .. ":%d"
        end
    end
end

-- updated with script
local VENDOR_PRICES, VENDOR_PRICES_RAW = AtlasLoot:GetGameVersionDataTable()
VENDOR_PRICES_RAW.CLASSIC = {}

if AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM) then
    VENDOR_PRICES_RAW.BCC = {
        [15196] = "pvpArathi:3:pvpWarsong:3",
        [15197] = "pvpArathi:3:pvpWarsong:3",
        [15198] = "pvpAlterac:20:pvpArathi:20:pvpWarsong:20",
        [15199] = "pvpAlterac:20:pvpArathi:20:pvpWarsong:20",
        [17348] = "money:1000",
        [17349] = "money:500",
        [17351] = "money:1000",
        [17352] = "money:500",
        [18839] = "money:900:honor:1",
        [18841] = "money:900:honor:1",
        [19029] = "pvpAlterac:50",
        [19030] = "pvpAlterac:50",
        [19031] = "pvpAlterac:60",
        [19032] = "pvpAlterac:60",
        [19045] = "pvpAlterac:30",
        [19046] = "pvpAlterac:30",
        [19060] = "money:2000",
        [19061] = "money:1500",
        [19062] = "money:1000",
        [19066] = "money:2000",
        [19067] = "money:1500",
        [19068] = "money:1000",
        [19301] = "money:7000",
        [19307] = "money:8000",
        [19316] = "money:6000",
        [19317] = "money:6000",
        [19318] = "money:5000",
        [19505] = "pvpWarsong:60",
        [19506] = "pvpWarsong:60",
        [20222] = "money:2000",
        [20223] = "money:1000",
        [20224] = "money:1500",
        [20225] = "money:2000",
        [20226] = "money:1000",
        [20227] = "money:1500",
        [20232] = "money:1500",
        [20234] = "money:2000",
        [20235] = "money:1000",
        [20237] = "money:1500",
        [20243] = "money:2000",
        [20244] = "money:1000",
        [22906] = "glowcap:30",
        [22916] = "glowcap:25",
        [22917] = "money:76000",
        [22918] = "money:64000",
        [22922] = "money:80000",
        [23572] = "BoJ:10",
        [23618] = "money:48000",
        [23814] = "money:48000",
        [24183] = "money:96000",
        [24417] = "money:1600",
        [24429] = "money:6400",
        [24539] = "glowcap:2",
        [25526] = "money:48000",
        [25548] = "glowcap:1",
        [25550] = "glowcap:1",
        [25735] = "money:128000",
        [25736] = "money:112000",
        [25737] = "money:112000",
        [25741] = "money:114000",
        [25742] = "money:114000",
        [25743] = "money:114000",
        [25827] = "glowcap:25",
        [25828] = "glowcap:15",
        [25835] = "money:358386",
        [25836] = "money:359704",
        [25838] = "money:181153",
        [25869] = "money:64000",
        [27689] = "glowcap:2",
        [28271] = "money:64000",
        [28553] = "SpiritShard:50",
        [28555] = "SpiritShard:50",
        [28556] = "SpiritShard:8",
        [28557] = "SpiritShard:8",
        [28559] = "SpiritShard:18",
        [28560] = "SpiritShard:18",
        [28561] = "SpiritShard:18",
        [28574] = "SpiritShard:18",
        [28575] = "SpiritShard:18",
        [28576] = "SpiritShard:18",
        [28577] = "SpiritShard:18",
        [28632] = "money:48000",
        [28758] = "SpiritShard:18",
        [28759] = "SpiritShard:18",
        [28760] = "SpiritShard:18",
        [28761] = "SpiritShard:18",
        [29102] = "money:950000",
        [29103] = "money:950000",
        [29104] = "money:950000",
        [29105] = "money:950000",
        [29135] = "money:196078",
        [29136] = "money:207130",
        [29137] = "money:496240",
        [29138] = "money:524391",
        [29139] = "money:120013",
        [29140] = "money:130313",
        [29141] = "money:218003",
        [29142] = "money:196936",
        [29143] = "money:100000",
        [29144] = "money:100000",
        [29145] = "money:167154",
        [29146] = "money:175951",
        [29147] = "money:158775",
        [29148] = "money:150969",
        [29149] = "glowcap:20",
        [29150] = "glowcap:45",
        [29170] = "money:632090",
        [29171] = "money:2125454",
        [29172] = "money:632090",
        [29173] = "money:140762",
        [29174] = "money:101897",
        [29192] = "money:800000",
        [29194] = "money:800000",
        [29217] = "money:108000",
        [29218] = "money:108000",
        [29219] = "money:108000",
        [29227] = "money:900000",
        [29229] = "money:900000",
        [29230] = "money:900000",
        [29231] = "money:900000",
        [29266] = "BoJ:33",
        [29267] = "BoJ:33",
        [29268] = "BoJ:33",
        [29269] = "BoJ:25",
        [29270] = "BoJ:25",
        [29271] = "BoJ:25",
        [29272] = "BoJ:25",
        [29273] = "BoJ:25",
        [29274] = "BoJ:25",
        [29275] = "BoJ:50",
        [29367] = "BoJ:25",
        [29368] = "BoJ:25",
        [29369] = "BoJ:25",
        [29370] = "BoJ:41",
        [29373] = "BoJ:25",
        [29374] = "BoJ:25",
        [29375] = "BoJ:25",
        [29376] = "BoJ:41",
        [29379] = "BoJ:25",
        [29381] = "BoJ:25",
        [29382] = "BoJ:25",
        [29383] = "BoJ:41",
        [29384] = "BoJ:25",
        [29385] = "BoJ:25",
        [29386] = "BoJ:25",
        [29387] = "BoJ:41",
        [29388] = "BoJ:15",
        [29389] = "BoJ:15",
        [29390] = "BoJ:15",
        [29465] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29466] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29467] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29468] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29469] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29470] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29471] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29472] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [29664] = "money:47500",
        [29720] = "money:48000",
        [29721] = "money:96000",
        [30156] = "glowcap:1",
        [30183] = "BoJ:15",
        [30443] = "money:72000",
        [30444] = "money:45000",
        [30623] = "money:80000",
        [30761] = "BoJ:30",
        [30762] = "BoJ:30",
        [30763] = "BoJ:20",
        [30764] = "BoJ:20",
        [30766] = "BoJ:30",
        [30767] = "BoJ:20",
        [30768] = "BoJ:20",
        [30769] = "BoJ:30",
        [30770] = "BoJ:20",
        [30772] = "BoJ:30",
        [30773] = "BoJ:30",
        [30774] = "BoJ:20",
        [30776] = "BoJ:30",
        [30778] = "BoJ:30",
        [30779] = "BoJ:20",
        [30780] = "BoJ:20",
        [31356] = "money:32000",
        [31390] = "money:192000",
        [31391] = "money:192000",
        [31392] = "money:192000",
        [31402] = "money:96000",
        [31773] = "money:9500",
        [31774] = "money:9000",
        [31775] = "glowcap:10",
        [31804] = "money:8000",
        [31829] = "money:665000",
        [31830] = "money:630000",
        [31831] = "money:665000",
        [31832] = "money:630000",
        [31833] = "money:665000",
        [31834] = "money:630000",
        [31835] = "money:665000",
        [31836] = "money:630000",
        [31838] = "pvpArathi:2",
        [31839] = "pvpAlterac:2",
        [31840] = "pvpArathi:2",
        [31841] = "pvpAlterac:2",
        [31852] = "pvpEye:2",
        [31853] = "money:3200:honor:50",
        [31854] = "pvpEye:2",
        [31855] = "money:3200:honor:50",
        [31949] = "money:4000",
        [32070] = "money:32000",
        [32083] = "BoJ:50",
        [32084] = "BoJ:50",
        [32085] = "BoJ:50",
        [32086] = "BoJ:50",
        [32087] = "BoJ:50",
        [32088] = "BoJ:50",
        [32089] = "BoJ:50",
        [32090] = "BoJ:50",
        [32227] = "BoJ:15",
        [32228] = "BoJ:15",
        [32229] = "BoJ:15",
        [32230] = "BoJ:15",
        [32231] = "BoJ:15",
        [32233] = "money:5000",
        [32249] = "BoJ:15",
        [32314] = "money:2000000",
        [32316] = "money:2000000",
        [32317] = "money:2000000",
        [32318] = "money:2000000",
        [32319] = "money:2000000",
        [32445] = "money:10000",
        [32453] = "money:2000:honor:2",
        [32455] = "money:1080:honor:1",
        [32538] = "money:137691",
        [32539] = "money:138166",
        [32645] = "ApexisC:4:ApexisS:100",
        [32647] = "ApexisC:4:ApexisS:100",
        [32648] = "ApexisC:4:ApexisS:100",
        [32650] = "ApexisC:1:ApexisS:50",
        [32651] = "ApexisC:4:ApexisS:100",
        [32652] = "ApexisC:1:ApexisS:50",
        [32653] = "ApexisC:1:ApexisS:50",
        [32654] = "ApexisC:1:ApexisS:50",
        [32721] = "money:4500",
        [32722] = "money:4000",
        [32770] = "money:41230",
        [32771] = "money:41230",
        [32783] = "ApexisS:3",
        [32784] = "ApexisS:2",
        [32828] = "ApexisS:10",
        [32947] = "SpiritShard:2",
        [32948] = "SpiritShard:2",
        [33047] = "Brewfest:100",
        [33149] = "money:80000",
        [33192] = "BoJ:25",
        [33207] = "BoJ:60",
        [33222] = "BoJ:60",
        [33279] = "BoJ:60",
        [33280] = "BoJ:60",
        [33287] = "BoJ:60",
        [33291] = "BoJ:60",
        [33296] = "BoJ:35",
        [33304] = "BoJ:60",
        [33324] = "BoJ:60",
        [33325] = "BoJ:35",
        [33331] = "BoJ:60",
        [33333] = "BoJ:60",
        [33334] = "BoJ:35",
        [33386] = "BoJ:60",
        [33484] = "BoJ:60",
        [33501] = "BoJ:75",
        [33502] = "BoJ:20",
        [33503] = "BoJ:20",
        [33504] = "BoJ:20",
        [33505] = "BoJ:20",
        [33506] = "BoJ:20",
        [33507] = "BoJ:20",
        [33508] = "BoJ:20",
        [33509] = "BoJ:20",
        [33510] = "BoJ:20",
        [33512] = "BoJ:60",
        [33513] = "BoJ:35",
        [33514] = "BoJ:60",
        [33515] = "BoJ:75",
        [33516] = "BoJ:35",
        [33517] = "BoJ:60",
        [33518] = "BoJ:75",
        [33519] = "BoJ:60",
        [33520] = "BoJ:35",
        [33522] = "BoJ:75",
        [33523] = "BoJ:60",
        [33524] = "BoJ:60",
        [33527] = "BoJ:75",
        [33528] = "BoJ:60",
        [33529] = "BoJ:35",
        [33530] = "BoJ:75",
        [33531] = "BoJ:60",
        [33532] = "BoJ:35",
        [33534] = "BoJ:60",
        [33535] = "BoJ:35",
        [33536] = "BoJ:60",
        [33537] = "BoJ:60",
        [33538] = "BoJ:75",
        [33539] = "BoJ:60",
        [33540] = "BoJ:35",
        [33552] = "BoJ:75",
        [33557] = "BoJ:35",
        [33559] = "BoJ:60",
        [33566] = "BoJ:75",
        [33577] = "BoJ:60",
        [33578] = "BoJ:35",
        [33579] = "BoJ:75",
        [33580] = "BoJ:35",
        [33582] = "BoJ:60",
        [33583] = "BoJ:60",
        [33584] = "BoJ:75",
        [33585] = "BoJ:75",
        [33586] = "BoJ:60",
        [33587] = "BoJ:60",
        [33588] = "BoJ:35",
        [33589] = "BoJ:35",
        [33593] = "BoJ:35",
        [33810] = "BoJ:75",
        [33832] = "BoJ:75",
        [33862] = "Brewfest:200",
        [33863] = "Brewfest:200",
        [33864] = "Brewfest:50",
        [33868] = "Brewfest:100",
        [33927] = "Brewfest:100",
        [33934] = "money:3400:ApexisS:50",
        [33935] = "money:3400:ApexisS:50",
        [33965] = "BoJ:75",
        [33966] = "Brewfest:100",
        [33967] = "Brewfest:50",
        [33968] = "Brewfest:50",
        [33969] = "Brewfest:50",
        [33970] = "BoJ:60",
        [33972] = "BoJ:75",
        [33973] = "BoJ:60",
        [33974] = "BoJ:60",
        [33978] = "Brewfest:600",
        [33999] = "money:16000000",
        [34008] = "Brewfest:100",
        [34028] = "Brewfest:600",
        [34049] = "BoJ:75",
        [34050] = "BoJ:75",
        [34129] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [34162] = "BoJ:75",
        [34163] = "BoJ:75",
        [34172] = "money:152000",
        [34173] = "money:144000",
        [34174] = "money:152000",
        [34175] = "money:144000",
        [34478] = "glowcap:30",
        [34887] = "BoJ:60",
        [34888] = "BoJ:60",
        [34889] = "BoJ:60",
        [34890] = "BoJ:60",
        [34891] = "BoJ:150",
        [34892] = "BoJ:150",
        [34893] = "BoJ:105",
        [34894] = "BoJ:105",
        [34895] = "BoJ:150",
        [34896] = "BoJ:150",
        [34898] = "BoJ:150",
        [34900] = "BoJ:100",
        [34901] = "BoJ:100",
        [34902] = "BoJ:75",
        [34903] = "BoJ:100",
        [34904] = "BoJ:75",
        [34905] = "BoJ:100",
        [34906] = "BoJ:100",
        [34910] = "BoJ:100",
        [34911] = "BoJ:75",
        [34912] = "BoJ:100",
        [34914] = "BoJ:100",
        [34916] = "BoJ:75",
        [34917] = "BoJ:100",
        [34918] = "BoJ:100",
        [34919] = "BoJ:75",
        [34921] = "BoJ:100",
        [34922] = "BoJ:100",
        [34923] = "BoJ:75",
        [34924] = "BoJ:100",
        [34925] = "BoJ:100",
        [34926] = "BoJ:75",
        [34927] = "BoJ:100",
        [34928] = "BoJ:100",
        [34929] = "BoJ:75",
        [34930] = "BoJ:100",
        [34931] = "BoJ:100",
        [34932] = "BoJ:75",
        [34933] = "BoJ:100",
        [34934] = "BoJ:100",
        [34935] = "BoJ:75",
        [34936] = "BoJ:100",
        [34937] = "BoJ:100",
        [34938] = "BoJ:75",
        [34939] = "BoJ:100",
        [34940] = "BoJ:100",
        [34941] = "BoJ:75",
        [34942] = "BoJ:100",
        [34943] = "BoJ:100",
        [34944] = "BoJ:75",
        [34945] = "BoJ:100",
        [34946] = "BoJ:100",
        [34947] = "BoJ:75",
        [34949] = "BoJ:45",
        [34950] = "BoJ:45",
        [34951] = "BoJ:45",
        [34952] = "BoJ:45",
        [35321] = "BoJ:60",
        [35324] = "BoJ:60",
        [35326] = "BoJ:75",
        [35329] = "money:104726",
        [35336] = "money:127597",
        [35342] = "money:173807",
        [35347] = "money:164580",
        [35358] = "money:202894",
        [35365] = "money:201430",
        [35367] = "money:146143",
        [35374] = "money:149973",
        [35379] = "money:226822",
        [35385] = "money:184540",
        [35387] = "money:123397",
        [35394] = "money:259883",
        [35403] = "money:127598",
        [35408] = "money:145302",
        [35415] = "money:272224",
        [35906] = "pvpAlterac:30:pvpArathi:30:pvpWarsong:30",
        [37736] = "Brewfest:200",
        [37737] = "Brewfest:200",
        [37750] = "Brewfest:2",
        [37816] = "Brewfest:20",
        [38229] = "glowcap:25",
        [38628] = "money:400000",
        [39476] = "Brewfest:5",
        [39477] = "Brewfest:5",
        [185690] = "money:80000",
        [185923] = "money:144000",
        [185924] = "money:144000",
        [187048] = "money:152000",
        [187049] = "money:152000"
    }
end

if AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM) then
    VENDOR_PRICES_RAW.WRATH = {
        [39728] = "EmblemOfValor:25",
        [39757] = "EmblemOfValor:25",
        [40191] = "EmblemOfValor:25",
        [40207] = "EmblemOfValor:25",
        [40267] = "EmblemOfValor:25",
        [40268] = "EmblemOfValor:25",
        [40321] = "EmblemOfValor:25",
        [40322] = "EmblemOfValor:25",
        [40337] = "EmblemOfValor:25",
        [40342] = "EmblemOfValor:25",
        [40612] = "EmblemOfHeroism:80",
        [40615] = "EmblemOfHeroism:60",
        [40636] = "EmblemOfValor:75",
        [40639] = "EmblemOfValor:60",
        [40678] = "EmblemOfHeroism:25",
        [40679] = "EmblemOfHeroism:25",
        [40680] = "EmblemOfHeroism:25",
        [40681] = "EmblemOfHeroism:25",
        [40682] = "EmblemOfHeroism:40",
        [40683] = "EmblemOfHeroism:40",
        [40684] = "EmblemOfHeroism:40",
        [40685] = "EmblemOfHeroism:40",
        [40688] = "EmblemOfHeroism:40",
        [40689] = "EmblemOfHeroism:40",
        [40691] = "EmblemOfHeroism:40",
        [40692] = "EmblemOfHeroism:40",
        [40693] = "EmblemOfHeroism:40",
        [40694] = "EmblemOfHeroism:40",
        [40695] = "EmblemOfHeroism:40",
        [40696] = "EmblemOfHeroism:40",
        [40697] = "EmblemOfHeroism:40",
        [40698] = "EmblemOfHeroism:25",
        [40699] = "EmblemOfHeroism:25",
        [40700] = "EmblemOfHeroism:35",
        [40701] = "EmblemOfHeroism:35",
        [40702] = "EmblemOfHeroism:50",
        [40703] = "EmblemOfHeroism:50",
        [40704] = "EmblemOfHeroism:50",
        [40711] = "EmblemOfHeroism:15",
        [40712] = "EmblemOfHeroism:15",
        [40713] = "EmblemOfHeroism:15",
        [40716] = "EmblemOfHeroism:15",
        [40717] = "EmblemOfValor:25",
        [40718] = "EmblemOfValor:25",
        [40719] = "EmblemOfValor:25",
        [40720] = "EmblemOfValor:25",
        [40721] = "EmblemOfValor:25",
        [40722] = "EmblemOfValor:25",
        [40723] = "EmblemOfValor:25",
        [40724] = "EmblemOfValor:25",
        [40733] = "EmblemOfValor:60",
        [40734] = "EmblemOfValor:60",
        [40735] = "EmblemOfValor:60",
        [40736] = "EmblemOfValor:60",
        [40737] = "EmblemOfValor:60",
        [40738] = "EmblemOfValor:60",
        [40739] = "EmblemOfValor:60",
        [40740] = "EmblemOfValor:60",
        [40741] = "EmblemOfValor:60",
        [40742] = "EmblemOfValor:40",
        [40743] = "EmblemOfValor:40",
        [40745] = "EmblemOfValor:40",
        [40746] = "EmblemOfValor:40",
        [40747] = "EmblemOfValor:40",
        [40748] = "EmblemOfValor:40",
        [40749] = "EmblemOfValor:40",
        [40750] = "EmblemOfValor:40",
        [40751] = "EmblemOfValor:40",
        [41268] = "EmblemOfHeroism:30",
        [41269] = "EmblemOfHeroism:45",
        [41270] = "EmblemOfHeroism:45",
        [41271] = "EmblemOfHeroism:30",
        [41272] = "EmblemOfHeroism:45",
        [41273] = "EmblemOfValor:30",
        [41278] = "EmblemOfHeroism:30",
        [41279] = "EmblemOfValor:30",
        [41284] = "EmblemOfValor:30",
        [41290] = "EmblemOfHeroism:30",
        [41291] = "EmblemOfValor:30",
        [41296] = "EmblemOfValor:45",
        [41301] = "EmblemOfHeroism:45",
        [41302] = "EmblemOfValor:45",
        [41308] = "EmblemOfValor:45",
        [41313] = "EmblemOfHeroism:45",
        [41314] = "EmblemOfValor:45",
        [41319] = "EmblemOfValor:45",
        [41324] = "EmblemOfHeroism:45",
        [41325] = "EmblemOfValor:45",
        [41643] = "EmblemOfHeroism:30",
        [41644] = "EmblemOfHeroism:45",
        [41645] = "EmblemOfHeroism:45",
        [41646] = "EmblemOfHeroism:30",
        [41647] = "EmblemOfHeroism:45",
        [41648] = "EmblemOfValor:45",
        [41653] = "EmblemOfValor:45",
        [41658] = "EmblemOfHeroism:45",
        [41659] = "EmblemOfValor:45",
        [41664] = "EmblemOfHeroism:45",
        [41665] = "EmblemOfValor:45",
        [41670] = "EmblemOfValor:45",
        [41675] = "EmblemOfHeroism:45",
        [41676] = "EmblemOfValor:45",
        [41681] = "EmblemOfValor:30",
        [41712] = "EmblemOfHeroism:30",
        [41713] = "EmblemOfValor:30",
        [41765] = "EmblemOfValor:30",
        [41770] = "EmblemOfHeroism:30",
        [41771] = "EmblemOfValor:30",
        [42943] = "EmblemOfHeroism:65",
        [42944] = "EmblemOfHeroism:40",
        [42945] = "EmblemOfHeroism:40",
        [42946] = "EmblemOfHeroism:65",
        [42947] = "EmblemOfHeroism:65",
        [42948] = "EmblemOfHeroism:50",
        [42949] = "EmblemOfHeroism:40",
        [42950] = "EmblemOfHeroism:40",
        [42951] = "EmblemOfHeroism:40",
        [42952] = "EmblemOfHeroism:40",
        [42984] = "EmblemOfHeroism:40",
        [42985] = "EmblemOfHeroism:40",
        [42991] = "EmblemOfHeroism:50",
        [42992] = "EmblemOfHeroism:50",
        [43007] = "epicurean:1",
        [43017] = "epicurean:5",
        [43018] = "epicurean:3",
        [43019] = "epicurean:3",
        [43020] = "epicurean:3",
        [43021] = "epicurean:3",
        [43022] = "epicurean:3",
        [43023] = "epicurean:3",
        [43024] = "epicurean:3",
        [43025] = "epicurean:3",
        [43026] = "epicurean:3",
        [43027] = "epicurean:3",
        [43028] = "epicurean:3",
        [43029] = "epicurean:3",
        [43030] = "epicurean:3",
        [43031] = "epicurean:3",
        [43032] = "epicurean:3",
        [43033] = "epicurean:3",
        [43034] = "epicurean:3",
        [43035] = "epicurean:3",
        [43036] = "epicurean:3",
        [43037] = "epicurean:3",
        [43102] = "EmblemOfHeroism:10",
        [43505] = "epicurean:3",
        [43506] = "epicurean:3",
        [44231] = "EmblemOfHeroism:200",
        [44954] = "epicurean:3",
        [46349] = "epicurean:100",
        [45294] = "SiderealEssence:15",
        [46032] = "SiderealEssence:15",
        [45933] = "SiderealEssence:15",
        [45869] = "SiderealEssence:15",
        [46096] = "SiderealEssence:15",
        [45297] = "SiderealEssence:15",
        [45888] = "SiderealEssence:15",
        [45296] = "SiderealEssence:15",
        [45456] = "SiderealEssence:15",
        [45945] = "SiderealEssence:15",
        [45946] = "SiderealEssence:15",
        [45447] = "SiderealEssence:15",
        [45871] = "SiderealEssence:15",
        [45931] = "SiderealEssence:19",
        [46046] = "SiderealEssence:19",
        [46095] = "SiderealEssence:19",
        [46068] = "SiderealEssence:19",
        [45929] = "SiderealEssence:19",
        [46042] = "SiderealEssence:19",
        [46048] = "SiderealEssence:19",
        [45988] = "SiderealEssence:19",
        [46040] = "SiderealEssence:19",
        [46047] = "SiderealEssence:19",
        [45989] = "SiderealEssence:19",
        [45293] = "SiderealEssence:19",
        [45928] = "SiderealEssence:19",
        [45943] = "SiderealEssence:19",
        [45455] = "SiderealEssence:19",
        [45300] = "SiderealEssence:19",
        [46038] = "SiderealEssence:24",
        [46051] = "SiderealEssence:24",
        [46050] = "SiderealEssence:24",
        [46041] = "SiderealEssence:24",
        [46037] = "SiderealEssence:24",
        [46045] = "SiderealEssence:24",
        [46043] = "SiderealEssence:24",
        [46044] = "SiderealEssence:24",
        [46097] = "SiderealEssence:25",
        [45947] = "SiderealEssence:25",
        [45877] = "SiderealEssence:25",
        [46036] = "SiderealEssence:25",
        [45993] = "SiderealEssence:25",
        [45887] = "SiderealEssence:25",
        [45930] = "SiderealEssence:25",
        [45876] = "SiderealEssence:25",
        [45449] = "SiderealEssence:25",
        [45295] = "SiderealEssence:25",
        [45982] = "SiderealEssence:25",
        [45448] = "SiderealEssence:25",
        [45867] = "SiderealEssence:25",
        [46034] = "SiderealEssence:25",
        [46039] = "SiderealEssence:32",
        [46049] = "SiderealEssence:32",
        [45868] = "SiderealEssence:38",
        [46035] = "SiderealEssence:38",
        [45886] = "SiderealEssence:38",
        [46067] = "SiderealEssence:38",
        [45990] = "SiderealEssence:38",
        [46033] = "SiderealEssence:38",
        [45870] = "SiderealEssence:38",
        [47661] = "EmblemOfTriumph:25",
        [47662] = "EmblemOfTriumph:25",
        [47664] = "EmblemOfTriumph:25",
        [47665] = "EmblemOfTriumph:25",
        [47666] = "EmblemOfTriumph:25",
        [47667] = "EmblemOfTriumph:25",
        [47668] = "EmblemOfTriumph:25",
        [47670] = "EmblemOfTriumph:25",
        [47671] = "EmblemOfTriumph:25",
        [47672] = "EmblemOfTriumph:25",
        [47673] = "EmblemOfTriumph:25",
        [47734] = "EmblemOfTriumph:50",
        [47735] = "EmblemOfTriumph:50",
        [48677] = "EmblemOfHeroism:40",
        [48683] = "EmblemOfHeroism:40",
        [48685] = "EmblemOfHeroism:40",
        [48687] = "EmblemOfHeroism:40",
        [48689] = "EmblemOfHeroism:40",
        [48691] = "EmblemOfHeroism:40",
        [48716] = "EmblemOfHeroism:40",
        [48718] = "EmblemOfHeroism:65",
        [48722] = "EmblemOfTriumph:50",
        [48724] = "EmblemOfTriumph:50",
        [50355] = "EmblemOfFrost:60",
        [50356] = "EmblemOfFrost:60",
        [50357] = "EmblemOfFrost:60",
        [50358] = "EmblemOfFrost:60",
        [50454] = "EmblemOfFrost:30",
        [50455] = "EmblemOfFrost:30",
        [50456] = "EmblemOfFrost:30",
        [50457] = "EmblemOfFrost:30",
        [50458] = "EmblemOfFrost:30",
        [50459] = "EmblemOfFrost:30",
        [50460] = "EmblemOfFrost:30",
        [50461] = "EmblemOfFrost:30",
        [50462] = "EmblemOfFrost:30",
        [50463] = "EmblemOfFrost:30",
        [50464] = "EmblemOfFrost:30",
        [50466] = "EmblemOfFrost:50",
        [50467] = "EmblemOfFrost:50",
        [50468] = "EmblemOfFrost:50",
        [50469] = "EmblemOfFrost:50",
        [50470] = "EmblemOfFrost:50",
        [54637] = "cpvpWarsong:1",
        [40492] = "NecroticRune:40",
        [40593] = "NecroticRune:30",
        [40601] = "NecroticRune:8",
        [23122] = "NecroticRune:8",
        [23123] = "NecroticRune:8",
        [22999] = "NecroticRune:8",
        [43530] = "NecroticRune:20",
        [43531] = "NecroticRune:20",
        [43074] = "NecroticRune:15",
        [43073] = "NecroticRune:15",
        [43077] = "NecroticRune:15",
        [43078] = "NecroticRune:15",
        [43081] = "NecroticRune:15",
        [43082] = "NecroticRune:15",
        [43070] = "NecroticRune:15",
        [43068] = "NecroticRune:15",
        [49908] = "DefilersScourgestone:12",
        [47242] = "DefilersScourgestone:20",
        [45518] = "DefilersScourgestone:60",
        [47303] = "DefilersScourgestone:38",
        [45609] = "DefilersScourgestone:60",
        [47115] = "DefilersScourgestone:38",
        [47271] = "DefilersScourgestone:38",
        [45535] = "DefilersScourgestone:60",
        [47316] = "DefilersScourgestone:38",
        [45495] = "DefilersScourgestone:60",
        [47285] = "DefilersScourgestone:76",
        [47261] = "DefilersScourgestone:60",
        [47069] = "DefilersScourgestone:76",
        [45517] = "DefilersScourgestone:60",
        [47182] = "DefilersScourgestone:38",
        [45243] = "DefilersScourgestone:60",
        [47041] = "DefilersScourgestone:38",
        [45133] = "DefilersScourgestone:60",
        [45534] = "DefilersScourgestone:60",
        [45496] = "DefilersScourgestone:60",
        [45461] = "DefilersScourgestone:60",
        [47287] = "DefilersScourgestone:50",
        [47314] = "DefilersScourgestone:50",
        [45471] = "DefilersScourgestone:60",
        [47080] = "DefilersScourgestone:38",
        [47290] = "DefilersScourgestone:38",
        [47282] = "DefilersScourgestone:30",
        [47291] = "DefilersScourgestone:30",
        [45443] = "DefilersScourgestone:60",
        [47193] = "DefilersScourgestone:60",
        [47276] = "DefilersScourgestone:30",
        [47322] = "DefilersScourgestone:60",
        [47307] = "DefilersScourgestone:30",
        [45459] = "DefilersScourgestone:60",
        [47329] = "DefilersScourgestone:76",
        [47148] = "DefilersScourgestone:50",
        [47070] = "DefilersScourgestone:30",
        [46979] = "DefilersScourgestone:60",
        [47089] = "DefilersScourgestone:30",
        [47309] = "DefilersScourgestone:30",
        [47233] = "DefilersScourgestone:76",
        [46970] = "DefilersScourgestone:30",
        [45486] = "DefilersScourgestone:60",
        [47258] = "DefilersScourgestone:38",
        [45242] = "DefilersScourgestone:60",
        [47293] = "DefilersScourgestone:38",
        [47079] = "DefilersScourgestone:50",
        [47272] = "DefilersScourgestone:30",
        [47139] = "DefilersScourgestone:30",
        [47286] = "DefilersScourgestone:38",
        [47092] = "DefilersScourgestone:38",
        [46959] = "DefilersScourgestone:30",
        [46976] = "DefilersScourgestone:30",
        [47267] = "DefilersScourgestone:76",
        [47256] = "DefilersScourgestone:30",
        [47257] = "DefilersScourgestone:30",
        [47260] = "DefilersScourgestone:50",
        [47223] = "DefilersScourgestone:30",
        [47266] = "DefilersScourgestone:50",
        [47320] = "DefilersScourgestone:30",
        [47053] = "DefilersScourgestone:30",
        [47284] = "DefilersScourgestone:38",
        [47297] = "DefilersScourgestone:30",
        [47138] = "DefilersScourgestone:30",
        [47278] = "DefilersScourgestone:30",
        [47054] = "DefilersScourgestone:30",
        [45485] = "DefilersScourgestone:60",
        [46963] = "DefilersScourgestone:50",
        [47302] = "DefilersScourgestone:76",
        [47299] = "DefilersScourgestone:38",
        [47255] = "DefilersScourgestone:50",
        [47252] = "DefilersScourgestone:30",
        [46994] = "DefilersScourgestone:76",
        [47081] = "DefilersScourgestone:38",
        [47071] = "DefilersScourgestone:38",
        [46972] = "DefilersScourgestone:38",
        [46958] = "DefilersScourgestone:50",
        [47072] = "DefilersScourgestone:38",
        [47295] = "DefilersScourgestone:38",
        [47269] = "DefilersScourgestone:38",
        [47107] = "DefilersScourgestone:38",
        [47150] = "DefilersScourgestone:38",
        [47043] = "DefilersScourgestone:30",
        [47315] = "DefilersScourgestone:30",
        [47312] = "DefilersScourgestone:38",
        [47268] = "DefilersScourgestone:38",
        [47253] = "DefilersScourgestone:30",
        [47105] = "DefilersScourgestone:30",
        [47116] = "DefilersScourgestone:30",
        [47114] = "DefilersScourgestone:76",
        [47152] = "DefilersScourgestone:38",
        [47042] = "DefilersScourgestone:30",
        [47324] = "DefilersScourgestone:30",
        [47313] = "DefilersScourgestone:30",
        [47149] = "DefilersScourgestone:30",
        [47327] = "DefilersScourgestone:30",
        [47300] = "DefilersScourgestone:50",
        [46999] = "DefilersScourgestone:38",
        [47281] = "DefilersScourgestone:30",
        [47275] = "DefilersScourgestone:30",
        [47263] = "DefilersScourgestone:38",
        [47328] = "DefilersScourgestone:30",
        [47311] = "DefilersScourgestone:38",
        [47306] = "DefilersScourgestone:30",
        [47321] = "DefilersScourgestone:38",
        [47305] = "DefilersScourgestone:30",
        [47203] = "DefilersScourgestone:30",
        [47151] = "DefilersScourgestone:30",
        [47104] = "DefilersScourgestone:50",
        [47225] = "DefilersScourgestone:30",
        [47283] = "DefilersScourgestone:38",
        [47277] = "DefilersScourgestone:30",
        [47323] = "DefilersScourgestone:38",
        [47141] = "DefilersScourgestone:30",
        [47296] = "DefilersScourgestone:38",
        [46997] = "DefilersScourgestone:38",
        [46985] = "DefilersScourgestone:38",
        [47055] = "DefilersScourgestone:30",
        [46996] = "DefilersScourgestone:50",
        [47308] = "DefilersScourgestone:38",
        [47298] = "DefilersScourgestone:30",
        [47262] = "DefilersScourgestone:38",
        [47194] = "DefilersScourgestone:38",
        [46990] = "DefilersScourgestone:38",
        [47183] = "DefilersScourgestone:30",
        [47140] = "DefilersScourgestone:38",
        [47106] = "DefilersScourgestone:38",
        [47073] = "DefilersScourgestone:30",
        [47294] = "DefilersScourgestone:30",
        [47280] = "DefilersScourgestone:30",
        [46961] = "DefilersScourgestone:30",
        [47108] = "DefilersScourgestone:30",
        [47265] = "DefilersScourgestone:38",
        [47090] = "DefilersScourgestone:38",
        [47056] = "DefilersScourgestone:30",
        [46988] = "DefilersScourgestone:38",
        [47093] = "DefilersScourgestone:30",
        [47195] = "DefilersScourgestone:38",
        [40586] = "money:68000000",
        [44935] = "money:68000000",
        [40585] = "money:68000000",
        [44934] = "money:68000000",
        [45688] = "money:10000000",
        [45689] = "money:10000000",
        [45690] = "money:10000000",
        [45691] = "money:10000000",
        [48954] = "money:10000000",
        [48955] = "money:10000000",
        [48956] = "money:10000000",
        [48957] = "money:10000000",
        [51557] = "money:10000000",
        [51558] = "money:10000000",
        [51559] = "money:10000000",
        [51560] = "money:10000000"
    }
end

if AtlasLoot:GameVersion_GE(AtlasLoot.CATA_VERSION_NUM) then
    VENDOR_PRICES_RAW.CATA = {
        -- JP vendor
        [57930] = "JusticePoints:1250", -- Pendant of Quiet Breath
        [57931] = "JusticePoints:1250", -- Amulet of Dull Dreaming
        [57932] = "JusticePoints:1250", -- The Lustrous Eye
        [57933] = "JusticePoints:1250", -- String of Beaded Bubbles
        [57934] = "JusticePoints:1250", -- Celadon Pendant
        [57921] = "JusticePoints:1650", -- Incense Infused Cummerbund
        [57922] = "JusticePoints:1650", -- Belt of the Falling Rain
        [58153] = "JusticePoints:2200", -- Robes of Embalmed Darkness
        [58154] = "JusticePoints:2200", -- Pensive Legwraps
        [58155] = "JusticePoints:2200", -- Cowl of Pleasant Gloom
        [58157] = "JusticePoints:1650", -- Meadow Mantle
        [58158] = "JusticePoints:1650", -- Gloves of the Painless Midnight
        [58159] = "JusticePoints:2200", -- Musk Rose Robes
        [58160] = "JusticePoints:2200", -- Leggings of Charity
        [58161] = "JusticePoints:2200", -- Mask of New Snow
        [58162] = "JusticePoints:1650", -- Summer Song Shoulderwraps
        [58163] = "JusticePoints:1650", -- Gloves of Purification
        [57927] = "JusticePoints:950", -- Throat Slasher
        [57918] = "JusticePoints:1650", -- Sash of Musing
        [57919] = "JusticePoints:1650", -- Thatch Eave Vines
        [58131] = "JusticePoints:2200", -- Tunic of Sinking Envy
        [58132] = "JusticePoints:2200", -- Leggings of the Burrowing Mole
        [58133] = "JusticePoints:2200", -- Mask of Vines
        [58134] = "JusticePoints:1650", -- Embrace of the Night
        [58138] = "JusticePoints:1650", -- Sticky Fingers
        [58139] = "JusticePoints:2200", -- Chestguard of Forgetfulness
        [58140] = "JusticePoints:2200", -- Leggings of Late Blooms
        [58150] = "JusticePoints:2200", -- Cluster of Stars
        [58151] = "JusticePoints:1650", -- Somber Shawl
        [58152] = "JusticePoints:1650", -- Blessed Hands of Elune
        [57916] = "JusticePoints:1650", -- Belt of the Dim Forest
        [57917] = "JusticePoints:1650", -- Belt of the Still Stream
        [58121] = "JusticePoints:2200", -- Vest of the True Companion
        [58122] = "JusticePoints:2200", -- Hillside Striders
        [58123] = "JusticePoints:2200", -- Willow Mask
        [58124] = "JusticePoints:1650", -- Wrap of the Valley Glades
        [58125] = "JusticePoints:1650", -- Gloves of the Passing Night
        [58126] = "JusticePoints:2200", -- Vest of the Waking Dream
        [58127] = "JusticePoints:2200", -- Leggings of Soothing Silence
        [58128] = "JusticePoints:2200", -- Helm of the Inward Eye
        [58129] = "JusticePoints:1650", -- Seafoam Mantle
        [58130] = "JusticePoints:1650", -- Gleaning Gloves
        [57923] = "JusticePoints:950", -- Hermit's Lamp
        [57924] = "JusticePoints:950", -- Apple-Bent Bough
        [57928] = "JusticePoints:950", -- Windslicer
        [57929] = "JusticePoints:950", -- Dawnblaze Blade
        [57913] = "JusticePoints:1650", -- Beech Green Belt
        [57914] = "JusticePoints:1650", -- Girdle of the Mountains
        [57915] = "JusticePoints:1650", -- Belt of Barred Clouds
        [58096] = "JusticePoints:2200", -- Breastplate of Raging Fury
        [58097] = "JusticePoints:2200", -- Greaves of Gallantry
        [58098] = "JusticePoints:2200", -- Helm of Easeful Death
        [58099] = "JusticePoints:1650", -- Reaping Gauntlets
        [58100] = "JusticePoints:1650", -- Pauldrons of the High Requiem
        [58101] = "JusticePoints:2200", -- Chestplate of the Steadfast
        [58102] = "JusticePoints:2200", -- Greaves of Splendor
        [58103] = "JusticePoints:2200", -- Helm of the Proud
        [58104] = "JusticePoints:1650", -- Sunburnt Pauldrons
        [58105] = "JusticePoints:1650", -- Numbing Handguards
        [58106] = "JusticePoints:2200", -- Chestguard of Dancing Waves
        [58107] = "JusticePoints:2200", -- Legguards of the Gentle
        [58108] = "JusticePoints:2200", -- Crown of the Blazing Sun
        [58109] = "JusticePoints:1650", -- Pauldrons of the Forlorn
        [58110] = "JusticePoints:1650", -- Gloves of Curious Conscience
        [57925] = "JusticePoints:950", -- Shield of the Mists
        [57926] = "JusticePoints:950", -- Shield of the Four Grey Towers
        -- VP vendor
        [58180] = "ValorPoints:1650", -- License to Slay
        [58181] = "ValorPoints:1650", -- Fluid Death
        [58183] = "ValorPoints:1650", -- Soul Casket
        [58184] = "ValorPoints:1650", -- Core of Ripeness
        [58182] = "ValorPoints:1650", -- Bedrock Talisman
        [64673] = "ValorPoints:700", -- Throat Slasher
        [64674] = "ValorPoints:700", -- Windslicer
        [64671] = "ValorPoints:700", -- Dawnblaze Blade
        [64676] = "ValorPoints:700", -- Shield of the Four Grey Towers
        [64672] = "ValorPoints:700", -- Shield of the Mists
        [58189] = "ValorPoints:1250", -- Twined Band of Flowers
        [58188] = "ValorPoints:1250", -- Band of Secret Names
        [58185] = "ValorPoints:1250", -- Band of Bees
        [68812] = "ValorPoints:1250", -- Hornet-Sting Band
        [58187] = "ValorPoints:1250", -- Ring of the Battle Anthem
        [58191] = "ValorPoints:1250", -- Viewless Wings
        [58194] = "ValorPoints:1250", -- Heavenly Breeze
        [58193] = "ValorPoints:1250", -- Haunt of Flies
        [58190] = "ValorPoints:1250", -- Floating Web
        [58192] = "ValorPoints:1250", -- Gray Hair Cloak
        [60360] = "ValorPoints:2200", -- Reinforced Sapphirium Breastplate
        [60363] = "ValorPoints:1650", -- Reinforced Sapphirium Gloves
        [60361] = "ValorPoints:2200", -- Reinforced Sapphirium Greaves
        [60344] = "ValorPoints:2200", -- Reinforced Sapphirium Battleplate
        [60345] = "ValorPoints:1650", -- Reinforced Sapphirium Gauntlets
        [60347] = "ValorPoints:2200", -- Reinforced Sapphirium Legplates
        [60354] = "ValorPoints:2200", -- Reinforced Sapphirium Chestguard
        [60355] = "ValorPoints:1650", -- Reinforced Sapphirium Handguards
        [60357] = "ValorPoints:2200", -- Reinforced Sapphirium Legguards
        [60323] = "ValorPoints:2200", -- Earthen Battleplate
        [60326] = "ValorPoints:1650", -- Earthen Gauntlets
        [60324] = "ValorPoints:2200", -- Earthen Legplates
        [60329] = "ValorPoints:2200", -- Earthen Chestguard
        [60332] = "ValorPoints:1650", -- Earthen Handguards
        [60330] = "ValorPoints:2200", -- Earthen Legguards
        [60339] = "ValorPoints:2200", -- Magma Plated Battleplate
        [60340] = "ValorPoints:1650", -- Magma Plated Gauntlets
        [60342] = "ValorPoints:2200", -- Magma Plated Legplates
        [60349] = "ValorPoints:2200", -- Magma Plated Chestguard
        [60350] = "ValorPoints:1650", -- Magma Plated Handguards
        [60352] = "ValorPoints:2200", -- Magma Plated Legguards
        [58197] = "ValorPoints:1650", -- Rock Furrow Boots
        [58198] = "ValorPoints:1650", -- Eternal Pathfinders
        [58195] = "ValorPoints:1650", -- Woe Breeder's Boots
        [60313] = "ValorPoints:2200", -- Hauberk of the Raging Elements
        [60314] = "ValorPoints:1650", -- Gloves of the Raging Elements
        [60316] = "ValorPoints:2200", -- Kilt of the Raging Elements
        [60309] = "ValorPoints:2200", -- Tunic of the Raging Elements
        [60312] = "ValorPoints:1650", -- Handwraps of the Raging Elements
        [60310] = "ValorPoints:2200", -- Legwraps of the Raging Elements
        [60318] = "ValorPoints:2200", -- Cuirass of the Raging Elements
        [60319] = "ValorPoints:1650", -- Grips of the Raging Elements
        [60321] = "ValorPoints:2200", -- Legguards of the Raging Elements
        [60304] = "ValorPoints:2200", -- Lightning-Charged Tunic
        [60307] = "ValorPoints:1650", -- Lightning-Charged Gloves
        [60305] = "ValorPoints:2200", -- Lightning-Charged Legguards
        [58199] = "ValorPoints:1650", -- Moccasins of Verdurous Glooms
        [58481] = "ValorPoints:1650", -- Boots of the Perilous Seas
        [60276] = "ValorPoints:2200", -- Stormrider's Robes
        [60280] = "ValorPoints:1650", -- Stormrider's Handwraps
        [60278] = "ValorPoints:2200", -- Stormrider's Legwraps
        [60287] = "ValorPoints:2200", -- Stormrider's Raiment
        [60290] = "ValorPoints:1650", -- Stormrider's Grips
        [60288] = "ValorPoints:2200", -- Stormrider's Legguards
        [60281] = "ValorPoints:2200", -- Stormrider's Vestment
        [60285] = "ValorPoints:1650", -- Stormrider's Gloves
        [60283] = "ValorPoints:2200", -- Stormrider's Leggings
        [60301] = "ValorPoints:2200", -- Wind Dancer's Tunic
        [60298] = "ValorPoints:1650", -- Wind Dancer's Gloves
        [60300] = "ValorPoints:2200", -- Wind Dancer's Legguards
        [58482] = "ValorPoints:1650", -- Treads of Fleeting Joy
        [58484] = "ValorPoints:1650", -- Fading Violet Sandals
        [60244] = "ValorPoints:2200", -- Firelord's Robes
        [60247] = "ValorPoints:1650", -- Firelord's Gloves
        [60245] = "ValorPoints:2200", -- Firelord's Leggings
        [60251] = "ValorPoints:2200", -- Shadowflame Robes
        [60248] = "ValorPoints:1650", -- Shadowflame Handwraps
        [60250] = "ValorPoints:2200", -- Shadowflame Leggings
        [60259] = "ValorPoints:2200", -- Mercurial Robes
        [60275] = "ValorPoints:1650", -- Mercurial Handwraps
        [60261] = "ValorPoints:2200", -- Mercurial Legwraps
        [60254] = "ValorPoints:2200", -- Mercurial Vestment
        [60257] = "ValorPoints:1650", -- Mercurial Gloves
        [60255] = "ValorPoints:2200", -- Mercurial Leggings
        [58485] = "ValorPoints:1650", -- Melodious Slippers
        [58486] = "ValorPoints:1650", -- Slippers of Moving Waters
        -- CA vendor
	[65433] = "chefsaward:5", -- Recipe: South Island Iced Tea
	[65432] = "chefsaward:5", -- Recipe: Fortune Cookie
	[65426] = "chefsaward:3", -- Recipe: Baked Rockfish
	[62799] = "chefsaward:3", -- Recipe: Broiled Dragon Feast
	[65431] = "chefsaward:3", -- Recipe: Chocolate Cookie
	[62800] = "chefsaward:3", -- Recipe: Seafood Magnifique Feast
	[65427] = "chefsaward:3", -- Recipe: Basilisk Liverdog
	[65429] = "chefsaward:3", -- Recipe: Beer-Basted Crocolisk
	[65424] = "chefsaward:3", -- Recipe: Blackbelly Sushi
	[65430] = "chefsaward:3", -- Recipe: Crocolisk Au Gratin
	[65422] = "chefsaward:3", -- Recipe: Delicious Sagefish Tail
	[65428] = "chefsaward:3", -- Recipe: Grilled Dragon
	[65409] = "chefsaward:3", -- Recipe: Lavascale Minestrone
	[65420] = "chefsaward:3", -- Recipe: Mushroom Sauce Mudfish
	[65421] = "chefsaward:3", -- Recipe: Severed Sagefish Head
	[65425] = "chefsaward:3", -- Recipe: Skewered Eel
	[68688] = "chefsaward:3", -- Recipe: Scalding Murglesnout
	[65423] = "chefsaward:3", -- Recipe: Fish Fry
	[65418] = "chefsaward:3", -- Recipe: Hearty Seafood Soup
	[65417] = "chefsaward:3", -- Recipe: Pickled Guppy
	[65419] = "chefsaward:3", -- Recipe: Tender Baked Turtle
	[65411] = "chefsaward:3", -- Recipe: Broiled Mountain Trout
	[65407] = "chefsaward:3", -- Recipe: Lavascale Fillet
	[65412] = "chefsaward:3", -- Recipe: Lightly Fried Lurker
	[65416] = "chefsaward:3", -- Recipe: Lurker Lunch
	[65410] = "chefsaward:3", -- Recipe: Salted Eye
	[65413] = "chefsaward:3", -- Recipe: Seasoned Crab
	[65406] = "chefsaward:3", -- Recipe: Whitecrest Gumbo
	[65415] = "chefsaward:3", -- Recipe: Highland Spirits
	[65414] = "chefsaward:3", -- Recipe: Starfire Espresso
	[65408] = "chefsaward:3", -- Recipe: Feathered Lure
	[65513] = "chefsaward:2", -- Crate of Tasty Meat
	[68689] = "chefsaward:1" -- Imported Supplies
    }
end

local function GetItemPriceString(itemID)
    return AtlasLoot.dbGlobal.VendorPrice[itemID] or VENDOR_PRICES[itemID]
end

function VendorPrice.ItemHasVendorPrice(itemID)
    return GetItemPriceString(itemID) ~= nil
end

function VendorPrice.GetVendorPriceForItem(itemID)
    return GetItemPriceString(itemID)
end

function VendorPrice.GetPriceInfoList()
    return PRICE_INFO_LIST
end

-- ################################
-- Vendor scan
-- ################################
local VendorLockList = {}
local SourcesAddon
local UnitGUID, GetMerchantNumItems, GetMerchantItemID, GetMerchantItemCostInfo, GetMerchantItemCostItem,
    GetItemInfoInstant = UnitGUID, GetMerchantNumItems, GetMerchantItemID, GetMerchantItemCostInfo,
    GetMerchantItemCostItem, GetItemInfoInstant

local function GetNpcIDFromGuid(guid)
    local npcID = select(6, strsplit("-", guid))
    if npcID then
        return tonumber(npcID)
    end
end

function VendorPrice.ScanShownVendor()
    local targetGUID = UnitGUID("target")
    if not targetGUID then
        return
    end
    local npcID = GetNpcIDFromGuid(targetGUID)
    if not npcID or VendorLockList[npcID] then
        return
    end
    if not SourcesAddon then
        SourcesAddon = AtlasLoot.Addons:GetAddon("Sources")
    end

    for itemNum = 1, GetMerchantNumItems() do
        local vItemID = GetMerchantItemID(itemNum)
        if vItemID then
            local itemCost = ""
            for costNum = 1, GetMerchantItemCostInfo(itemNum) do
                local itemTexture, itemValue, itemLink, currencyName = GetMerchantItemCostItem(itemNum, costNum)
                if itemLink then
                    local costItemID = GetItemInfoInstant(itemLink)
                    local formatString
                    if VENDOR_PRICE_FORMAT[costItemID] then
                        formatString = VENDOR_PRICE_FORMAT[costItemID]
                    elseif VENDOR_PRICE_FORMAT[itemTexture] then
                        formatString = VENDOR_PRICE_FORMAT[itemTexture]
                    else
                        break -- end here as there is a unknown currency
                    end
                    if formatString then
                        if itemCost == "" then
                            itemCost = format(formatString, itemValue or 0)
                        else
                            itemCost = itemCost .. ":" .. format(formatString, itemValue or 0)
                        end
                    end
                end
            end

            if itemCost ~= "" then
                AtlasLoot.dbGlobal.VendorPrice[vItemID] = itemCost
            end
            if SourcesAddon then
                SourcesAddon:ItemSourcesUpdated(vItemID)
            end
        end
    end

    VendorLockList[npcID] = true
end

VendorPrice.EventFrame = CreateFrame("FRAME")
local function EventFrame_OnEvent(frame, event, arg1, arg2)
    if event == "MERCHANT_SHOW" then
        VendorPrice.ScanShownVendor()
    end
end
VendorPrice.EventFrame:SetScript("OnEvent", EventFrame_OnEvent)
VendorPrice.EventFrame:RegisterEvent("MERCHANT_SHOW")
