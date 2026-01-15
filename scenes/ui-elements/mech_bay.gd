extends Control

var primary_weapon: int = 1
var secondary_weapon: int = 1
var body: int = 1

func _ready() -> void:
	for x in %PWMenu.item_count:
		if %PWMenu.get_item_text(x).to_snake_case() == PlayerConfig.primary_weapon:
			%PWMenu.select(x)

	for y in %SWMenu.item_count:
		if %SWMenu.get_item_text(y).to_snake_case() == PlayerConfig.secondary_weapon:
			%SWMenu.select(y)

	for z in %BodyMenu.item_count:
		if %BodyMenu.get_item_text(z).to_snake_case() == PlayerConfig.mech_body:
			%BodyMenu.select(z)


func _on_pw_menu_item_selected(index: int) -> void:
	primary_weapon = %PWMenu.selected


func _on_sw_menu_item_selected(index: int) -> void:
	secondary_weapon = %SWMenu.selected


func _on_body_menu_item_selected(index: int) -> void:
	body = %BodyMenu.selected
	print(body)


func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui-elements/title_menu.tscn")


func _on_save_button_pressed() -> void:
	PlayerConfig.primary_weapon = %PWMenu.get_item_text(primary_weapon).to_snake_case()
	PlayerConfig.secondary_weapon = %SWMenu.get_item_text(secondary_weapon).to_snake_case()
	PlayerConfig.mech_body = %BodyMenu.get_item_text(body).to_snake_case()
	get_tree().change_scene_to_file("res://scenes/ui-elements/title_menu.tscn")
