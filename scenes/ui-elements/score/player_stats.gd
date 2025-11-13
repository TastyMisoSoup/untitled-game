extends HBoxContainer
class_name PlayerStats

var player_name:String = "Player";
var kills:int = 0;
var deaths:int = 0;
var rank:int = 1;

func sort():
	pass

func update():
	$Stats.text = str(kills)+" l "+str(deaths)
