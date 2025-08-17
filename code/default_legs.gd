extends Legs

class_name DefaultLegs

func move(player_direction: Vector2) -> void:
	player_direction = -(player_direction)
	var direction := global_position+player_direction
	if player_direction != Vector2(0,0):
		$AnimatedSprite2D.play("move")
		look_at(direction)
	else:
		$AnimatedSprite2D.stop()
