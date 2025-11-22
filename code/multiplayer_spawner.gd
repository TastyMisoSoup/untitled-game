extends MultiplayerSpawner

const PLAYER_SCENE = preload("res://scenes/player/player.tscn")

func _enter_tree() -> void:
	set_spawn_function(get_player_inst)

func _ready() -> void:
	spawn_player(multiplayer.get_unique_id())
	multiplayer.peer_connected.connect(spawn_player)
	
func spawn_player(id:int) -> void:
	spawn(id)

func get_player_inst(id:int) -> Node:
	var player: Player = PLAYER_SCENE.instantiate()
	player.name = str(id)
	player.player_id = id
	return player
	
