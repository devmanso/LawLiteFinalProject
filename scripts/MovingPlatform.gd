extends StaticBody2D

# Properties
var original_position: Vector2
var move_distance: float = 200.0  # Distance to move up and down
var speed: float = 200.0  # Speed of the platform

func _ready():
	# Store the original position
	original_position = position

func _process(delta):
	# Calculate the target position for the platform
	var target_position = original_position + Vector2(0, move_distance)
	
	# Move the platform towards the target position
	position = position.move_toward(target_position, speed * delta)
	
	# Check if the platform has reached the target position
	if position.distance_to(target_position) < 1.0:
		# Swap the direction by negating move_distance
		move_distance = -move_distance
