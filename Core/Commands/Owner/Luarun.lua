function CommandLuaRun(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	local Function = load(Text_0)
	Function()
end

System.addCmd("luarun", "Scripting", 300, "CommandLuaRun", "/luarun [script]")