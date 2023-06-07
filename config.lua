print("^2px^7-^2Billing ^7v^41^7.^40^7 ^7- ^2Billing Script by ^1MeetxDev^7")

Config = {}

Config.Target = {

    -- [1] = {
    --     modelorcoords = 'prop_name', -- Coords/Model
    --     ml = 0.0, --[ length for biller box only if you give coords and want boxzone]
    --     mb = 0.0 ,--[ breadth for biller box only if you give coords and want boxzone]
    --     mminz = 0.0, --[ minz for biller box only if you give coords and want boxzone]
    --     mmaxz = 0.0, --[ maxz for biller box only if you give coords and want boxzone]
    --     mdebug = false, --[ debug for biller box only if you give coords and want boxzone]
    --     job = 'jobname', --[ Job Needed to Give Bill at this Target ]
    --     label = 'Biller Label', --[ Label of the Target ]
    --     shopname = 'Shop Name', --[[ Shop Name (Should be unique for everyshop ) eg - You have two BurgerShots so 
    --     Shop 1 - "Burger Shot 1
    --     Shop 2 - "Burger Shot 2" ]]--
    --     targetmodelorcoords = 'prop_name', -- Coords/model
    --     tl = 0.0, --[ length for customer box only if you give coords and want boxzone]
    --     tb = 0.0, --[ breadth for customer box only if you give coords and want boxzone]
    --     tminz = 0.0, --[ minz for customer box only if you give coords and want boxzone]
    --     tmaxz = 0.0, --[ maxz for customer box only if you give coords and want boxzone]
    --     tdebug = false, --[ debug for customer box only if you give coords and want boxzone]
    --     targetlabel = 'Customer Label', --[ Target Label to Take Items ]
    -- },
    -- [2] = {
    --     modelorcoords = vector4(0.0, 0.0, 0.0, 0.0),
    --     ml = 0.0,
    --     mb = 0.0 ,
    --     mminz = 0.0,
    --     mmaxz = 0.0,
    --     mdebug = false,
    --     job = 'jobname',
    --     label = 'Biller Label',
    --     shopname = 'Shop Name',
    --     targetmodelorcoords = vector4(0.0, 0.0, 0.0, 0.0),
    --     tl = 0.0,
    --     tb = 0.0,
    --     tminz = 0.0,
    --     tmaxz = 0.0,
    --     tdebug = false,
    --     targetlabel = 'Customer Label',
    -- },
    -- [3] = {
    --     modelorcoords = vector4(-1193.5, -895.1, 14.0, 305.66),
    --     ml = 0.5,
    --     mb = 0.5 ,
    --     mminz = 13.9,
    --     mmaxz = 14.3,
    --     mdebug = false,
    --     job = 'foodtruck',
    --     label = 'Bill Player',
    --     shopname = 'Burger Shot',
    --     targetmodelorcoords = 'prop_food_bs_tray_02',
    --     tl = 0.5,
    --     tb = 0.5,
    --     tminz = 30.5,
    --     tmaxz = 31,
    --     tdebug = false,
    --     targetlabel = 'Take your Items',
    -- },

}


Config.InvShopEvent = 'inventory:server:OpenInventory' -- [ for opening inv (setting stash, shop) ]
Config.InvStashEvent = 'inventory:client:SetCurrentStash' -- [ to set Current stash ]
Config.InvRemoveEvent = 'inventory:client:ItemBox' -- [ for showing removed item to player ]
Config.GetStashItems = 'qb-inventory:server:GetStashItems'-- [ for getting items in a stash (it's a callback) ]
