clientString = {}
server_title_string = "&eD3PP Demo Server"
extra_line = "&cPowered by D3&d++"
function Do_Wom_Compass(Result, Entity_ID, Map_ID, X, Y, Z, Rot, Look, Priority, Send_own)
	local Client_ID = Entity_Get_Client(Entity_ID)

	if CPE.getexts(Client_ID, "MessageTypes") == 0 then
		return Result
	end
	if Client_ID ~= -1 then
		--local Rot_90 = math.floor((Rot-45)/90)
		local Rot_30 = math.floor((Rot - 45)/45)
		local text = ""
		local heldBlockText = "&eHeld Block: " .. Block.name(CPE.getheld(Client_ID))
		local mapText = "&eCurrent map: &c" .. Map.name(Client.getmap(Client_ID))

		if Rot_30 == 1 then
			text = "&9[&cNorth&9]"
		elseif Rot_30 == 0 then
			text = "&9[&cNorth west&9]"
		elseif Rot_30 == 2 then
			text = "&9[&cNorth east&9]"
		elseif Rot_30 == -5 then
			text = "&9[&cEast&9]"
		elseif Rot_30 == -4 then
			text = "&9[&cSouth East&9]"
		elseif Rot_30 == -3 then
			text = "&9[&cSouth&9]"
		elseif Rot_30 == -1 then
			text = "&9[&cWest&9]"
		elseif Rot_30 == -2 then
			text = "&9[&cSouth West&9]"
		end
		
		if not clientString[Client_ID] then
			clientString[Client_ID] = {}
		end

		if clientString[Client_ID]["Compass"] ~= text then
			clientString[Client_ID]["Compass"] = text
			System.msg(Client_ID, server_title_string, 1)
			System.msg(Client_ID, text, 2)
			System.msg(Client_ID, extra_line, 3)
	    end
		if clientString[Client_ID]["HeldBlock"] ~= heldBlockText then
			System.msg(Client_ID, heldBlockText, 11)
			clientString[Client_ID]["HeldBlock"] = heldBlockText
		end
		if clientString[Client_ID]["Map"] ~= mapText then
			System.msg(Client_ID, mapText, 12)
			clientString[Client_ID]["Map"] = mapText
		end
	end

	return 1
end

System.msgAll(-1, "&8Compass reloaded")
System.addEvent("Compass","Do_Wom_Compass","Entity_Position_Set",1,0,-1)
