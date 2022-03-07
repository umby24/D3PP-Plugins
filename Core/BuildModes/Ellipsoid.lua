function Build_Mode_Ellipsoid(Client_ID, Map_ID, X, Y, Z, Mode, Block_Type)
	if Mode == 1 then
		
		local State = BuildMode.getstate(Client_ID)
		
		if State == 0 then
			BuildMode.setcoordinate(Client_ID, 0, X, Y, Z)
			BuildMode.setstate(Client_ID, 1)
			
		elseif State == 1 then
			local X_0, Y_0, Z_0, X_1, Y_1, Z_1 = X, Y, Z, BuildMode.getcoordinate(Client_ID, 0)
			local rX, rY, rZ = math.abs(X_0-X_1), math.abs(Y_0-Y_1), math.abs(Z_0-Z_1)
			local Replace_Material = BuildMode.getlong(Client_ID, 0)
			local Hollow = BuildMode.getlong(Client_ID, 1)
			
			local Player_Number = Entity.getplayer(Client.getentity(Client_ID))
			
			Build_Ellipsoid_Player(Player_Number, Map_ID, X_1, Y_1, Z_1, rX, rY, rZ, Block_Type, Replace_Material, Hollow, 1, 1, 1, 5)
			System.msg(Client_ID, "&eEllipsoid created")
			
			BuildMode.set(Client_ID, "Normal")
			
			local continue = BuildMode.getlong(Client_ID, 2)
			if continue == 1 then
				BuildMode.set(Client_ID, "Ellipsoid")
				BuildMode.setstate(Client_ID, 0)
			end
			
		end
	end
end

function Build_Ellipsoid_Player(Player_Number, Map_ID, X_0, Y_0, Z_0, rX, rY, rZ, Block_Type, Replace_Material, Hollow,  Undo, Physic, Send, Priority)
	for ix = -rX, rX do
		for iy = -rY, rY do
			for iz = -rZ, rZ do
			
				-- Finds blocks within range based on ellipsoid formula. Structured this way so that any axis can be 0
				local count = 0
				if rX > 0 then
					count = count + (ix)^2 / (rX)^2
				end
				if rY > 0 then
					count = count + (iy)^2 / (rY)^2
				end
				if rZ > 0 then
					count = count + (iz)^2 / (rZ)^2
				end
				
				if Hollow == 0 and count <= 1 or Hollow == 1 and count >= .6 and count <= 1 then
					local X, Y, Z = X_0+ix, Y_0+iy, Z_0+iz
					if Replace_Material == -1 or Replace_Material ~= -1 and Map.getblock(Map_ID, X, Y, Z) == Replace_Material then
						Map.setblock(Player_Number, Map_ID, X, Y, Z , Block_Type, Undo, Physic, Send, Priority)
					end
				end
			end
		end
	end
end