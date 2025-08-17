extends CharacterBody2D


const SPEED = 200.0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_direction := Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = input_direction * SPEED
	$DefaultLegs.move(input_direction)
	if Input.is_action_pressed("attack"):
		$Body.get_node("Minigun").action()
		$Body.get_node("Minigun2").action()
	move_and_slide()
	
