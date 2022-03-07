-- Returns the Client ID of the person with the given name (If they're online)
-- If not online, returns nil.
function Name_Get_Client(Name)
	local Client_Table, Clients = Client.getall() -- Gets the client table, and number of clients online.

	for i = 1, Clients do -- Iterates through the table (Array, more or less)
		local Client_ID = Client_Table[i]
		local Client_Name = Client.getloginname(Client_ID)
		
        if string.lower(Client_Name) == string.lower(Name) then 
            return Client_ID -- We've got a winner
        end
	end
    
    return nil -- Player not found
end

-- Retrieves the Client for the given Entity, if it has one.
-- If not found, returns nil. (Fake entity / invalid Entity ID)
function Entity_Get_Client(Entity_ID)
	local Player_Number = Entity.getplayer(Entity_ID)
	
	if Player_Number == -1 then -- Player doesn't exist.
		return nil
	end
	
	local Client_Table, Clients = Client.getall() -- Gets the client table
	
	for i = 1, Clients do -- Iterates through the table
		local Client_ID = Client_Table[i]
		
        if Client.getentity(Client_ID) == Entity_ID then -- if the EIDs match, we have a winner.
            return Client_ID
        end
	end
    
    return nil
end

-- Retrieves a Client from its player ID. Returns nil if not found.
function Player_Get_Client(Player_ID)
	local Client_Table, Clients = Client.getall()
	
	for i = 1, Clients do
		local Client_ID = Client_Table[i]
		
        if Entity.getplayer(Client.getentity(Client_ID)) == Player_ID then 
            return Client_ID
        end
	end
    
    return nil
end

-- Equivalent of fCraft's "Player.Classyname", returns the clients name with the proper rank prefix and suffix.
function Client_Get_Coded_Name(Client_ID)
	PlayerID = Entity.getplayer(Client.getentity(Client_ID))
	return Player.getprefix(PlayerID) .. Player.getname(PlayerID) .. Player.getsuffix(PlayerID)
end

local clock = os.clock

function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

System.msgAll(-1, "&2Umby24 API Reloaded")
