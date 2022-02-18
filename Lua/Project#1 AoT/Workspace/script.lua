   --// SERVER SCRIPT \\--
----// GEAR EQUIPMENT  \\----

local function OnClick(player)
	if player then
		if not player.Backpack:findFirstChild("Gear") then
			script.Gear:Clone().Parent = player.Backpack
			game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "ODMG Equipped!", "You have equipped ODMG.", 5, "green")
		end
	end                      
end
script.Parent.ClickDetector.MouseClick:connect(OnClick)
