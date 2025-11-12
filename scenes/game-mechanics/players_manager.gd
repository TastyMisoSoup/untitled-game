extends Node

func get_random_spawn_point() -> Vector2:
	var spawn_point:Marker2D = $"../Map2/TileMapLayer/SpawnPoints".get_children().pick_random()
	return spawn_point.position


func _on_child_entered_tree(node: Node) -> void:
	if node.is_class("Player"):
		$CanvasLayer/Scoreboard.add_player_stats(node)
	else:
		node.queue_free()
