extends Control


func _on_pw_menu_item_selected(index: int) -> void:
	var select = %PWMenu.selected
	PlayerConfig.primary_weapon = %PWMenu.get_item_text(select).to_lower()


func _on_sw_menu_item_selected(index: int) -> void:
	var select = %SWMenu.selected
	PlayerConfig.secondary_weapon = %SWMenu.get_item_text(select).to_lower()


func _on_body_menu_item_selected(index: int) -> void:
	var select = %BodyMenu.selected
	PlayerConfig.mech_body = %BodyMenu.get_item_text(select).to_lower()
	print(PlayerConfig.mech_body)


func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui-elements/title_menu.tscn")
