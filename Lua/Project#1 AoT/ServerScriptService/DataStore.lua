   --//       SERVER SCRIPT       \\--
----// HANDLES LOADING/SAVING DATA \\----

local DSS = game:GetService("DataStoreService")

local KillsData = DSS:GetDataStore("KillsData")
local SettingsData = DSS:GetDataStore("Settings")
local SkillPoints = DSS:GetDataStore("SkillPoints")
local Leveling = DSS:GetDataStore("Leveling")

game.Players.PlayerAdded:Connect(function(player)
	local f = Instance.new("Folder")
	f.Name = "leaderstats"
	f.Parent = player
	local kills = Instance.new("IntValue")
	kills.Name = "Kills"
	kills.Parent = f
	local killstreak = Instance.new("IntValue")
	killstreak.Name = "Killstreak"
	killstreak.Parent = f
	local assists = Instance.new("IntValue")
	assists.Name = "Assists"
	assists.Parent = f
	
	--// DATASTORE LOADING \\--
		--// SETTINGS AND KILLS LOADING \\--
	local uID = "Player_"..player.UserId
	print(uID)
	local data4
	local succ2, err2 = pcall(function()
		data4 = Leveling:GetAsync(uID)
	end)
	local data3
	local succ1, err1 = pcall(function()
		data3 = SkillPoints:GetAsync(uID)
	end)
	
	local data2
	local succ, err = pcall(function()
		data2 = SettingsData:GetAsync(uID)
	end)
	
	local Data
	local success, err = pcall(function()
		Data = KillsData:GetAsync(uID)
	end)
	print("Kills Loaded! Succeeded:", success, Data.Kills, Data.Killstreak, Data.Assists.." Kills | Killstreak | Assists")
	print("Settings Loaded! Succeeded:", succ, data2.UIMuted, data2.MusicMuted, data2.GS, " UI Muted | Music Muted | Global Shadows")
	print("Skillpoints Loaded! Succeeded:", succ1, data3.SkillPoints, data3.SkillPoints_MoreGas, data3.SkillPoints_MoreGasBought, data3.SkillPoints_MoreDurability, data3.SkillPoints_MoreDurabilityBought, data3.SkillPoints_MoreBlades, data3.SkillPoints_MoreBladesBought, " Skillpoints | Gas Bought | Gas Level | Durability Level | Durability Bought.")
	if succ2 then
		player.Backpack:WaitForChild("Settings", 100).Level.Level.Value = data4.Level
		player.Backpack:WaitForChild("Settings", 100).Level.EXP.Value = data4.EXP
		player.Backpack:WaitForChild("Settings", 100).Level.RequiredEXP.Value = data4.RequiredEXP
	else
		player.Backpack:WaitForChild("Settings", 100).Level.Level.Value = 0
		player.Backpack:WaitForChild("Settings", 100).Level.EXP.Value = 0
		player.Backpack:WaitForChild("Settings", 100).Level.RequiredEXP.Value = 100
	end
	if succ1 then
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Skillpoints.Value = data3.SkillPoints
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Level.Value = data3.SkillPoints_MoreGas
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Level.Value = data3.SkillPoints_MoreDurability
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Value = data3.SkillPoints_MoreGasBought
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Value = data3.SkillPoints_MoreDurabilityBought
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Value = data3.SkillPoints_MoreBladesBought
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Level.Value = data3.SkillPoints_MoreBlades
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Value = data3.SkillPoints_ThunderBought
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Level.Value = data3.SkillPoints_Thunder
	else
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Skillpoints.Value = 0
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Value = false
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Value = false
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Level.Value = 0
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Level.Value = 0
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Value = false
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Level.Value = 0
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Value = false
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Level.Value = 0
	end
	if succ then
		player.Backpack:WaitForChild("Settings", 100).MuteUI.Value = data2.UIMuted
		player.Backpack:WaitForChild("Settings", 100).MuteMusic.Value = data2.MusicMuted
		player.Backpack:WaitForChild("Settings", 100).GSEnabled.Value = data2.GS
	else
		player.Backpack.Settings.MuteUI.Value = false
		player.Backpack.Settings.MuteMusic.Value = false
		player.Backpack.Settings.GSEnabled.Value = true
	end
	if success then
		kills.Value = Data.Kills
		killstreak.Value = Data.Killstreak
		assists.Value = Data.Assists
	else
		print("User "..uID.." Not found!")
		warn(err)
	end
	
	player.CharacterRemoving:Connect(function(char)
		wait(game.Players.RespawnTime+1)
		killstreak.Value = 0
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Skillpoints.Value = data3.SkillPoints
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Level.Value = data3.SkillPoints_MoreGas
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Level.Value = data3.SkillPoints_MoreDurability
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Value = data3.SkillPoints_MoreGasBought
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Value = data3.SkillPoints_MoreDurabilityBought
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Value = data3.SkillPoints_MoreBladesBought
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Level.Value = data3.SkillPoints_MoreBlades
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Value = data3.SkillPoints_ThunderBought
		player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Level.Value = data3.SkillPoints_Thunder
	end)
	
	while wait(1) do
		player.Backpack.ChildAdded:Connect(function(v)
			if v.Name == "Settings" then
				v.ChildAdded:Connect(function(vv)
					if vv.Name == "Level" then
						wait()
						player.Backpack:WaitForChild("Settings", 100).Level.Level.Value = data4.Level
						player.Backpack:WaitForChild("Settings", 100).Level.EXP.Value = data4.EXP
						player.Backpack:WaitForChild("Settings", 100).Level.RequiredEXP.Value = data4.RequiredEXP
					end
				end)
			end
		end)
	end	
	
	while true do
		wait(1)
		player.Backpack.ChildAdded:Connect(function(folder)
			if folder.Name == "Settings" then
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Skillpoints.Value = data3.SkillPoints
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Level.Value = data3.SkillPoints_MoreGas
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Level.Value = data3.SkillPoints_MoreDurability
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Value = data3.SkillPoints_MoreGasBought
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Value = data3.SkillPoints_MoreDurabilityBought
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Value = data3.SkillPoints_MoreBladesBought
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Level.Value = data3.SkillPoints_MoreBlades
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Value = data3.SkillPoints_ThunderBought
				player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Level.Value = data3.SkillPoints_Thunder
				player.Backpack:WaitForChild("Settings", 100).Level.Level.Value = data4.Level
				player.Backpack:WaitForChild("Settings", 100).Level.EXP.Value = data4.EXP
				player.Backpack:WaitForChild("Settings", 100).Level.RequiredEXP.Value = data4.RequiredEXP
			end
		end)
	end
	
end)

