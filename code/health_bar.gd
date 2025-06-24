extends Node2D

@export var max_health: float;
@export var health: float;

signal health_changed(value: float)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_health_changed(value: float) -> void:
	health += value;
	if health + value > max_health:
		health = max_health;
	elif health <= 0:
		get_parent().queue_free()
	
