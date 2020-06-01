extends Resource

class_name ParticleWorld

class ForceProfile:
	var max_radius := 10.0
	var max_force := 15.0
	
	func _get_force_ad_distance(distance: float) -> float:
		if distance < 0.0 or distance > max_radius:
			return 0.0
		var a := (2.0*max_force)/max_radius
		return -a*abs(distance - (max_radius - max_force/max_radius)) + max_force

export var friction := 0.05

# particle_type_to_attractions[particle_type_number] = attractions_dict
# attractions_dict[particle_type_number] = force to particle_type_number
export var number_of_types := 0
export var max_force := 80.0
export var max_radius := 200.0
var particle_type_to_attractions := {}
var colors := [
	"f44336",
	"9c27b0",
	"3f51b5",
	"2196f3",
	"03a9f4",
	"00bcd4",
	"009688",
	"4caf50",
	"8bc34a"
]

func _ready():
	randomize()

func generate_world():
	particle_type_to_attractions.clear()
	for p in number_of_types:
		particle_type_to_attractions[p] = {}
		for pp in number_of_types:
			var new_force_profile := ForceProfile.new()
			new_force_profile.max_radius = rand_range(0.0, max_radius)
			new_force_profile.max_force = rand_range(-max_force, max_force)
			particle_type_to_attractions[p][pp] = new_force_profile
