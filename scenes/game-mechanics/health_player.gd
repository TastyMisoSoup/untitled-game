extends Health
class_name HealthPlayer

@rpc("any_peer","call_local")
func change_health(amount:float) -> void:
	#wif !multiplayer.is_server(): return
	super(amount)
	$CanvasLayer/HealthBarHUD.change_health(amount)
	$HealthBar.change_health(amount)

func update() -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health
	$CanvasLayer/HealthBarHUD.update(max_health)

func HUD_visible() -> void:
	$CanvasLayer/HealthBarHUD.visible = !$CanvasLayer/HealthBarHUD.visible
