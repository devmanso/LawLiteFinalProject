extends StaticBody2D

# Define variables
var speed = 100  # Adjust the speed as needed
var distance = 100  # Adjust the distance the platform travels

# Store the initial position
var initial_position = position
var target_position = initial_position + Vector2(0, distance)
var moving_up = true

# Called every frame
func _process(delta):
	# Move the platform
	var direction = Vector2(0, 0)
	
	if moving_up:
		direction.y = -1
	else:
		direction.y = 1
	
	position += direction * speed * delta
	
	# Check if the platform reached the target position or the initial position
	var distance_to_target = position.distance_to(target_position)
	var distance_to_initial = position.distance_to(initial_position)
	
	if moving_up and distance_to_target >= distance:
		moving_up = false
	elif not moving_up and distance_to_initial >= distance:
		moving_up = true
