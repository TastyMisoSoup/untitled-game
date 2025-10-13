extends Node2D
class_name Player

var team_number: int = 5;
var team: String;
var open_menu: bool = false
const SPEED = 200.0
@export var input_direction: Vector2

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	
func _ready() -> void:
	position = Vector2(150, 50)
	if !is_multiplayer_authority():
		$CanvasLayer/Button.visible = true
	$Mech.change_team("team"+name)
	

func _physics_process(_delta: float) -> void:
	
	if !is_multiplayer_authority(): return
	
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
			$Mech.dash()
		$Mech.mech_look_at(get_global_mouse_position())
		$Mech.move(input_direction)


func _on_hitbox_on_raycast_hit(amount) -> void:
	$Mech/Health.change_health(amount)
	if $Mech/Health.health <= 0:
		hide()
	print($Mech/Health.health)


func _on_game_menu_menu_visibility_change(open: bool) -> void:
	open_menu = open


func _on_button_pressed() -> void:
	print($Mech/Hitbox.get_groups())
