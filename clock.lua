task.wait(0.1)
local UI = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
UI.ResetOnSpawn = false
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")

local CP = game:GetService("ContentProvider")

local BaseID = "rbxassetid://116479168303550"
local HandID ="rbxassetid://92887877691852"
local OutlinePrimary ="rbxassetid://81173863250339"
local OutlineSecondary ="rbxassetid://93712476598926"
local GearID ="rbxassetid://147328632"

local Static ="rbxassetid://569507725"

local TickSound = "rbxassetid://134410911353980"
local SwooshSound = "rbxassetid://101754068104110"
local GearSound = "rbxassetid://137857392269247"
local BlastSound = "rbxassetid://137231920197356"
local RewindSound = "rbxassetid://105163773399147"
local SmallSound = "rbxassetid://16480551414"





local ItemsTable = {}

local NextTick = 1
local Timer = 0
local Speed = 1
local CurrentTicks = 0
local CurrentLoops = 1
local CurrentRealLoops = 0
local LastTick = 5

local OutlineVelocity = 0
local Shake = 0

local ClockSwing = false

function CreateImage(ID)
	local img = Instance.new("ImageLabel",UI)
	img.Image = ID
	img.AnchorPoint = Vector2.new(0.5,0.5)
	img.BackgroundTransparency=1
	return img
end

function CreateImageButton(ID)
	local img = Instance.new("ImageButton",UI)
	img.Image = ID
	img.AnchorPoint = Vector2.new(0.5,0.5)
	img.BackgroundTransparency=1
	return img
end

function PlaySound(ID)
	local S = Instance.new("Sound",UI)
	S.SoundId = ID
	return S
end

function GetRotationFromTicks(num)
	return (num*30)+90
end

function GetTicksFromLoops()
	return (CurrentRealLoops*12)+CurrentTicks
end

function IncrementTicks()
	if CurrentTicks%12 == 0 and CurrentTicks ~= 0 then
		CurrentLoops *= 2
		CurrentRealLoops += 1
	end
	CurrentTicks += 1
end

function DecrementTicks()
	if CurrentTicks ~= 0 then
		if CurrentTicks%12 == 0 then
			CurrentLoops /= 2
		end
		CurrentTicks -= 1
	end
end

local GearTextures = {}

local TickSFXInstance = PlaySound(TickSound)
TickSFXInstance.Volume = 0.4
CP:PreloadAsync({TickSFXInstance})

local SwooshSFXInstance = PlaySound(SwooshSound)
SwooshSFXInstance.Volume = 0.1
CP:PreloadAsync({SwooshSFXInstance})

local GearSFXInstance = PlaySound(GearSound)
GearSFXInstance.Volume = 0.2
GearSFXInstance.PlaybackSpeed = 1
CP:PreloadAsync({GearSFXInstance})

local BlastSFXInstance = PlaySound(BlastSound)
BlastSFXInstance.Volume = 0.25
CP:PreloadAsync({BlastSFXInstance})

local RewindSFXInstance = PlaySound(RewindSound)
RewindSFXInstance.Volume = 0.6
CP:PreloadAsync({RewindSFXInstance})

local SmallSFXInstance = PlaySound(SmallSound)
SmallSFXInstance.Volume = 0.4
CP:PreloadAsync({SmallSFXInstance})

local ClockBase = CreateImageButton(BaseID)
ClockBase.Size = UDim2.new(0,128,0,128)
ClockBase.Position = UDim2.new(0.2,0,0.8,0)
table.insert(ItemsTable,ClockBase)



local Outline1 = CreateImage(OutlinePrimary)
Outline1.Size = UDim2.new(0,128,0,128)
Outline1.Position = UDim2.new(0.2,0,0.8,0)
table.insert(ItemsTable,Outline1)

local Outline2 = CreateImage(OutlinePrimary)
Outline2.Size = UDim2.new(0,134,0,134)
Outline2.ImageColor3 = Color3.new(0, 0, 0)
Outline2.Position = UDim2.new(0.2,0,0.8,0)
table.insert(ItemsTable,Outline2)

local GearTexture = CreateImage(GearID)
GearTexture.Size = UDim2.new(0,100,0,100)
GearTexture.ImageColor3 = Color3.new(1, 0.866667, 0.470588)
GearTexture.Position = UDim2.new(0.215, 0,0.787, 0)
GearTexture.ZIndex = -1
GearTexture.Name = "Gear"
table.insert(ItemsTable,GearTexture)
table.insert(GearTextures,GearTexture)

