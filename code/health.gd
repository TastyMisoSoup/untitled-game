extends Node
class_name Health

@export var max_health: float
@export var health: float

func set_max_health(new_max_health: float) -> void:
	max_health = new_max_health
	
func set_health(new_health: float) -> void:
	health = new_health
	
func take_damage(damage_amount: float) -> void:
	var final_damage: float = damage_amount
	if final_damage < 0:
		final_damage = 0
	health = health - final_damage
	
func heal(heal_amount: float) -> void:
	var final_heal: float = heal_amount
	if final_heal < 0:
		final_heal = 0
	health = health + final_heal
	
