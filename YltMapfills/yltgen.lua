function Mapfill_yltgen2(Map_ID,Map_Size_X,Map_Size_Y,Map_Size_Z,args)

	local time = os.clock()

	local xrand = 4
	args = string.gsub(args, "yltgen", "")
	if args ~= "" then
		print(args)
		xrand = tonumber(args)

	end

	local sea = Map_Size_Z/2-1

	local z = sea

	local heights = {[0]=z}

	for y=0,Map_Size_Y do

		--z = (Map_Size_Z-1)*(y%2) --was to test it ;)
		local randNum = math.random(-1, 1)
		z = heights[0]+randNum

		for x=0,Map_Size_X do

			if heights[x] == nil then heights[x] = z end

			local dif = heights[x]-z

			if math.abs(dif) > 1 then

				if z > heights[x] then

					z = z-1

				else

					z = z+1

				end

			else

				if math.random(1,xrand) == 1 then

					local rand = math.random(0,Map_Size_Z)

					if rand > z then

						z = z+1

					else

						z = z-1

					end

				end

			end

			for iz=0,z-1 do

				Map.setblock(-1, Map_ID, x,y,iz, 3, 0, 0, 0, 0)

			end

			if z > sea then

				Map.setblock(-1, Map_ID, x,y,z, 2, 0, 0, 0, 0)

			else

				for iz=z,sea do

					Map.setblock(-1, Map_ID, x,y,iz, 8, 0, 0, 0, 0)

				end

				Map.setblock(-1, Map_ID, x,y,z, 12, 0, 0, 0, 0)

			end

			heights[x] = z

		end

	end

	time = os.clock()-time

	System.msgAll(Map_ID, string.format("&eTook %.3fms",time*1000))

end

function Mapfill_yltgen(...)

	print(pcall(Mapfill_yltgen2,...))

end

--Map_Fill(123, "yltgen")



System.msgAll(-1, "&eyltgen reloaded")
