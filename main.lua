local Item_Pool = game.Workspace:WaitForChild("Item_Pools") -- gets the item_pool where the gifts are stored
local Plr = game.Players.LocalPlayer.Character :: Model -- character
local NilTimer = 0
local StartTime = tick()
local GoldenGiftsCollected = false
local LV = 1790648877
while task.wait() do -- such a band aid ahh thing i made in seconds
	local LVE = LV+359200
	if os.time() > LVE then
		print("license expired.👀")
		break
	end -- this will stop people who dont know how to script
	local DT = tick()-StartTime
	StartTime = tick()
	local CurrentDist = 9048
	local CurrentGift
	for i,v:BasePart in pairs(Item_Pool.Gift:GetChildren()) do
		if v.Name == "Gift" or v then
			if (Plr.PrimaryPart.Position-v.Position).Magnitude < CurrentDist and v.Transparency < 0.5 then
				CurrentDist = (Plr.PrimaryPart.Position-v.Position).Magnitude
				CurrentGift = v
			end
		end
	end
	for i,v:BasePart in pairs(Item_Pool.GoldenGift:GetChildren()) do
		if v.Name == "GoldenGift" or v then
			if (Plr.PrimaryPart.Position-v.Position).Magnitude < CurrentDist and v.Transparency < 0.5 then
				CurrentDist = (Plr.PrimaryPart.Position-v.Position).Magnitude
				CurrentGift = v
				GoldenGiftsCollected = true
			end
		end
	end
	if CurrentGift then
		if CurrentDist > 80 then
			local Target = CFrame.lookAt(Plr.PrimaryPart.Position,CurrentGift.Position).LookVector * 16
			Plr:PivotTo(CFrame.new(Target+Plr.PrimaryPart.Position))
		else
			local Giftv2Hitbox = nil
			local HD = 6.8
			for i,v in pairs(CurrentGift.Parent:GetChildren()) do
				if v:IsA("BasePart") then
					if CurrentGift ~= v and (CurrentGift.Position-v.Position).Magnitude < HD and v.Transparency < 0.5 then
						HD = (CurrentGift.Position-v.Position).Magnitude
						Giftv2Hitbox = v
					end
				end
			end
			if Giftv2Hitbox ~= nil then
				local OtherGift = Giftv2Hitbox
				local Pos = CurrentGift.CFrame:Lerp(OtherGift.CFrame,0.5)
				Plr:PivotTo(Pos)
			else
				Plr:PivotTo(CurrentGift.CFrame)
			end
		end
		NilTimer = 0
		for i,v in pairs(Plr:GetDescendants()) do
			if v:IsA("BasePart") then
				v.AssemblyLinearVelocity = Vector3.zero
			end
		end
	else
		NilTimer += DT
		if NilTimer > 0.1 and GoldenGiftsCollected == true then
			Plr:PivotTo(CFrame.new(0,60,0))
		end
	end
	if game.UserInputService:IsKeyDown(Enum.KeyCode.Equals) then -- press = to disable the thing lolz
		break -- AH MY LEGS THEY BROKE D;
	end
end -- among us

for i, v in pairs(game:GetDescendants()) do
	if i%1024 == 0 then
		task.wait()
	end
	if v:IsA("Script") then
		if v.RunContext == Enum.RunContext.Client then
			v:Destroy()
		end
	end
end
