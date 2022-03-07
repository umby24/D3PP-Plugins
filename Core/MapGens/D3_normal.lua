local Height_Solid = 0
local Height_Water = 41
local Height_Sand = 42
local Height_Grass = 100

local function World_Block_Set(mapid, x, y, z, block, ...)

    Map.setblock(-1, mapid,x,y,z , block, 0, 0, 0, 0)
end
function DiamondRandomMap(Map, Size, Map_Pos_X_m, Map_Pos_Y_m, Size_Factor, Random_Factor, Seed)
	for ix = 1, Size, 2 do
		for iy = 1, Size, 2 do
			local Temp_Avg = (Map[ix+1][iy+1] + Map[ix-1][iy+1] + Map[ix+1][iy-1] + Map[ix-1][iy-1]) / 4
			local Temp_Max = math.max(math.abs(Temp_Avg-Map[ix+1][iy+1]), math.abs(Temp_Avg-Map[ix-1][iy+1]), math.abs(Temp_Avg-Map[ix+1][iy-1]), math.abs(Temp_Avg-Map[ix-1][iy-1]))
			local Random_Val = 	Random(Map_Pos_X_m + ix*Size_Factor, Map_Pos_Y_m + iy*Size_Factor, Seed)
			local Random_Val_Timzed = (Random_Val*2-1)
			local Final_Val = Temp_Avg + Random_Val_Timzed * Temp_Max * Random_Factor
			Map[ix][iy] = Final_Val
		end
	end

	return Map
end
function Random(X, Y, Seed)
	local Value = X + Y*1.2345 + Seed*5.6789
	local Value = Value + Value - X
	local Value = Value + Value + Y
	local Value = Value + Value + X * 12.3
	local Value = Value + Value - Y * 45.6
	local Value = Value + math.sin(X*78.9012)+Y + math.cos(Seed*78.9012)
	local Value = Value + math.cos(Y*12.3456)-X + math.sin(Seed*Value+Value+X)
	local Value = Value + math.sin(Y*45.6789)+X + math.cos(Seed*Value+Value-Y)
	return Value - math.floor(Value)
end

function Quantize(X, Y, Factor)
	return math.floor(X/Factor)*Factor, math.floor(Y/Factor)*Factor
end

function DoubleMap(Map, Size)
	local max = 0;

	for ix = Size+1, Size*2 do
		Map[ix] = {}
	end

	for ix = Size, 0, -1 do
		for iy = Size, 0, -1 do
			if (ix == 1 and iy == 1) then
				
			end
			Map[ix*2][iy*2] = Map[ix][iy]
			if Map[ix*2][iy*2] == nil then
				print("Setting a nil!")
			end
		end
	end

	return Map
end
function SquareRandomMap(Map, Size, Map_Pos_X_m, Map_Pos_Y_m, Size_Factor, Random_Factor, Seed)
	for ix = 0, Size, 2 do
		for iy = 1, Size, 2 do
			local Temp_Avg = (Map[ix][iy-1] + Map[ix][iy+1]) / 2 -- Average of blocks to right and left of current block
			local Temp_Max = math.max(math.abs(Temp_Avg-Map[ix][iy-1]), math.abs(Temp_Avg-Map[ix][iy+1])) -- Maximum of those two
			Map[ix][iy] = Temp_Avg + ((Random(Map_Pos_X_m + ix*Size_Factor, Map_Pos_Y_m + iy*Size_Factor, Seed)*2-1) * Temp_Max * Random_Factor)
		end
	end
	for ix = 1, Size, 2 do
		for iy = 0, Size, 2 do
			local Temp_Avg = (Map[ix-1][iy] + Map[ix+1][iy]) / 2 -- Average of blocks above and below current block
			local Temp_Max = math.max(math.abs(Temp_Avg-Map[ix-1][iy]), math.abs(Temp_Avg-Map[ix+1][iy])) -- Max of those blocks
			Map[ix][iy] = Temp_Avg + ((Random(Map_Pos_X_m + ix*Size_Factor, Map_Pos_Y_m + iy*Size_Factor, Seed)*2-1) * Temp_Max * Random_Factor)
		end
	end

	return Map
end

function DiamondHeightMap(Map, Size)

	for ix = 1, Size, 2 do
		for iy = 1, Size, 2 do
			Map[ix][iy] = (Map[ix+1][iy+1] + Map[ix-1][iy+1] + Map[ix+1][iy-1] + Map[ix-1][iy-1]) / 4
		end
	end
	return Map
