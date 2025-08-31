-- Example Script

-- https://medal.tv/games/roblox-studio/clips/l0DbJl7JZ0GpTt6Wn?invite=cr-MSxyckMsNDQwNDM2NTY5&v=12

local Dictionary = require(script.Dictionary)

local Data = 
	{
		Rank = "Alpha",
		Level = 19,
		Age = 17,
		Name = 'Sera Williams',
		EXP = 900,
		Coins = 200,
	}

Dictionary.bind(Data)

local isFirstChange: boolean = true

Data.Changed:Connect(function(key, value)

	
	if type(value) == "number" and isFirstChange then
		Data:rawset(key, value+10)
		isFirstChange = false
	end
end)

Data["Level"] = 10
print(Data["Level"]) -- will return 20
