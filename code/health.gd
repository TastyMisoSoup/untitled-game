extends Node
class_name Health

var max_health: float

var health: float: 
	set(value):
		health = min(value,max_health)
	
func change_health(amount: float) -> void:
	health = health + amount
