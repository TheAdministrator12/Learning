--// LOCAL SCRIPT \\--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Folder = script:WaitForChild("Events")
local ODMGEvent = Folder:WaitForChild("EquipODMG")
local ReloadEvent = Folder:WaitForChild("BladeReload")
local DropBlades = Folder:WaitForChild("DropBlades")
local BreakBlades = Folder:WaitForChild("BreakBlades")
local AttackingEvent = Folder:WaitForChild("AttackingEvent")
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local grefillers = workspace:WaitForChild("gasRefillers")
local brefillers = workspace:WaitForChild("bladeRefill")
local Mouse = Player:GetMouse()
local UserInputService = game:GetService("UserInputService")

local canOpen = true

local bladesstock = brefillers.BladeRefiller.BladesPart.BladesLeft.Value
local bladebroke = true
local GasRefill = ReplicatedStorage:WaitForChild("GasRefill")
local BladeRefill = ReplicatedStorage:WaitForChild("BladeRefill")
ODMGEvent:FireServer()
local canReload = true

wait(.1)

if game.Players.LocalPlayer.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value >= 3 then
	script.Config.Durability.Value = 20
elseif game.Players.LocalPlayer.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value == 2 then
	script.Config.Durability.Value = 15
elseif game.Players.LocalPlayer.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value == 1 then
	script.Config.Durability.Value = 12
else
	script.Config.Durability.Value = 10
end

local Durability = script.Config.Durability.Value
local Speed = script.Config.Speed.Value
local GasLeft = script.Config.GasLeft.Value 
local BladesLeft = script.Config.BladesLeft.Value

local Blades = false

local mouse = Player:GetMouse()

local canAttack = false
local attackDebounce = false
local leftBlade = Character["Left Arm"]:waitForChild("Blade")
local rightBlade = Character["Right Arm"]:waitForChild("Blade")

local BladesGui = script.BladeGui:Clone()
BladesGui.Parent = Player.PlayerGui
local TextL = BladesGui.TextLabel
TextL.Text = "Blades remaining   "..BladesLeft

local GasGui = script.GasGui:Clone()
GasGui.Parent = Player.PlayerGui
local TextLa = GasGui.TextLabel
TextLa.Text = "Gas: "..GasLeft

local DurabGui = script.BladeDurabilityGui:Clone()
DurabGui.Parent = Player.PlayerGui
local TextLs = DurabGui.TextLabel
TextLs.Text = "Blade Durability: "..Durability.."/10"

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local cannotGrappleon = {
	Baseplate = nil,
	['Torso'] = nil,
	['Right Arm'] = nil,
	['Right Leg'] = nil,
	['Left Arm'] = nil,
	['Left Leg'] = nil,
	Hill1 = nil,
	Hill2 = nil,
	Hill3 = nil,
	Hill4 = nil,
	Hill5 = nil,
	Hill = nil,
	ground = nil,
	path = nil,
	flat = nil,
	BasePlate = nil,
	["Precip"..player.Name] = true,
}

local hatsfixed = {}

local function UpdateGas()
	local formula = GasLeft/1000
	GasGui.ImageLabel.FillArea.Count:TweenSize(UDim2.new(formula, 0, 1, 0))
end
local function UpdateDurab()
	local formula = Durability/20
	DurabGui.MainFrame.Count.Size = UDim2.new(.144,0,-formula,0)
	DurabGui.MainFrame.Count2.Size = UDim2.new(.144,0,-formula,0)
end

UpdateDurab()
UpdateGas()

local hatsfixed = {}

