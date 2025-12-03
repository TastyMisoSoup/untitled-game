extends Node

var player_name: String = "John Doe"
var primary_weapon: String = "minigun"
var secondary_weapon: String = "grenade_launcher"
var mech_body: String = "daemon"

func get_player_info() -> Dictionary:
	return {
		"player_name":player_name,
		"primary_weapon":primary_weapon,
		"secondary_weapon":secondary_weapon,
		"mech_body":mech_body
	}
