extends MultiplayerSpawner

const PLAYER_SCENE = preload("res://scenes/player/player.tscn")

func _enter_tree() -> void:
	set_spawn_function(get_player_inst)

func _ready() -> void:
	if multiplayer.is_server(): spawn_player(1, MechConfig.mech_body)
	Lobby.player_connected.connect(spawn_player)
	
func spawn_player(id:int, player_info) -> void:
	#print(str(multiplayer.get_unique_id())+": "+str(Lobby.players))
	spawn({"id":id,"player_info":player_info})

func get_player_inst(data:Dictionary) -> Node:
	var player: Player = PLAYER_SCENE.instantiate()
	var mech_info:String 
	if multiplayer.is_server():
		mech_info = Lobby.players[data["id"]]
	player.name = str(data["id"])
	player.player_id = data["id"]
	player.mech_body = data["player_info"]
	return player
	
