   --//         SERVER SCRIPT        \\--
----// MAIN CUSTOM ANIMATIONS HANDLER \\----

game.ReplicatedStorage.Remotes.PlayAnimation.OnServerEvent:Connect(function(player, character)
	print("Received ", character.Name)
	local anim1 = character.TrainingAnims.Salute1
	local anim2 = character.TrainingAnims.Salute1.Salute2
	if anim1.IsPlaying.Value == false then
		anim1.IsPlaying.Value = true
		local Humanoid = character.Humanoid
		local loadedanim1 = Humanoid:LoadAnimation(anim1)
		local loadedanim2 = Humanoid:LoadAnimation(anim2)
		loadedanim1:Play()
		print("Playing.")
		loadedanim1.Stopped:Connect(function()
			loadedanim2:Play()
		end)
	else if anim1.IsPlaying.Value == true then
			local hum = character.Humanoid
			anim1.IsPlaying.Value = false
			for i, v in pairs(hum:GetPlayingAnimationTracks()) do
				v:Stop()
			end
		end
	end
end)
