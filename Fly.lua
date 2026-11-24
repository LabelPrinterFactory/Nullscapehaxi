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
	return MoveDirection
end

function Step()
	local MoveDirection = GetMoveDirections()
	
	BodyGyro = Camera.CFrame
	BodyVelocity.Velocity = MoveDirection * 100
	
	if not BodyVelocity:IsDescendantOf(workspace) then
		RSConnection:Disconnect()
		BodyVelocity:Destroy()
		BodyGyro:Destroy()
	end
end

RSConnection = RunService.RenderStepped:Connect(Step)
