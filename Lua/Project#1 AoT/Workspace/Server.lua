    --// SERVER SCRIPT  \\--
-----// GEAR FUNCTIONING \\----


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Folder = script.Parent.Events
local ODMGEvent = Folder:WaitForChild("EquipODMG")
local ReloadEvent = Folder:WaitForChild("BladeReload")
local BreakBlades = Folder:WaitForChild("BreakBlades")
local DropBlades = Folder:WaitForChild("DropBlades")
local AttackingEvent = Folder:WaitForChild("AttackingEvent")

local Blades = false

ODMGEvent.OnServerEvent:connect(function(player)
	local EquipOMDG = player.Character.Humanoid:LoadAnimation(script.EquipODMG)
	EquipOMDG:Play()
    player.Character.Humanoid.WalkSpeed = 0
    player.Character.Humanoid.JumpPower = 0

	for a, p in ipairs(game.ReplicatedStorage.StarterCharacter2.Welds["Left Container"]:GetChildren()) do
		if p:isA("Part") or p:isA("BasePart") then
		local part = p:clone()
			part.Anchored = false
			part.CanCollide = false
			part.Parent = player.Character["Left Leg"]
			local weld = Instance.new("Weld",part)
			weld.Part0 = player.Character["Left Leg"]
			weld.Part1 = part
			weld.C1 = p.CFrame:inverse()*game.ReplicatedStorage.StarterCharacter2["Left Leg"].CFrame
		end
	end
	
	for a, p in ipairs(game.ReplicatedStorage.StarterCharacter2.Welds["3DMG"]:GetChildren()) do
		if p:isA("Part") or p:isA("BasePart") then
			local part = p:clone()
			part.Anchored = false
			part.CanCollide = false
			part.Parent = player.Character["Torso"]
			local weld = Instance.new("Weld",part)
			weld.Part0 = player.Character["Torso"]
			weld.Part1 = part
			weld.C1 = p.CFrame:inverse()*game.ReplicatedStorage.StarterCharacter2["Torso"].CFrame
		end
	end
	
	for a, p in ipairs(game.ReplicatedStorage.StarterCharacter2.Welds["Right Container"]:GetChildren()) do
		if p:isA("Part") or p:isA("BasePart") then
			local part = p:clone()
			part.Anchored = false
			part.CanCollide = false
			part.Parent = player.Character["Right Leg"]
			local weld = Instance.new("Weld",part)
			weld.Part0 = player.Character["Right Leg"]
			weld.Part1 = part
			weld.C1 = p.CFrame:inverse()*game.ReplicatedStorage.StarterCharacter2["Right Leg"].CFrame
		end
	end
	
	for a, p in ipairs(game.ReplicatedStorage.StarterCharacter2.Welds["Right Blade"]:GetChildren()) do
		if p:isA("Part") or p:isA("BasePart") then
			local part = p:clone()
			part.Anchored = false
			part.CanCollide = false
			part.Parent = player.Character["Right Arm"]
			local weld = Instance.new("Weld",part)
			weld.Part0 = player.Character["Right Arm"]
			weld.Part1 = part
			weld.C1 = p.CFrame:inverse()*game.ReplicatedStorage.StarterCharacter2["Right Arm"].CFrame
		end
	end
	
	for a, p in ipairs(game.ReplicatedStorage.StarterCharacter2.Welds["Left Blade"]:GetChildren()) do
		if p:isA("Part") or p:isA("BasePart") then
			local part = p:clone()
			part.Anchored = false
			part.CanCollide = false
			part.Parent = player.Character["Left Arm"]
			local weld = Instance.new("Weld",part)
			weld.Part0 = player.Character["Left Arm"]
			weld.Part1 = part
			weld.C1 = p.CFrame:inverse()*game.ReplicatedStorage.StarterCharacter2["Left Arm"].CFrame
		end
		
	local leftBlade = player.Character["Left Arm"]:waitForChild("Blade")
	local rightBlade = player.Character["Right Arm"]:waitForChild("Blade")
	
	rightBlade.Transparency = 1
	leftBlade.Transparency = 1
	
	player.Character.Humanoid.WalkSpeed = 16
	player.Character.Humanoid.JumpPower = 65
	wait()
	rightBlade.Transparency = 1
	leftBlade.Transparency = 1
	end
end)





