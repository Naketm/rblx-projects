-- Example Script

local Dictionary = require(script.Dictionary)

local Data_Template = 
	{
		Rank = "Alpha",
		Level = 19,
		Age = 17,
		Name = 'Sera Williams',
		EXP = 900,
		Coins = 200,
	}

local Data = Dictionary.bind(Data_Template)

local isFirstChange: boolean = true

Data.Changed:Connect(function(key, value)

	
	if type(value) == "number" and isFirstChange then
		Data:rawset(key, value+10)
		isFirstChange = false
	end
end)

Data["Level"] = 10
print(Data["Level"]) -- will return 20
