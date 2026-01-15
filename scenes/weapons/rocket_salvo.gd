extends SecondaryWeapon
class_name RocketSalvo

const ROCKET_PATH:NodePath = "res://scenes/weapons/projectiles/rocket.tscn"

var rocket_count:int = 0
var weapon_ready:bool = true
var weapon_cooldown:int = 2
var rng = RandomNumberGenerator.new()
	
	
	
func _ready() -> void:
	%WeaponCooldownIcon.max_value = weapon_cooldown


func _process(delta: float) -> void:
	%WeaponCooldownIcon.value = %WeaponCooldownIcon.max_value - $WeaponCooldown.time_left


func show_icon() -> void:
	$CanvasLayer.show()

@rpc("any_peer","call_local","reliable")
func action(current_energy:int) -> void:
	if weapon_ready == false: return
	weapon_ready = false
	rocket_count = current_energy / energy
	print(rocket_count)
	$WeaponCooldown.start(weapon_cooldown)
	spawn_rocket()


func spawn_rocket() -> void:
	var random_lifetime = random_lifetime()
	print(random_lifetime)
	shoot.rpc($Muzzle.global_position,$Direction.global_position,random_lifetime,ROCKET_PATH)
	spend_energy(energy)
	rocket_count -= 1
	if rocket_count > 0:
		$Timer.start()


func _on_timer_timeout() -> void:
	spawn_rocket()


func _on_weapon_cooldown_timeout() -> void:
	weapon_ready = true


func random_lifetime() -> float:
	var lifetimes = [10.3,10.5,10.7]
	var weights = PackedFloat32Array([2,1,2])
	var result:float = lifetimes[rng.rand_weighted(weights)]
	return result
