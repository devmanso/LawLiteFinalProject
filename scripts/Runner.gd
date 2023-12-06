extends KinematicBody2D

onready var AnimSprite = $AnimSprite

# Constants
export var gravity = 1600
export var jump_force = -800
export var duck_speed = 600

# Variables
var velocity = Vector2()  # Player's velocity
var current_time

func _process(delta):
	# Check for input and perform actions
	process_input()
	
	# Apply gravity
	apply_gravity()
	
	# Move the player
	move_and_slide(velocity, Vector2(0, -1))


# Function to get the framerate of the currently playing animation
func get_current_animation_framerate(anim_sprite : AnimatedSprite):
	var current_animation = anim_sprite.animation
	if current_animation != "":
		var animation_length = anim_sprite.get_animation_length(current_animation)
		var num_frames = anim_sprite.get_frame_count(current_animation)
		
		if animation_length > 0:
			var framerate = num_frames / animation_length
			print("Current animation framerate: ", framerate)
			return framerate
	return 0  # Return 0 if there's an issue or no animation is playing


func process_input():
	# Jumping
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_force
	
	# Ducking
	if Input.is_action_pressed("duck"):
		AnimSprite.play("running")
		velocity.y = duck_speed
	else:
		AnimSprite.play("running")  # TODO: make ducking animation
		velocity.x = 0

func apply_gravity():
	# Apply gravity only if not on the floor
	if not is_on_floor():
		velocity.y += gravity * get_process_delta_time()

func kill():
	get_tree().change_scene("res://Levels/Desktop.tscn")

