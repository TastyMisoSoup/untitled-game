extends Control
class_name TitleMenu

var player_name: String = "John Doe"

func _ready() -> void:
	Input.set_custom_mouse_cursor(null,Input.CursorShape.CURSOR_ARROW,Vector2.ZERO)

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_create_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui-elements/server_listing.tscn")


func _on_button_pressed() -> void:
	PlayerConfig.mech_body = "daemon"


func _on_button_2_pressed() -> void:
	PlayerConfig.mech_body = "artemis"



func _on_player_profile_btn_pressed() -> void:
	%PlayerNameEditor.visible = true


func _on_cancel_button_pressed() -> void:
	%PlayerNameEditor.visible = false
	%NameEdit.text = player_name


func _on_save_button_pressed() -> void:
	if %NameEdit.text != "":
		player_name = %NameEdit.text
		PlayerConfig.player_name = %NameEdit.text
		%PlayerNameEditor.visible = false


func _on_mech_bay_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui-elements/mech_bay.tscn")
