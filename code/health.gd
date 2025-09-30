extends Node2D
class_name Health

@export var max_health: float

@export var health: float: 
	set(value):
		health = min(value,max_health)
	
func change_health(amount: float) -> void:
	health = health + amount
	print(health)