--// DATASTORE SAVING \\--

game.Players.PlayerRemoving:Connect(function(player)
	local ID = "Player_"..player.UserId
	local perks = player.Backpack:WaitForChild("Settings"):WaitForChild("PerkSettings")
	local data = {
		Kills = player.leaderstats.Kills.Value,
		Killstreak = player.leaderstats.Killstreak.Value,
		Assists = player.leaderstats.Assists.Value;
	}
	print(data.Kills, data.Killstreak, data.Assists)
	local success, errormessage = pcall(function()
		KillsData:SetAsync(ID, data)
	end)
	if success then
		print("Data saved! - Kills")
	elseif not success then
		print("There was an error")
		warn(errormessage)
	end
	
	local data2 = {
		UIMuted = player.Backpack.Settings.MuteUI.Value;
		MusicMuted = player.Backpack.Settings.MuteMusic.Value;
		GS = player.Backpack.Settings.GSEnabled.Value;
	}
	print(data2.MusicMuted, data2.UIMuted, data2.GS)
	local succ, err = pcall(function()
		SettingsData:SetAsync(ID, data2)
	end)
	if succ then
		print("Data saved! - Settings")
	elseif not succ then
		print("There was an error")
		warn(err)
	end
	local data3 = {
		SkillPoints = player.Backpack.Settings.PerkSettings.Skillpoints.Value,
		SkillPoints_MoreGas = player.Backpack.Settings.PerkSettings.Perks.MoreGas.Level.Value,
		SkillPoints_MoreGasBought = player.Backpack.Settings.PerkSettings.Perks.MoreGas.Value,
		SkillPoints_MoreDurability = player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value,
		SkillPoints_MoreDurabilityBought = player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Value,
		SkillPoints_MoreBlades = player.Backpack.Settings.PerkSettings.Perks.MoreBlades.Level.Value,
		SkillPoints_MoreBladesBought = player.Backpack.Settings.PerkSettings.Perks.MoreBlades.Value,
		SkillPoints_Thunder = perks.Perks.Thunder.Level.Value,
		SkillPoints_ThunderBought = perks.Perks.Thunder.Value;
	}
	local succ1, err1 = pcall(function()
		SkillPoints:SetAsync(ID, data3)
	end)
	if succ1 then
		print("Data saved! - SkillPoints")
	else
		print("Error found!")
		warn(err1)
	end
	
	local data4 = {
		Level = player.Backpack.Settings.Level.Level.Value,
		EXP = player.Backpack.Settings.Level.EXP.Value,
		RequiredEXP = player.Backpack.Settings.Level.RequiredEXP.Value;
	}
	print(data4.Level, data4.EXP, data4.RequiredEXP)
	local succ2, err2 = pcall(function()
		Leveling:SetAsync(ID, data4)
	end)
	if succ2 then
		print("Saved Level Data!")
	else
		print("Got an error!")
		warn(err2)
	end
	
end)

