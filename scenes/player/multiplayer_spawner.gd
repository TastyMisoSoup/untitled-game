extends MultiplayerSpawner

func spawn_mech(team_number:int) -> void:
	if !multiplayer.is_server(): return
	var team = "team"+str(team_number);
	var mech_instance = Mech.mech_construct(team)
	get_node(spawn_path).add_child(mech_instance, true)
