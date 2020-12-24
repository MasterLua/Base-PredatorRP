--[[ Main ]]--
local textscreens = {
	{
		coords = vector3(-831.23, -126.96, 28.98),
		text = "~o~Bienvenue~s~ sur ~r~PredatorRP~s~ !\nPasse un ~g~agréable~s~ moment parmi nous !",
		size = 0.7,
		font = 0,
		maxDistance = 10
	},
	{
		coords = vector3(-823.40, -121.51, 28.98),
		text = "Votre personnage n'a pas était créer correctement ?\nAlors faites ~b~/register~s~ dans le chat ~b~[T]~s~",
		size = 0.7,
		font = 0,
		maxDistance = 10
	},
	{
		coords = vector3(-829.16, -106.81, 28.99),
		text = "Noublie pas de rejoindre notre discord !\n~b~discord.gg/UW8ZMfczN5~s~",
		size = 0.7,
		font = 0,
		maxDistance = 10
	},
	{
		coords = vector3(-843.15, -130.43, 28.98),
		text = "~b~RECRUTEMENT ~b~STAFF ~b~ON",
		size = 0.7,
		font = 0,
		maxDistance = 10

	},
	{
		coords = vector3(-38.85, -1110.08, 26.44),
		text = "~b~MERCI ~b~DE ~b~PAS TROLL",
		size = 0.7,
		font = 0,
		maxDistance = 10
	}
}

AddEventHandler('korioz:init', function()
	Citizen.CreateThread(function()
		while true do
			local PlayerCoords = LocalPlayer().Coords

			for i = 1, #textscreens, 1 do
				if #(PlayerCoords - textscreens[i].coords) < textscreens[i].maxDistance then
					ESX.Game.Utils.DrawText3D(textscreens[i].coords, textscreens[i].text, textscreens[i].size, textscreens[i].font)
				end
			end

			Citizen.Wait(0)
		end
	end)
end)