# Remake to esx_holdup that made by ESX Framework 
# License - Legal
esx_holdup - rob stores

Copyright (C) 2015-2018 Jérémie N'gadi

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.

# Info about Me:
Hello my name is Ariel, i am going to release some of the scripts i am remaking.
I am not a programmer only kind of developer, I am still learning and my goal is to specialize in the field of programming.
The script i remaked made for my roleplay server and also for a friend of mine, i had some problems with the script and took me a bit to fix and build the remake.


# About the Remake: ->esx_advanced_holdup<-
The script i remaked a bit based about: esx_holdup witch enable stores around the island for criminals to rob.
I am sure u all guys know this normal & simple script but as i told you in #info about me, i made the changes for my roleplay server and also for a server of my friend.
I made the script look a bit better and more realistic.
there are few things that got changed: added animation when start the rob, [stand close to the safe box to watch it!], added alarm sound that will start playing about few seconds after you start the rob.
The alarm is based on native PLAY_SOUND_FROM_COORD witch enable the sound getting low when you leave the store that getting robbed and a bit loud when close to id, when you are far of it you wont hear it.
Gta notification also changed but only the rob message for start the rob all the rest i didnt chage but maybe i will change this to chat alerts or pNotify idk what, but in the future.
For the last change is the text down: i added option to cencel to rob by pressing X control key [you can easily change this], you can see the cancel message down the rob message with the seconds you have left.
the messages set in good place on screen with color and as i told with an option to cencel the robbery.

# How to set esx_advanced_holdup:
The script Required a bit of setup because the alarm permission, that means that if you wont do this setup the alarm wont play & work for you.
i have tried some ways to do this but only in the way i am going to show you it worked.
The setup enable jobs that you have in your server to hear the alarm by the distance of the alarm while playing, the setup gonna be in the [server folder - > main.lua], you also have some things to set in the config.lua as normal
in this script.
The setup in [server-main.lua], will be look like in these lines 54 - 76: you will have to use this part only and set the job name you want to here the alarm while there is a robbery
or while someone with the job rob will be able to hear it.
All what you need to do is jump some lines down and copy & paste the code and put there your jobs names.
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'unemployed' then
						TriggerClientEvent('Robberies:setBlip', xPlayers[i], Stores[currentStore].position)
					end
				end
				
As well i added an option to disable some key controls, you can set it up in[client - mani.lua] down in the code see https://docs.fivem.net/docs/game-references/controls/ for choose cotrol key to disable.
You can also set the alarm play time by milliseconds to seconds [in client main.lua] line 81 [120000] = 120 seconds as default.

# In conclusion:
I had fun to remake this script i can say that i learned a lot and let me remind you that i am not a programmer or something big, still learning.
I want to say A Big Thanks to the beta testers that helped me testing this before release this remake, thanks to: Devileye™#6969, tomer#8230.
If you have any problems or questions feel free to ask me and keep in touch by my discord name: ArielZ#5022 
Here are A clip & small showcase of the remake: https://streamable.com/9e7kd6
