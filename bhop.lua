local notifStuff = {	
	Title = "Hello",
}
game:GetService("GuiService"):SendNotification(notifStuff)

local SpeedAddition = 0

function RegChar()
	

	local Item_Pool = game.Workspace:WaitForChild("Item_Pools") -- gets the item_pool where the gifts are stored
	local Plr = game.Players.LocalPlayer.Character :: Model -- character
	local Humanoid = Plr:FindFirstChildWhichIsA("Humanoid")
	local StartTime = tick()
	local GoldenGiftsCollected = false
	local LV = 1795151673
	local Speed = 25
	local LastMoveDir = Humanoid.MoveDirection
	while game:GetService("RunService").RenderStepped:Wait() do -- such a band aid ahh thing i made in seconds
		local DT = tick()-StartTime
		StartTime = tick()
		
		
		if Humanoid then
			local MoveDirUnit = LastMoveDir:Dot(Humanoid.MoveDirection)
			LastMoveDir = Humanoid.MoveDirection
			local TurnThisFrame = (1-MoveDirUnit)/DT
			print(TurnThisFrame)
			local SpeedAddMult = math.clamp(TurnThisFrame,0,0.1)*10
			SpeedAddMult -= math.clamp(TurnThisFrame-0.2,0,1)*10
			if Humanoid.FloorMaterial == Enum.Material.Air then
				SpeedAddition += DT*SpeedAddMult
			end
		end
		
		game.ReplicatedStorage.Events.MovementGiftMagnet:Fire({Add = SpeedAddition/50, Squish = 1+(SpeedAddition/50)})

		if game.UserInputService:IsKeyDown(Enum.KeyCode.Equals) then -- press = to disable the thing lolz
			break -- AH MY LEGS THEY BROKE D;
		end
	end -- among us
end


local C2
local CC

game:GetService("RunService"):BindToRenderStep("WalkSpd",Enum.RenderPriority.Character.Value+2,function(DT)
	local Plr = game.Players.LocalPlayer.Character :: Model -- character
	local Human = Plr:FindFirstChild("Humanoid") :: Humanoid
	if Human.FloorMaterial == Enum.Material.Air then
		SpeedAddition /= 1 + (DT*0.15)
	else
		SpeedAddition /= 1 + (DT*2.4)
	end
	Human.WalkSpeed += math.clamp(SpeedAddition-1,0,256)
end)

CC = game.UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.Equals then
		CC:Disconnect()
		C2:Disconnect()
		game:GetService("RunService"):UnbindFromRenderStep("WalkSpd")
		local notifStuff = {	
			Title = "Bye",
		}
		game:GetService("GuiService"):SendNotification(notifStuff)
	end
end)


task.spawn(function()
	RegChar()
end)
C2 = game.Players.LocalPlayer.CharacterAdded:Connect(function(character: Model)
	task.spawn(function()
		task.wait(1)
		RegChar()
	end)
end)
