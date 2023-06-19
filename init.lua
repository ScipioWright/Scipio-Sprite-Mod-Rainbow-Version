dofile_once("data/scripts/lib/utilities.lua") -- Noita's internal utilities

local TRANSLATIONS_FILE = "data/translations/common.csv"
local translations = ModTextFileGetContent(TRANSLATIONS_FILE) .. ModTextFileGetContent("data/rainbow-scipio/translations.csv")
ModTextFileSetContent(TRANSLATIONS_FILE, translations)

local function get_player()
	return EntityGetWithTag("player_unit")[1]
end

local function get_arm()
	return EntityGetWithTag("player_arm_r")[1]
end

local function choose_randoms_from_list(list)
	-- list needs to have 3 items in it. It can have more, but it shouldn't
	-- table.remove returns the removed result, similar to pop in python
	local result1 = table.remove(list, Random(1, #list))
	local result2 = table.remove(list, Random(1, #list))
	local result3 = list[1]
	return result1, result2, result3
end

function OnWorldPostUpdate()
	-- if you just pressed the left mouse button
	if InputIsMouseButtonJustDown(1) then
		local player_id = get_player()
		local arm_id = get_arm()
		-- the components are labelled with tags, see player_base.xml
		local red_comp = EntityGetFirstComponent(player_id, "SpriteComponent", "player_red")
		local green_comp = EntityGetFirstComponent(player_id, "SpriteComponent", "player_green")
		local blue_comp = EntityGetFirstComponent(player_id, "SpriteComponent", "player_blue")
		local red_arm_comp = EntityGetFirstComponent(arm_id, "SpriteComponent", "arm_red")
		local green_arm_comp = EntityGetFirstComponent(arm_id, "SpriteComponent", "arm_green")
		local blue_arm_comp = EntityGetFirstComponent(arm_id, "SpriteComponent", "arm_blue")
		local r1 = rand(0, 1)
		local r2 = rand(0, 1 - r1)
		local r3 = 1 - r1 - r2
		local array = {r1, r2, r3}
		local alpha1, alpha2, alpha3 = choose_randoms_from_list(array)
		ComponentSetValue2(red_comp, "alpha", alpha1)
		ComponentSetValue2(red_arm_comp, "alpha", alpha1)
		ComponentSetValue2(green_comp, "alpha", alpha2)
		ComponentSetValue2(green_arm_comp, "alpha", alpha2)
		ComponentSetValue2(blue_comp, "alpha", alpha3)
		ComponentSetValue2(blue_arm_comp, "alpha", alpha3)
	end
end