end

function SquareHeightMap(Map, Size)
	for ix = 0, Size, 2 do
		for iy = 1, Size, 2 do
			Map[ix][iy] = (Map[ix][iy-1] + Map[ix][iy+1]) / 2
		end
	end
	for ix = 1, Size, 2 do
		for iy = 0, Size, 2 do
			Map[ix][iy] = (Map[ix-1][iy] + Map[ix+1][iy]) / 2
		end
	end
	return Map
end
function Random_Map(Chunk_X, Chunk_Y, Chunks, Result_Size, Randomness, Seed)
	local Chunk_Size = 16 -- in m
	local Map_Divider = Chunks -- in 1
	local Map_Pos_X, Map_Pos_Y = Quantize(Chunk_X, Chunk_Y, Map_Divider) -- in Chunks
	local Map_Pos_X_m, Map_Pos_Y_m = Map_Pos_X*Chunk_Size, Map_Pos_Y*Chunk_Size -- in m
	local Map_Offset_X, Map_Offset_Y = Chunk_X-Map_Pos_X, Chunk_Y-Map_Pos_Y -- in Chunks
	--local Map_Offset_X_m, Map_Offset_Y_m = Map_Offset_X*Chunk_Size/Result_Size, Map_Offset_Y*Chunk_Size/Result_Size -- in m

	local Map = {}
	-- Fill it with random start values
	local Size = 1 -- (2x2)
	for ix = 0, Size do
		Map[ix] = {}
		for iy = 0, Size do
			local mx = Map_Pos_X_m + ix*Chunk_Size*Chunks
			local my = Map_Pos_Y_m + iy*Chunk_Size*Chunks
			local randomVal = Random(Map_Pos_X_m + ix*Chunk_Size*Chunks, Map_Pos_Y_m + iy*Chunk_Size*Chunks, Seed)
			Map[ix][iy] = randomVal
		end
	end

	-- Do the iterations
	while Size < Chunks*Result_Size do
		-- Resize the array
		Map = DoubleMap(Map, Size)
		Size = Size * 2
		
		local Size_Factor = Chunks*Chunk_Size / Size
		
		local Random_Factor = Randomness
		
		-- The diamond step
		Map = DiamondRandomMap(Map, Size, Map_Pos_X_m, Map_Pos_Y_m, Size_Factor, Random_Factor, Seed)

		-- The square step
		Map = SquareRandomMap(Map, Size, Map_Pos_X_m, Map_Pos_Y_m, Size_Factor, Random_Factor, Seed)
	end
	
	-- Return the Map
	local Result = {}
	
	for ix = 0, Result_Size do
		Result[ix] = {}
		for iy = 0, Result_Size do
			Result[ix][iy] = Map[Map_Offset_X*Result_Size+ix][Map_Offset_Y*Result_Size+iy]
		end
	end

	return Result
end

function Heightmap_Fractal(Chunk_X, Chunk_Y, Quantisation, It_Per_Chunk, Randomness, Seed)
	local Chunk_Size = 16
	-- Fill it with random start values
	local Size = It_Per_Chunk -- (2x2)

	local Heightmap = Random_Map(Chunk_X, Chunk_Y, Quantisation, Size, Randomness, Seed) -- 0,0, 0, 1, 1,0, 1, 1... 2x2 chunk.
	-- Do the iterations
	while Size < Chunk_Size do
		
		-- Resize the array
		for ix = Size+1, Size*2 do
			Heightmap[ix] = {}
			--for iy = Size+1, Size*2 do
			--	Heightmap[ix][iy] = 0
			--end
		end
		for ix = Size, 0, -1 do
			for iy = Size, 0, -1 do
				Heightmap[ix*2][iy*2] = Heightmap[ix][iy]
			end
		end
		Size = Size * 2
		
		-- The diamond step
		Heightmap = DiamondHeightMap(Heightmap, Size)
		
		-- The square step
		Heightmap = SquareHeightMap(Heightmap, Size)
	end
	
	-- Return the Heightmap
	
	return Heightmap