ReloadEvent.OnServerEvent:Connect(function(player)
	if Blades == true then return end
	
	local leftBlade = player.Character["Left Arm"]:waitForChild("Blade")
    local rightBlade = player.Character["Right Arm"]:waitForChild("Blade")

    rightBlade.Transparency = 0
    leftBlade.Transparency = 0 
    Blades = true

    local a = Instance.new("Sound")
    a.SoundId = "http://www.roblox.com/asset/?id=130785405"
    a.Volume = 1
    a.Pitch = 2
    a.MaxDistance = 50
    a.Parent = player.Character.HumanoidRootPart
    a:play()
    game.Debris:AddItem(a,0.5)
end)


BreakBlades.OnServerEvent:connect(function(player)
	if Blades == true then
	local leftBlade = player.Character["Left Arm"]:waitForChild("Blade")
    local rightBlade = player.Character["Right Arm"]:waitForChild("Blade")
    local RClone = game.ReplicatedStorage.StarterCharacter2.Welds["Right Blade"].Blade:Clone()
    RClone.CanCollide = true
    RClone.Parent = game.Workspace
	RClone.Anchored = false
	RClone.CFrame = rightBlade.CFrame
	local LClone = game.ReplicatedStorage.StarterCharacter2.Welds["Left Blade"].Blade:Clone()
    LClone.CanCollide = true
    LClone.Parent = game.Workspace
	LClone.Anchored = false
	LClone.CFrame = leftBlade.CFrame
	rightBlade.Transparency = 1
	leftBlade.Transparency = 1
		
		
	local a = Instance.new("Sound")
		a.SoundId = "rbxassetid://3447686238"
    a.Volume = 1
    a.Pitch = 2
    a.MaxDistance = 50
    a.Parent = player.Character.HumanoidRootPart
    a:play()
    game.Debris:AddItem(RClone, 2)
    game.Debris:AddItem(LClone, 2)
    wait(.25)
	Blades = false
		
		
end
end)


DropBlades.OnServerEvent:Connect(function(player)
	if Blades == true then
		local leftBlade = player.Character["Left Arm"]:waitForChild("Blade")
	    local rightBlade = player.Character["Right Arm"]:waitForChild("Blade")
	
	    local RClone = game.ReplicatedStorage.StarterCharacter2.Welds["Right Blade"].Blade:Clone()
	
	    RClone.CanCollide = true
	    RClone.Parent = game.Workspace
		RClone.Anchored = false
		RClone.CFrame = rightBlade.CFrame
		
		local LClone = game.ReplicatedStorage.StarterCharacter2.Welds["Left Blade"].Blade:Clone()
		
	    LClone.CanCollide = true
	    LClone.Parent = game.Workspace
		LClone.Anchored = false
		LClone.CFrame = leftBlade.CFrame
		
		RClone.Transparency = 1
		LClone.Transparency = 1

		rightBlade.Transparency = 1
	    leftBlade.Transparency = 1
	
	 
	    wait(0.1)
	    Blades = false
	end
end)






