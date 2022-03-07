local AdminRankMin = 149
local helpMessage = "§S/adminchat [message]<br>§SSends a chat message to staff players of the server."

function Command_Message_Admins(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	local Prefix, Name, Suffix = Entity.getdisplayname(Client.getentity(Client_ID))
	local Rank = Player.rank(Entity.getplayer(Client.getentity(Client_ID)))
	local tcol = "&e"
	
	if Rank > 1000 then
		tcol = "&7"
	elseif Rank >= 250 then
		tcol = "&a"
	elseif Rank >= 200 then
		tcol = "&1"
	elseif Rank >= 150 then
		tcol = "&6"
	end
	
	Client_Table, Clients = Client.getall()
	for i = 1, Clients do
		local Temp_Client_ID = Client_Table[i]
		local Player_Number = Entity.getplayer(Client.getentity(Temp_Client_ID))
		local Rank = Player.rank(Player_Number)

		if  Rank >= AdminRankMin or Temp_Client_ID == Client_ID then --Check ranks
			System.msg(Temp_Client_ID ,Prefix..Name..Suffix.." &c>>".." "..tcol..Text_0)
		end
	end
end

System.addCmd("adminchat", "General", 0, "Command_Message_Admins", helpMessage)