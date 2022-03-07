function Command_Build_Mode_Ellipsoid(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if Arg_0 ~= "" and Arg_0:lower() ~= "hollow" and Arg_0:lower() ~= "h" and Arg_0:lower() ~= "inf" and Arg_0:lower() ~= "infinity" then
		local Found = 0
		
		for i = 0, 255 do
			local Block_Name = Block.name(i)
			if string.lower(Block_Name) == string.lower(Arg_0) then
				BuildMode.set(Client_ID, "Ellipsoid")
				BuildMode.setstate(Client_ID, 0)
				BuildMode.setlong(Client_ID, 0, i)
				
				-- Set Hollow
				local hollow = 0
				if Arg_1:lower() == "hollow" or Arg_1:lower() == "h" then
					hollow = 1
				elseif Arg_2:lower() == "hollow" or Arg_2:lower() == "h" then
					hollow = 1
				end
				BuildMode.setlong(Client_ID, 1, hollow)
				
				-- Set Continue
				local continue = 0
				if Arg_1:lower() == "inf" or Arg_1:lower() == "infinity" then
					continue = 1
				elseif Arg_2:lower() == "inf" or Arg_2:lower() == "infinity" then
					continue = 1
				end
				BuildMode.setlong(Client_ID, 2, continue)
				
				
				System.msg(Client_ID, "&eBuildmode: Ellipsoid started")
				System.msg(Client_ID, "&eBuildmode: Replace '" .. Block_Name .. "'")
				if hollow == 1 then System.msg(Client_ID, "&eHollow mode enabled") end
				if continue == 1 then System.msg(Client_ID, "&eContinue mode enabled. Build mode will repeat until you type /cancel") end
				
				Found = 1
				break
			end
		end
		
		if Found == 0 then
			System.msg(Client_ID, "&4Error:&f Can't find a block called '" .. Text_0 .. "'")
		end
	else
		
		BuildMode.set(Client_ID, "Ellipsoid")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setlong(Client_ID, 0, -1)
		
		-- Set Hollow
		local hollow = 0
		if Arg_0:lower() == "hollow" or Arg_0:lower() == "h" then
			hollow = 1
		elseif Arg_1:lower() == "hollow" or Arg_1:lower() == "h" then
			hollow = 1
		end
		BuildMode.setlong(Client_ID, 1, hollow)
		
		-- Set Continue
		local continue = 0
		if Arg_0:lower() == "inf" or Arg_0:lower() == "infinity" then
			continue = 1
		elseif Arg_1:lower() == "inf" or Arg_1:lower() == "infinity" then
			continue = 1
		end
		BuildMode.setlong(Client_ID, 2, continue)
		
		System.msg(Client_ID, "&eBuildmode: Ellipsoid started")
		if hollow == 1 then System.msg(Client_ID, "&eHollow mode enabled") end
		if continue == 1 then System.msg(Client_ID, "&eContinue mode enabled. Build mode will repeat until you type /cancel") end

	end
end