local GearTexture2 = CreateImage(GearID)
GearTexture2.Size = UDim2.new(0,120,0,120)
GearTexture2.ImageColor3 = Color3.new(1, 0.866667, 0.470588)
GearTexture2.Position = UDim2.new(0.188, 0,0.788, 0)
GearTexture2.ZIndex = -1
GearTexture2.Name = "Gear"
table.insert(ItemsTable,GearTexture2)
table.insert(GearTextures,GearTexture2)

local GearTexture3 = CreateImage(GearID)
GearTexture3.Size = UDim2.new(0,105,0,105)
GearTexture3.ImageColor3 = Color3.new(1, 0.866667, 0.470588)
GearTexture3.Position = UDim2.new(0.198, 0,0.831, 0)
GearTexture3.ZIndex = -1
GearTexture3.Name = "Gear"
table.insert(ItemsTable,GearTexture3)
table.insert(GearTextures,GearTexture3)

for i,v in pairs(GearTextures) do
	v.ImageTransparency = 0.5
end

function lerp(start, goal, alpha)
	--definitely not stolen from starmaq
	return start + (goal - start) * alpha
end

for i=1,4 do
	local GoldOutline = CreateImage(OutlinePrimary)
	GoldOutline.Size = UDim2.new(0,i*20,0,i*20)
	GoldOutline.ImageTransparency = 0.5
	GoldOutline.ImageColor3 = Color3.new(0, 0, 0)
	GoldOutline.Position = UDim2.new(0.2,0,0.8,0)
	GoldOutline.BackgroundColor3 = Color3.new(0.745098, 0.658824, 0.309804)
	table.insert(ItemsTable,GoldOutline)
end

local GoldOutline2 = CreateImage(OutlinePrimary)
GoldOutline2.Size = UDim2.new(0,99,0,99)
GoldOutline2.ImageTransparency = 0
GoldOutline2.ImageColor3 = Color3.new(0, 0, 0)
GoldOutline2.Position = UDim2.new(0.2,0,0.8,0)
GoldOutline2.BackgroundColor3 = Color3.new(0.745098, 0.658824, 0.309804)
table.insert(ItemsTable,GoldOutline2)

for i=1,3 do
	local GoldOutline = CreateImage(OutlinePrimary)
	GoldOutline.Size = UDim2.new(0,(i+0.5)*20,0,(i+0.5)*20)
	GoldOutline.ImageTransparency = 0.5
	GoldOutline.ImageColor3 = Color3.new(0, 0, 0)
	GoldOutline.Position = UDim2.new(0.2,0,0.8,0)
	GoldOutline.BackgroundColor3 = Color3.new(1, 0.917647, 0.309804)
	table.insert(ItemsTable,GoldOutline)
end

local Outline3 = CreateImage(OutlineSecondary)
Outline3.Size = UDim2.new(0,150,0,150)
Outline3.ImageColor3 = Color3.new(0.266667, 0.121569, 0.121569)
Outline3.Position = UDim2.new(0.2,0,0.8,0)
Outline3.ImageTransparency = 0.5
table.insert(ItemsTable,Outline3)

local LongHand = CreateImage(HandID)
LongHand.Size = UDim2.new(0,112,0,112)
LongHand.Position = UDim2.new(0.2,0,0.8,0)
LongHand.ImageColor3 = Color3.new(0.745098, 0.658824, 0.309804)
table.insert(ItemsTable,LongHand)

local StaticTexture = CreateImage(Static)
StaticTexture.Size = UDim2.new(0,314,0,314)
StaticTexture.Position = UDim2.new(0.2,0,0.8,0)
table.insert(ItemsTable,StaticTexture)

for i=1,12 do
	local F = Instance.new("Frame",ClockBase)
	
	local Progress = (i/12)*(math.pi*2)
	
	F.AnchorPoint = Vector2.one*0.5
	F.Position = UDim2.new(0.5+math.sin(Progress)/2.5,0,0.5+math.cos(Progress)/2.5,0)
	
	F.BorderSizePixel = 0
	F.Size = UDim2.new(0,1,0,3)
	F.Rotation = (GetRotationFromTicks(i)-90) * -1
	if F.Rotation%90 == 0 then
		F.Size += UDim2.new(0,1,0,1)
	end
	
	F.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	table.insert(ItemsTable,F)
