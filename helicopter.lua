task.wait(2)
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

local FlyAnimPlaying = false
FlyAnimation.AnimationId = FlyID
local LoadedAnimation = Plr.Humanoid:LoadAnimation(FlyAnimation) :: AnimationTrack
local ContextService = game:GetService("ContextActionService")

local C

local Hint = Instance.new("Hint",workspace)
Hint.Text = "loadign"

local FlightDecay = 0

local matrix = true
local rings = 3
local sportshoes = true
local sharktail = true
local adrenaline = false
local hourglass = true
local ninjabelt = true

C = game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.F then
		if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) and sharktail == true and Flying == false and FlySpeed > 1 then
			Plr.HumanoidRootPart.AssemblyLinearVelocity *= -2
			FlySpeed = 0
			FlightDecay = 0
		else
			Flying = not Flying
			print(Flying)
			if Flying == true then
				if FlySpeed < 0.05 then
					FlySpeed = 0.05
				end
			end
		end
	end
	if input.KeyCode == Enum.KeyCode.R and Fuel > 5 and ninjabelt == true then
		Fuel -= 5
		FlySpeed /= 4
		local DashSpeed = 25
		DashSpeed += rings
		if adrenaline == true then
			TargetThrottle += 1.5
		end
		if sportshoes == true then
			TargetThrottle += 1.5
		end
		FlySpeed += DashSpeed
		FlightDecay += 25
	end
end)


while task.wait() do
	local WillBreak = false
	pcall(function(...) 
		print(FlightDecay)
		if not BF.Parent.Parent.Parent then
			WillBreak = true
			C:Disconnect()
		end
		
		TargetThrottle = 9
		TargetThrottle += rings
		if adrenaline == true then
			TargetThrottle += 1.5
		end
		if sportshoes == true then
			TargetThrottle += 1.5
		end
		
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
		
		Hint.Text = "Fuel: ".. math.round(Fuel*100)/100 .."%"

		local FlyThreshold = 0.03

		if Flying == true then
			FlightDecay /= 1+(DT*4)
			local Acceleration = 1
			if hourglass == true then
				Acceleration = 3
			end
			FlySpeed = math.lerp(FlySpeed,TargetThrottle,DT*Acceleration)
			Fuel -= TargetThrottle*(DT/4)
		else
			FlySpeed = math.lerp(FlySpeed,0,DT)
			FlyThreshold = 1.5
			Fuel = math.clamp(Fuel+(DT*0.7),0,100)
		end
		
		
		if FlightDecay > 0 then
			local DecayAmount = (FlightDecay+5)*(DT/2)
			FlightDecay -= DecayAmount
			FlySpeed -= DecayAmount
		end

		
		if FlySpeed > FlyThreshold then
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
			
			if matrix == true then
				HorizontalDrag = 20
				FowardSpeed = 1000
			end
			
			BF.Force = Plr.HumanoidRootPart.CFrame.UpVector * (FlySpeed+10)*50
			BF.Force += workspace.CurrentCamera.CFrame.LookVector * (FlySpeed)*FowardSpeed
			
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
		
		HelicopterSound.PlaybackSpeed = FlySpeed/5

		--[[if Flying == true then
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E) then
				TargetThrottle = math.clamp(TargetThrottle+(DT*5),1,10)
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Q) then
				TargetThrottle = math.clamp(TargetThrottle-(DT*5),1,10)
			end
		end--]]
		
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
