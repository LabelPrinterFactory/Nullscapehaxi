task.wait(3)
local Item_Pool = game.Workspace:WaitForChild("Item_Pools") -- gets the item_pool where the gifts are stored
local Plr = game.Players.LocalPlayer.Character :: Model -- character
local NilTimer = 0
local StartTime = tick()
local GoldenGiftsCollected = false
local License = 1790606027
while task.wait() do -- such a band aid ahh thing i made in seconds
	local LicenseExpire = License+259200
	if os.time() > LicenseExpire then
		break
	end
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
		if CurrentDist > 150 then
			local Target = CFrame.lookAt(Plr.PrimaryPart.Position,CurrentGift.Position).LookVector * 75
			Plr:PivotTo(CFrame.new(Target))
		else
			Plr:PivotTo(CurrentGift.CFrame)
		end
		Plr:PivotTo(CurrentGift.CFrame)
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

local Item_Pool = game.Workspace:WaitForChild("Item_Pools")
for i,v:BasePart in pairs(Item_Pool.GiftShell:GetChildren()) do
	if v.Name == "GiftShell" then
		
	end
end
--[[local H = Instance.new("Highlight",Item_Pool.GiftShell)
game.Debris:AddItem(H,5)--]]

--local Item_Pool = workspace:WaitForChild("Item_Pools") -- gets the item_pool where the gifts are stored
--[[local Plr = game.Players.LocalPlayer.Character :: BasePart -- character
while game:GetService("RunService").RenderStepped:Wait() do -- loop. duh.
	local Gift = Item_Pool:FindFirstChild("Gift")
	if Gift then
		Plr:PivotTo(Gift:FindFirstChildWhichIsA("BasePart").CFrame)
	else
		break -- AH MY LEGS THEY BROKE D;
	end
end --]]

for i,v in pairs(workspace:GetDescendants()) do
	if i%512 == 0 then
		task.wait()
	end
	if v:IsA("Highlight") then
		task.wait()
		print(v:GetFullName())
	end
end
local Item_Pool = game.Workspace:WaitForChild("Item_Pools")
for i,v in pairs(Item_Pool.GiftShell:GetChildren()) do
	print(v.Name)
	print(v.ClassName)
end

for i,v in pairs(workspace:GetChildren()) do
	print(v)
end