AttackingEvent.OnServerEvent:Connect(function(player, hit)
	local attacking = false
	local leftBlade = player.Character["Left Arm"]:waitForChild("Blade")
	local rightBlade = player.Character["Right Arm"]:waitForChild("Blade")
	local leftTrail = player.Character["Left Arm"]:waitForChild("Blade"):WaitForChild("BladeTrail")
	local rightTrail = player.Character["Right Arm"]:waitForChild("Blade"):WaitForChild("BladeTrail")
	local a = Instance.new("Sound")
	a.SoundId = "http://www.roblox.com/asset/?id=210946558"
	a.Volume = 1
	a.Pitch = math.random(1)
	a.Parent = player.Character.HumanoidRootPart
	    a:play()
	local chance = math.random(1,20)
	local blade = leftBlade or rightBlade
	   local attacking = false
	leftTrail.Enabled = true
	rightTrail.Enabled = true
	leftBlade.Material = Enum.Material.Neon
	rightBlade.Material = Enum.Material.Neon
	blade.Touched:Connect(function(hit)
		if hit.Parent.Name == "Dummy" then
			hit.Parent.Killer.Value = player.Name
		end
		if hit.Parent.Name == "QuestNPC" then
			return nil
		end
		if hit.Parent:findFirstChild("Humanoid") and hit.Parent.Name ~= player.Name then
			if not attacking and not hit.Parent:findFirstChild("Nape") and not hit.Parent:findFirstChild("Ragdoller") then
				attacking = true
				hit.Parent.Humanoid:TakeDamage(25)
				BreakBlades:FireClient(player)
				if hit.Parent:findFirstChild("Killer") and hit.Parent:findFirstChild("Assist") and not nil then
					hit.Parent.Killer.Value = player.Name
					if hit.Parent.Assist.Value == "" or hit.Parent.Assist.Value == nil or hit.Parent.Assist.Value == " " then
						hit.Parent.Assist.Value = player.Name
					else
						local cd = 3
						repeat
							if cd == 0 then
								hit.Parent.Assist.Value = player.Name
							end
							wait(1)
							cd -= 1
						until cd == 0
						
					end
					print(player.Name, hit.Parent.Name)
				end
			end
		end
		
		if hit.Name == "Nape" and not attacking then
			attacking = true
			local hitv = Instance.new("ObjectValue")
			hitv.Name = "HitRequest"
			hitv.Value = player
			if hit.Parent.Parent:FindFirstChild("Player") then
				if hit.Blocking.Value == true or hit.Hardened.Value == true then
					return
				end
				game.ReplicatedStorage.ShiftRemotes.Blind:FireClient(game.Players[hit.Parent.Parent.Player.Value])
			end
			hit.Parent:findFirstChildOfClass("Humanoid"):TakeDamage(50000)
			BreakBlades:FireClient(player)
		end

		if hit.Name == "Eye" and not attacking then
			attacking = true
			local hitv = Instance.new("ObjectValue")
			hitv.Name = "HitRequest"
			hitv.Value = player

			for i,v in pairs(hit.Parent.Humanoid:GetPlayingAnimationTracks())do
				v:Stop()
			end
			local t = hit.Parent:findFirstChild("Animations").Blind

			local track = hit.Parent.Humanoid:LoadAnimation(t)
			track:Play()


			hit.Parent.Humanoid.WalkSpeed = 0
			hit.Parent.Humanoid.JumpPower = 0

			hit.Parent.Values.isStunned.Value = true

			BreakBlades:FireClient(player)

			wait(10)

			hit.Parent.Values.isStunned.Value = false


			hit.Parent.Humanoid.WalkSpeed = 16
			hit.Parent.Humanoid.JumpPower = 50


			track:Stop()
		end

		if hit.Name == "Tendon" and not attacking then
			attacking = true
			local hitv = Instance.new("ObjectValue")
			hitv.Name = "HitRequest"
			hitv.Value = player

			for i,v in pairs(hit.Parent.Humanoid:GetPlayingAnimationTracks())do
				v:Stop()
			end
			local t = hit.Parent:findFirstChild("Animations").Drop

			local track = hit.Parent.Humanoid:LoadAnimation(t)
			track:Play()

			print("hit")

			hit.Parent.Humanoid.WalkSpeed = 0
			hit.Parent.Humanoid.JumpPower = 0

			hit.Parent.Values.isStunned.Value = true

			BreakBlades:FireClient(player)

			wait(10)

			hit.Parent.Values.isStunned.Value = false


			hit.Parent.Humanoid.WalkSpeed = 16
			hit.Parent.Humanoid.JumpPower = 50


			track:Stop()
		end
		end)
	wait(1)
	leftTrail.Enabled = false
	rightTrail.Enabled = false
	leftBlade.Material = Enum.Material.Metal
	rightBlade.Material = Enum.Material.Metal
	attacking = true
end)
	