end
function create_tree(Map_ID, X, Y, Z, Size, Type)
    Map.setblock(-1, Map_ID,X, Y, Z-1, 3, 0, 0, 0, 0)
	if Type == 'oak' then
		local Block_Size = math.floor(Size * 5)
		if Block_Size > 7 then Block_Size = 7 end
		if Block_Size < 6 then Block_Size = 6 end
		for iz = 0, Block_Size-2 do
			--World_Block_Set(World_ID, X, Y, Z+iz, 17, 0, 0, 0, 0, 0, 0, 0)
            Map.setblock(-1, Map_ID,X, Y, Z+iz, 17, 0, 0, 0, 0)
		end
		local Radius = 0.5
		for iz = Block_Size, Block_Size-4, -1 do
			local Int_Radius = math.ceil(Radius)
			for ix = -Int_Radius, Int_Radius do
				for iy = -Int_Radius, Int_Radius do
					local Dist = math.sqrt(ix^2 + iy^2)
					if Dist <= Radius then
						--local Result, Type = World_Block_Get(World_ID, X+ix, Y+iy, Z+iz)
                        local Type = Map.getblock(Map_ID, X+ix, Y+iy, Z+iz)
						--if Result and Type == 0 then
                        if Type == 0 then
							if iz >= Block_Size then
								--World_Block_Set(World_ID, X+ix, Y+iy, Z+iz, 18, 0, -1, -1, 0, 1, 1, 0)
                                Map.setblock(-1, Map_ID,X+ix, Y+iy, Z+iz, 18, 0, 0, 0, 0)
							else
								--World_Block_Set(World_ID, X+ix, Y+iy, Z+iz, 18, 0, -1, -1, 0, 1, 0, 0)
                                Map.setblock(-1, Map_ID,X+ix, Y+iy, Z+iz, 18, 0, 0, 0, 0)
							end
						end
					end
				end
			end
			if Radius < 2 then
				Radius = Radius + 0.7
			end
		end
	elseif Type == 'birch' then
		local Block_Size = math.floor(Size * 5)
		if Block_Size > 7 then Block_Size = 7 end
		if Block_Size < 6 then Block_Size = 6 end
		for iz = 0, Block_Size-2 do
			--World_Block_Set(World_ID, X, Y, Z+iz, 17, 2, 0, 0, 0, 0, 0, 0)
            Map.setblock(-1, Map_ID,X, Y, Z+iz, 108, 0, 0, 0, 0)
		end
		local Radius = 0.5
		for iz = Block_Size, Block_Size-4, -1 do
			local Int_Radius = math.ceil(Radius)
			for ix = -Int_Radius, Int_Radius do
				for iy = -Int_Radius, Int_Radius do
					local Dist = math.sqrt(ix^2 + iy^2)
					if Dist <= Radius then
						--local Result, Type = World_Block_Get(World_ID, X+ix, Y+iy, Z+iz)
						--if Result and Type == 0 then
                        local Type = Map.getblock(Map_ID, X+ix, Y+iy, Z+iz)
                        if Type == 0 then
							if iz >= Block_Size then
								--World_Block_Set(World_ID, X+ix, Y+iy, Z+iz, 18, 2, -1, -1, 0, 1, 1, 0)
                                Map.setblock(-1, Map_ID,X+ix, Y+iy, Z+iz, 110, 0, 0, 0, 0)
							else
								--World_Block_Set(World_ID, X+ix, Y+iy, Z+iz, 18, 2, -1, -1, 0, 1, 0, 0)
                                Map.setblock(-1, Map_ID,X+ix, Y+iy, Z+iz, 110, 0, 0, 0, 0)
							end
						end
					end
				end
			end
			if Radius < 2 then
				Radius = Radius + 0.7
			end
		end
	elseif Type == 'pine' then
		local Block_Size = math.floor(Size * 7)
		for iz = 0, Block_Size-2 do
			--World_Block_Set(World_ID, X, Y, Z+iz, 17, 1, 0, 0, 0, 0, 0, 0)
            Map.setblock(-1, Map_ID,X, Y, Z+iz, 107, 0, 0, 0, 0)
		end
		local Radius = 0
		local Step = 0
		for iz = Block_Size, 3, -1 do
			for ix = -Radius, Radius do
				for iy = -Radius, Radius do
					if Radius == 0 or ( math.abs(ix) < Radius and math.abs(iy) < Radius ) then
						--local Result, Type = World_Block_Get(World_ID, X+ix, Y+iy, Z+iz)
						--if Result and Type == 0 then
                        local Type = Map.getblock(Map_ID, X+ix, Y+iy, Z+iz)
                        if Type == 0 then
							if iz >= Block_Size-2 then
								--World_Block_Set(World_ID, X+ix, Y+iy, Z+iz, 18, 1, -1, -1, 0, 1, 1, 0)
                                Map.setblock(-1, Map_ID,X+ix, Y+iy, Z+iz, 111, 0, 0, 0, 0)
							else
								--World_Block_Set(World_ID, X+ix, Y+iy, Z+iz, 18, 1, -1, -1, 0, 1, 0, 0)
                                Map.setblock(-1, Map_ID,X+ix, Y+iy, Z+iz, 111, 0, 0, 0, 0)
							end
						end
					end
				end
			end
			Step = Step + 1
			if Step == 3 then
				Step = 0
				Radius = Radius - 1
			else
				Radius = Radius + 1
			end
		end
	end
