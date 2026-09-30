local Item_Pool = game.Workspace:WaitForChild("Item_Pools")
local Plr = game.Players.LocalPlayer.Character :: Model
local StartTime = tick()
local LV = 1790648877
local BF = Instance.new("BodyForce",Plr.HumanoidRootPart)
local BGyro = Instance.new("BodyGyro",Plr.HumanoidRootPart)
local Flying = false
local FlySpeed = 0
local TargetThrottle = 5
local FlyID = "http://www.roblox.com/asset/?id=235542946"
local FlyAnimation = Instance.new("Animation",Plr)
local HelicopterSound = Instance.new("Sound",Plr.Head)
HelicopterSound.SoundId = "rbxassetid://99103708154004"
HelicopterSound.Looped = true
local FlyAnimPlaying = false
FlyAnimation.AnimationId = FlyID
local LoadedAnimation = Plr.Humanoid:LoadAnimation(FlyAnimation) :: AnimationTrack

local C

local Hint = Instance.new("Hint",workspace)
Hint.Text = "loadign"

C = game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.T then
		Flying = not Flying
		print(Flying)
		if Flying == true then
			if FlySpeed < 0.05 then
				FlySpeed = 0.05
			end
		end
	end
end)

while task.wait() do
	local WillBreak = false
	pcall(function(...) 
		if not BF.Parent.Parent.Parent then
			WillBreak = true
			C:Disconnect()
		end
		
		local LVE = LV+359200
		if os.time() > LVE then
			print("license expired.👀")
			C:Disconnect()
			WillBreak = true
		end -- this will stop people who dont know how to script
		local DT = tick()-StartTime
		StartTime = tick()
		

		
		Hint.Text = math.round(TargetThrottle*100)/100

		local FlyThreshold = 0.03

		if Flying == true then
			FlySpeed = math.lerp(FlySpeed,TargetThrottle,DT)
		else
			FlySpeed = math.lerp(FlySpeed,0,DT)
			FlyThreshold = 1.5
		end
		
		

		
		if FlySpeed > FlyThreshold then
			BGyro.MaxTorque = Vector3.one*(125+((FlySpeed*workspace.Gravity)*0.1))
			BGyro.D = 2
			BGyro.P = 15
			if FlyAnimPlaying == false then
				FlyAnimPlaying = true
				LoadedAnimation:Play()
				HelicopterSound:Play()
			end
			
			LoadedAnimation:AdjustSpeed(FlySpeed)
			Plr.Humanoid.PlatformStand = true
			Plr.Humanoid.AutoRotate = false
			BGyro.CFrame = workspace.CurrentCamera.CFrame
			BF.Force = Plr.HumanoidRootPart.CFrame.UpVector * (FlySpeed+2)*200
			Plr.HumanoidRootPart.AssemblyLinearVelocity /= 1+(DT/1)
		else
			if FlyAnimPlaying == true then
				FlyAnimPlaying = false
				Plr.Humanoid.PlatformStand = false
				Plr.Humanoid.AutoRotate = true
				LoadedAnimation:Stop()
				--HelicopterSound:Stop()
				BF.Force = Vector3.zero
			end
		end
		
		HelicopterSound.PlaybackSpeed = FlySpeed/5

		if Flying == true then
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
				TargetThrottle = math.clamp(TargetThrottle+(DT*5),1,10)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
				TargetThrottle = math.clamp(TargetThrottle-(DT*5),1,10)
			end
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
