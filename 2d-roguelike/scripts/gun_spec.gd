extends Node
class_name GunSpec

const GUN_SPEC := {
	"pistol": 
	{
		"magazine_size": 15,
		"starting_reserve": 50,
		"max_reserve": 100,
		"reload_time": 0.5,
	},
	"machine gun": 
	{
		"magazine_size": 75,
		"starting_reserve": 150,
		"max_reserve": 300,
		"reload_time": 3.5
	},
	"sniper": 
	{
		"magazine_size": 5,
		"starting_reserve": 25,
		"max_reserve": 50,
		"reload_time": 1.0
	},
	"shotgun": 
	{
		"magazine_size": 8,
		"starting_reserve": 30,
		"max_reserve": 60,
		"reload_time": 2.0
	},
	"rocket launcher": 
	{
		"magazine_size": 1,
		"starting_reserve": 5,
		"max_reserve": 10,
		"reload_time": 2.0
	}
}

static func get_stats(gun_key: String) -> Dictionary:
	return GUN_SPEC.get(gun_key, {})
