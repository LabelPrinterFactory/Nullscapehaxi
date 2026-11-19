for i,v in pairs(game:GetDescendants()) do
	local name = string.lower(v.Name)
	if string.find(name,"gift") or string.find(name,"magnet") or string.find(name,"range") or string.find(name,"collection") or string.find(name,"radius") then
		print(v:GetFullName())
	end
	if i%64 == 0 then
		task.wait()
	end
end
