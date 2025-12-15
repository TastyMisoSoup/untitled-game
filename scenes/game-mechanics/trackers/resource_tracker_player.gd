extends ResourceTracker
class_name ResourceTrackerPlayer

@rpc("any_peer","call_local")
func change_health(amount:float) -> float:
	#if !multiplayer.is_server(): return
	super(amount)
	$CanvasLayer/ResourceTrackerHUD.change_health(amount)
	$HealthBar.change_health(amount)
	return health
	
func change_energy(amount:int) -> int:
	super(amount)
	$CanvasLayer/ResourceTrackerHUD
	return energy

func update_energy() -> void:
	$CanvasLayer/ResourceTrackerHUD.update_energy(max_energy)

func update_health() -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health
	$CanvasLayer/ResourceTrackerHUD.update_health(max_health)

func HUD_visible() -> void:
	$CanvasLayer/ResourceTrackerHUD.visible = !$CanvasLayer/ResourceTrackerHUD.visible
