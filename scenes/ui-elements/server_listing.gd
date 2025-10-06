extends Control

var map:Map;
var mapList:Array;

func _init() -> void:
	mapList.append_array(ValidScenePaths.MAPS)

func _ready() -> void:
	update_map()

func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui-elements/title_menu.tscn")

func _on_create_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_join_button_pressed() -> void:
	pass # Replace with function body.

func update_map() -> void:
	map = load("res://resources/maps/"+mapList[0]+".tres")
	get_node("%MapImage").texture = load(map.IMAGE_PATH)
	get_node("%MapName").text = map.NAME
	get_node("%SelectedMapImage").texture = load(map.IMAGE_PATH)
	
func next_map() -> void:
	var temp = mapList.pop_front();
	mapList.append(temp)
	update_map();

func _on_next_map_pressed() -> void:
	next_map()
	print(mapList[0])
