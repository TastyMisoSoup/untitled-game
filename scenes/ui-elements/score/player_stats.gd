extends HBoxContainer
class_name PlayerStats

const IS_OWNER:Theme = preload("res://scenes/ui-elements/themes/is_owner.tres")

var player_name:String = "Player";
var kills:int = 0;
var deaths:int = 0;
var rank:int = 0;
var is_owner:bool;

func _ready() -> void:
	if is_owner:
		$PanelContainer.theme = IS_OWNER
	$PanelContainer/PlayerName.text = player_name
	$PanelContainer/Stats.text = str(kills)+" / "+str(deaths)
	$PanelContainer/Rank.text = str(rank)+"#"

func sort():
	pass

func update():
	$Stats.text = str(kills)+" / "+str(deaths)
