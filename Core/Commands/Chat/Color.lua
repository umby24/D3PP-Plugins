local helpMessage = "§S/color [player] [color]<br>§SSets the nick color of that player.<br>If [color] is not given, reverts to default."
local notEnoughPermsMessage = "§EYou do not have permission to set someones color."
local minColorRank = 150

function CommandSetColor(clientId, command, text0, text1, arg0, arg1, ...)
    if arg0 == "" then
        System.msg(clientId, helpMessage)
        return
    end

    local setCid = Name_Get_Client(arg0)
    if (setCid == nil) then
        System.msg(clientId, "§ECouldn't find that player")
        return
    end
	local setEid = Client.getentity(setCid)
	local setPid = Entity.getplayer(setEid)
	
	local Prefix, Name, Suffix = Player.getprefix(setPid), Player.getname(setPid), Player.getsuffix(setPid)
    if (arg1 ~= "") then
        Prefix = "&" .. arg1
    end

    Entity.setdisplayname(setEid, Prefix, Name, Suffix)
    System.msg(clientId, "§SPlayer's name is updated.")
end

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

System.addCmd("color", "General", minColorRank, "CommandSetColor", helpMessage)