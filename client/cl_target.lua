local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for k, options in pairs(Config.Target) do
        modelnameorcoord = options.modelorcoords
        neededjob = options.job
        label = options.label
        shopname = options.shopname
        targetmodelorcoord = options.targetmodelorcoords
        targetlabel = options.targetlabel

        modell = options.ml
        modelb = options.mb
        modelminz = options.mminz
        modelmaxz = options.mmaxz
        modeldebug = options.mdebug

        targetl = options.tl
        targetb = options.tb
        targetminz = options.tminz
        targetmaxz = options.tmaxz
        targetdebug = options.tdebug

        if type(modelnameorcoord) == "vector4" then

            exports['qb-target']:AddBoxZone("mxdbill"..k, vector3(modelnameorcoord.x, modelnameorcoord.y, modelnameorcoord.z), modell, modelb, {
            name = "mxdbill"..k,
            heading = modelnameorcoord.w,
            debugPoly = modeldebug,
            minZ = modelminz,
            maxZ = modelmaxz,
            }, {
                options = {
                    {
                        type = "client",
                        event = "mxd-billing:client:billplayerfood",
                        icon = 'fas fa-money-bill',
                        label = label,
                        job = neededjob,
                        action = function(entity)
                            if IsPedAPlayer(entity) then return false end
                            TriggerEvent('mxd-billing:client:billplayerfood', shopname)
                        end,
                    },
                },
                distance = 2.5, 
            })

        else

            exports['qb-target']:AddTargetModel(modelnameorcoord, {
                options = {
                    {
                        type = "client",
                        event = "mxd-billing:client:billplayerfood",
                        icon = 'fas fa-money-bill',
                        label = label,
                        job = neededjob,
                        action = function(entity)
                            if IsPedAPlayer(entity) then return false end
                            TriggerEvent('mxd-billing:client:billplayerfood', shopname)
                        end,
                    },
                },
                distance = 2.5, 
            })

        end
        
        if type(targetmodelorcoord) == "vector4" then

            exports['qb-target']:AddBoxZone("mxdbilltarget"..k, vector3(targetmodelorcoord.x, targetmodelorcoord.y, targetmodelorcoord.z), targetl, targetb, {
            name = "mxdbilltarget"..k,
            heading = targetmodelorcoord.w,
            debugPoly = targetdebug,
            minZ = targetminz,
            maxZ = targetmaxz,
            }, {
                options = {
                    {
                        type = "client",
                        event = "mxd-billing:client:billplayerfoodaccept",
                        icon = 'fas fa-money-bill',
                        label = targetlabel,
                        action = function(entity)
                            if IsPedAPlayer(entity) then return false end
                            TriggerEvent('mxd-billing:client:billplayerfoodaccept', shopname)
                        end,
                        canInteract = function()
                            local isOwnedT = MxDBillCheckTarget(shopname)
                            if isOwnedT then
                                return true
                            else
                                return false
                            end
                        end,
                    },
                },
                distance = 2.5, 
            })

        else

            exports['qb-target']:AddTargetModel(targetmodelorcoord, {
                options = {
                    {
                        type = "client",
                        event = "mxd-billing:client:billplayerfoodaccept",
                        icon = 'fas fa-money-bill',
                        label = targetlabel,
                        action = function(entity)
                            if IsPedAPlayer(entity) then return false end
                            TriggerEvent('mxd-billing:client:billplayerfoodaccept', shopname)
                        end,
                        canInteract = function()
                            local isOwnedT = MxDBillCheckTarget(shopname)
                            if isOwnedT then
                                return true
                            else
                                return false
                            end
                        end,
                    },
                },
                distance = 2.5, 
            })
            
        end

    end

end)