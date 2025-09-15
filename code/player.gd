extends CharacterBody2D


const SPEED = 200.0

func _ready() -> void:
	$Health.max_health = 100
	$Health.health = 100

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_direction := Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = input_direction * SPEED
	$DefaultLegs.move(input_direction)
	if Input.is_action_pressed("attack"):
		$Body.primary_weapon_action(get_global_mouse_position())
	if Input.is_action_just_released("attack"):
		$Body.primary_weapon_action_stop()
	move_and_slide()
	$Body.look_at(get_global_mouse_position())


func _on_hitbox_on_raycast_hit(amount) -> void:
	$Health.change_health(amount)
	if $Health.health <= 0:
		queue_free()
	print($Health.health)
