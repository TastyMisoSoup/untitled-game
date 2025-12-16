extends Node2D
class_name ResourceTracker

@export var max_health: float

@export var health: float: 
	set(value):
		health = clamp(value,0,max_health)
		
var max_energy:int

var energy:int:
	set(value):
		energy = clamp(value,0,max_energy)

func change_energy(amount:int) -> int:
	energy = energy + amount
	return energy
	
func change_health(amount: float) -> float:
	health = health + amount
	return health
