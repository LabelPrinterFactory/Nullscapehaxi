local Upgrades = game:GetService("ReplicatedStorage"):WaitForChild("UpgradeFolder"):WaitForChild("Upgrades")
local Item_Pool = game.Workspace:WaitForChild("Item_Pools")
local Plr = game.Players.LocalPlayer.Character :: Model
local StartTime = tick()
local LV = 1790648877
while task.wait() do
	local LVE = LV+359200
	if os.time() > LVE then
		print("license expired.👀")
		break
	end -- this will stop people who dont know how to script
	local DT = tick()-StartTime
	StartTime = tick()
	if game.UserInputService:IsKeyDown(Enum.KeyCode.Equals) then -- press = to disable the thing lolz
		break -- AH MY LEGS THEY BROKE D;
	end
end -- among us
