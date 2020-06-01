extends Node2D

const SPAWN_DISTANCE = 100.0
const SPAWN_JITTER = 20.0

var cur_world = preload("res://test_world.tres")

func _ready():
	randomize()
#	cur_world.number_of_types = 5
	cur_world.generate_world()
	spawn_particles()

func _input(event):
	if event is InputEventKey and event.scancode == KEY_SPACE:
		cur_world.generate_world()
		spawn_particles()

func spawn_particles():
	for c in get_children():
		c.queue_free()
	var cur_pos = Vector2(SPAWN_DISTANCE, SPAWN_DISTANCE)
	var screen_size := Utility.get_screen_size()
	while cur_pos.x < screen_size.x:
		while cur_pos.y < screen_size.y:
			var cur_particle = preload("res://Particle.tscn").instance()
			add_child(cur_particle)
			cur_particle.position = cur_pos
			cur_particle.position += Vector2(
				rand_range(-SPAWN_JITTER, SPAWN_JITTER),
				rand_range(-SPAWN_JITTER, SPAWN_JITTER))
			cur_particle.world = cur_world
			cur_pos.y += SPAWN_DISTANCE
		cur_pos.x += SPAWN_DISTANCE
		cur_pos.y = SPAWN_DISTANCE
