extends Node2D


const SPEED = 200.0

func _ready() -> void:
	$Mech/Health.max_health = 100
	$Mech/Health.health = 100
	$Mech/Hitbox.add_to_group("team"+str(1))

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if self.has_node("Mech"):
		var input_direction := Input.get_vector("move_left", "move_right","move_up","move_down")
		if Input.is_action_pressed("attack"):
			$Mech.primary_weapon_action(get_global_mouse_position())
		if Input.is_action_just_released("attack"):
			$Mech.primary_weapon_action_stop()
		$Mech.mech_look_at(get_global_mouse_position())
		$Mech.move(input_direction)


func _on_hitbox_on_raycast_hit(amount) -> void:
	$Mech/Health.change_health(amount)
	if $Mech/Health.health <= 0:
		queue_free()
	print($Mech/Health.health)
