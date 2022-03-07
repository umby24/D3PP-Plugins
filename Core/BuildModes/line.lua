
function Build_Mode_Line(Client_ID, Map_ID, X, Y, Z, Mode, Block_Type)
	if Mode == 1 then
		
		local State = BuildMode.getstate(Client_ID)
		
		if State == 0 then -- Ersten Punkt w�hlen
			BuildMode.setcoordinate(Client_ID, 0, X, Y, Z)
			BuildMode.setstate(Client_ID, 1)
			
		elseif State == 1 then -- Zweiten Punkt w�hlen und bauen
			local X_0, Y_0, Z_0, X_1, Y_1, Z_1 = X, Y, Z, BuildMode.getcoordinate(Client_ID, 0)
			
			local Player_Number = Entity.getplayer(Client.getentity(Client_ID))
			
			Build.line(Player_Number, Map_ID, X_0, Y_0, Z_0, X_1, Y_1, Z_1, Block_Type, 10, 1, 1)
			System.msg(Client_ID, "&eBuildmode: Line created")
			
			BuildMode.set(Client_ID, "Normal")
		end
		
	end
	
end