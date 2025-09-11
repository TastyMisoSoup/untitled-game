extends Node2D

func _on_hitbox_on_raycast_hit(damage: float) -> void:
	$Health.take_damage(damage)
	if $Health.health <= 0:
		queue_free()
	print($Health.health)
