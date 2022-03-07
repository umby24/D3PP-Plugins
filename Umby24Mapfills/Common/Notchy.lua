local heightMap = {}
local MapInfo = {}
local minHeight = 0
local waterLevel = 0

local function CreateHeightmap(mapX, mapY, waterLevel)
    heightMap = {}
    local index = 1
    for y = 1, mapY do
        for x = 1, mapX do
            local hLow = ComputeCombinedNoise(8, x*1.3, y*1.3) / 6 - 4
            local height = hLow

            if (ComputeOctaveNoise(6, x, y) <= 0) then
                local hHIgh = ComputeCombinedNoise(8, x*1.3, y*1.3) / 5 + 6
                height = math.max(hHIgh, hLow)
            end
            height = height * 0.5
            if (height < 0) then height = height * 0.8
            end

            local heightAdj = (height + waterLevel)
            
            if (heightAdj < minHeight) then minHeight = heightAdj end
            heightMap[index] = heightAdj
            index = index + 1
        end
    end
end

local function CreateStrataFast()
    local mapIndex = 0
    for y=0, MapInfo["SizeY"]-1 do
        for x = 0, MapInfo["SizeX"]-1 do
            Map.setblock(-1, MapInfo["id"], x, y, 0, 11, 0, 0, 0, 3)
        end
    end

    local stoneHeight = minHeight - 14
    
    if (stoneHeight <= 0) then
        return 1
    end
    
    for z=1, stoneHeight+1 do
        for y=0, MapInfo["SizeY"]-1 do
            for x=0, MapInfo["SizeX"]-1 do
                Map.setblock(-1, MapInfo["id"], x, y, z, 1, 0, 0, 0, 3)
            end
        end
    end

    return stoneHeight
end

local function CreateStrata()
    local hMapIndex = 1
    local maxZ = MapInfo["SizeZ"] - 1
    local mapIndex = 0
    local minStoneZ = CreateStrataFast()

    for y=0, MapInfo["SizeY"]-1 do
        for x = 0, MapInfo["SizeX"]-1 do
            local dirtThickness = (ComputeOctaveNoise(8, x, y) / 24) - 4
            local dirtHeight = heightMap[hMapIndex]
            hMapIndex = hMapIndex + 1
            local stoneHeight = dirtHeight + dirtThickness

            stoneHeight = math.min(stoneHeight, maxZ)
            dirtHeight = math.min(dirtHeight, maxZ)

            for z=minStoneZ, stoneHeight+1 do
                Map.setblock(-1, MapInfo["id"], x, y, z, 1, 0, 0, 0, 3)    
            end
            for z=stoneHeight+1, dirtHeight do
                Map.setblock(-1, MapInfo["id"], x, y, z, 3, 0, 0, 0, 3)    
            end
            --Map.setblock(-1, MapInfo["id"], x, y, 0, 11, 0, 0, 0, 3)
        end
    end
end



local function CarveCaves()
end

local function CarveOreVeins()
end

local function FloodFillWaterBorders()

end

local function FloodFillWater()
end

local function FloodFillLava()
end

local function CreateSurfaceLayer(mapId, mapX, mapY, mapZ)
    local hMapIndex = 0

    for y = 0, mapY-1 do
        for x = 0, mapX-1 do

            local z = heightMap[hMapIndex + 1]
            hMapIndex = hMapIndex + 1
            if (z < 0 or z >= mapZ) then
                -- noop
            else
                local blockAbove = 0
                if z > (mapZ - 1) then
                else
                    blockAbove = Map.getblock(mapId, x, y, z+1)
                end

                if blockAbove == 7 and GenerateOctaveNoise(8, x, y) > 12 then
                    Map.setblock(-1, mapId, x, y, z, 13, 0, 0, 0, 3) -- Gravel
                elseif blockAbove == 0 or blockAbove == -1 then
                        if z <= (mapZ/2) and ComputeOctaveNoise(8, x, y) > 8 then
                            Map.setblock(-1, mapId, x, y, z, 12, 0, 0, 0, 3) -- Sand
                        else
                            Map.setblock(-1, mapId, x, y, z, 2, 0, 0, 0, 3) -- Grass
                        end
                end
            end
        end
    end
end

local function PlantFlowers()
    local numPatches = (MapInfo["SizeX"] * MapInfo["SizeY"]) / 3000
    for i = 0, numPatches-1 do
        local type = 37 + (math.random(0,2))
        local patchX = math.random(0, MapInfo["SizeX"])
        local patchY = math.random(0, MapInfo["SizeY"])

        for j=0, 9 do
            local flowerX = patchX
            local flowerY = patchY
            for k = 0, 4 do
                flowerX = flowerX + (math.random(0, 6) - math.random(0, 6))
                flowerY = flowerY + (math.random(0, 6) - math.random(0, 6))
                if (flowerX < 0 or flowerY < 0 or flowerX >= MapInfo["SizeX"] or flowerY >= MapInfo["SizeY"]) then
                    -- nothing
                else
                    local flowerZ = heightMap[flowerY*MapInfo["SizeX"]+flowerX+1]+1
                    if (flowerZ <= 0 or flowerZ >= MapInfo["SizeZ"]) then
                        -- nothing
                    else
                        local blockBelow = Map.getblock(MapInfo["id"], flowerX, flowerY, flowerZ-1)
                        local blocktoPlace = Map.getblock(MapInfo["id"], flowerX, flowerY, flowerZ)
                        if (blocktoPlace == 0 and blockBelow == 2) then
                            Map.setblock(-1, MapInfo["id"], flowerX, flowerY, flowerZ, type, 0, 0, 0, 3)
                        end
                    end
                end
            end
        end
    end
end

local function PlantMushrooms()

end

local function PlantTrees()
end

function Mapfill_notchy(Map_ID, Map_Size_X, Map_Size_Y, Map_Size_Z, arguments)
    MapInfo["SizeX"] = Map_Size_X
    MapInfo["SizeY"] = Map_Size_Y
    MapInfo["SizeZ"] = Map_Size_Z
    MapInfo["id"] = Map_ID
    minHeight = Map_Size_Z
    waterLevel = Map_Size_Z / 2

    CreateHeightmap(Map_Size_X, Map_Size_Y, waterLevel)
    CreateStrata()
    CreateSurfaceLayer(Map_ID, Map_Size_X, Map_Size_Y, Map_Size_Z)
    PlantFlowers()
end

System.msgAll(-1, "Reloaded Notchy Generator")