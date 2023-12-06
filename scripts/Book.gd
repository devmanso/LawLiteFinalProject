extends Node2D

onready var titlelabel = $Title
onready var authorlabel = $Author
onready var cover = $BookCover

export var title = "my title // change this!!"
export var author = "Mansour Quddus // change this!!"


func _ready(): 
	titlelabel.text = title
	authorlabel.text = author
	titlelabel.hide()
	authorlabel.hide()

