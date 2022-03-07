local helpMessage = "§S/clear [global]<br>§SClears your chat window. If you include 'global', everyones chat will clear."
local notEnoughPermsMessage = "§EYou do not have permission to perform a global clear."
local minGlobalClearRank = 150

function CommandClear(clientId, command, text0, text1, arg0, ...)
    if arg0 == "global" then
        local Rank = Player.rank(Entity.getplayer(Client.getentity(Client_ID)))

        if Rank < minGlobalClearRank then
            System.msg(clientId, notEnoughPermsMessage)
        end

        Client_Table, Clients = Client.getall()
        for i = 1, Clients do
            local Temp_Client_ID = Client_Table[i]
            ClearClientWindow(Temp_Client_ID)
        end
        System.msgAll(-1, "§SGlobal chat cleared.")
        return
    end

    ClearClientWindow(clientId)
    System.msg(clientId, "§SChat cleared.")
end

function ClearClientWindow(clientId)
    for i = 1, 30 do
        System.msg(clientId, " ")
    end
end

System.addCmd("clear", "General", 0, "CommandClear", helpMessage)