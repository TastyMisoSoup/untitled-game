extends Legs

class_name DefaultLegs

func _process(delta: float) -> void:
	_move()

func _move() -> void:
	var input_direction: Vector2 = Input.get_vector('move_left','move_right','move_up','move_down')
	velocity = input_direction * SPEED
	if input_direction != Vector2(0,0):
		$AnimatedSprite2D.play("move")
		look_at(global_position+input_direction)
		move_and_slide()
	else:
		$AnimatedSprite2D.stop()
