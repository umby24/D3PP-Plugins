local helpMessage = "/setmodel [model]<br>Changes your CPE player model."

function Command_Change_Model(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	local Model = string.lower(Arg_0)
	if (Model == "") then
        Command_Model_Reset(Client_ID)
        return
    end

	if Model ~= "chicken" and Model ~= "creeper" and Model ~= "zombie" and Model ~= "humanoid" and Model ~= "default" and Model ~= "pig" and Model ~= "sheep" and Model ~= "skeleton" and Model ~= "spider" and tonumber(Model) == nil then
		System.msg(Client_ID, "§EModel not found!")
		return
	end
	
	CPE.setmodel(Client_ID, Model)
	System.msg(Client_ID, "§SModel changed!")
end

function Command_Model_Reset(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	CPE.setmodel(Client_ID, "cow")
	System.msg(Client_ID, "§SModel reset")
end


System.addCmd("setmodel", "General", 0, "Command_Change_Model", helpMessage)