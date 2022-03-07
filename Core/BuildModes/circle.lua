function Build_Circle_Player(Player_Number, Map_ID, X, Y, Z, R, Rot, Look, Material, Replace_Material, Hollow)
	local R_Rounded = math.ceil(R)
	local R_Pow = R^2
	local R_Pow_Small = (R-3)^2
	
	local Rot = math.floor(Rot/90+0.5)*90
	
	local M_X, M_Z = math.cos(math.rad(Look)), -math.sin(math.rad(Look))
	
	local Allowed
	
	for i = -R_Rounded, R_Rounded do
		for j = -R_Rounded, R_Rounded do
			
			local ix, iy, iz = (i*M_X)*math.cos(math.rad(Rot-90)) + j*math.sin(math.rad(Rot-90)), j*math.cos(math.rad(Rot-90)) + (i*M_X)*math.sin(math.rad(Rot-90)), i*M_Z
			
			local Square_Dist = ix^2 + iy^2 + iz^2
			
			if Square_Dist <= R_Pow then
				if Hollow == 1 then
					Allowed = 0
					if Square_Dist > R_Pow_Small then
						if     (ix+1)^2 + (iy  )^2 + (iz  )^2 > R_Pow then Allowed = 1
						elseif (ix-1)^2 + (iy  )^2 + (iz  )^2 > R_Pow then Allowed = 1
						elseif (ix  )^2 + (iy+1)^2 + (iz  )^2 > R_Pow then Allowed = 1
						elseif (ix  )^2 + (iy-1)^2 + (iz  )^2 > R_Pow then Allowed = 1
						elseif (ix  )^2 + (iy  )^2 + (iz+1)^2 > R_Pow then Allowed = 1
						elseif (ix  )^2 + (iy  )^2 + (iz-1)^2 > R_Pow then Allowed = 1
						end
					end
				else
					Allowed = 1
				end
				if Allowed == 1 then
					if Replace_Material == -1 or Replace_Material == Map.getblock(Map_ID, X+ix, Y+iy, Z+iz) then
						Map.setblockplayer(Player_Number, Map_ID, X+ix, Y+iy, Z+iz, Material, 1, 1, 1, 10)
					end
				end
			end
		end
	end
end

function Build_Mode_Circle(Client_ID, Map_ID, X, Y, Z, Mode, Block_Type)
	local Entity_ID = Client.getentity(Client_ID)
	
	if Mode == 1 then
		
		local State = BuildMode.getstate(Client_ID)
		
		if State == 0 then -- Ersten Punkt w�hlen
			BuildMode.setcoordinate(Client_ID, 0, X, Y, Z)
			BuildMode.setstate(Client_ID, 1)
			
		elseif State == 1 then -- Zweiten Punkt w�hlen und bauen
			local X_0, Y_0, Z_0, X_1, Y_1, Z_1 = X, Y, Z, BuildMode.getcoordinate(Client_ID, 0)
			local H_Dist = math.sqrt((X_0-X_1)^2+(Y_0-Y_1)^2)
			local R = math.sqrt((X_0-X_1)^2+(Y_0-Y_1)^2+(Z_0-Z_1)^2)
			local Rotation, Look = math.deg(math.atan((Y_0-Y_1), (X_0-X_1)))+90, -math.deg(math.atan(Z_0-Z_1, H_Dist))
			if math.abs(Look) > 60 and Entity_ID ~= -1 then
				Rotation = -Entity.getrotation(Entity_ID)
			end
			local Replace_Material = BuildMode.getlong(Client_ID, 0)
			local Hollow = BuildMode.getlong(Client_ID, 1)
			
			local Player_Number = Entity.getplayer(Client.getentity(Client_ID))
			
			Build_Circle_Player(Player_Number, Map_ID, X_1, Y_1, Z_1, R, Rotation, Look, Block_Type, Replace_Material, Hollow)
			System.msg(Client_ID, "&eCircle created")
			
			
			BuildMode.set(Client_ID, "Normal")
		end
		
	end
end