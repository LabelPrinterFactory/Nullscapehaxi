local Running = true

local Plr = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
local Root = Plr:WaitForChild("HumanoidRootPart") :: BasePart
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local BodyVelocity = Instance.new("BodyVelocity",Root)
BodyVelocity.MaxForce = Vector3.one *100000
local BodyGyro = Instance.new("BodyGyro",Root)

local RSConnection

function GetMoveDirections()
	local MoveDirection = Vector3.zero
	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		MoveDirection += Camera.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		MoveDirection -= Camera.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		MoveDirection -= Camera.CFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		MoveDirection += Camera.CFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.E) then
		MoveDirection += Camera.CFrame.UpVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
		MoveDirection -= Camera.CFrame.UpVector
	end
	return MoveDirection
end

function AutoStep()
	local MaxDist = 2048
	local Target
	for i,v in pairs(workspace:GetChildren()) do
		if v:FindFirstChild("Humanoid") then
			if v:FindFirstChild("HumanoidRootPart") then
				if v ~= Plr then
					print(Root)
					print(v)
					local Dist = (Root.Position - v:WaitForChild("HumanoidRootPart").Position).Magnitude
					if Dist < MaxDist then
						MaxDist = Dist
						Target = v
					end
				end
			end
		end
	end

	if Target then
		Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position,Target:WaitForChild("HumanoidRootPart").Position)
	end
end


RunService:BindToRenderStep("AutoStep",Enum.RenderPriority.Camera.Value+5,AutoStep)
task.spawn(function()
	while task.wait() do
		if Running == false then
			RunService:UnbindFromRenderStep("AutoStep")
		end
	end
end)

function Step()
	local MoveDirection = GetMoveDirections()
	
	BodyGyro = Camera.CFrame
	BodyVelocity.Velocity = MoveDirection * 200
	
	BodyVelocity.Velocity += Vector3.new(math.noise(time()*10,math.pi,tick()),math.noise((time()+35)*10,math.pi,tick()),math.noise((time()+125)*10,math.pi,tick()))*500
	
	if not BodyVelocity:IsDescendantOf(workspace) then
		Running = false
		RSConnection:Disconnect()
		if BodyVelocity then
			BodyVelocity:Destroy()
			BodyGyro:Destroy()
		end
	end

end

RSConnection = RunService.RenderStepped:Connect(Step)
