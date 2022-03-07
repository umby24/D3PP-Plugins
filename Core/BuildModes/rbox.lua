function Build_Mode_Rank_Box(Client_ID, Map_ID, X, Y, Z, Mode, Block_Type)
	if Mode == 1 then
		local State = BuildMode.getstate(Client_ID)
		
		if State == 0 then -- Ersten Punkt w�hlen
			BuildMode.setcoordinate(Client_ID, 0, X, Y, Z)
			BuildMode.setstate(Client_ID, 1)
			
		elseif State == 1 then -- Zweiten Punkt w�hlen und bauen
			local X_0, Y_0, Z_0, X_1, Y_1, Z_1 = X, Y, Z, BuildMode.getcoordinate(Client_ID, 0)
			local Rank = BuildMode.getlong(Client_ID, 0)
			local Player_Number = Entity.getplayer(Client.getentity(Client_ID))
			local Player_Rank = Player.rank(Player_Number)
			
			Build.rankbox(Map_ID, X_0, Y_0, Z_0, X_1, Y_1, Z_1, Rank, Player_Rank)
			System.msg(Client_ID, "&eRank Box created")
			
			BuildMode.set(Client_ID, "Normal")
		end
		
	end
	
end