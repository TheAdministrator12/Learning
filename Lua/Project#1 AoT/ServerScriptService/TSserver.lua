   --// SERVER SCRIPT \\--
----// HANDLES ROCKETS \\----

local event = game.ReplicatedStorage.TS
local Debris = game:GetService("Debris")
tss= game:GetService("TweenService")

local ignore = {"exp", "HumanoidRootPart"}

info = TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0)
local g1 = {Size = Vector3.new(60,60,60)}
speed = 250
info3 = TweenInfo.new(2, Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0)
g5 = {Orientation = Vector3.new(30,0,180)}



event.OnServerEvent:Connect(function(plr, mouse)
	local maxdist = 50
	local dist = 0
	local tsF = Instance.new("Folder", workspace)
	tsF.Name = plr.Name.."Folder"
	Debris:AddItem(tsF, 5)
	
	local ts = script.Meshes:WaitForChild("TS"):Clone()
	ts.CFrame = CFrame.new((plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,5)).p,mouse.p)
	ts.Orientation = Vector3.new(mouse.lookVector.X, mouse.lookVector.Y, mouse.lookVector.Z)
	ts.Parent = tsF
	
	local bv = Instance.new("BodyVelocity", ts)
	bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	bv.Velocity = mouse.lookVector * speed
	
	local bg = Instance.new("BodyGyro", ts)
	bg.CFrame = mouse
	bg.MaxTorque = Vector3.new(30000,30000,30000)
	bg.P = 30000
	local exp = script.Meshes.exp:Clone()
	
	ts.Touched:Connect(function(hit)
		exp.Parent = tsF
		exp.CFrame = ts.CFrame
		exp.Anchored = true
		ts:Destroy()
		local eff = tss:Create(exp,info,g1)
		local eff2 = tss:Create(exp,info3,g5)
		eff:Play()
		eff2:Play()
		wait(3)
		local g2 = {Transparency = 1}
		local info2 = TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0)
		local diss = tss:Create(exp,info2,g2)
		diss:Play()
		wait(0.5)
		exp:Destroy()
	end)
	exp.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") then
			if hit.Parent.Name == "Titans" or hit.Parent.Parent.Name == "Titans" or hit.Parent.Name == "Dummy" then
				hit.Parent.Killer.Value = plr.Name
			end
				hit.Parent.Humanoid:TakeDamage(math.huge)
		end
	end)
	while wait(0.01) do
		print(dist)
		dist += 1
		if dist >= maxdist then
			exp.Parent = tsF
			exp.CFrame = ts.CFrame
			exp.Anchored = true
			ts:Destroy()
			local eff = tss:Create(exp,info,g1)
			local eff2 = tss:Create(exp,info3,g5)
			eff:Play()
			eff2:Play()
			wait(3)
			local g2 = {Transparency = 1}
			local info2 = TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0)
			local diss = tss:Create(exp,info2,g2)
			diss:Play()
			wait(0.5)
			exp:Destroy()
		end
	end
end)
