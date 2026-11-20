local notifStuff = {	
	Title = "Hello",
}
game:GetService("GuiService"):SendNotification(notifStuff)

function RegChar()
	
	
	local Item_Pool = game.Workspace:WaitForChild("Item_Pools") -- gets the item_pool where the gifts are stored
	local Plr = game.Players.LocalPlayer.Character :: Model -- character
	local StartTime = tick()
	local GoldenGiftsCollected = false
	local LV = 1795151673
	local Speed = 25
	local BodyForce = Instance.new("BodyForce",Plr:FindFirstChild("HumanoidRootPart"))
	BodyForce.Force = Vector3.zero
	BodyForce.Name = "gravitron"
	while task.wait(0.05) do -- such a band aid ahh thing i made in seconds
		local LVE = LV+50000
		if os.time() > LVE then
			print("license expired.👀")
			break
		end -- this will stop people who dont know how to script
		local DT = tick()-StartTime
		StartTime = tick()
		local CurrentForce = Vector3.zero
		local CurrentDist = 512
		local MagnetAdd = 0
		local CurrentGift
		for i,v:BasePart in pairs(Item_Pool.Gift_Model:GetChildren()) do
			if v.Name == "Gift" or v then
				if (Plr.PrimaryPart.Position-v.Position).Magnitude < CurrentDist and v.Transparency < 0.5 then
					CurrentDist = (Plr.PrimaryPart.Position-v.Position).Magnitude
					CurrentGift = v
				end
			end
		end
		for i,v:BasePart in pairs(Item_Pool.GoldenGift_Model:GetChildren()) do
			if v.Name == "GoldenGift" or v then
				if (Plr.PrimaryPart.Position-v.Position).Magnitude < CurrentDist and v.Transparency < 0.5 then
					CurrentDist = (Plr.PrimaryPart.Position-v.Position).Magnitude
					CurrentGift = v
					GoldenGiftsCollected = true
				end
			end
		end
		if CurrentGift then
			local dir = (CurrentGift.CFrame.Position-Plr.HumanoidRootPart.Position) :: Vector3
			local ForceAddition = dir.Unit / ((dir.Magnitude)+5)
			ForceAddition *= 20000
			MagnetAdd += ForceAddition.Magnitude/1000
			if Plr.Humanoid.FloorMaterial ~= Enum.Material.Air then
				ForceAddition *= 10
			end
			CurrentForce += ForceAddition*Vector3.new(1,0.4,1)
		end
		
		game.ReplicatedStorage.Events.MovementGiftMagnet:Fire({Add = MagnetAdd})
		
		BodyForce.Force = CurrentForce+Vector3.new(0,600,0)
		
		if game.UserInputService:IsKeyDown(Enum.KeyCode.Equals) then -- press = to disable the thing lolz
			break -- AH MY LEGS THEY BROKE D;
		end
	end -- among us
end


local C2
local CC

CC = game.UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.Equals then
		CC:Disconnect()
		C2:Disconnect()
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
