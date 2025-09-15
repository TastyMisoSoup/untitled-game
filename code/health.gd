extends Node
class_name Health

@export var max_health: float
@export var health: float: 
	set(value):
		health = min(value,max_health)
		

func set_max_health(new_max_health: float) -> void:
	max_health = new_max_health
	
func set_health(new_health: float) -> void:
	health = new_health
	
func change_health(amount: float) -> void:
	health = health + amount
