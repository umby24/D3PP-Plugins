function Command_Build_Mode_Rank_Box(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if Arg_0 ~= "" then
		System.msg(Client_ID, "&eBuildmode: Rank Box started")
		BuildMode.set(Client_ID, "Rank-Box")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setlong(Client_ID, 0, tonumber(Arg_0))
	else
		System.msg(Client_ID, "&4Error:&f Define a rank!")
	end
end
