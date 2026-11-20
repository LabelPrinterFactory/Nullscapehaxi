local notifStuff = {	
	Title = "Hello",
}
game:GetService("GuiService"):SendNotification(notifStuff)

local SpeedAddition = 0

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
		local CurrentSpeedAdd = 0
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
			local ForceAddition = dir.Unit / ((dir.Magnitude)+20)
			ForceAddition *= 32000
			local AltForceAddition = Vector3.zero
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.F) then
				AltForceAddition = dir.Unit / ((dir.Magnitude)+180)
				AltForceAddition *= 400000
			end
			MagnetAdd += ForceAddition.Magnitude/1000
			MagnetAdd += AltForceAddition.Magnitude/6000
			
			CurrentSpeedAdd += (ForceAddition.Magnitude)/1000
			CurrentSpeedAdd += (AltForceAddition.Magnitude)/750
			
			if Plr.Humanoid.FloorMaterial ~= Enum.Material.Air then
				ForceAddition *= 6
			end
			CurrentForce += (ForceAddition+AltForceAddition)*Vector3.new(1,0.5,1)
		end
		
		game.ReplicatedStorage.Events.MovementGiftMagnet:Fire({Add = MagnetAdd, Squish = 1+(MagnetAdd/2)})
		
		BodyForce.Force = CurrentForce+Vector3.new(0,200,0)
		
		local SpeedAddMult = Plr.HumanoidRootPart.AssemblyLinearVelocity.Unit:Dot(CurrentForce.Unit)

		if SpeedAddMult ~= SpeedAddMult then
			SpeedAddMult = 0
		end
		
		SpeedAddition += CurrentSpeedAdd*SpeedAddMult
		print(SpeedAddMult)
		
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
	Human.WalkSpeed += math.clamp(SpeedAddition-10,0,256)
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
