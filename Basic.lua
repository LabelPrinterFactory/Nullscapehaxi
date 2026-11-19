for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
	if v:IsA("NumberValue") then
		print(v:GetFullName())
	end
	if i%4 == 0 then
		task.wait()
	end
end
