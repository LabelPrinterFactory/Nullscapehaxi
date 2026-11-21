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
	while game:GetService("RunService").RenderStepped:Wait() do -- such a band aid ahh thing i made in seconds
		local DT = tick()-StartTime
		StartTime = tick()
		
		
		if Humanoid then
			
		end
		
		--game.ReplicatedStorage.Events.MovementGiftMagnet:Fire({Add = MagnetAdd, Squish = 1+(MagnetAdd/2)})

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
		SpeedAddition /= 1 + (DT*0.6)
	else
		SpeedAddition /= 1 + (DT*1.2)
	end
	Human.WalkSpeed += math.clamp(SpeedAddition-5,0,256)
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
