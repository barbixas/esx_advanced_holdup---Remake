local holdingUp = false
local store = ""
local blipRobbery = nil
local rob = false
local dict = "mini@safe_cracking"
ESX = nil

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

function HelpText(text)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

RegisterNetEvent('esx_advanced_holdup:currentlyRobbing')
AddEventHandler('esx_advanced_holdup:currentlyRobbing', function(currentStore)
	holdingUp, store = true, currentStore
	TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_normal", 0.5, 1.0, -1, 11, 0.0, 0, 0, 0)
end)

RegisterNetEvent('esx_advanced_holdup:killBlip')
AddEventHandler('esx_advanced_holdup:killBlip', function()
	RemoveBlip(blipRobbery)
end)

Citizen.CreateThread(function()
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	while true do
	Citizen.Wait(0)
end
end)


soundid = GetSoundId()

RegisterNetEvent('esx_advanced_holdup:setBlip')
AddEventHandler('esx_advanced_holdup:setBlip', function(position)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
	Citizen.Wait(2000)
	PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", position.x, position.y, position.z)

	SetBlipSprite(blipRobbery, 161)
	SetBlipScale(blipRobbery, 0.0)
	SetBlipColour(blipRobbery, 3)
    Citizen.Wait(2000)
	Citizen.Wait(120000)
	StopSound(soundid)

	PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_advanced_holdup:setblip')
AddEventHandler('esx_advanced_holdup:setblip', function(position)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
	Citizen.Wait(2000)
	PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", position.x, position.y, position.z)

	SetBlipSprite(blipRobbery, 161)
	SetBlipScale(blipRobbery, 1.2)
	SetBlipColour(blipRobbery, 3)
    Citizen.Wait(2000)
	Citizen.Wait(120000)
	StopSound(soundid)

	PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_advanced_holdup:tooFar')
AddEventHandler('esx_advanced_holdup:tooFar', function()
	holdingUp, store = false, ''
	ESX.ShowNotification(_U('robbery_cancelled'))
end)

RegisterNetEvent('esx_advanced_holdup:robberyComplete')
AddEventHandler('esx_advanced_holdup:robberyComplete', function(award)
	holdingUp, store = false, ''
	ESX.ShowNotification(_U('robbery_complete', award))
end)

RegisterNetEvent('esx_advanced_holdup:startTimer')
AddEventHandler('esx_advanced_holdup:startTimer', function()
	local timer = Stores[store].secondsRemaining

	Citizen.CreateThread(function()
		while timer > 0 and holdingUp do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while holdingUp do
			Citizen.Wait(0)
			drawTxt(0.68, 1.44, 0.7, 1.0, 0.3, _U('robbery_timer', timer), 88, 166, 245, 255)
			drawTxt(0.66, 1.66, 0.7, 1.4, 0.3, _U('robbery_cancel'), 88, 166, 245, 255)
		end
	end)
end)

Citizen.CreateThread(function() -->Blips that show witch store you can rob<--
	for k,v in pairs(Stores) do
		local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
		SetBlipSprite(blip, 156)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

		for k,v in pairs(Stores) do
			local storePos = v.position
			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z)

			if distance < Config.Marker.DrawDistance then
				if not holdingUp then
					DrawMarker(Config.Marker.Type, storePos.x, storePos.y, storePos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, false, false, false, false)

					if distance < 0.5 then
						--ESX.ShowHelpNotification(_U('press_to_rob', v.nameOfStore))
						  ESX.Game.Utils.DrawText3D({ x = 1734.75, y = 6420.73, z = 35.04 }, 'Press ~r~[E] ~w~to rob this store', 0.4)
                          ESX.Game.Utils.DrawText3D({ x = 1959.38, y = 3748.8, z = 32.34  }, 'Press ~r~[E] ~w~to rob this store', 0.4)		
                          ESX.Game.Utils.DrawText3D({ x = -709.57, y = -904.16, z = 19.22 }, 'Press ~r~[E] ~w~to rob this store', 0.4)		
                          ESX.Game.Utils.DrawText3D({ x = 1990.57, y = 3044.95, z = 47.21 }, 'Press ~r~[E] ~w~to rob this store', 0.4)	
                          ESX.Game.Utils.DrawText3D({ x = -2959.6, y = 387.28, z = 14.04  }, 'Press ~r~[E] ~w~to rob this store', 0.4)
                          ESX.Game.Utils.DrawText3D({ x = 1126.80, y = -980.40, z = 45.41 }, 'Press ~r~[E] ~w~to rob this store', 0.4)	
                          ESX.Game.Utils.DrawText3D({ x = -1220.66, y = -915.83, z = 11.33}, 'Press ~r~[E] ~w~to rob this store', 0.4)	
						  ESX.Game.Utils.DrawText3D({ x = -43.23, y = -1748.52, z = 29.42 }, 'Press ~r~[E] ~w~to rob this store', 0.4)
						  ESX.Game.Utils.DrawText3D({ x = 1159.65, y = -313.98, z = 69.21 }, 'Press ~r~[E] ~w~to rob this store', 0.4)

						if IsControlJustReleased(0, Keys['E']) then
							TriggerServerEvent('esx_advanced_holdup:robberyStarted', k)
						end
					end
				end
			end
		end
		
					if IsControlJustReleased(0, Keys['X']) then
					ClearPedTasks(PlayerPedId())
						TriggerServerEvent('esx_advanced_holdup:robberyFinished', k)
						TriggerServerEvent('esx_advanced_holdup:tooFar', store)
						Citizen.Wait(2000)
					    StopSound(soundid)
					end
		
		if holdingUp then
			local storePos = Stores[store].position
			if Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z) > Config.MaxDistance then
				TriggerServerEvent('esx_advanced_holdup:tooFar', store)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if holdingUp then
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here
			DisableControlAction(0, 0, true) -- add your configuration here

		else
			Citizen.Wait(500)
		end
	end
end)

