extends PanelContainer

var kill:String
var death:String

func _ready() -> void:
	%Kill.text = kill
	%Death.text = death
	$Timer.start(3)


func _on_timer_timeout() -> void:
	queue_free()
