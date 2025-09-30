extends Health
class_name HealthPlayer

func change_health(amount:float) -> void:
	super(amount)
	$CanvasLayer/HealthBarHUD.change_health(amount)
	$HealthBar.change_health(amount)

func update() -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health
	$CanvasLayer/HealthBarHUD.update(max_health)
