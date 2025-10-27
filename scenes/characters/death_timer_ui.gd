extends Control

func _process(delta: float) -> void:
	$VBoxContainer/Label2.text = str(int($"../../DeathTimer".time_left)+1)
