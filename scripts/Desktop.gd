extends Node2D

onready var apps = $Apps
onready var time = $Time
onready var debug_mem_info = $DebugMem

var am_pm = " AM"

func _process(delta):
#	var mem_usage = OS.get_static_memory_usage()
#	var mb = mem_usage/1024^2
#	debug_mem_info.text = str(mb)
	var current_time = OS.get_time()
	
	var hour = current_time.hour
	var minute = current_time.minute
	var seconds = current_time.second
	
	# Convert to 12-hour format
	if hour > 12:
		hour -= 12
		am_pm = " PM"
	
	time.text = "Time: " + str(hour) + ":" + str(minute) + ":" + str(seconds) + am_pm


func _on_FairUsePlease_pressed():
	get_tree().change_scene("res://Levels/FairUsePleaseTutorial.tscn")


func _on_VHSVault_pressed():
	get_tree().change_scene("res://Levels/VHSVaultMain.tscn")


func _on_PiracyPursuit_pressed():
	pass # Replace with function body.
