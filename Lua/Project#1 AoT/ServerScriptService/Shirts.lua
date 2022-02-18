   --//              SERVER SCRIPT             \\--
----// CUSTOM SHIRT SETUP AND SOME DATA LOADING \\----

local DSS = game:GetService("DataStoreService")
local SkillPoints = DSS:GetDataStore("SkillPoints")
local Leveling = DSS:GetDataStore("Leveling")
local API = require(script.Parent.TrelloStuff.TrelloAPI)

game.Players.PlayerAdded:Connect(function(player)
	print(player.Name, " Joined!")
	if player.Character or player.CharacterAdded:Wait() then
		local character = player.Character
		print(character.Name, " Character Found!")
		wait(game.Players.RespawnTime)
		local shirt = character:WaitForChild("Shirt", 100)
		local pants = character:WaitForChild("Pants", 100)
		if shirt and pants then
			print(player.Name, " character Set up!")
			shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=2152121028"
			pants.PantsTemplate = "http://www.roblox.com/asset/?id=2151988427"
			if game.Players[character.Name].UserId == 357829043 then
				print("GodGamer331 character Set up!")
				shirt:Destroy()
				pants:Destroy()
				game.ReplicatedStorage.ToCopyFrom.Shirt:Clone().Parent = character
				game.ReplicatedStorage.ToCopyFrom.Pants:Clone().Parent = character				
			end
			if game.Players[character.Name].UserId == 178849946 then
				print("BriefLukasslenderman character Set up!")
				shirt:Destroy()
				pants:Destroy()
				game.ReplicatedStorage.ToCopyFrom2.Shirt:Clone().Parent = character
				game.ReplicatedStorage.ToCopyFrom2.Pants:Clone().Parent = character				
			end

			for i, v in pairs(character:getChildren()) do
				if v:IsA("Accessory") then
					local hair = v.Handle:FindFirstChild("HairAttachment")
					if not hair then
						v:Destroy()
					end
				end
			end
		end
	end
	while wait(1) do
		player.CharacterAdded:Connect(function()
			local character = player.Character
			local shirt = character:WaitForChild("Shirt", 100)
			local pants = character:WaitForChild("Pants", 100)

			local uID = "Player_"..player.UserId
			local data4
			local succ2, err2 = pcall(function()
				data4 = Leveling:GetAsync(uID)
			end)
			player.Backpack:WaitForChild("Settings", 100).Level.Level.Value = data4.Level
			player.Backpack:WaitForChild("Settings", 100).Level.EXP.Value = data4.EXP
			player.Backpack:WaitForChild("Settings", 100).Level.RequiredEXP.Value = data4.RequiredEXP

			local data3
			local succ1, err1 = pcall(function()
				data3 = SkillPoints:GetAsync(uID)
			end)
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Skillpoints.Value = data3.SkillPoints
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Level.Value = data3.SkillPoints_MoreGas
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Level.Value = data3.SkillPoints_MoreDurability
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Value = data3.SkillPoints_MoreGasBought
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Value = data3.SkillPoints_MoreDurabilityBought
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Value = data3.SkillPoints_MoreBladesBought
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Level.Value = data3.SkillPoints_MoreBlades
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Value = data3.SkillPoints_ThunderBought
			player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Level.Value = data3.SkillPoints_Thunder

			if game.Players[character.Name].UserId == 357829043 then
				shirt:Destroy()
				pants:Destroy()
				wait()
				if character:FindFirstChild("Shirt") and character:FindFirstChild("Pants") then
					return
				end
				game.ReplicatedStorage.ToCopyFrom.Shirt:Clone().Parent = character
				game.ReplicatedStorage.ToCopyFrom.Pants:Clone().Parent = character
				print("GodGamer331 character reseted!")
			elseif game.Players[character.Name].UserId == 178849946 then
				print("BriefLukasslenderman character Set up!")
				shirt:Destroy()
				pants:Destroy()
				wait()
				if character:FindFirstChild("Shirt") and character:FindFirstChild("Pants") then
					return
				end
				game.ReplicatedStorage.ToCopyFrom2.Shirt:Clone().Parent = character
				game.ReplicatedStorage.ToCopyFrom2.Pants:Clone().Parent = character				
			else
				if character.Shirt and character.Pants then
					character.Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=2152121028"
					character.Pants.PantsTemplate = "http://www.roblox.com/asset/?id=2151988427"
				end
				wait()
				print(player.Name, " character reseted!")
				shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=2152121028"
				pants.PantsTemplate = "http://www.roblox.com/asset/?id=2151988427"
			end
			wait(1)
			for i, v in pairs(character:getChildren()) do
				if v:IsA("Accessory") then
					local hair = v.Handle:FindFirstChild("HairAttachment")
					if not hair then
						print("Removed ", v.Name)
						v:Destroy()
					end
				end
			end
		end)
	end
end)

