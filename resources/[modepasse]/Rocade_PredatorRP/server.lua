local players = {}
local waiting = {}
local connecting = {}
local prePoints = Config.Points
local EmojiList = Config.EmojiList
local mdp = "magic1234"
AddEventHandler('playerConnecting', function(name, reject, def)
	local source = source
    def.defer()
    AntiSpam(def)
	def.presentCard([==[{
		"type":"AdaptiveCard",
		"body":[
		{
		    "type": "ColumnSet",
		    "columns": [
		    {
		        "type": "Column",
		        "items": [
		        {
		            "type": "Image",
		            "url": "",
		            "size": "Large"
		        }],
		    	"width": "auto"
		    }]
		},
		{
		    "type":"TextBlock",
		    "text":"Bonjour Merci de rejoindre le discord !! : https://discord.gg/PredatorRP",
		    "wrap":true
		},
		{
		    "type":"Input.Text",
		    "id":"password",
		    "placeholder":"Mot de passe"
		},
		{
		    "type":"ActionSet",
		    "actions":[
		    {
		    	"type":"Action.Submit",
		    	"title":"Se connecter"
		    }]
		},
		{
		    "type":"ActionSet",
		    "actions":[
		    {
		    	"type":"Action.OpenUrl",
		    	"title":"Rejoindre le Discord",
		    	"url":"https://discord.gg/PredatorRP"
		    }]
		}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json","version":"1.0"
	}]==], function(data, rawData)
		if data.password and data.password == mdp then
			local steamID = GetSteamID(source)
	    	if not steamID then
				reject(Config.NoSteam)
				CancelEvent()
				return 
			end
			if not Rocade(steamID, def, source) then
				CancelEvent()
			end
		else
			def.done('Mauvais mot de passe, il est trouvable sur le discord : https://discord.gg/PredatorRP')
		end
	end)
end)
-- Fonction principale, utilise l'objet "deferrals" transmis par l'evenement "playerConnecting"
function Rocade(steamID, def, source)
	-- retarder la connexion
	def.defer()
	-- faire patienter un peu pour laisser le temps aux listes de s'actualiser
	AntiSpam(def)
	-- retirer notre ami d'une éventuelle liste d'attente ou connexion
	Purge(steamID)
	-- l'ajouter aux players
  	-- ou actualiser la source
	AddPlayer(steamID, source)
	-- le mettre en file d'attente
	table.insert(waiting, steamID)
	-- tant que le steamID n'est pas en connexion
	local stop = false
	repeat
	for i,p in ipairs(connecting) do
		if p == steamID then 
			stop = true 
			break
		end
	end
    -- Hypothèse: Quand un joueur en file d'attente a un ping = 0, ça signifie que la source est perdue
    -- Détecter si l'user clique sur "cancel"
    -- Le retirer de la liste d'attente / connexion
    -- Le message d'accident ne devrait j'amais s'afficher
    for j,sid in ipairs(waiting) do
      for i,p in ipairs(players) do
      -- Si un joueur en file d'attente a un ping = 0
        if sid == p[1] and p[1] == steamID and (GetPlayerPing(p[3]) == 0) then
          -- le purger
          Purge(steamID)
          -- comme il a annulé, def.done ne sert qu'à identifier un cas non géré
          def.done(Config.Accident)
          return false
        end
      end
    end
	-- Mettre à jour le message d'attente
	def.update(GetMessage(steamID))
	Citizen.Wait(Config.TimerRefreshClient * 1000)
	until stop
	-- quand c'est fini, lancer la co
	def.done()
	return true
end
-- Vérifier si une place se libère pour le premier de la file
Citizen.CreateThread(function()
	local maxServerSlots = 256
	while true do
		Wait(Config.TimerCheckPlaces * 1000)
		CheckConnecting()
		if #waiting > 0 and #connecting + #GetPlayers() < maxServerSlots then
			ConnectFirst()
		end
	end
end)
-- Mettre régulièrement les points à jour
Citizen.CreateThread(function()
	while true do
		UpdatePoints()
		Wait(Config.TimerUpdatePoints * 1000)
	end
end)
-- Lorsqu'un joueur est kick
-- lui retirer le nombre de points fourni en argument
RegisterServerEvent("Rocade_Raven:playerKicked")
AddEventHandler("Rocade_Raven:playerKicked", function(src, points)
	local sid = GetSteamID(src)
	Purge(sid)
  	for i,p in ipairs(prePoints) do
    	if p[1] == sid then
			p[2] = p[2] - points
      		return
    	end
	end
	local initialPoints = GetInitialPoints(sid)
  	table.insert(prePoints, {sid, initialPoints - points})
end)
-- Quand un joueur spawn, le purger
RegisterServerEvent("Rocade_Raven:playerConnected")
AddEventHandler("Rocade_Raven:playerConnected", function()
	local sid = GetSteamID(source)
	Purge(sid)
end)
-- Quand un joueur drop, le purger
AddEventHandler("playerDropped", function(reason)
	local steamID = GetSteamID(source)
	Purge(steamID)
end)
-- si le ping d'un joueur en connexion semble partir en couille, le retirer de la file
-- Pour éviter un fantome en connexion
function CheckConnecting()
	for i,sid in ipairs(connecting) do
		for j,p in ipairs(players) do
			if p[1] == sid and (GetPlayerPing(p[3]) == 500) then
				table.remove(connecting, i)
				break
			end
		end
	end
end
-- ... connecte le premier de la file
function ConnectFirst()
	if #waiting == 0 then return end
	local maxPoint = 0
	local maxSid = waiting[1][1]
	local maxWaitId = 1
	for i,sid in ipairs(waiting) do
		local points = GetPoints(sid)
		if points > maxPoint then
			maxPoint = points
			maxSid = sid
			maxWaitId = i
		end
	end
	table.remove(waiting, maxWaitId)
	table.insert(connecting, maxSid)
end
-- retourne le nombre de kilomètres parcourus par un steamID
function GetPoints(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			--print(p[1] .. ' [' .. p[2] .. ']')
			return p[2]
		end
	end
end
-- Met à jour les points de tout le monde
function UpdatePoints()
  for i,p in ipairs(players) do
    local found = false
    for j,sid in ipairs(waiting) do
      if p[1] == sid then
        p[2] = p[2] + Config.AddPoints
        found = true
        break
      end
    end
    if not found then
      for j,sid in ipairs(connecting) do
        if p[1] == sid then
          found = true
          break
        end
      end
    	if not found then
        p[2] = p[2] - Config.RemovePoints
        if p[2] < GetInitialPoints(p[1]) - Config.RemovePoints then
          Purge(p[1])
          table.remove(players, i)
        end
      end
		end
  end
end
function AddPlayer(steamID, source)
  for i,p in ipairs(players) do
		if steamID == p[1] then
      players[i] = {p[1], p[2], source}
      return
    end
	end
	local initialPoints = GetInitialPoints(steamID)
	table.insert(players, {steamID, initialPoints, source})
end
function GetInitialPoints(steamID)
	local points = Config.RemovePoints + 1
	for n,p in ipairs(prePoints) do
		if p[1] == steamID then
			points = p[2]
		end
	end
	return points
end
function GetPlace(steamID)
	points = GetPoints(steamID)
	place = 1
	for i,sid in ipairs(waiting) do
		for j,p in ipairs(players) do
			if p[1] == sid and p[2] > points then
				place = place + 1
			end
		end
	end
	return place
end
function GetMessage(steamID) 
	local msg = ""
	if GetPoints(steamID) ~= nil then
		msg = "\n"..Config.EnRoute.." "..GetPoints(steamID).." "..Config.PointsRP..".\n"
		if GetPlace(steamID) == 1 then
			msg = msg .. Config.Position .. GetPlace(steamID) .. Config.AfterPosition1ER .. "\n"
		else
			msg = msg..Config.Position.. GetPlace(steamID) ..Config.AfterPosition.. "\n"
		end
		msg = msg ..Config.PlyPosition.. #waiting ..Config.AfterPlyPosition
	else
		msg = Config.Error
	end
	return msg
end
function LoterieBoost(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			p[2] = p[2] + Config.LoterieBonusPoints
			return
		end
	end
end
function Purge(steamID)
	for n,sid in ipairs(connecting) do
		if sid == steamID then
			table.remove(connecting, n)
		end
	end
	for n,sid in ipairs(waiting) do
		if sid == steamID then
			table.remove(waiting, n)
		end
	end
end
function AntiSpam(def)
	for i=Config.AntiSpamTimer,0,-1 do
		def.update(Config.PleaseWait_1 .. i .. Config.PleaseWait_2)
		Citizen.Wait(1000)
	end
end
function RandomEmojiList()
	randomEmoji = EmojiList[math.random(#EmojiList)]
	return randomEmoji
end
-- Helper pour récupérer le steamID or false
function GetSteamID(src)
	local sid = GetPlayerIdentifiers(src)[1] or false
	if (sid == false or sid:sub(1,5) ~= "steam") then
		return false
	end 
	return sid
end