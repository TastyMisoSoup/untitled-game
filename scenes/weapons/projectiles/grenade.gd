extends Projectile
class_name Grenade

func _ready() -> void:
	position = start_position
	look_at(global_position + direction)
	add_to_group(team)
	velocity = direction * speed
	$Timer.start(timer)



func _on_timer_timeout() -> void:
	queue_free()
