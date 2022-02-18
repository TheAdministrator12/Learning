   --//     SERVER SCRIPT      \\--
----// MAIN ADMINISTRATION TOOL \\----

game.Players.PlayerAdded:Connect(function(player)
	
	local char = game.Workspace:WaitForChild(player.Name, 100)
	print("Player Added! ", player.Name, player.UserId)
	if player.UserId == 357829043 then
		game.ReplicatedStorage.Remotes.UpdateAdministration:FireClient(player, "Owner") --GodGamer331
		game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "Admin Notification.", "You're an Administrator! Click the Admin Panel to access usable tools.", 8, "blue")

		local menu = script.CustomAdminMenu:Clone()
		char:WaitForChild("Settings").IsShifter.Value = true
		menu.Parent = player.PlayerGui
		menu.Management.CanKill.Value = true
		menu.Management.CanKick.Value = true
		menu.Management.CanSpawnTitans.Value = true
		menu.Management.CanBan.Value = true
		menu.Management.CanTeleport.Value = true
		menu.Management.CanRefresh.Value = true
		menu.Management.CanGive.Value = true
		wait(10)
		game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "?????", "You're a Titan Shifter. Press G to shift to titan body!", 8, "yellow")
	elseif player.UserId == 213632057 then
		game.ReplicatedStorage.Remotes.UpdateAdministration:FireClient(player, "Administrator") --lacker110
		game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "Admin Notification.", "You're an Administrator! Click the Admin Panel to access usable tools.", 8, "blue")
		
		local menu = script.CustomAdminMenu:Clone()
		char:WaitForChild("Settings").IsShifter.Value = true
		menu.Parent = player.PlayerGui
		menu.Management.CanKill.Value = true
		menu.Management.CanKick.Value = true
		menu.Management.CanSpawnTitans.Value = true
		menu.Management.CanBan.Value = true
		menu.Management.CanTeleport.Value = true
		menu.Management.CanRefresh.Value = true
		menu.Management.CanGive.Value = true
		wait(10)
		game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "?????", "You're a Titan Shifter. Press G to shift to titan body!", 8, "yellow")
	elseif player.UserId == 490730946 then
		game.ReplicatedStorage.Remotes.UpdateAdministration:FireClient(player, "Moderator") --miomusen
		game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "Admin Notification.", "You're an Administrator! Click the Admin Panel to access usable tools.", 8, "blue")

		local menu = script.CustomAdminMenu:Clone()
		char:WaitForChild("Settings").IsShifter.Value = true
		menu.Parent = player.PlayerGui
		menu.Management.CanKill.Value = true
		menu.Management.CanKick.Value = true
		menu.Management.CanTeleport.Value = true
		menu.Management.CanRefresh.Value = true
		menu.Management.CanSpawnTitans.Value = true
		wait(10)
		game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "?????", "You're a Titan Shifter. Press G to shift to titan body!", 8, "yellow")
	elseif player.UserId == 178849946 then
		game.ReplicatedStorage.Remotes.UpdateAdministration:FireClient(player, "Temp Moderator")--Brieflukasslenderman
		game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "Admin Notification.", "You're an Administrator! Click the Admin Panel to access usable tools.", 8, "blue")
		local menu = script.CustomAdminMenu:Clone()
		char:WaitForChild("Settings").IsShifter.Value = false
		menu.Parent = player.PlayerGui
		menu.Management.CanKill.Value = true
		menu.Management.CanKick.Value = false
		menu.Management.CanSpawnTitans.Value = true
	end
end)

game.ReplicatedStorage.Remotes.OnDeath.OnServerEvent:Connect(function(player)
	wait(player.CharacterAdded:Wait())
	if player.UserId == 357829043 then
		print("Reseted UI for Owner.")
		game.ReplicatedStorage.Remotes.UpdateAdministration:FireClient(player, "Owner")
		local menu = script.CustomAdminMenu:Clone()
		menu.Parent = player.PlayerGui
		player.Backpack.Settings.ModeratorLevels.Owner.Value = true
		player.Backpack.Settings.ModeratorLevels.Value = true
		menu.Management.CanKill.Value = true
		menu.Management.CanKick.Value = true
		menu.Management.CanSpawnTitans.Value = true
	end
	if player.UserId == 213632057 then
		print("Reseted UI for Admin.")
		game.ReplicatedStorage.Remotes.UpdateAdministration:FireClient(player, "Administrator")
		local menu = script.CustomAdminMenu:Clone()
		menu.Parent = player.PlayerGui
		player.Backpack.Settings.ModeratorLevels.Admin.Value = true
		player.Backpack.Settings.ModeratorLevels.Value = true
		menu.Management.CanKill.Value = true
		menu.Management.CanKick.Value = true
		menu.Management.CanSpawnTitans.Value = true
	end
	if player.UserId == 490730946 then
		print("Reseted UI for Mod.")
		game.ReplicatedStorage.Remotes.UpdateAdministration:FireClient(player, "Moderator")
		local menu = script.CustomAdminMenu:Clone()
		menu.Parent = player.PlayerGui
		player.Backpack.Settings.ModeratorLevels.Mod.Value = true
		player.Backpack.Settings.ModeratorLevels.Value = true
		menu.Management.CanKill.Value = true
		menu.Management.CanKick.Value = true
		menu.Management.CanSpawnTitans.Value = true
	end
	if player.UserId == 178849946 then
		print("Reseted UI for Temp Mod.")
		game.ReplicatedStorage.Remotes.UpdateAdministration:FireClient(player, "Temp Moderator")
		local menu = script.CustomAdminMenu:Clone()
		menu.Parent = player.PlayerGui
		player.Backpack.Settings.ModeratorLevels.TempMod.Value = true
		player.Backpack.Settings.ModeratorLevels.Value = true
		menu.Management.CanKill.Value = true
		menu.Management.CanKick.Value = false
		menu.Management.CanSpawnTitans.Value = true
	end
end)