game.ReplicatedStorage.Remotes.MuteMusic.OnServerEvent:Connect(function(player)
	player.Backpack.Settings.MuteMusic.Value = true
end)
game.ReplicatedStorage.Remotes.MuteMusic.UnMuteMusic.OnServerEvent:Connect(function(player)
	player.Backpack.Settings.MuteMusic.Value = false
end)

game.ReplicatedStorage.Remotes.MuteUI.OnServerEvent:Connect(function(player)
	player.Backpack.Settings.MuteUI.Value = true
end)
game.ReplicatedStorage.Remotes.MuteUI.UnMuteUI.OnServerEvent:Connect(function(player)
	player.Backpack.Settings.MuteUI.Value = false
end)

--// CHECKING IF PLAYER HAS SOUNDS MUTED \\--

game.Players.PlayerAdded:Connect(function(player)
	print(player.Name.." joined, waiting 3 seconds before setting up.")
	wait(3)
	print("Setting Settings.")
	if player.PlayerGui.Menu.Enabled == false then
		player.PlayerGui.Menu.Enabled = true
		player.PlayerGui.Menu.Main.Visible = false
		player.PlayerGui.Menu.Settings.Visible = false
		player.PlayerGui.Menu.PerksTab.Visible = false
	end
	if player.PlayerGui.Menu.Main.Visible == true or player.PlayerGui.Menu.Settings.Visible == true or player.PlayerGui.Menu.PerksTab.Visible == true and player.PlayerGui.Menu.Enabled == true then
		player.PlayerGui.Menu.Main.Visible = false
		player.PlayerGui.Menu.Settings.Visible = false
		player.PlayerGui.Menu.PerksTab.Visible = false
	end
	if player.Backpack:WaitForChild("Settings", 100).MuteMusic.Value == true then
		for i, v in pairs(game.Workspace.Sounds.Music:GetChildren()) do
			if v:IsA("Sound") then
				v.Volume = 0
				print(v.Name.."'s volume set to 0.")
			end
		end
		player.PlayerGui.Menu.Settings.MusicMuted.Text = "Music Muted: True"
		
	end
	if player.Backpack:WaitForChild("Settings", 100).MuteUI.Value == true then
		game.Workspace.Sounds.MenuSelect.Volume = 0
		game.Workspace.Sounds.MenuHover.Volume = 0
		print("UI sound set to 0.")
		player.PlayerGui.Menu.Settings.UIMuted.Text = "UI Muted: True"
	end
	if player.Backpack:WaitForChild("Settings", 100).GSEnabled.Value == true then
		game.ReplicatedStorage.Remotes.UpdateGS:FireClient(player)
	end
	print("Settings Set.")
	player.PlayerGui.Menu.PerksTab.Skillpoints.Text = "Skill Points: "..player.Backpack.Settings.PerkSettings.Skillpoints.Value
end)

