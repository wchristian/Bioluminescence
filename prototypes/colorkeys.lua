require "__DragonIndustries__.strings"

local function parseColor(data)
	local clr = data.run_animation.layers[3].tint
	local ret = clr.r .. "-" .. clr.g .. "-" .. clr.b
	return ret
end

local function getRefname(basename)
	return "biter-color-reference-" .. basename
end

function getColor(bitername)
	local ref = getRefname(bitername)
	if ref == nil then return nil end
	local item = game.item_prototypes[ref]
	local clrstring = item.order
	local vals = splitString(clrstring, "%-")
	return {r = vals[1], g = vals[2], b = vals[3]}
end

local function createItem(data)
	return
	{
		type = "item",
		name = getRefname(data.name),
		icon = "__core__/graphics/empty.png",
		icon_size = 1,
		stack_size = 1,
		order = parseColor(data),
		hidden = true
	}
end

if data then
	for name,biter in pairs(data.raw.unit) do
		if string.find(name, "biter", 1, true) or string.find(name, "spitter", 1, true) then
			local ref = createItem(biter)
			log("Identified biter type '" .. name .. "' to be given color key '" .. ref.name .. "' and '" .. ref.order .. "'")
			data:extend({ref})
		end
	end
end