end
for i=1,60 do
	local F = Instance.new("Frame",ClockBase)

	local Progress = (i/60)*(math.pi*2)

	F.AnchorPoint = Vector2.one*0.5
	F.Position = UDim2.new(0.5+math.sin(Progress)/2.6,0,0.5+math.cos(Progress)/2.6,0)

	F.BorderSizePixel = 0
	F.Size = UDim2.new(0,1,0,2)
	F.Rotation = (GetRotationFromTicks(i)-90) * -1
	F.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	table.insert(ItemsTable,F)
end

LongHand.Rotation = GetRotationFromTicks(CurrentTicks) 

local ClickConnection
local StaticFlipped = false
task.wait(0.1)

function Stepped(DT) -- DT doesnt stand for deltaTime. it stands for Drake Troverman!
	
	Speed = (CurrentLoops)
	
	Timer += Speed*DT
	
	

	if Shake > 0 then
		local Divider = 5000000/Shake
		game.Workspace.CurrentCamera.FieldOfView = lerp(70,70+(Shake/5),DT*3)
		game.Workspace.Camera.CFrame *= CFrame.fromEulerAngles(math.random(-1000,1000)/Divider,math.random(-1000,1000)/Divider,math.random(-2000,2000)/Divider)
	end
	
	if Timer > NextTick then 
		NextTick = Timer+1
		ClockSwing = true
		IncrementTicks()
		
		if CurrentLoops > 3 then
			SwooshSFXInstance.PlaybackSpeed = 1+(CurrentLoops/10)
			GearSFXInstance.PlaybackSpeed = math.log((1.4 + (CurrentTicks/400) )+(CurrentLoops/36)) * 2.5
		else
			SwooshSFXInstance.PlaybackSpeed = 1
			GearSFXInstance.PlaybackSpeed = math.log((1.4 + (CurrentTicks/400) )+(CurrentLoops/36)) * 2.5
		end
		
		GearSFXInstance:Play()
		local ClockSwingTime = (0.25*32)/(CurrentLoops+32)
		local Tween = TS:Create(LongHand,TweenInfo.new(ClockSwingTime,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{Rotation = GetRotationFromTicks(CurrentTicks)-0.5})
		Tween:Play()
		task.delay(1,function()
			Tween = nil -- NULLL!!!! AHAHAHA BAHAHA UR NULL HAHAH
		end)
		SwooshSFXInstance:Play()
		SwooshSFXInstance.Volume = math.clamp((CurrentLoops/100),0,0.2)
		task.delay(ClockSwingTime-0.01,function()
			TickSFXInstance:Play()
			SwooshSFXInstance:Stop()
			ClockSwing = false
			LastTick = 0
			OutlineVelocity += 1000/(10+CurrentLoops)
			
			local Outline2 = CreateImage(OutlinePrimary)
			Outline2.Size = UDim2.new(0,134,0,134)
			Outline2.ImageColor3 = Color3.new(0, 0, 0)
			Outline2.Position = UDim2.new(0.2,0,0.8,0)
			
			if CurrentTicks > 16 then
				Shake += (CurrentTicks-2)*0.25
			end
			
			local Shockwave = CreateImage(OutlinePrimary)
			Shockwave.Size = UDim2.new(0,134,0,134)
			Shockwave.ImageColor3 = Color3.new(0, 0, 0)
			Shockwave.Position = UDim2.new(0.2,0,0.8,0)
			Shockwave.ImageTransparency = 0.7
			
			local Tween = TS:Create(Shockwave,TweenInfo.new(10/(10+Speed),Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(0,235-(Speed*1),0,235-(Speed*1)),ImageTransparency=1})
			Tween:Play()
			task.delay(20/(10+Speed),function()
				Tween = nil -- NULLL!!!! AHAHAHA BAHAHA UR NULL HAHAH
			end)
			
			if CurrentTicks > 16 then
				
				local Shockwave = CreateImage(OutlineSecondary)
				Shockwave.Size = UDim2.new(0,134,0,134)
				Shockwave.ImageColor3 = Color3.new(0, 0, 0)
				Shockwave.Position = UDim2.new(0.2,0,0.8,0)
				Shockwave.ImageTransparency = 0.96

				local Tween = TS:Create(Shockwave,TweenInfo.new(140/(20+Speed),Enum.EasingStyle.Sine,Enum.EasingDirection.Out),{Size=UDim2.new(0,742,0,742),ImageTransparency=1})
				Tween:Play()
				task.delay(255/(20+Speed),function()
					Tween = nil -- NULLL!!!! AHAHAHA BAHAHA UR NULL HAHAH
				end)
				
			end
			
		end)
	end
	
	Outline3.Rotation += OutlineVelocity*DT
	local Subtractor = (DT*(50+OutlineVelocity))*0.7
	if OutlineVelocity > 0 then
		OutlineVelocity = math.clamp(OutlineVelocity-Subtractor,-1000,1000)
	end
	
	local Subtractor = (DT*(25+Shake))*1
	Shake = math.clamp(Shake-Subtractor,0,1000)
	
	if ClockSwing == false then
		
		LastTick += ((Speed+1)*DT) / (0.7+LastTick)
		
		local TickOffset = LastTick + ((math.pi/2)+1)
		
		LongHand.Rotation += math.sin(TickOffset*8)*((DT/ (.1+LastTick) )*(30/(1+LastTick))) -- math conglomerate
	end
	
	for i,v in pairs(GearTextures) do
		if CurrentTicks > 0 then
			v.Rotation += Speed*(DT*36)
		end
	end
	
	if CurrentTicks > 12 then
		StaticTexture.ImageTransparency = 1/((CurrentTicks-12)*0.05)
	else
		StaticTexture.ImageTransparency = 1
	end

	if game.UserInputService:IsKeyDown(Enum.KeyCode.Home) or CurrentTicks > 256 --[[this SHOULD not have any input conflicts]] then
		RS:UnbindFromRenderStep("ClockLolz")
		ClickConnection = nil
		for i,v in pairs(ItemsTable) do
			v:Destroy() -- this might have issues. but i dont care.
		end
		UI:Destroy()
		
		local StartFreeze = tick()
		
		if CurrentTicks > 250 then
			while true do
				if tick() > StartFreeze+5 then
					break
				end
			end
		end

	end
end
RS:BindToRenderStep("ClockLolz",Enum.RenderPriority.Camera.Value+1,Stepped) --ahahaha funny... not really.
ClickConnection = ClockBase.MouseButton1Down:Connect(function(x: number, y: number) 
	if CurrentLoops < 32 and GetTicksFromLoops() > 4 then
		local Length = 0.75+(CurrentTicks/30)
		CurrentLoops = 1
		CurrentTicks = 0
		Timer = 0
		NextTick = 2+Length
		LastTick = 5
		BlastSFXInstance:Play()
		if CurrentRealLoops < 0.5 then
			SmallSFXInstance:Play()
			Shake += 20
		else
			RewindSFXInstance:Play()
			Shake += 40
		end
		CurrentRealLoops = 0
		local Tween = TS:Create(LongHand,TweenInfo.new(Length,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{Rotation = GetRotationFromTicks(CurrentTicks)})
		Tween:Play()
		task.delay(Length+1,function()
			Tween = nil
		end)
		for i,v in pairs(GearTextures) do
			local Tween = TS:Create(v,TweenInfo.new(Length+2,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Rotation = GetRotationFromTicks(CurrentTicks)})
			Tween:Play()
			task.delay(Length+2,function()
				Tween = nil
			end)
		end

		task.spawn(function()
			for i=1,math.round( Length*25 ) do
				task.wait(1/30)
				OutlineVelocity /= 1.01
				if OutlineVelocity > 0 then
					OutlineVelocity /= 1.01
				end
				OutlineVelocity -= 15
			end
			for i=1,math.round( Length*5 ) do
				task.wait(1/30)
				OutlineVelocity /= 1.1
			end
		end)

	end
end)

task.spawn(function()
	while task.wait(1/30) do
		if StaticTexture.ImageTransparency < 1 then
			if StaticFlipped == false then
				StaticFlipped = true
				StaticTexture.Rotation = 180
			else
				StaticFlipped = false
				StaticTexture.Rotation = 0
			end
			StaticTexture.Position = UDim2.new(0.2+math.random(-1000,1000)/340000,0,0.8+math.random(-1000,1000)/340000,0)
		end

	end
end)
