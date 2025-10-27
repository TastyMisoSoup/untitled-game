extends Node2D
class_name Player

const MECH_SCENE = preload("res://scenes/characters/mech.tscn")

var team_number: int = 5;
var team: String;
var open_menu: bool = false
var mech: Mech;
const SPEED = 200.0
@export var input_direction: Vector2

func _enter_tree() -> void:
	#set_multiplayer_authority(multiplayer.get_unique_id())
	pass
	
func _ready() -> void:
	$MultiplayerSpawner.set_spawn_function(mech_construct)
	if multiplayer.is_server():
		set_multiplayer_authority(multiplayer.get_unique_id())
		$MultiplayerSpawner.spawn("team"+name)
	

func _physics_process(_delta: float) -> void:
	
	#if !is_multiplayer_authority(): return
	
	if !visible: return
	
	if open_menu:
		return
	
	if self.has_node("Mech"):
		input_direction = Input.get_vector("move_left", "move_right","move_up","move_down")
		if Input.is_action_pressed("attack"):
			$Mech.primary_weapon_action(get_global_mouse_position())
		if Input.is_action_just_released("attack"):
			$Mech.primary_weapon_action_stop()
		if Input.is_action_just_pressed("dash") && input_direction!=Vector2(0,0):
			$Mech.dash.rpc_id(multiplayer.get_unique_id())
		$Mech.mech_look_at(get_global_mouse_position())
		$Mech.move(input_direction)


func _on_game_menu_menu_visibility_change(open: bool) -> void:
	open_menu = open

func mech_construct(team_param):
	var mech_instance = MECH_SCENE.instantiate()
	mech_instance.team = team_param
	mech_instance.label_name = self.name
	mech_instance.position = $"../".get_random_spawn_point()
	mech_instance.set_multiplayer_authority(name.to_int())
	return mech_instance
	
