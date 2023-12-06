extends Area2D

export var move_speed : float = 250.0

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _physics_process(delta):
	
	#move_speed = rng.randf_range(100, 200)
	position.x -= move_speed * delta

func _on_TangledTape_body_entered(body):
	if body.name == "Runner":
		body.kill()