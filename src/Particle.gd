extends KinematicBody2D

var world: ParticleWorld = null setget set_world
var color := Color(1, 0, 0) setget set_color
var radius := 5.0 setget set_radius
var type := 0

var accel := Vector2()
var vel := Vector2()

func set_color(new_color):
	color = new_color
	update()

func set_radius(new_radius):
	radius = new_radius
	if has_node("CollisionShape2D"):
		$CollisionShape2D.shape.radius = radius
	update()

func set_world(new_world):
	world = new_world
	type = randi() % world.number_of_types
	var screen_size := Utility.get_screen_size()
	
	var cur_max_radius := 0.0
	for profile in world.particle_type_to_attractions[type].values():
		cur_max_radius = max(cur_max_radius, profile.max_radius)
	$ForcesArea/CollisionShape2D.shape.radius = cur_max_radius
	color = world.colors[type % world.colors.size()]
	
#	linear_damp = world.friction / 300.0

func _ready():
	randomize()
	self.radius = radius
#	linear_velocity = Vector2(rand_range(-300,300), 0)

func _physics_process(delta):
	if world == null:
		return
	accel = Vector2()
#	add_central_force(-linear_velocity.normalized()*world.friction)
	for particle in $ForcesArea.get_overlapping_bodies():
		if not particle.is_in_group("particles"):
			continue # skip over this particle if it isn't actually a particle
		var distance: float = (particle.global_position - global_position).length()
		var force_magnitude: float = world.particle_type_to_attractions[type][particle.type]._get_force_ad_distance(distance)
#		if force_magnitude < 0.0:
#			print(force_magnitude)
		accel += force_magnitude * (particle.global_position - global_position).normalized()
	var screen_size := Utility.get_screen_size()
	if global_position.x > screen_size.x:
		global_position.x -= screen_size.x
	elif global_position.x < 0.0:
		global_position.x += screen_size.x
	if global_position.y > screen_size.y:
		global_position.y -= screen_size.y
	elif global_position.y < 0.0:
		global_position.y += screen_size.y
	
	vel += accel*delta
	vel = move_and_slide(vel)
	
	vel = lerp(vel, Vector2(), world.friction)

func _draw():
	draw_circle(Vector2(), radius, color)
