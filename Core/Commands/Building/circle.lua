function Command_Build_Mode_Circle(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if Text_0 ~= "" then
		local Found = 0
		
		for i = 0, 255 do
			local Block_Name = Block.name(i)
			if string.lower(Block_Name) == string.lower(Text_0) then
				System.msg(Client_ID, "&eCircle started")
				System.msg(Client_ID, "Buildmode: Replace '" .. Block_Name .. "'")
				BuildMode.set(Client_ID, "Circle")
				BuildMode.setstate(Client_ID, 0)
				BuildMode.setlong(Client_ID, 0, i)
				BuildMode.setlong(Client_ID, 1, 0)
				Found = 1
				break
			end
		end
		if Found == 0 then
			System.msg(Client_ID, "Ingame: Can't find Block()\\Name = [Text_0]")
		end
	else
		System.msg(Client_ID, "&eCircle started")
		BuildMode.set(Client_ID, "Circle")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setlong(Client_ID, 0, -1)
		BuildMode.setlong(Client_ID, 1, 0)
	end
end

function Command_Build_Mode_Hollow_Circle(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if Text_0 ~= "" then
		local Found = 0
		
		for i = 0, 255 do
			local Block_Name = Block.name(i)
			if string.lower(Block_Name) == string.lower(Text_0) then
				System.msg(Client_ID, "&eBuildmode: Hollow Circle started")
				System.msg(Client_ID, "&eBuildmode: Replace '" .. Block_Name .. "'")
				BuildMode.set(Client_ID, "Circle")
				BuildMode.setstate(Client_ID, 0)
				BuildMode.setlong(Client_ID, 0, i)
				BuildMode.setlong(Client_ID, 1, 1)
				Found = 1
				break
			end
		end
		if Found == 0 then
			System.msg(Client_ID, "&4Error:&f Can't find a block called '" .. Text_0 .. "'")
		end
	else
		System.msg(Client_ID, "&eBuildmode: Hollow_Circle started")
		BuildMode.set(Client_ID, "Circle")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setlong(Client_ID, 0, -1)
		BuildMode.setlong(Client_ID, 1, 1)
	end
end