
function Build_Mode_Sphere(Client_ID, Map_ID, X, Y, Z, Mode, Block_Type)
	if Mode == 1 then
		local State = BuildMode.getstate(Client_ID)
		
		if State == 0 then -- Ersten Punkt w�hlen
			BuildMode.setcoordinate(Client_ID, 0, X, Y, Z)
			BuildMode.setstate(Client_ID, 1)
			
		elseif State == 1 then -- Zweiten Punkt w�hlen und bauen
			local X_0, Y_0, Z_0, X_1, Y_1, Z_1 = X, Y, Z, BuildMode.getcoordinate(Client_ID, 0)
			local R = math.sqrt((X_0-X_1)^2+(Y_0-Y_1)^2+(Z_0-Z_1)^2)
			local Replace_Material = BuildMode.getlong(Client_ID, 0)
			local Hollow = BuildMode.getlong(Client_ID, 1)
			
			local Player_Number = Entity.getplayer(Client.getentity(Client_ID))
			
			if R < 50 then
				Build.sphere(Player_Number, Map_ID, X_1, Y_1, Z_1, R, Block_Type, Replace_Material, Hollow, 2, 1, 0)
				System.msg(Client_ID, "&eSphere created")
			else
				System.msg(Client_ID, "&4Error:&f Sphere too big!")
			end

			BuildMode.set(Client_ID, "Normal")
		end
		
	end
	
end