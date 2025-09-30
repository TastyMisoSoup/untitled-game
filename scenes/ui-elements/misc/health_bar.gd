extends ProgressBar

const THEME_NORMAL:Theme = preload("res://scenes/ui-elements/themes/health_bar.tres")
const THEME_CRITICAL:Theme = preload("res://scenes/ui-elements/themes/health_bar_critical.tres")

func change_health(amount:float):
	value += amount
	if(value / max_value * 100 <= 35):
		theme = THEME_CRITICAL
	else:
		theme = THEME_NORMAL
#e93439
#51b072
