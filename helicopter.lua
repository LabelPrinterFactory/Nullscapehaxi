task.wait(1.5)
function RegisterCharacter()
	local Upgrades = game:GetService("ReplicatedStorage"):WaitForChild("UpgradeFolder"):WaitForChild("Upgrades")
	local Item_Pool = game.Workspace:WaitForChild("Item_Pools")
	local Plr = game.Players.LocalPlayer.Character :: Model
	local StartTime = tick()
	local LV = 1790648877
	local BF = Instance.new("BodyForce",Plr.HumanoidRootPart)
	local BGyro = Instance.new("BodyGyro",Plr.HumanoidRootPart)
	BGyro.Name = "fixit"
	local Flying = false
	local FlySpeed = 0
	local Fuel = 100
	local TargetThrottle = 10
	local FlyID = "http://www.roblox.com/asset/?id=235542946"
	local FlyAnimation = Instance.new("Animation",Plr)

	local HelicopterSound = Instance.new("Sound",Plr.Head)
	HelicopterSound.SoundId = "rbxassetid://99103708154004"
	HelicopterSound.Looped = true
	HelicopterSound.Volume = 0.25
	
	local CharacterLoaded = false
	
	game.Players.LocalPlayer.CharacterAdded:Once(function(character: Model) 
		CharacterLoaded = true
		print("loadign")
	end)
	
	local FlyAnimPlaying = false
	FlyAnimation.AnimationId = FlyID
	local LoadedAnimation = Plr.Humanoid:LoadAnimation(FlyAnimation) :: AnimationTrack
	local ContextService = game:GetService("ContextActionService")

	local C

	local Hint = Instance.new("Hint",workspace)
	Hint.Text = "loadign"
	
	local Overfuel = 0
	local FlightDecay = 0

	local matrix = false
	local rings = 0
	local idols = 0
	local sportshoes = false
	local sharktail = false
	local adrenaline = false
	local hourglass = false
	local ninjabelt = false
	local gracewings = false
	
	local Preloader = Instance.new("Sound",Plr)
	Preloader.SoundId = "rbxassetid://15675059323"
	
	C = game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
		if gameProcessedEvent then return end
		if input.KeyCode == Enum.KeyCode.F then
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) and sharktail == true and Flying == false and FlySpeed > 1 then
				Plr.HumanoidRootPart.AssemblyLinearVelocity *= -1.5
				Fuel -= 0.2
				FlySpeed = 0
				FlightDecay = 0
			else
				Flying = not Flying
				if Flying == true then
					if FlySpeed < 0.05 then
						FlySpeed = 0.05
					end
				end
			end
		end
		if input.KeyCode == Enum.KeyCode.R and Fuel > 2+Overfuel and ninjabelt == true then
			
			local DashSound = Instance.new("Sound",Plr)
			DashSound.PlaybackSpeed = 0.85+(Overfuel/2)
			DashSound.Volume = 0.8+(Overfuel/25)
			DashSound.SoundId = "rbxassetid://15675059323"
			DashSound:Play()
			game.Debris:AddItem(DashSound,3)
			
			Fuel -= 2+Overfuel
			Plr.HumanoidRootPart.AssemblyLinearVelocity += Vector3.new(0,(Overfuel^2)/3,0)
			Overfuel += 2
			FlySpeed /= 3
			local DashSpeed = 42
			DashSpeed += (rings*3)
			if adrenaline == true then
				DashSpeed += 4.5
			end
			if sportshoes == true then
				DashSpeed += 4.5
			end
			FlySpeed += DashSpeed
			FlightDecay += DashSpeed
		end
	end)
	
	while task.wait() do
		local WillBreak = false
		pcall(function(...) 
			if CharacterLoaded == true then
				WillBreak = true
				print("BROKENLEGS")
				C:Disconnect()
			end

			if Upgrades:FindFirstChild("NinjaBelt") then
				ninjabelt = true
			end
			if Upgrades:FindFirstChild("MiniatureHourglass") then
				hourglass = true
			end
			if Upgrades:FindFirstChild("SharkTail") then
				sharktail = true
			end
			if Upgrades:FindFirstChild("Adrenaline") then
				adrenaline = true
			end
			if Upgrades:FindFirstChild("MatrixTetrahedron") then
				matrix = true
			end
			if Upgrades:FindFirstChild("SportShoes") then
				sportshoes = true
			end
			if Upgrades:FindFirstChild("GraceWings") then
				gracewings = true
			end
			if Upgrades:FindFirstChild("SwiftnessRing") then
				rings = Upgrades:FindFirstChild("SwiftnessRing").Value
			end
			if Upgrades:FindFirstChild("GiftIdol") then
				idols = Upgrades:FindFirstChild("GiftIdol").Value
			end
			
			
			local capacity = 80
			if ninjabelt == true then
				capacity = 130
			end
			capacity += idols*2
			
			TargetThrottle = 9
			TargetThrottle += rings
			if adrenaline == true then
				TargetThrottle += 1.5
			end
			if sportshoes == true then
				TargetThrottle += 1.5
			end

			TargetThrottle *= math.clamp(Fuel/10,0,1)

			local LVE = LV+359200
			if os.time() > LVE then
				print("license expired.👀")
				C:Disconnect()
				WillBreak = true
			end -- this will stop people who dont know how to script
			local DT = tick()-StartTime
			StartTime = tick()

			local DisableThreshold = 10

			if Flying == true then
				DisableThreshold = 0
			end

			if Fuel <= DisableThreshold then
				if Fuel < 0 then
					Fuel = 0
				end
				Flying = false
			end

			Hint.Text = "Fuel: ".. math.round(Fuel*100)/100 .. "/"..capacity
			
			Overfuel /= 1+(DT/10)
			Overfuel = math.clamp(Overfuel-DT,0,15)
			
			
			local FlyThreshold = 0.03
			
			
			local RegenSpeed = 0.6
			RegenSpeed += rings/10
			if hourglass == true then
				if Fuel > 50 then
					RegenSpeed += (Fuel-50)/200
				end
			end
			
			FlyThreshold = 1.5
			
			
			if Flying == true then
				RegenSpeed = 0
				FlightDecay /= 1+(DT*4)
				local Acceleration = 0.8
				if gracewings == true then
					Acceleration = 1.2
				end
				if hourglass == true then
					Acceleration = 3
				end
				FlySpeed = math.lerp(FlySpeed,TargetThrottle,DT*Acceleration)
				
				Fuel -= 10*(DT/6)
			else
				FlySpeed = math.lerp(FlySpeed,0,DT)
				
			end

			
			
			if FlightDecay > 0 then
				local DecayAmount = (FlightDecay+5)*(DT/2)
				FlightDecay -= DecayAmount
				FlySpeed -= DecayAmount
			end


			if FlySpeed > FlyThreshold then
				RegenSpeed /= 2
				BGyro.MaxTorque = Vector3.one*(125+((FlySpeed*workspace.Gravity)*0.1))
				BGyro.D = 200
				BGyro.P = 1500
				if FlyAnimPlaying == false then
					FlyAnimPlaying = true
					LoadedAnimation:Play()
					HelicopterSound:Play()
				end

				LoadedAnimation:AdjustSpeed(FlySpeed)
				Plr.Humanoid.PlatformStand = true
				Plr.Humanoid.AutoRotate = false
				BGyro.CFrame = CFrame.identity

				local HorizontalDrag = 2
				local FowardSpeed = 125
				if gracewings == false then
					HorizontalDrag = 1
					FowardSpeed = 70
				end
				if matrix == true then
					HorizontalDrag = 20
					FowardSpeed = 1000
				end

				BF.Force = Plr.HumanoidRootPart.CFrame.UpVector * (FlySpeed+10)*50
				BF.Force += workspace.CurrentCamera.CFrame.LookVector * (FlySpeed)*(FowardSpeed)

				Plr.HumanoidRootPart.AssemblyLinearVelocity /= Vector3.new(1+(DT*HorizontalDrag),1+(DT*(HorizontalDrag/2)),1+(DT*HorizontalDrag))
			else
				if FlyAnimPlaying == true then
					FlyAnimPlaying = false
					Plr.Humanoid.PlatformStand = false
					Plr.Humanoid.AutoRotate = true
					LoadedAnimation:Stop()
					--HelicopterSound:Stop()
					BF.Force = Vector3.zero
				end
				BGyro.MaxTorque = Vector3.zero
			end
			
			Fuel = math.clamp(Fuel+(DT*(RegenSpeed/1.5)),0,capacity)
			HelicopterSound.PlaybackSpeed = FlySpeed/5

		--[[if Flying == true then
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E) then
				TargetThrottle = math.clamp(TargetThrottle+(DT*5),1,10)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Q) then
				TargetThrottle = math.clamp(TargetThrottle-(DT*5),1,10)
			end
		end--]]
			
			if capacity > ((250-150)*2)/2 then -- dont ask
				capacity = (100-99)/100
			end
			
			if game.UserInputService:IsKeyDown(Enum.KeyCode.Equals) or BF.Parent == nil then -- press = to disable the thing lolz
				C:Disconnect()
				WillBreak = true -- AH MY LEGS THEY BROKE D;
			end
		end)
		if WillBreak == true then
			Hint:Destroy()
			break
		end
	end -- among us

end

local C
local CC

CC = game.UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.Equals then
		C:Disconnect()
		CC:Disconnect()
	end
end)

task.spawn(function()
	RegisterCharacter()
end)
C = game.Players.LocalPlayer.CharacterAdded:Connect(function(character: Model)
	task.spawn(function()
		task.wait(1)
		RegisterCharacter()
	end)
end)
