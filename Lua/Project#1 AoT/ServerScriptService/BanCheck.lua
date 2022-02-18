   --//      SERVER SCRIPT     \\--
----// Checks if user is banned \\----

local API = require(game.ServerScriptService.TrelloStuff:WaitForChild("TrelloAPI"))

game.Players.PlayerAdded:Connect(function(player)
	print("Player Joined - Pre-check.")
	local BoardID = API:GetBoardID("Attack On Titan Bans")
	local ListID = API:GetListID("Ban List", BoardID)

	local Info = API:GetCardsInList(ListID)
	print("Player Joined! - Ban Check.")
	for i, v in pairs(Info) do
		local s = string.split(v.name, " | ")
		local id = tonumber(s[2])
		print(id.." | "..player.UserId)
		if id == player.UserId then
			player:Kick("\nYou have been banned for: "..v.desc)
			print(v.name, v.desc)
		end
	end
end)
