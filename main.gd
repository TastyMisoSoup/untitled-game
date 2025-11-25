extends Node2D

const CROSSHAIR = preload("res://assets/icons/cursor.png")

func _process(_delta: float) -> void:
	pass

func _ready() -> void:
	multiplayer.peer_disconnected.connect(_client_disconnected)
	Input.set_custom_mouse_cursor(CROSSHAIR,Input.CursorShape.CURSOR_ARROW,Vector2(16,16))
	pass
	
func _client_disconnected(id:int) -> void:
	var player_node = $Players.get_node_or_null(str(id))
	if player_node:
		player_node.queue_free()
