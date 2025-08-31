local actor = script.Parent
local op = script:GetAttribute("Operation") or "filter"

actor:BindToMessageParallel("Work", function(chunk, fnSource, SliceIndex, SharedResults)
	local ok, f = pcall(function() return loadstring("return "..fnSource)() end)
	if not ok or type(f) ~= "function" then
		warn("Loadstring failed", ok, tostring(f))
		SharedResults[SliceIndex] = {}
		return
	end

	local output = {}
	if op == "map" then
		for k, v in pairs(chunk) do
			output[k] = f(k, v)
		end
	else
		for k, v in pairs(chunk) do
			if f(k, v) then
				output[k] = v
			end
		end
	end

	task.synchronize()
	SharedResults[SliceIndex] = output
end)
