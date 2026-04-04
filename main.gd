extends Node2D
class_name Main

const CROSSHAIR = preload("res://assets/icons/cursor.png")
var map: NodePath = Lobby.map

func _init() -> void:
	#print(map)
	Input.set_custom_mouse_cursor(CROSSHAIR,Input.CursorShape.CURSOR_ARROW,Vector2(16,16))
	
func _ready() -> void:
	if !multiplayer.is_server(): return
	var map_scene = load(map)
	var map_inst = map_scene.instantiate()
	add_child(map_inst)
	$MultiplayerSpawner.spawn_player(1, PlayerConfig.get_player_info())

func _on_map_spawner_spawned(node: Node) -> void:
	print("hellous")
