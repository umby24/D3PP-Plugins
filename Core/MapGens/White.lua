function Mapfill_white(Map_ID, Map_Size_X, Map_Size_Y, Map_Size_Z)
	Material = 36 -- White
	Map.beginfill(Map_ID)

	local ix, iy, iz
	for ix = 0, Map_Size_X-1 do
		for iy = 0, Map_Size_Y-1 do
			iz = 0
			Map.setfillblock(Map_ID, ix, iy, iz, Material)
			--Map.setblock(-1, Map_ID, ix, iy, iz, Material, 0, 0, 0, 0)
		end
	end
	for ix = 0, Map_Size_X-1 do
		for iz = 0, Map_Size_Z/2-1 do
			iy = 0
			Map.setfillblock(Map_ID, ix, iy, iz, Material)
			iy = Map_Size_Y-1
			Map.setfillblock(Map_ID, ix, iy, iz, Material)
		end
	end
	for iy = 0, Map_Size_Y-1 do
		for iz = 0, Map_Size_Z/2-1 do
			ix = 0
			Map.setfillblock(Map_ID, ix, iy, iz, Material)
			ix = Map_Size_X-1
			Map.setfillblock(Map_ID, ix, iy, iz, Material)
		end
	end
	Map.endfill(Map_ID)
	System.msgAll(Map_ID, "&c Map done.")
end