local function MassUpdate(child)
	if child then if child:IsA("StringValue") then return end end
	for n,i in pairs(hatsfixed) do if i == child then return end end
	local Mass = 0
	for n,i in pairs(Character:GetChildren()) do
		if i:IsA("Part") then
			Mass = Mass + i:GetMass()
		elseif i:IsA("Hat") then
			hatsfixed[#hatsfixed+1] = i
			i.Parent = game.Lighting
			i.Handle.FormFactor = "Custom"
			i.Handle.Size = Vector3.new(.2,.2,.2)
			i.Parent = Character
		end
	end
end

local Stalling = false
local StallingDistance = 0
local StallingDirectionDown = false
local StallingDirectionUp = false

local Anim = Character.Humanoid:LoadAnimation(script.Animations.Grapple)
local LAnim = Character.Humanoid:LoadAnimation(script.Animations.LGrapple)
local RAnim = Character.Humanoid:LoadAnimation(script.Animations.RGrapple)
local B1 = Character.Humanoid:LoadAnimation(script.Animations.Break1)
local B2 = Character.Humanoid:LoadAnimation(script.Animations.Break2)


Anim.Priority = Enum.AnimationPriority.Action
LAnim.Priority = Enum.AnimationPriority.Action
RAnim.Priority = Enum.AnimationPriority.Action
B1.Priority = Enum.AnimationPriority.Movement
B2.Priority = Enum.AnimationPriority.Movement

local Gas = false
local DriftEnabled = false

local JumpRecoil = 2

local DriftRight = false
local DriftLeft = false

local Force = 8000
local CastSpeed = 7
local RecoilTime = 4.5
local RefillAnim = 8289566184--Refill amination for blades and gas
local BladeAnim = 8289566184
local RightGoal = CFrame.new()
local LeftGoal = CFrame.new()
local RightGoalLocal = CFrame.new()
local LeftGoalLocal = CFrame.new()
local RightGoalTarget = nil
local LeftGoalTarget = nil

local RightFirePosition = CFrame.new(1.05001497, -0.824505806, -0.600113869)
local LeftFirePosition = CFrame.new(-1.04998493, -0.824505806, -0.600113869)

local Velocity = Instance.new("BodyVelocity")
Velocity.Name = "Velocity"
Velocity.P = 30000
Velocity.maxForce = Vector3.new()
Velocity.Parent = Character.HumanoidRootPart

local Rotation = Instance.new("BodyGyro")
Rotation.Name = "Rotation"
Rotation.P = 5000
Rotation.maxTorque = Vector3.new()
Rotation.D = 500
Rotation.Parent = Character.HumanoidRootPart

local RGrappleBool = Instance.new("BoolValue",Character)
RGrappleBool.Name = "Right Grapple"
RGrappleBool.Value = false

local RGoalVal = Instance.new("Vector3Value",RGrappleBool)
RGoalVal.Name = "RightGoal"

local LGrappleBool = Instance.new("BoolValue",Character)
LGrappleBool.Name = "Left Grapple"
LGrappleBool.Value = false

local LGoalVal = Instance.new("Vector3Value",LGrappleBool)
LGoalVal.Name = "LeftGoal"

local GrappleBin = Instance.new("Model",workspace.CurrentCamera)
GrappleBin.Name = "Grapples"
game.Players.LocalPlayer:GetMouse().TargetFilter = GrappleBin

local RightGrapple = Instance.new("Part",GrappleBin)
RightGrapple.Name = "Right Grapple"
RightGrapple.BrickColor = BrickColor.new("Really black")
RightGrapple.Anchored = true
RightGrapple.FormFactor = Enum.FormFactor.Custom
RightGrapple.Transparency = 1
RightGrapple.CanCollide = false

local RightMesh = Instance.new("BlockMesh",RightGrapple)
RightMesh.Scale = Vector3.new(0.05,0.05,1)

local LeftGrapple = Instance.new("Part",GrappleBin)
LeftGrapple.Name = "Left Grapple"
LeftGrapple.BrickColor = BrickColor.new("Really black")
LeftGrapple.Anchored = true
LeftGrapple.FormFactor = Enum.FormFactor.Custom
LeftGrapple.Transparency = 1
LeftGrapple.CanCollide = false

local LeftMesh = Instance.new("BlockMesh",LeftGrapple)
LeftMesh.Scale = Vector3.new(0.05,0.05,1)

local Frl = Instance.new("Part",Character)
Frl.Name = "FakeRL"
Frl.Size = Vector3.new(1,2,1)
Frl.Transparency = 1
Frl.BottomSurface = "Smooth"
Frl.TopSurface = "Smooth"
Frl.CanCollide = false

local FrlWeld = Instance.new("ManualWeld",Frl)
FrlWeld.Part0 = Character["Right Leg"]
FrlWeld.Part1 = Frl

local Fll = Instance.new("Part",Character)
Fll.Name = "FakeLL"
Fll.Size = Vector3.new(1,2,1)
Fll.Transparency = 1
Fll.BottomSurface = "Smooth"
Fll.TopSurface = "Smooth"
Fll.CanCollide = false

local FllWeld = Instance.new("ManualWeld",Fll)
FllWeld.Part0 = Character["Left Leg"]
FllWeld.Part1 = Fll

local Keys = {}
local Keys2 = {}

local grappleevent = script:WaitForChild("Grapple")
local function CastRightGrapple(Goal,Part)
	grappleevent:FireServer()
	Keys2["e"] = nil
	local Point = Vector3.new()
	local LoopNo = 0
	RightGrapple.Transparency = 1
	local Goal2 = Goal.p
	repeat
		game:GetService("RunService").RenderStepped:wait()
		if not Part then break end
		if not Part.Parent then break end
		LoopNo = LoopNo+1
		local FirePos = (Character.HumanoidRootPart.CFrame*RightFirePosition).p
		local Progression = LoopNo/((Goal2-FirePos).magnitude/CastSpeed)
		if Progression > 1 then Progression = 1 end
		local Point = FirePos+(Goal2-FirePos)*Progression
		RightGrapple.Size = Vector3.new(1, 1, (FirePos-Point).magnitude)
		RightGrapple.CFrame = CFrame.new(FirePos+(Point-FirePos)/2, Goal2)
	until(Point-Goal2).magnitude < 5 or not Keys["e"]
	Keys2["e"] = true
	if not Keys["e"] then Keys2["e"] = false return false end
	return true
end



local function CastLeftGrapple(Goal,Part)
	Keys2["q"] = nil
	local Point = Vector3.new()
	local LoopNo = 0
	LeftGrapple.Transparency = 1
	local Goal2 = Goal.p
	repeat
		game:GetService("RunService").RenderStepped:wait()
		if not Part then break end
		if not Part.Parent then break end
		Goal2 = (LeftGoalTarget.CFrame*(LeftGoalLocal:inverse())).p
		LoopNo = LoopNo+1
		local FirePos = (Character.HumanoidRootPart.CFrame*LeftFirePosition).p
		local Progression = LoopNo/((Goal2-FirePos).magnitude/CastSpeed)
		if Progression > 1 then Progression = 1 end
		local Point = FirePos+(Goal2-FirePos)*Progression
		LeftGrapple.Size = Vector3.new(1, 1, (FirePos-Point).magnitude)
		LeftGrapple.CFrame = CFrame.new(FirePos+(Point-FirePos)/2, Goal2)
	until (Point-Goal2).magnitude < 5 or not Keys["q"]
	Keys2["q"] = true
	if not Keys["q"] then Keys2["q"] = false return false end
	return true
end

--// Blade Drop Function
Mouse.KeyDown:connect(function(key)
	local durab
	if player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value >= 3 then
		durab = 20
	elseif player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value == 2 then
		durab = 15
	elseif player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value == 1 then
		durab = 12
	else
		durab = 10
	end
	if key == "r" and Blades == false and canReload == true and bladebroke == false then
		if BladesLeft <= 0 then return end
		local ChangeBlade = Character.Humanoid:LoadAnimation(script.Animations.ChangeBlade)
		ChangeBlade.Priority = Enum.AnimationPriority.Action

		UpdateDurab()
		print(BladesLeft)
		ChangeBlade:Play()
		canReload = false
		BladesLeft = BladesLeft - 2
		print(BladesLeft)
		TextL.Text = "Blades remaining "..BladesLeft
		wait(.5)
		ReloadEvent:FireServer()
		Blades = true
		canAttack = true
		wait(1)
		canReload = true
	elseif key == "r" and Blades == false and canReload == true and bladebroke == true then
		if BladesLeft <= 0 then return end
		local ChangeBlade = Character.Humanoid:LoadAnimation(script.Animations.ChangeBlade)
		ChangeBlade:Play()
		BladesLeft = BladesLeft - 2
		Durability = durab
		UpdateDurab()
		print(BladesLeft)
		local txt
		if player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value >= 3 then
			txt = "/20"
		elseif player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value == 2 then
			txt = "/15"
		elseif player.Backpack.Settings.PerkSettings.Perks.MoreDurability.Level.Value == 1 then
			txt = "/12"
		else
			txt = "/10"
		end
		TextLs.Text = "Durability: "..Durability..txt
		TextL.Text = "Blades remaining "..BladesLeft
		canReload = false
		wait(.5)

		ReloadEvent:FireServer()
		bladebroke = false
		Blades = true
		canAttack = true
		wait(1)
		canReload = true

	elseif key == "r" and Blades == true and canReload == true then

		canReload = false
		local BladesIn = Character.Humanoid:LoadAnimation(script.Animations.BladesIn)
		BladesIn.Priority = Enum.AnimationPriority.Action
		UpdateDurab()
		print(BladesLeft)
		BladesIn:Play()
		BladesLeft = BladesLeft + 2
		print(BladesLeft)
		TextL.Text = "Blades remaining "..BladesLeft
		canAttack = false
		wait(0.1)
		Blades = false
		DropBlades:FireServer()
		bladebroke = false
		canReload = true
	end
end)

--// Blades Used Function
--//Client Events
local function OnBladeBreakFired()


	Durability = Durability - 1
	UpdateDurab()
	print(BladesLeft)
	if Durability == 0 or Durability <= 0 then
		BreakBlades:FireServer()
		canAttack = false
		Blades = false
		bladebroke = true
	else
	end
end


BreakBlades.OnClientEvent:Connect(OnBladeBreakFired)

local function GasRefilled()
	local gslft
	if player.Backpack.Settings.PerkSettings.Perks.MoreGas.Level.Value >= 3 then
		gslft = 1000
	elseif player.Backpack.Settings.PerkSettings.Perks.MoreGas.Level.Value == 2 then
		gslft = 750
	elseif player.Backpack.Settings.PerkSettings.Perks.MoreGas.Level.Value == 1 then
		gslft = 625
	else
		gslft = 500
	end
	GasLeft = gslft
	script.Config.GasLeft.Value = gslft
	UpdateGas()
	Character.HumanoidRootPart.Anchored = true
	Character.Humanoid.WalkSpeed = 15
	Character.Humanoid.JumpPower = 65
	local a = Instance.new("Sound")
	a.SoundId = "http://www.roblox.com/asset/?id=378270721"
	a.Volume = 1
	a.Pitch = math.random(1,1.5)
	a.Parent = player.Character.HumanoidRootPart
	spawn(function()
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://"..RefillAnim
		Anim.Parent = Character
		local AnimationTrek = Character.Humanoid:LoadAnimation(Anim)
		AnimationTrek:Play()
		a:play()
		wait(1)
		a:play()
		AnimationTrek.Stopped:connect(function()
			Anim:Destroy()
			AnimationTrek:Destroy()
			Character.HumanoidRootPart.Anchored = false
			Character.Humanoid.WalkSpeed = 15
			Character.Humanoid.JumpPower = 65
			GasLeft = script.Config.GasLeft.Value
		end)
	end)
end
GasRefill.OnClientEvent:connect(GasRefilled)
local function BladeRefilled()
	local remove
	local blades
	if player.Backpack.Settings.PerkSettings.Perks.MoreBlades.Level.Value >= 3 then
		blades = 20
	elseif player.Backpack.Settings.PerkSettings.Perks.MoreBlades.Level.Value == 2 then
		blades = 18
	elseif player.Backpack.Settings.PerkSettings.Perks.MoreBlades.Level.Value == 1 then
		blades = 12
	else
		blades = 10
	end
	BladesLeft = blades
	remove = 8
	TextL.Text = "Blades remaining "..BladesLeft
	Character.HumanoidRootPart.Anchored = true
	Character.Humanoid.WalkSpeed = 15
	Character.Humanoid.JumpPower = 65
	local a = Instance.new("Sound")
	a.SoundId = "http://www.roblox.com/asset/?id=211134014"
	a.Volume = 1
	a.Pitch = math.random(1)
	a.Parent = player.Character.HumanoidRootPart
	spawn(function()
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://"..BladeAnim
		Anim.Parent = Character
		local AnimationTrek = Character.Humanoid:LoadAnimation(Anim)
		AnimationTrek:Play()
		a:play()
		wait(1)
		a:play()
		AnimationTrek.Stopped:connect(function()
			Anim:Destroy()
			AnimationTrek:Destroy()
			Character.HumanoidRootPart.Anchored = false
			Character.Humanoid.WalkSpeed = 15
			Character.Humanoid.JumpPower = 65
			--GasLeft = script.Config.GasLeft.Value
		end)
	end)	
end
BladeRefill.OnClientEvent:connect(BladeRefilled)

UserInputService.InputBegan:connect(function(Input, GME)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		if not GME and canAttack then
			if not attackDebounce then
				attackDebounce = true
				local AnimRandom = math.random(1,2)
				if AnimRandom == 1 then
					local AttackAnim = Character.Humanoid:LoadAnimation(script.Animations.AttackAnim)
					AttackAnim.Priority = Enum.AnimationPriority.Action
					AttackAnim:Play()
					AttackingEvent:FireServer()
					wait(1)
					attackDebounce = false
				elseif AnimRandom == 2 then
					AttackingEvent:FireServer()
					local AttackAnim2 = Character.Humanoid:LoadAnimation(script.Animations.AttackAnim2)
					AttackAnim2.Priority = Enum.AnimationPriority.Action
					AttackAnim2:Play()
					AttackingEvent:FireServer()
					wait(1)
					attackDebounce = false
				end
			end
		end
	end
end)

local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
SpaceButtonDown = false
Mouse.KeyDown:connect(function(key)
	if key == " " then
		SpaceButtonDown = true
		if DriftEnabled == true then
			repeat
				wait(0.05)
				if GasLeft > 0 then
					GasLeft = GasLeft -1
					TextLa.Text = "Gas: "..GasLeft
					print(GasLeft)
					UpdateGas()
				end
			until SpaceButtonDown == false
		end
	end
end)


Mouse.KeyUp:connect(function(key)
	if key == " " then
		SpaceButtonDown = false
		Character.Torso.DESTROY:Destroy()
	end
end)

local UIS = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local Character = Player.Character


UIS.InputBegan:Connect(function(input, gameProcessedEvent)
	if (input.KeyCode == Enum.KeyCode.E and UIS:IsKeyDown(Enum.KeyCode.Q)) or (input.KeyCode == Enum.KeyCode.Q and UIS:IsKeyDown(Enum.KeyCode.E)) then
		if DriftEnabled then
			local anim = Instance.new("Animation")
			anim.AnimationId = 'rbxassetid://8289355134'
			local play = Character.Humanoid:LoadAnimation(anim)
			play.Priority = Enum.AnimationPriority.Action
			play:Play()
			Character.Torso.Ejector.Gas.Enabled = true
			Character.Torso.Ejector.boostEmitter.Enabled = true
			Character.Torso.Ejector.boostEmitter2.Enabled = true
			Character.Torso.Ejector.boostEmitter3.Enabled = true
			Character.Torso.Ejector.boostEmitter4.Enabled = true
			wait(1)
			Character.Torso.Ejector.Gas.Enabled = false
			Character.Torso.Ejector.boostEmitter.Enabled = false
			Character.Torso.Ejector.boostEmitter2.Enabled = false
			Character.Torso.Ejector.boostEmitter3.Enabled = false
			Character.Torso.Ejector.boostEmitter4.Enabled = false
			play:Stop()
		end
	end
end)


local Kd = game.Players.LocalPlayer:GetMouse().KeyDown:connect(function(k)
	if k == "e" and GasLeft > 0.00 then

		if (game.Players.LocalPlayer:GetMouse().Hit.p-Character.HumanoidRootPart.Position).magnitude > 700 then RightGoal = Vector3.new() return end
		local targ,hit = mouse.Target,mouse.Hit
		if targ then
			if cannotGrappleon[targ.Name] then
				return end
		end 
		Character.Humanoid.PlatformStand = true
		DriftEnabled = true
		Anim:Play()
		a = Instance.new("Sound")
		a.SoundId = "http://www.roblox.com/asset/?id=193202512"
		a.Volume = .5
		a.Pitch = 1
		a.Parent = Character.HumanoidRootPart
		a:play()
		GasLeft = GasLeft - 1
		TextLa.Text = "Gas: "..GasLeft
		UpdateGas()
		game.Debris:AddItem(a,2)
		Frl.CanCollide = true
		Fll.CanCollide = true
		RightGoal = CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.p)
		RightGoalLocal = RightGoal:inverse()*game.Players.LocalPlayer:GetMouse().Target.CFrame
		RightGoalTarget = game.Players.LocalPlayer:GetMouse().Target
		Keys["e"] = true
		Velocity.maxForce = Vector3.new(Force, Force, Force)
		Rotation.maxTorque = Vector3.new(Force, Force, Force)
		for i = 1,5 do
			game.Workspace.CurrentCamera.FieldOfView = (70+(i*2))
			wait()
		end
		local ret = CastRightGrapple(RightGoal,game.Players.LocalPlayer:GetMouse().Target)
		if not ret then return end
	elseif k == "q" and GasLeft > 0.00 then
		if (game.Players.LocalPlayer:GetMouse().Hit.p-Character.HumanoidRootPart.Position).magnitude > 700 then LeftGoal = Vector3.new() return end
		local targ,hit = mouse.Target,mouse.Hit
		if targ then
			if cannotGrappleon[targ.Name] then
				print("cannot grapple")
				return end
		end 
		Character.Humanoid.PlatformStand = true
		DriftEnabled = true
		Anim:Play()
		a = Instance.new("Sound")
		a.SoundId = "http://www.roblox.com/asset/?id=193202512"
		a.Volume = .5
		a.Pitch = 1
		a.Parent = Character.HumanoidRootPart
		a:play()
		GasLeft = GasLeft - 1
		TextLa.Text = "Gas: "..GasLeft
		UpdateGas()
		game.Debris:AddItem(a,2)
		Frl.CanCollide = true
		Fll.CanCollide = true
		LeftGoal = CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.p)
		LeftGoalLocal = LeftGoal:inverse()*game.Players.LocalPlayer:GetMouse().Target.CFrame
		LeftGoalTarget = game.Players.LocalPlayer:GetMouse().Target
		Keys["q"] = true
		Velocity.maxForce = Vector3.new(Force, Force, Force)
		Rotation.maxTorque = Vector3.new(Force, Force, Force)
		for i = 1,5 do
			game.Workspace.CurrentCamera.FieldOfView = (70+(i*2))
			wait()
		end
		local ret = CastLeftGrapple(LeftGoal,game.Players.LocalPlayer:GetMouse().Target)
		if not ret then return end
	elseif k == " " and DriftEnabled then
		local a2 = Instance.new("Sound")
		a2.Name = "DESTROY"
		a2.SoundId = "http://www.roblox.com/asset/?id=378270721"
		a2.Volume = .7
		a2.Pitch = 1
		a2.Parent = Character.Torso
		a2.Looped = true
		a2:Play()
		Gas = true
		Character.Torso.Ejector.Gas.Enabled = true
		Character.Torso.Ejector.boostEmitter.Enabled = true
		Character.Torso.Ejector.boostEmitter2.Enabled = true
		Character.Torso.Ejector.boostEmitter3.Enabled = true
		Character.Torso.Ejector.boostEmitter4.Enabled = true
	elseif k == "d" and DriftEnabled == true then
		DriftRight = true
		a = Instance.new("Sound")
		a.SoundId = "http://www.roblox.com/asset/?id=378283155"
		a.Volume = .5
		a.Pitch = 1
		a.Parent = Character.HumanoidRootPart
		a:play()
		RAnim:Play()
		Character.Torso.Ejector.Gas.Enabled = true
		Character.Torso.Ejector.boostEmitter.Enabled = true
		Character.Torso.Ejector.boostEmitter2.Enabled = true
		Character.Torso.Ejector.boostEmitter3.Enabled = true
		Character.Torso.Ejector.boostEmitter4.Enabled = true
		wait(0.3)
		Character.Torso.Ejector.Gas.Enabled = false
		Character.Torso.Ejector.boostEmitter.Enabled = false
		Character.Torso.Ejector.boostEmitter2.Enabled = false
		Character.Torso.Ejector.boostEmitter3.Enabled = false
		wait(0.5)
		Character.Torso.Ejector.boostEmitter4.Enabled = false
	elseif k == "a" and DriftEnabled == true  then
		DriftLeft = true
		a = Instance.new("Sound")
		a.SoundId = "http://www.roblox.com/asset/?id=378283155"
		a.Volume = .5
		a.Pitch = 1
		a.Parent = Character.Torso
		a:play()
		LAnim:Play()
		Character.Torso.Ejector.Gas.Enabled = true
		Character.Torso.Ejector.boostEmitter.Enabled = true
		Character.Torso.Ejector.boostEmitter2.Enabled = true
		Character.Torso.Ejector.boostEmitter3.Enabled = true
		Character.Torso.Ejector.boostEmitter4.Enabled = true
		wait(0.3)
		Character.Torso.Ejector.Gas.Enabled = false
		Character.Torso.Ejector.boostEmitter.Enabled = false
		Character.Torso.Ejector.boostEmitter2.Enabled = false
		Character.Torso.Ejector.boostEmitter3.Enabled = false
		wait(0.5)
		Character.Torso.Ejector.boostEmitter4.Enabled = false
	elseif k == " " and DriftEnabled and GasLeft > 0.00 then

		Gas = true
		local a2 = Instance.new("Sound")
		a2.Name = "DESTROY"
		a2.SoundId = "http://www.roblox.com/asset/?id=378270721"
		a2.Volume = .7
		a2.Pitch = 1
		a2.Parent = Character.Torso
		a2.Looped = true
		a2:Play()
		Character.Torso.Ejector.Gas.Enabled = true
		Character.Torso.Ejector.boostEmitter.Enabled = true
		Character.Torso.Ejector.boostEmitter2.Enabled = true
		Character.Torso.Ejector.boostEmitter3.Enabled = true
		Character.Torso.Ejector.boostEmitter4.Enabled = true
		for i = 1,5 do
			wait()
		end
		while wait() and Character.Torso.Ejector.Gas.boostEmitter.boostEmitter2.boostEmitter3.boostEmitter4.Enabled == true and GasLeft > 0.00 do
		end
	elseif k == "" and (Keys["q"] or Keys["e"]) then
	end
