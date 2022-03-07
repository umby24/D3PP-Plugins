function Command_Build_Mode_Line(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	System.msg(Client_ID, "&eBuildmode: Line started")
	BuildMode.set(Client_ID, "Line")
	BuildMode.setstate(Client_ID, 0)
end
