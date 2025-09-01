local dict = require(script.Dictionary)
local data = {}

for i = 1, 2000 do
	data["Entry" .. i] = {
		value = math.random(1000, 10000)
	}
end

local heavyMapFn = [[
	function(name, pdata)
		local x = pdata.value
		local result = 0
		for i = 1, 1000 do
			for j = 1, 50 do
				result += math.sin(x + i * j) ^ 2
				result += math.cos(x - i * j) ^ 1.5
				result = result % 100000 -- keep number reasonable
			end
		end
		return {computed = result, original = x}
	end
]]

local startParallel = os.clock()
local resultParallel = dict.mapParallel(data, heavyMapFn, 8)
local elapsedParallel = os.clock() - startParallel
print("Parallel map completed in", elapsedParallel, "seconds")
print("Parallel results count:", dict.len(resultParallel))

local function heavyMapSerial(name, pdata)
	local x = pdata.value
	local result = 0
	for i = 1, 1000 do
		for j = 1, 50 do
			result += math.sin(x + i * j) ^ 2
			result += math.cos(x - i * j) ^ 1.5
			result = result % 100000
		end
	end
	return {computed = result, original = x}
end

local startSerial = os.clock()
local resultSerial = dict.map(data, heavyMapSerial)
local elapsedSerial = os.clock() - startSerial
print("Serial map completed in", elapsedSerial, "seconds")
print("Serial results count:", dict.len(resultSerial))
