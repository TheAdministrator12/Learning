   --//         SERVER SCRIPT [Disabled]         \\--
----// ENABLES RANDOM SPAWNING FROM THE ADMIN GUI \\----

local titans = game.ReplicatedStorage:WaitForChild("Titans"):GetChildren()
local titanN

while true do
	local rng = math.random(30, 60)
	local ammount = math.random(1, 3)
	local i = 0;
	while i < ammount do
		local spawnpoint = game.Workspace:WaitForChild("Spawnpoints"):GetChildren()
		local randomness = math.random(1, 50)
		local spawnplatform = math.random(1, #spawnpoint)
		print("Time: ", rng)
		titanN = math.random(1, #titans)
		print("Titan: ", titanN)
		if titanN == 3 then
			if randomness < 10 then
				
				local tospawn = titans[3]
				local position = spawnpoint[spawnplatform].CFrame
				print("Spawning Crawler.")
				local clone = tospawn:Clone()
				clone.Parent = workspace.Titans
				clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
				
			elseif randomness >= 10 and randomness < 30 then
				
				local tospawn = titans[2]
				local position = spawnpoint[spawnplatform].CFrame
				print("Spawning Mindless.")
				local clone = tospawn:Clone()
				clone.Parent = workspace.Titans
				clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
				
			elseif randomness >= 30 then
				
				local tospawn = titans[1]
				local position = spawnpoint[spawnplatform].CFrame
				print("Spawning Abnormal.")
				local clone = tospawn:Clone()
				clone.Parent = workspace.Titans
				clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)
				
			end
			
		elseif randomness >= 1 and randomness < 30 then

			local tospawn = titans[2]
			local position = spawnpoint[spawnplatform].CFrame
			print("Spawning Mindless.")
			local clone = tospawn:Clone()
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)

		elseif randomness >= 30 then

			local tospawn = titans[1]
			local position = spawnpoint[spawnplatform].CFrame
			print("Spawning Abnormal.")
			local clone = tospawn:Clone()
			clone.Parent = workspace.Titans
			clone.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y+5, position.Z)

			
		end

		i = i+1
	end
  
	wait(rng)
end