end)

game:GetService("UserInputService").InputEnded:connect(function(Io)
	if Io.KeyCode == Enum.KeyCode.D then
		DriftRight = false
		RAnim:Stop()
	end
	if Io.KeyCode == Enum.KeyCode.A then
		DriftLeft = false
		LAnim:Stop()
	end
end)

UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.H and canOpen == true then
		local flaregui = player.StarterGUI.flaregui

		flaregui.Visible = true
		wait(.1)
		canOpen = false

	end
end)

UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.H and canOpen == false then
		if Player.PlayerGui:FindFirstChild("flaregui")then
			Player.PlayerGui:FindFirstChild("flaregui").Frame.Visible = false
			canOpen = true


		end
	end
end)

local Ku = game.Players.LocalPlayer:GetMouse().KeyUp:connect(function(k)
	local dorecoil = false
	if (Keys["e"] and k == "e") or (Keys["q"] and k == "q") then
		Anim:Stop()
		dorecoil = true
		local Break = math.random(1,2)
		if Break == 1 then
			B1:Play()
		elseif Break == 2 then
			B2:Play()
		end
		a = Instance.new("Sound")
		a.SoundId = "http://www.roblox.com/asset/?id=193202522"
		a.Volume = 1
		a.Pitch = 1
		a.Parent = Character.HumanoidRootPart
		a:play()
		game.Debris:AddItem(a,2)
		for i = 1,5 do
			game.Workspace.CurrentCamera.FieldOfView = (80-(i*2))
			wait()
		end
	end
	Keys[k] = nil
	Keys2[k] = nil
	if not Keys["q"] and not Keys["e"] and (k == "q" or k == "e") then
		DriftEnabled = false
		local LastVelocity = Character.HumanoidRootPart.Velocity
		Velocity.maxForce = Vector3.new()
		Rotation.maxTorque = Vector3.new()
		Character.Humanoid.PlatformStand = false
		Frl.CanCollide = false
		Fll.CanCollide = false
		Stalling = false
		if RightGoal.p ~= Vector3.new() or LeftGoal.p ~= Vector3.new() then
		end
		Character.HumanoidRootPart.Velocity = LastVelocity
		RightGoal = CFrame.new()
		LeftGoal = CFrame.new()
	end
	if dorecoil then
		JumpRecoil = workspace.DistributedGameTime
	end
	if not Keys["e"] then
		RightGrapple.Transparency = 1
		Character.Torso.Ejector.Gas.Enabled = false
	end
	if not Keys["q"] then
		LeftGrapple.Transparency = 1
		Character.Torso.Ejector.Gas.Enabled = false
	end
	if k == " " then
		Gas = false
		Character.Torso.Ejector.Gas.Enabled = false	
		Character.Torso.Ejector.boostEmitter.Enabled = false	
		Character.Torso.Ejector.boostEmitter2.Enabled = false
		Character.Torso.Ejector.boostEmitter3.Enabled = false
		Character.Torso.Ejector.boostEmitter4.Enabled = false
	end
end)