game.ReplicatedStorage.Remotes.OnDeath.OnServerEvent:Connect(function(player)
	wait(player.CharacterAdded:Wait())
	local character = player.Character
	local shirt = character:WaitForChild("Shirt", 100)
	local pants = character:WaitForChild("Pants", 100)
	
	local uID = "Player_"..player.UserId
	local data4
	local succ2, err2 = pcall(function()
		data4 = Leveling:GetAsync(uID)
	end)
	player.Backpack:WaitForChild("Settings", 100).Level.Level.Value = data4.Level
	player.Backpack:WaitForChild("Settings", 100).Level.EXP.Value = data4.EXP
	player.Backpack:WaitForChild("Settings", 100).Level.RequiredEXP.Value = data4.RequiredEXP
	
	local data3
	local succ1, err1 = pcall(function()
		data3 = SkillPoints:GetAsync(uID)
	end)
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Skillpoints.Value = data3.SkillPoints
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Level.Value = data3.SkillPoints_MoreGas
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Level.Value = data3.SkillPoints_MoreDurability
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreGas.Value = data3.SkillPoints_MoreGasBought
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreDurability.Value = data3.SkillPoints_MoreDurabilityBought
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Value = data3.SkillPoints_MoreBladesBought
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.MoreBlades.Level.Value = data3.SkillPoints_MoreBlades
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Value = data3.SkillPoints_ThunderBought
	player.Backpack:WaitForChild("Settings", 100).PerkSettings.Perks.Thunder.Level.Value = data3.SkillPoints_Thunder
	
	if game.Players[character.Name].UserId == 357829043 then
		shirt:Destroy()
		pants:Destroy()
		if character:FindFirstChild("Shirt") and character:FindFirstChild("Pants") then
			return
		end
		game.ReplicatedStorage.ToCopyFrom.Shirt:Clone().Parent = character
		game.ReplicatedStorage.ToCopyFrom.Pants:Clone().Parent = character
		print("GodGamer331 character reseted!")
	elseif game.Players[character.Name].UserId == 178849946 then
		print("BriefLukasslenderman character Set up!")
		shirt:Destroy()
		pants:Destroy()
		if character:FindFirstChild("Shirt") and character:FindFirstChild("Pants") then
			return
		end
		game.ReplicatedStorage.ToCopyFrom2.Shirt:Clone().Parent = character
		game.ReplicatedStorage.ToCopyFrom2.Pants:Clone().Parent = character				
	else
		print(player.Name, " character reseted!")
		shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=2152121028"
		pants.PantsTemplate = "http://www.roblox.com/asset/?id=2151988427"
	end
	wait(1)
	for i, v in pairs(character:getChildren()) do
		if v:IsA("Accessory") then
			local hair = v.Handle:FindFirstChild("HairAttachment")
			if not hair then
				print("Removed ", v.Name)
				v:Destroy()
			end
		end
	end
end)
