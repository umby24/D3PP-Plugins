function Command_Build_Mode_Box(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if (Arg_0 == "--preview" or Arg_0 == "-p") then
		if CPE.getexts(Client_ID, "SelectionCuboid") then
			BuildMode.setstring(Client_ID, 0, "preview")
			Text_0 = ""
			Arg_0 = ""
		else
			System.msg(Client_ID, "&cYour client does not support SelectionCuboid.")
		end
	end
	if (Arg_1 == "-p" or Arg_1 == "--preview") then -- Incase the player is replacing.
		if CPE.getexts(Client_ID, "SelectionCuboid") then
			BuildMode.setstring(Client_ID, 0, "preview")
			Text_1 = ""
			Arg_1 = ""
		else
			System.msg(Client_ID, "&cYour client does not support SelectionCuboid.")
		end
	end
	
	if Text_0 ~= "" then
		local Found = 0
		
		for i = 0, 255 do
			local Block_Name = Block.name(i)
			if string.lower(Block_Name) == string.lower(Text_0) then
				BuildMode.set(Client_ID, "Box")
				BuildMode.setstate(Client_ID, 0)
				BuildMode.setlong(Client_ID, 0, i)
				BuildMode.setlong(Client_ID, 1, 0)
				System.msg(Client_ID, "&eBuildmode: Box started")
				System.msg(Client_ID, "&eBuildmode: Replace '" .. Block_Name .. "'")
				Found = 1
				break
			end
		end
		if Found == 0 then
			System.msg(Client_ID, "&4Error:&f Can't find a block called '" .. Text_0 .. "'")
		end
	else
		
		BuildMode.set(Client_ID, "Box")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setlong(Client_ID, 0, -1)
		BuildMode.setlong(Client_ID, 1, 0)
		System.msg(Client_ID, "&eBuildmode: Box started")
	end
end

function Command_Build_Mode_Hollow_Box(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if Text_0 == "--preview" or Text_0 == "-p" then
		if CPE.getexts(Client_ID, "SelectionCuboid") then
			BuildMode.setstring(Client_ID, 0, "preview")
			Text_0 = ""
			Arg_0 = ""
		else
			System.msg(Client_ID, "&cYour client does not support SelectionCuboid.")
		end
	end
	if (Arg_1 == "-p" or Arg_1 == "--preview") then -- Incase the player is replacing.
		if CPE.getexts(Client_ID, "SelectionCuboid") then
			BuildMode.setstring(Client_ID, 0, "preview")
			Text_1 = ""
			Arg_1 = ""
		else
			System.msg(Client_ID, "&cYour client does not support SelectionCuboid.")
		end
	end
	
	if Text_0 ~= "" then
		local Found = 0
		
		for i = 0, 255 do
			local Block_Name = Block.name(i)
			if string.lower(Block_Name) == string.lower(Text_0) then
				BuildMode.set(Client_ID, "Box")
				BuildMode.setstate(Client_ID, 0)
				BuildMode.setlong(Client_ID, 0, i)
				BuildMode.setlong(Client_ID, 1, 1)
				System.msg(Client_ID, "&eBuildmode: Hollow_Box started")
				System.msg(Client_ID, "&eBuildmode: Replace '" .. Block_Name .. "'")
				Found = 1
				break
			end
		end
		if Found == 0 then
			System.msg(Client_ID, "&4Error:&f Can't find a block called '" .. Text_0 .. "'")
		end
	else
		
		BuildMode.set(Client_ID, "Box")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setlong(Client_ID, 0, -1)
		BuildMode.setlong(Client_ID, 1, 1)
		System.msg(Client_ID, "&eBuildmode: Hollow_Box started")
	end
end