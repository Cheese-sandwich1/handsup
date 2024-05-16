local delayRunning = false
local delay = 0

Citizen.CreateThread(function()
    local dict = "missfra1mcs_2_crew_react"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
        local ped = PlayerPedId()
        local player = GetPlayerPed(-1)
		Citizen.Wait(0)
		if IsControlJustPressed(1, 323) then --Start holding X
            if not handsup then
                if not delayRunning then
                    TaskPlayAnim(player, dict, "handsup_standing_base", 1.5, 2.0, -1, 50, 0, false, false, false)
                    SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"),true)
                    startDelay()
                    handsup = true
                else
                    exports['mythic_notify']:DoHudText('error', 'Wait a couple of seconds')
                end
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        elseif handsup then
            SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"),true)
            DisableControlAction(2, 37, true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 140, true)
            DisablePlayerFiring(ped, true)
        end
    end
end)

function startDelay()
    delayRunning = true
    delay = 3
    Citizen.CreateThread(function()
        while delay > 0 do
            delay = delay -1
            Citizen.Wait(1000)
        end
        delayRunning = false
    end)
end
