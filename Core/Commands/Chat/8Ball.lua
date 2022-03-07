local delay = 2
local nextUse = os.time()
local executeTime = os.time()
local isActive = false
local helpMessage = "§S/8ball [Yes or no question]<br>§SGet an answer from the all-knowing 8-ball!"

local messages = {"As I see it, yes.", "Ask again later.", "Better not tell you now.", "Cannot predict now.", "Concentrate and ask again.",
"Don’t count on it.", "It is certain.", "It is decidedly so.", "Most likely.", "My reply is no.", "My sources say no.",
"Outlook not so good.", "Outlook good.", "Reply hazy, try again.", "Signs point to yes.", "Very doubtful.", "Without a doubt.",
"Yes.", "Yes – definitely.", "You may rely on it."}

function Client_Get_Coded_Name(Client_ID)
	PlayerID = Entity.getplayer(Client.getentity(Client_ID))
	return Player.getprefix(PlayerID) .. Player.getname(PlayerID) .. Player.getsuffix(PlayerID)
end

function Command_8Ball(clientId, command, text0, text1, arg0, arg1, arg2, arg3, arg4)
    if (text0 == "") then
        System.msg(clientId, helpMessage)
        return
    end

    if (nextUse - os.time() > 0 or isActive) then
        System.msg(clientId, "§SThe 8-ball is still recharging, wait another " .. tostring((nextUse - os.time())/60) .. " seconds.")
        return
    end

    local clientName = Client_Get_Coded_Name(clientId)

    nextUse = os.time() + (delay)
    isActive = true
    System.msgAll(-1, "§S" .. clientName .. " asked the &b8-ball: &f" ..text0)
end

function Timer8Ball(...)
    local timeUntilExecute = nextUse - os.time()

    if (timeUntilExecute < 0 and isActive) then
        isActive = false
        local index = math.random(1, #messages)
        System.msgAll(-1, "§SThe 8-Ball says: &f " .. messages[index])
    end
end

local function RegisterTimer()
    if (System.addEvent("Timer_8ball", "Timer8Ball", "Timer", 0, 1000, -1) == false) then -- Check to see if the event is already registered. 
        System.addEvent("Timer_8ball", "Timer8Ball", "Timer", 1, 1000, -1) -- Not registered, create it.
    end
end

print(System.addEvent("Timer_8ball", "Timer8Ball", "Timer", 0, 1000, -1))
RegisterTimer()
--System.addCmd("8ball", "General", 0, "Command_8Ball", helpMessage)