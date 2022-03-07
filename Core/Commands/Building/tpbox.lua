
function Command_Build_Mode_Teleporter_Box(Client_ID, Command, Text_0, Text_1, Arg_0, Arg_1, Arg_2, Arg_3, Arg_4)
	if Arg_0 ~= "" then
		
		local Entity_ID = Client.getentity(Client_ID)
		
		local Map_ID, X, Y, Z = Entity.getmap(Entity_ID), Entity.getposition(Entity_ID)
		local Rot, Look = Entity.getrotation(Entity_ID), Entity.getlook(Entity_ID)
		local Map_Unique_ID = Map.uuid(Map_ID)
		System.msg(Client_ID, "&eBuildmode: Teleporter started")
		BuildMode.set(Client_ID, "Teleporter-Box")
		BuildMode.setstate(Client_ID, 0)
		BuildMode.setstring(Client_ID, 0, Arg_0)
		BuildMode.setstring(Client_ID, 1, Map_Unique_ID)
		BuildMode.setlong(Client_ID, 0, -1)
		BuildMode.setfloat(Client_ID, 0, X)
		BuildMode.setfloat(Client_ID, 1, Y)
		BuildMode.setfloat(Client_ID, 2, Z)
		BuildMode.setfloat(Client_ID, 3, Rot)
		BuildMode.setfloat(Client_ID, 4, Look)
		--BuildMode.setlong(Client_ID, 5, Entity.create(Arg_0.." Destination", Map_ID, X, Y, Z, Rot, Look))
	else
		System.msg(Client_ID, "&4Error:&f Define a name")
	end
end