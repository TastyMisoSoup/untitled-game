extends Weapon
class_name PrimaryWeapon

var weapon_ready:bool = false
	
func stop_action():
	pass

@rpc("any_peer","call_local","unreliable")
func shoot(start_pos:Vector2,target_pos:Vector2,timer:float,projectile_path:NodePath):
	weapon_ready = false
	
	super(start_pos,target_pos,timer,projectile_path)

func generate_energy(energy:int):
	weapon_action.emit(energy)

#@rpc("any_peer","call_local","reliable")
#func overload_switch(switch:bool) -> void:
#	if switch:
#		self.modulate = Color(1, 0.6, 0.6, 1)
#	else:
#		self.modulate = Color(1, 1, 1, 1)
