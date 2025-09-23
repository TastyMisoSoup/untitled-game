extends Node2D

@export var team_number: int;
var team: String 
var open_menu: bool = false
const SPEED = 200.0

func _ready() -> void:
	team = "team"+str(team_number);
	var mech_instance = Mech.mech_construct(team, 1)
	add_child(mech_instance)

func _physics_process(delta: float) -> void:
	
	if open_menu:
		return
	
	if self.has_node("Mech"):
		var input_direction := Input.get_vector("move_left", "move_right","move_up","move_down")
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
		queue_free()
	print($Mech/Health.health)


func _on_game_menu_menu_visibility_change(open: bool) -> void:
	open_menu = open
