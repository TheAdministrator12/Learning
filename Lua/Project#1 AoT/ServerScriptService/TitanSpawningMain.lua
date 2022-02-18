   --//                  SERVER SCRIPT                   \\--
----// HANDLES TITAN SPAWNING IN GAME USING THE ADMIN GUI \\----

local titans = game.ReplicatedStorage:WaitForChild("Titans"):GetChildren()
local lastspawn;

game.Players.PlayerAdded:Connect(function(player)
	while wait(3) do
		game.Players.PlayerRemoving:Connect(function(p)
			if p.Name == player.Name then
				return
			end
		end)
		player.PlayerGui.Menu.PerksTab.Skillpoints.Text = "Skill Points: "..player.Backpack.Settings.PerkSettings.Skillpoints.Value
	end
	
	
end)

game.ReplicatedStorage.Remotes.StartTitans.OnServerEvent:Connect(function(p)
	print("Titans spawning Enabled!")
	script.TitanSpawner.Disabled = false
	print(script.TitanSpawner.Disabled)
	
end)
game.ReplicatedStorage.Remotes.StopTitans.OnServerEvent:Connect(function(p)
	print("Titans spawning Disabled")
	script.TitanSpawner.Disabled = true
	print(script.TitanSpawner.Disabled)
end)

game.ReplicatedStorage.Remotes.ForceAbnormal.onServerEvent:Connect(function(p, amount)
	print(amount)
	local i = amount
	repeat
		wait(1)
		local tospawn = titans[1]
		local clone = tospawn:Clone()
		local spawnpoint = game.Workspace:WaitForChild("Spawnpoints"):GetChildren()
		local spawnplatform = math.random(1, #spawnpoint)
		if lastspawn ~= nil and lastspawn ~= spawnplatform then
			local position = spawnpoint[spawnplatform].CFrame
			print(spawnplatform)
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
			lastspawn = spawnplatform
			i -= 1
		else
			local spwnpltfrm = math.random(1, #spawnpoint)
			local position = spawnpoint[spwnpltfrm].CFrame
			print(spwnpltfrm)
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
			i -= 1
		end
		
	until i == 0
		
end)

game.ReplicatedStorage.Remotes.ForceMindless.onServerEvent:Connect(function(p, amount)
	print(amount)
	local i = amount
	repeat
		wait(1)
		local tospawn = titans[2]
		local clone = tospawn:Clone()
		local spawnpoint = game.Workspace:WaitForChild("Spawnpoints"):GetChildren()
		local spawnplatform = math.random(1, #spawnpoint)
		if lastspawn ~= nil and lastspawn ~= spawnplatform then
			local position = spawnpoint[spawnplatform].CFrame
			print(spawnplatform)
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
			lastspawn = spawnplatform
			i -= 1
		else
			local spwnpltfrm = math.random(1, #spawnpoint)
			local position = spawnpoint[spwnpltfrm].CFrame
			print(spwnpltfrm)
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
			i -= 1
		end
	until i == 0
end)

game.ReplicatedStorage.Remotes.ForceCrawler.onServerEvent:Connect(function(p, amount)
	print(amount)
	local i = amount
	repeat
		wait(1)
		local tospawn = titans[3]
		local clone = tospawn:Clone()
		local spawnpoint = game.Workspace:WaitForChild("Spawnpoints"):GetChildren()
		local spawnplatform = math.random(1, #spawnpoint)
		if lastspawn ~= nil and lastspawn ~= spawnplatform then
			local position = spawnpoint[spawnplatform].CFrame
			print(spawnplatform)
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
			lastspawn = spawnplatform
			i -= 1
		else
			local spwnpltfrm = math.random(1, #spawnpoint)
			local position = spawnpoint[spwnpltfrm].CFrame
			print(spwnpltfrm)
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
			i -= 1
		end
	until i == 0
end)

game.ReplicatedStorage.Remotes.ForceDummy.onServerEvent:Connect(function(p, amount)
	print(amount)
	local i = amount
	repeat
		wait(1)
		local tospawn = titans[4]
		local clone = tospawn:Clone()
		local spawnpoint = game.Workspace:WaitForChild("Spawnpoints"):GetChildren()
		local spawnplatform = math.random(1, #spawnpoint)
		if lastspawn ~= nil and lastspawn ~= spawnplatform then
			local position = spawnpoint[spawnplatform].CFrame
			print(spawnplatform)
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
			lastspawn = spawnplatform
			i -= 1
		else
			local spwnpltfrm = math.random(1, #spawnpoint)
			local position = spawnpoint[spwnpltfrm].CFrame
			print(spwnpltfrm)
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
			i -= 1
		end
	until i == 0
end)
