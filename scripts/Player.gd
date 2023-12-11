extends KinematicBody2D

# Player properties
var speed : float = 200
var jump_force : float = -500
var gravity : float = 800
var is_jumping : bool = false
var velocity : Vector2 = Vector2()

# Called every frame
func _process(delta):
	# Player movement
	velocity.x = speed * Input.get_action_strength("right") - speed * Input.get_action_strength("left")
	
	# Jumping
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_force
		is_jumping = true
	
	# Apply gravity
	velocity.y += gravity * delta
	
	# Move the player
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	# Update animation or other game logic here

# Called when the player hits the ground
func _on_FloorDetector_area_entered(area):
	is_jumping = false
	velocity.y = 0