local function UpdateVelocities()
	if not Character then return end
	if not Character.HumanoidRootPart.Parent == Character then return end
	local Goal = Vector3.new()
	if not Keys["q"] and Keys["e"] then RightGoal = RightGoalTarget.CFrame*(RightGoalLocal:inverse()) Goal = RightGoal.p
	elseif not Keys["e"] and Keys["q"] then LeftGoal = LeftGoalTarget.CFrame*(LeftGoalLocal:inverse()) Goal = LeftGoal.p
	elseif Keys["q"] and Keys["e"] then RightGoal = RightGoalTarget.CFrame*(RightGoalLocal:inverse()) LeftGoal = LeftGoalTarget.CFrame*(LeftGoalLocal:inverse()) Goal = LeftGoal.p+(RightGoal.p-LeftGoal.p)/2
	end
	local Multiplier = 1.5
	if Gas then 
		Multiplier = 4.25
		game.Debris:AddItem(a,2)
	end
	local OrbitVelocity = Vector3.new()
	if DriftRight and not DriftLeft then
		local MultiplierOrbit = Speed*1*Multiplier
		if Keys["q"] or Keys["e"] then MultiplierOrbit = Speed*2 end
		local Dir = (Character.HumanoidRootPart.CFrame*CFrame.Angles(0, -math.rad(90), 0)).lookVector
		OrbitVelocity = Dir*MultiplierOrbit
	elseif DriftLeft and not DriftRight then
		local MultiplierOrbit = Speed*1*Multiplier
		if Keys["e"] or Keys["q"] then MultiplierOrbit = Speed*2 end
		local Dir = (Character.HumanoidRootPart.CFrame*CFrame.Angles(0, math.rad(90), 0)).lookVector
		OrbitVelocity = Dir*MultiplierOrbit
	end
	if not Stalling then
		StallingDistance = (Character.HumanoidRootPart.Position-Goal).magnitude
		Velocity.velocity = CFrame.new(Character.HumanoidRootPart.Position, Goal).lookVector*Speed*Multiplier+OrbitVelocity
		Rotation.cframe = CFrame.new(Character.HumanoidRootPart.Position, Goal)
	elseif Stalling then
		StallingDistance = (Character.HumanoidRootPart.Position-Goal).magnitude
		local DownPos = Goal-Vector3.new(0,StallingDistance,0)
		local DownArcVelocity = Vector3.new()
		if (Character.Torso.HumanoidRootPart-DownPos).magnitude > 3.5 then
			DownArcVelocity = (Character.HumanoidRootPart.CFrame*CFrame.Angles(-math.rad(90),0,0)).lookVector*50
		end
		local Maintain = Vector3.new(0,0,0)
		if StallingDirectionDown and not StallingDirectionUp then
			Maintain = Vector3.new(0,-10,0)
		elseif StallingDirectionUp and not StallingDirectionDown then
			Maintain = Vector3.new(0,10,0)
		end
		Velocity.velocity = DownArcVelocity+Maintain
		Rotation.cframe = CFrame.new((Character.HumanoidRootPart.CFrame*CFrame.new(0,5,0)).p, Goal)
	end
