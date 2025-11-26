extends VBoxContainer
class_name StatsManager

func remove_player_stats(id:int) -> void:
	if id == null: return
	for player:PlayerStats in get_children():
		if player.player_id == id: player.queue_free()
