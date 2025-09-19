extends Node2D

func _on_hitbox_on_raycast_hit(amount: float) -> void:
	$Health.change_health(amount)
	if $Health.health <= 0:
		queue_free()
	print($Health.health)

func _ready() -> void:
	$CanvasLayer/Control/TextureProgressBar.max_value = $Health.max_health

func _process(delta: float) -> void:
	$CanvasLayer/Control/TextureProgressBar.value = $Health.health
