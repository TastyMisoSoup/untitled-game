extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_y := Input.get_axis("move_up", "move_down")
	var direction_x := Input.get_axis("move_left", "move_right")
	if direction_x || direction_y:
		velocity.x = direction_x * SPEED
		velocity.y = direction_y * SPEED
	else:
		velocity.x = 0
		velocity.y = 0
	
	look_at(get_global_mouse_position())
	move_and_slide()
