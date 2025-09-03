extends CharacterBody2D


const SPEED = 200.0

func _ready() -> void:
	$Health.set

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_direction := Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = input_direction * SPEED
	$DefaultLegs.move(input_direction)
	if Input.is_action_just_pressed("attack"):
		$Body.get_node("Minigun").action()
		$Body.get_node("Minigun2").action()
	if Input.is_action_just_released("attack"):
		$Body.get_node("Minigun").stop_action()
		$Body.get_node("Minigun2").stop_action()
	move_and_slide()
	


func _on_hitbox_on_raycast_hit() -> void:
	print("hello")
