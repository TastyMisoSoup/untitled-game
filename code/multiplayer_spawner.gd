extends MultiplayerSpawner

const PLAYER_SCENE = preload("res://scenes/player/player.tscn")

func _enter_tree() -> void:
	set_spawn_function(get_player_inst)

func _ready() -> void:
	if multiplayer.is_server(): spawn_player(1)
	multiplayer.connected_to_server.connect(spawn_player)
	
func spawn_player(id:int) -> void:
	print("hi")
	spawn(id)

func get_player_inst(id:int) -> Node:
	var player: Player = PLAYER_SCENE.instantiate()
	var mech_info:String 
	if !multiplayer.is_server():
		mech_info = Lobby.players[str(id)]
	else:
		mech_info = MechConfig.mech_body
	player.name = str(id)
	player.player_id = id
	player.mech_body = mech_info
	return player
