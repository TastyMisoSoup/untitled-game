extends Node2D

func _ready() -> void:
	$HealthBar.max_value = $Health.max_health
	$HealthBar.value = $Health.max_health

func _on_hitbox_on_raycast_hit(amount: float) -> void:
	$Health.change_health(amount)
	$HealthBar.value += amount
	if $Health.health <= 0:
		queue_free()
	print($Health.health)
