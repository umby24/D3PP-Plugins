function Command_Build_Mode_Sphere(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if Text_0 ~= "" then
		local Found = 0
		
		for i = 0, 255 do
			local Block_Name = Block.name(i)
			if string.lower(Block_Name) == string.lower(Text_0) then
				BuildMode.set(Client_ID, "Sphere")
				BuildMode.setstate(Client_ID, 0)
				BuildMode.setlong(Client_ID, 0, i)
				BuildMode.setlong(Client_ID, 1, 0)
				System.msg(Client_ID, "&eSphere started")
				System.msg(Client_ID, "&eWill Replace '" .. Block_Name .. "'")
				Found = 1
				break
			end
		end
		if Found == 0 then
			System.msg(Client_ID, "&4Error:&f Couldn't find a block called '" .. Text_0 .. "'")
		end
	else
		
		BuildMode.set(Client_ID, "Sphere")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setlong(Client_ID, 0, -1)
		BuildMode.setlong(Client_ID, 1, 0)
		System.msg(Client_ID, "&eSphere started")
	end
end

function Command_Build_Mode_Hollow_Sphere(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if Text_0 ~= "" then
		local Found = 0
		
		for i = 0, 255 do
			local Block_Name = Block.name(i)
			if string.lower(Block_Name) == string.lower(Text_0) then
				BuildMode.set(Client_ID, "Sphere")
				BuildMode.setstate(Client_ID, 0)
				BuildMode.setlong(Client_ID, 0, i)
				BuildMode.setlong(Client_ID, 1, 1)
				System.msg(Client_ID, "&eHollow Sphere started")
				System.msg(Client_ID, "&eWill Replace '" .. Block_Name .. "'")
				Found = 1
				break
			end
		end
		if Found == 0 then
			System.msg(Client_ID, "&4Error:&f Couldn't find a block called '" .. Text_0 .. "'")
		end
	else
		
		BuildMode.set(Client_ID, "Sphere")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setlong(Client_ID, 0, -1)
		BuildMode.setlong(Client_ID, 1, 1)
	System.msg(Client_ID, "&eHollow Sphere started")
	end
end