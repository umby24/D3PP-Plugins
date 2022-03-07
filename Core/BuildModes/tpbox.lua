
function Build_Mode_Teleporter_Box(Client_ID, Map_ID, X, Y, Z, Mode, Block_Type)
	if Mode == 1 then
		local State = BuildMode.getstate(Client_ID)
		
		if State == 0 then -- Ersten Punkt w�hlen
			BuildMode.setcoordinate(Client_ID, 0, X, Y, Z)
			BuildMode.setstate(Client_ID, 1)
			
		elseif State == 1 then -- Zweiten Punkt w�hlen und bauen
			local X_0, Y_0, Z_0, X_1, Y_1, Z_1 = X, Y, Z, BuildMode.getcoordinate(Client_ID, 0)
			local Dest_Map_Unique_ID, Dest_X, Dest_Y, Dest_Z, Dest_Rot, Dest_Look = BuildMode.getstring(Client_ID, 1), BuildMode.getfloat(Client_ID, 0), BuildMode.getfloat(Client_ID, 1), BuildMode.getfloat(Client_ID, 2), BuildMode.getfloat(Client_ID, 3), BuildMode.getfloat(Client_ID, 4)
			local Dest_Map_ID = BuildMode.getlong(Client_ID, 0)
			local Name = BuildMode.getstring(Client_ID, 0)
			
			Teleporter.add(Map_ID, Name, X_0, Y_0, Z_0, X_1, Y_1, Z_1, Dest_Map_Unique_ID, Dest_Map_ID, Dest_X, Dest_Y, Dest_Z, Dest_Rot, Dest_Look)
			System.msg(Client_ID, "&eTeleporter created.")
			
			BuildMode.set(Client_ID, "Normal")
		end
		
	end
	
end