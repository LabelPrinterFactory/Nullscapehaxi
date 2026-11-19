for i,v in pairs(workspace:WaitForChild("Item_Pools"):GetChildren()) do
	print(v)
	task.wait()
end
