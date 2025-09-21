extends Node2D

func _on_hitbox_on_raycast_hit(amount: float) -> void:
	$Health.change_health(amount)
	if $Health.health <= 0:
		queue_free()
	print($Health.health)
