extends MultiplayerSpawner

const PLAYER_SCENE = preload("res://scenes/player/player.tscn")

func _enter_tree() -> void:
	set_spawn_function(get_player_inst)

func _ready() -> void:
	#if multiplayer.is_server(): spawn_player(1, PlayerConfig.get_player_info())
	Lobby.player_connected.connect(spawn_player)
	
func spawn_player(id:int, player_info:Dictionary) -> void:
	var player_node = spawn({"id":id,"player_info":player_info})
	get_parent().get_node("Players").add_player_to_array(player_node)
	
func get_player_inst(data:Dictionary) -> Node:
	var player: Player = PLAYER_SCENE.instantiate()
	var player_info:Dictionary = data["player_info"]
	player.name = player_info["player_name"]
	player.player_id = data["id"]
	player.mech_body = player_info["mech_body"]
	player.primary_weapon = player_info["primary_weapon"]
	player.secondary_weapon = player_info["secondary_weapon"]
	return player