game.ReplicatedStorage.Remotes.PurchaseSkillPoint.OnServerEvent:Connect(function(p, Type, Level, Cost)
	print(Type, Level, Cost)
	local perks = p.Backpack.Settings.PerkSettings
	if Type == "Gas" then
		perks.Perks.MoreGas.Value = true
		perks.Perks.MoreGas.Level.Value = Level
		perks.Skillpoints.Value -= Cost
	end
	if Type == "Blades" then
		perks.Perks.MoreDurability.Value = true
		perks.Perks.MoreDurability.Level.Value = Level
		perks.Skillpoints.Value -= Cost
	end
	if Type == "Stock" then
		perks.Perks.MoreBlades.Value = true
		perks.Perks.MoreBlades.Level.Value = Level
		perks.Skillpoints.Value -= Cost
	end
	if Type == "Thunder" then
		perks.Perks.Thunder.Value = true
		perks.Perks.Thunder.Level.Value = Level
		perks.Skillpoints.Value -= Cost
	end
end)

game.ReplicatedStorage.Remotes.SaveData.OnServerEvent:Connect(function(player)
	print(player.Name, player.UserId)
	local perks = player.Backpack:WaitForChild("Settings"):WaitForChild("PerkSettings")
	local ID = "Player_"..player.UserId
	local data3 = {
		SkillPoints = player.Backpack.Settings.PerkSettings.Skillpoints.Value,
		SkillPoints_MoreGas = player.Backpack.Settings.PerkSettings.Perks.MoreGas.Level.Value,
		SkillPoints_MoreGasBought = player.Backpack.Settings.PerkSettings.Perks.MoreGas.Value,
		SkillPoints_MoreDurability = player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value,
		SkillPoints_MoreDurabilityBought = player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Value,
		SkillPoints_MoreBlades = player.Backpack.Settings.PerkSettings.Perks.MoreBlades.Level.Value,
		SkillPoints_MoreBladesBought = player.Backpack.Settings.PerkSettings.Perks.MoreBlades.Value,
		SkillPoints_Thunder = perks.Perks.Thunder.Level.Value,
		SkillPoints_ThunderBought = perks.Perks.Thunder.Value;
	}
	local succ1, err1 = pcall(function()
		SkillPoints:SetAsync(ID, data3)
	end)
	if succ1 then
		print("Data saved! - SkillPoints")
	else
		print("Error found!")
		warn(err1)
	end
	local data = {
		Level = player.Backpack.Settings.Level.Level.Value,
		EXP = player.Backpack.Settings.Level.EXP.Value,
		RequiredEXP = player.Backpack.Settings.Level.RequiredEXP.Value;
	}
	local succ2, err2 = pcall(function()
		Leveling:SetAsync(ID, data)
	end)
	if succ2 then
		print("Saved.")
	else
		print("Error!")
		warn(err2)
	end
end)

game.ReplicatedStorage.Remotes.UpdateEXPorLevel.OnServerEvent:Connect(function(player)
	print(player.Name.." Level Up.")
	local ID = "Player_"..player.UserId
	local EXP = player.Backpack.Settings.Level.EXP
	local REXP = player.Backpack.Settings.Level.RequiredEXP
	local LVL = player.Backpack.Settings.Level.Level
	if EXP.Value >= REXP.Value then
		EXP.Value = 0
		REXP.Value = REXP.Value+100
		LVL.Value = LVL.Value+1
		player.Backpack.Settings.PerkSettings.Skillpoints.Value += 1
		wait()
		game.ReplicatedStorage.GUIRemotes.Notification.SendNotification:FireClient(player, "Level Notification!", "You have leveled up to Level: "..LVL.Value.."! You have: "..player.Backpack.Settings.PerkSettings.Skillpoints.Value.." unspent Skill points!", 7)
		print("Level: "..LVL.Value.." EXP/RemainingEXP: "..EXP.Value.."/"..REXP.Value)
		game.ReplicatedStorage.Remotes.UpdateEXPorLevel:FireClient(player)
	end
	wait()
	local data = {
		Level = player.Backpack.Settings.Level.Level.Value,
		EXP = player.Backpack.Settings.Level.EXP.Value,
		RequiredEXP = player.Backpack.Settings.Level.RequiredEXP.Value;
	}
	local succ2, err2 = pcall(function()
		Leveling:SetAsync(ID, data)
	end)
	if succ2 then
		print("Saved Leveling Data..")
	else
		print("Error!")
		warn(err2)
	end
end)
