extends Node2D
class_name Health

@export var max_health: float

@export var health: float: 
	set(value):
		health = clamp(value,0,max_health)
	
func change_health(amount: float) -> float:
	health = health + amount
	print(health)
	return health
