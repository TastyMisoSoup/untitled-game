extends Node
class_name Health

@export var max_health: float
@export var health: float

func set_max_health(new_max_health) -> void:
	max_health = new_max_health

func get_max_health() -> float:
	return max_health
	
func set_health(new_health) -> void:
	health = new_health
	
func get_health() -> float:
	return health