end

function smp_normal(World_ID, Chunk_X, Chunk_Y, Seed, Generation_State)
	local Chunk_Size = 16
	local Offset_X = Chunk_X * Chunk_Size -- in Blocks
	local Offset_Y = Chunk_Y * Chunk_Size -- in Blocks
	
	Start_Time = os.clock()
	
	if Generation_State == 1 then
		local Heightmap = Heightmap_Fractal(Chunk_X, Chunk_Y, 8, 4, 1, Seed)
		local Roughtmap = Heightmap_Fractal(Chunk_X+1, Chunk_Y+1, 2, 1, 0.5, Seed+1)
		local Offsetmap = Heightmap_Fractal(Chunk_X+1, Chunk_Y+1, 8, 1, 0.2, Seed+2)
		
		-- Build the chunk
		for ix = 0, Chunk_Size-1 do
			for iy = 0, Chunk_Size-1 do
				
				local Offset = (math.cos(Offsetmap[ix][iy]*12+2)-1+2*Offsetmap[ix][iy]*6)*7
				
				local Height = math.floor(Offset + Heightmap[ix][iy]*Roughtmap[ix][iy]*50)
				local Stone_Height = math.floor(Height - (0.6-Offsetmap[ix][iy]*Roughtmap[ix][iy])*20)
				
				local Max_Height = math.max(0, Height, Height_Water, Stone_Height)
				
				for iz = 0, Max_Height do
					if iz <= Height_Solid then
						World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 7, 0, 0, 0, 0, 0, 0, 0)
					elseif iz <= Height_Water then
						if iz <= Stone_Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 1, 0, 0, 0, 0, 0, 0, 0)
						elseif iz < Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 3, 0, 0, 0, 0, 0, 0, 0)
						elseif iz == Height then
							if iz < Height_Water - 3 then
								World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 13, 0, 0, 0, 0, 0, 0, 0)
							else
								World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 12, 0, 0, 0, 0, 0, 0, 0)
							end
						else
							if iz == Max_Height then
								World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 8, 0, 0, 0, 0, 0, 1, 0)
							else
								World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 8, 0, 0, 0, 0, 0, 0, 0)
							end
						end
					elseif iz <= Height_Sand then
						if iz <= Stone_Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 1, 0, 0, 0, 0, 0, 0, 0)
						elseif iz+1 < Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 3, 0, 0, 0, 0, 0, 0, 0)
						else
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 12, 0, 0, 0, 0, 0, 0, 0)
						end
					elseif iz <= Height_Grass-Roughtmap[ix][iy]*15 then
						if iz <= Stone_Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 1, 0, 0, 0, 0, 0, 0, 0)
						elseif iz < Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 3, 0, 0, 0, 0, 0, 0, 0)
						else
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 2, 0, 0, 0, 0, 0, 0, 0)
							--World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz+1, 59, math.abs(math.sin((Offset_X+ix)/10+(Offset_Y+iy)/12))*3, -1, -1, 0, 0, 0, 0)
						end
					else
						if iz < Stone_Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 1, 0, 0, 0, 0, 0, 0, 0)
						elseif iz == Stone_Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 1, 0, 0, 0, 0, 0, 0, 0)
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz+1, 53, 0, -1, -1, 0, 0, 0, 0)
						elseif iz < Height then
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 3, 0, 0, 0, 0, 0, 0, 0)
						else
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz, 2, 0, 0, 0, 0, 0, 0, 0)
							World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, iz+1, 53, 0, -1, -1, 0, 0, 0, 0)
						end
					end
				end
			end
		end
		return 100 -- Next step ONLY if there are neighbours around the chunk
	else-- Build the trees, decoration
		local Heightmap = Heightmap_Fractal(Chunk_X, Chunk_Y, 8, 4, 1, Seed)
		local Roughtmap = Heightmap_Fractal(Chunk_X+1, Chunk_Y+1, 2, 1, 0.5, Seed+1)
		local Offsetmap = Heightmap_Fractal(Chunk_X+1, Chunk_Y+1, 8, 1, 0.2, Seed+2)
		local Treetypemap = Heightmap_Fractal(Chunk_X, Chunk_Y, 8, 1, 0.0, Seed+3)
		local Treetype
		
		-- Some wild grass, flowers
		for i = 1, Treetypemap[7][7]*20 do
			local ix = math.floor(math.random()*(Chunk_Size))
			local iy = math.floor(math.random()*(Chunk_Size))
			
			local Offset = (math.cos(Offsetmap[ix][iy]*12+2)-1+2*Offsetmap[ix][iy]*6)*7
			local Height = math.floor(Offset + Heightmap[ix][iy]*Roughtmap[ix][iy]*50)
			
			-- Result, Type, Metadata, Blocklight, Skylight, Player = World_Block_Get(World_ID, Offset_X+ix, Offset_Y+iy, Height)
            local Type = Map.getblock(World_ID, Offset_X+ix, Offset_Y+iy, Height)
			if Type == 2 then
				local Deco_Type = math.floor(math.random()*20)
				if Deco_Type == 0 then
					World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, Height+1, 37, 0, -1, -1, 0, 0, 0, 0)
				elseif Deco_Type == 1 then
					World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, Height+1, 38, 0, -1, -1, 0, 0, 0, 0)
				else
					World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, Height+1, 37, 1, -1, -1, 0, 0, 0, 0)
				end
			elseif Type == 8 then
				local Deco_Type = math.floor(math.random()*10)
				if Deco_Type == 0 then
					World_Block_Set(World_ID, Offset_X+ix, Offset_Y+iy, Height+1, 112, 0, -1, -1, 0, 0, 0, 0)
				else
				end
			end
		end
		
		-- some trees
		for i = 1, 6 do
			local ix = math.floor(math.random()*(Chunk_Size))
			local iy = math.floor(math.random()*(Chunk_Size))
			
			local Offset = (math.cos(Offsetmap[ix][iy]*12+2)-1+2*Offsetmap[ix][iy]*6)*7
			local Height = math.floor(Offset + Heightmap[ix][iy]*Roughtmap[ix][iy]*50)
			
			if Treetypemap[ix][iy] <= 0.2 then
				Treetype = ""
			elseif Treetypemap[ix][iy] <= 0.4 then
				Treetype = "pine"
			elseif Treetypemap[ix][iy] <= 0.6 then
				Treetype = "birch"
			elseif Treetypemap[ix][iy] <= 0.8 then
				Treetype = "oak"
			else
				Treetype = ""
			end
			
			--local Result, Type, Metadata, Blocklight, Skylight, Player = World_Block_Get(World_ID, Offset_X+ix, Offset_Y+iy, Height)
            local Type = Map.getblock(World_ID, Offset_X+ix, Offset_Y+iy, Height)
			if Type == 2 and Treetype ~= "" then
				--Mapfill_Tree(World_ID, Offset_X+ix, Offset_Y+iy, Height+1, 1+math.random(), Treetype)
                for iix = -1, 1 do
                    for iiy = -1, 1 do
                        if Treetypemap[Offset_X+ix+iix] ~= nil and Treetypemap[Offset_X+ix+iix][Offset_Y+iy+iiy] ~= nil then
                            Treetypemap[Offset_X+ix+iix][Offset_Y+iy+iiy] = 0
                        end
                    end
                end
                create_tree(World_ID, Offset_X+ix, Offset_Y+iy, Height+1, 1+math.random(), Treetype)
			end
		end
		return 0 -- Disables any further generation steps
	end
	
	return 0 -- should never be reached
end

function Mapfill_smpnormal(Map_ID,MapX,MapY,MapZ,args)
	local chunkX, chunkY = MapX/16, MapY/16

	Height_Water = (MapZ/2) - 1
	Height_Sand = Height_Water + 1
    local mapseed = tonumber(args)
    if mapseed == nil then mapseed = math.random() end
    
    System.msgAll(Map_ID, "&eSeed: "..tostring(mapseed))
    for x = 0, chunkX-1 do
        for y = 0, chunkY-1 do
            smp_normal(Map_ID, x, y, mapseed, 1)
            smp_normal(Map_ID, x, y, mapseed, 2)
        end
    end
    
    System.msgAll(Map_ID, "&aDone!")
    
    
    
end

System.msgAll(-1, "&aSMPNormal Reloaded")
