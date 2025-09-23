extends Control
class_name TitleMenu

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_create_game_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
