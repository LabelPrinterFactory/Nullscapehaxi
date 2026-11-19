for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
	local name = string.lower(v.Name)
	if string.find(name,"gift") or string.find(name,"magnet") or string.find(name,"range") then
		print(v:GetFullName())
	end
end
