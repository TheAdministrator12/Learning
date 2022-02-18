   --//      SERVER SCRIPT     \\--
----// CREATES TAGS FOR PLAYERS \\----

local ServerScriptService = script.Parent
local ChatServiceRunner = ServerScriptService:WaitForChild("ChatServiceRunner", 100)
local ChatService = require(ChatServiceRunner:WaitForChild("ChatService", 100))

local Tags = require(script.Tags)

local function CheckForTags(Player)
	
	local Attempt = Tags[tostring(Player.UserId)] or Tags[Player.Name]
	
	if Attempt then
		local SpeakerObject
		
		repeat
			
			wait()
			SpeakerObject = ChatService:GetSpeaker(Player.Name)
			
		until SpeakerObject ~= nil
		
		SpeakerObject:SetExtraData("Tags", {Attempt})
		
	else
		print("Didn't find user ", Player.Name, "!")
		
	end
	
end

game.Players.PlayerAdded:Connect(function(Player)
	
	CheckForTags(Player)
	
end)

for _, Player in pairs(game.Players:GetPlayers()) do
	CheckForTags(Player)
end
