extends Control


func _on_pw_menu_item_selected(index: int) -> void:
	PlayerConfig.primary_weapon = %PWMenu.selected


func _on_sw_menu_item_selected(index: int) -> void:
	PlayerConfig.secondary_weapon = %SWMenu.selected


func _on_body_menu_item_selected(index: int) -> void:
	PlayerConfig.mech_body = %BodyMenu.selected
