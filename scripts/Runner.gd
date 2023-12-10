extends KinematicBody2D

onready var AnimSprite = $AnimSprite

# Constants
export var gravity = 1600
export var jump_force = -800
export var duck_speed = 600

# Variables
var velocity = Vector2()  # Player's velocity
var current_time
var deaths : int
var docs_collected : int

func _ready():
	# check if a "deaths.txt" file exists, if it doesn't, create it
	# and initialize the newly created file with a 0.
	var death_file = File.new()
	if not death_file.file_exists("user://deaths.txt"):
		death_file.open("user://deaths.txt", File.WRITE)
		death_file.store_line("0")
		death_file.close()
	
	# read file and init deaths
	death_file.open("user://deaths.txt", File.READ)
	deaths = int(death_file.get_line())
	death_file.close()
	
	var docsfile = File.new()
	if not docsfile.file_exists("user://docscollected.txt"):
		docsfile.open("user://docscollected.txt", File.WRITE)
		docsfile.store_line("0")
		docsfile.close()
	
	docsfile.open("user://docscollected.txt", File.READ)
	docs_collected = int(docsfile.get_line())
	docsfile.close()


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
	deaths +=1
	var file = File.new()
	file.open("user://deaths.txt", File.WRITE)
	file.store_line(str(deaths))
	file.close()
	get_tree().change_scene("res://Levels/EndlessDeath.tscn")

func legaldoc_collected():
	
	docs_collected +=1
	var file = File.new()
	file.open("user://docscollected.txt", File.WRITE)
	file.store_line(str(deaths))
	file.close()
