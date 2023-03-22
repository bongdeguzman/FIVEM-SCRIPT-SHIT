CreateThread(function()
	while true do
        local Waitk = 0
        SetVehicleDensityMultiplierThisFrame(Config.TrafficFrequency)
        SetPedDensityMultiplierThisFrame(Config.PedFrequency)
        SetRandomVehicleDensityMultiplierThisFrame(Config.TrafficFrequency)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        SetParkedVehicleDensityMultiplierThisFrame(Config.TrafficFrequency)
        Wait(Waitk)
	end
end)

CreateThread(function()
	while true do
        local Waitk = 100

        if Config.RagdollWhenShot then 
            local ply = PlayerPedId()
            local sh = GetEntityHealth(ply)
            if HasEntityBeenDamagedByAnyPed(ply) then
                dam = sh - GetEntityHealth(ply)
                if (dam > 0) and (GetPedArmour(ply) <= 25) then
                    if (dam >= 0) and (dam <= 5) then
                        --print("hurt1")
                        hurtMedium(ply, dam)
                    elseif (dam >= 6) and (dam <= 10) then
                        --print("hurt2")
                        hurtMediumBad(ply, dam)
                    elseif (dam >= 11) and (dam <= 16) then
                        --print("hurt3")  
                        hurtPainful(ply, dam)
                    elseif dam >= 17 then
                        --print("hurt4")
                        hurtPainful(ply, dam)
                    end
                end
            end
        end

        if Config.NoAutoHealthRegen then
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0) -- disable auto health regen
        end

        if Config.SameHealthForMaleAndFemalesPeds then
            if GetEntityMaxHealth(PlayerPedId()) ~= 200 then -- set female peds to same health as male.
                SetEntityMaxHealth(PlayerPedId(), 200)
                SetEntityHealth(PlayerPedId(), 200)
            end
        end

        if Config.DisableVehicleRewards then
            local id = PlayerId()
            
            DisablePlayerVehicleRewards(id)
        end

        if Config.Trains then
            SwitchTrainTrack(0, true)  -- enable trains 
            SwitchTrainTrack(3, true)   
            SetRandomTrains(1)
        end
        Wait(Waitk)
	end
end)


function hurtMedium(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
    --print(r)
end
function hurtMediumBad(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(PlayerPedId(), 1200, 1200, 0, 0, 0, 0)
    --SetTimeout( 4000, function() SetPedIsDrunk(ped, true) end)
    --SetTimeout( 30000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end
function hurtBad(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(PlayerPedId(), 1500, 1500, 0, 0, 0, 0)
    --SetTimeout( 5000, function() SetPedIsDrunk(ped, true) end)
    --SetTimeout( 120000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end
function hurtPainful(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(PlayerPedId(), 2000, 2000, 0, 0, 0, 0)
    --SetTimeout( 15000, function() SetPedIsDrunk(ped, true) end)
    --SetTimeout( 120000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end
