
function Build_Mode_Box(Client_ID, Map_ID, X, Y, Z, Mode, Block_Type)
	if Mode == 1 then
		
		local State = BuildMode.getstate(Client_ID)
		
		if State == 0 then -- Ersten Punkt w�hlen
			BuildMode.setcoordinate(Client_ID, 0, X, Y, Z)
			BuildMode.setstate(Client_ID, 1)
			
		elseif State == 1 then -- Zweiten Punkt w�hlen und bauen
			if BuildMode.getstring(Client_ID, 0) == "preview" then
				local X_0, Y_0, Z_0, X_1, Y_1, Z_1 = X, Y, Z, BuildMode.getcoordinate(Client_ID, 0)
				
				BuildMode.setstate(Client_ID, 2)
				System.msg(Client_ID, "&cThe shown area describes the box. Type /cancel to cancel. <br>&c/accept to continue.")
				BuildMode.setcoordinate(Client_ID, 1, X, Y, Z)
				BuildMode.setlong(Client_ID, 3, Block_Type)
				
				if X_0 > X_1 then
					local X_2 = X_0
					X_0 = X_1
					X_1 = X_2
				end
				if Y_0 > Y_1 then
					local Y_2 = Y_0
					Y_0 = Y_1
					Y_1 = Y_2
				end
				if Z_0 > Z_1 then
					local Z_2 = Z_0
					Z_0 = Z_1
					Z_1 = Z_2
				end
				
				Z_1 = Z_1 + 1
				X_1 = X_1 + 1
				Y_1 = Y_1 + 1
				
				CPE.addselection(Client_ID, 250, "Box", X_0, Y_0, Z_0, X_1, Y_1, Z_1, 108, 1, 112, 90)
			else
				local X_0, Y_0, Z_0, X_1, Y_1, Z_1 = X, Y, Z, BuildMode.getcoordinate(Client_ID, 0)
				local Replace_Material = BuildMode.getlong(Client_ID, 0)
				local Hollow = BuildMode.getlong(Client_ID, 1)
				
				local Player_Number = Entity.getplayer(Client.getentity(Client_ID))
				
				local Blocks = math.abs(X_0-X_1)*math.abs(Y_0-Y_1)*math.abs(Z_0-Z_1)
				
				if Hollow == 0 and Blocks < 500000 then
					Build.box(Player_Number, Map_ID, X_0, Y_0, Z_0, X_1, Y_1, Z_1, Block_Type, Replace_Material, Hollow, 2, 1, 0)
					System.msg(Client_ID, "&eBuildmode: Box created")
				elseif Hollow == 1 and Blocks < 5000000 then
					Build.box(Player_Number, Map_ID, X_0, Y_0, Z_0, X_1, Y_1, Z_1, Block_Type, Replace_Material, Hollow, 2, 1, 0)
					System.msg(Client_ID, "&eBuildmode: Box created")
				else
					System.msg(Client_ID, "&4Error:&f Buildmode: Box too big")
				end
				
				BuildMode.set(Client_ID, "Normal")
				
				
			end
		end
		
	end
	
end