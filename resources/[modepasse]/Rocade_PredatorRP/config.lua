Config = {}



Config.AntiSpamTimer = 1



-- Vérification et attribution d'une place libre / Verification and allocation of a free place

Config.TimerCheckPlaces = 3



-- Mise à jour du message (emojis) et accès à la place libérée pour l'heureux élu / Update of the message (emojis) and access to the free place for the lucky one

Config.TimerRefreshClient = 3



-- Mise à jour du nombre de points / Number of points updating

Config.TimerUpdatePoints = 6



----------------------------------------------------

------------ Nombres de points ---------------------

----------------------------------------------------



-- Nombre de points gagnés pour ceux qui attendent / Number of points earned for those who are waiting

Config.AddPoints = 1



-- Nombre de points perdus pour ceux qui sont entrés dans le serveur / Number of points lost for those who entered the server

Config.RemovePoints = 1



-- Nombre de points gagnés pour ceux qui ont 3 emojis identiques (loterie) / Number of points earned for those who have 3 identical emojis (lottery)

Config.LoterieBonusPoints = 25



-- Accès prioritaires / Priority access

Config.Points = {

	{'steam:11000011b5d6988', 100000}, -- Quiquin
}



Config.NoSteam = "Steam n'a pas été détecté. Veuillez lancer Steam et redémarrer FiveM."



Config.EnRoute = "Vous êtes en route, vous avez déjà parcouru"

Config.PointsRP = "kilomètres"



Config.Position = "Vous êtes en "

Config.AfterPosition1ER = "ère position !"

Config.AfterPosition = "ème position !"



Config.PlyPosition = "Il y a "

Config.AfterPlyPosition = " personne(s) sur la rocade."



Config.EmojiBoost = "!!! Youpi, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " gagnés !!!"



Config.PleaseWait_1 = "Veuillez patienter "

Config.PleaseWait_2 = " secondes. Tous va se lancer automatiquement ! 😎"



Config.Accident = "Oups, vous venez d'avoir un accident... Si cela se reproduit, vous pouvez en informer le support :)"

Config.Error = " ERREUR : RELANCEZ LA ROCADE ET CONTACTEZ LE SUPPORT DU SERVEUR "