end
local function UpdateGrapples()
	if RightGoal.p or LeftGoal.p then 
		RGoalVal.Value = RightGoal.p
		LGoalVal.Value = LeftGoal.p
		if Keys2["e"] then 
			RGrappleBool.Value = true
			RightGrapple.Transparency = 1
			local FirePos = (Character.HumanoidRootPart.CFrame*RightFirePosition).p
			RightGrapple.Size = Vector3.new(1.5, 1.5, (FirePos-RightGoal.p).magnitude)
			RightGrapple.CFrame = CFrame.new(FirePos+(RightGoal.p-FirePos)/2, RightGoal.p)
		else
			RGrappleBool.Value = false
		end
		if Keys2["q"] then
			LGrappleBool.Value = true
			LeftGrapple.Transparency = 1
			local FirePos = (Character.HumanoidRootPart.CFrame*LeftFirePosition).p
			LeftGrapple.Size = Vector3.new(1.5, 1.5, (FirePos-LeftGoal.p).magnitude)
			LeftGrapple.CFrame = CFrame.new(FirePos+(LeftGoal.p-FirePos)/2, LeftGoal.p)
		else
			LGrappleBool.Value = false
		end
	else
		return 0
	end
	
end
game:GetService("RunService").RenderStepped:connect(UpdateGrapples)
game:GetService("RunService").Stepped:connect(UpdateVelocities)
wait(1)
B2:Stop()
B1:Stop()
MassUpdate()
wait(1)
Character.ChildAdded:connect(MassUpdate)
Character.ChildRemoved:connect(MassUpdate)
Character.Humanoid.Died:connect(function()
	Kd:disconnect()
	Ku:disconnect()
	RightGrapple:remove()
	LeftGrapple:remove()
end)
