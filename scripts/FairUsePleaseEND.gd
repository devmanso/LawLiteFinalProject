extends Node2D

onready var BG = $BG

# RichTextLabel doesn't have position property so we must have a child Node2d 
# above it and use it's position property
onready var textPosition = $EndTextPosition
onready var txt = $EndTextPosition/EndText
onready var next = $Next
onready var booksInNEL = $BooksInNEL
onready var IAlogo = $IALogo
onready var court = $Court
onready var impacts = $Impacts

var textCounter : int = 0

var rng = RandomNumberGenerator.new()

func _ready():
	impacts.hide()
	IAlogo.hide()
	booksInNEL.hide()
	court.hide()
	if OS.has_environment("USERNAME"):
		username = OS.get_environment("USERNAME")
	else:
		username = "Player"
	rng.set_seed(hash(username))

var pos1 = Vector2(rng.randf_range(100, 600), rng.randf_range(100, 400))
var pos2 = Vector2(rng.randf_range(100, 600), rng.randf_range(100, 400))
var pos3 = Vector2(rng.randf_range(100, 600), rng.randf_range(100, 400))
var username : String
onready var button_position : Vector2 = Vector2(textPosition.position.x, textPosition.position.y+100)
onready var button_position_end : Vector2 = Vector2(impacts.position.x, impacts.position.y +100)

var text1 = """
Founded in 1996 by Brewster Khale, the Internet Archive (often called IA for short),
is a non-profit digital archive and library that aims to provide 
"Universal acces to all knowledge" by perserving digital content and making it freely
avaiable to anyone with an internet connection. The IA perserves all things digital,
such as books, movies, TV shows, videos, games and software, literature, making it
a comprehensive resource for researchers, scholars, or just the general public.
"""

func _process(delta):
	button_position = Vector2(textPosition.position.x, textPosition.position.y+100)
	match textCounter:
		0:
			booksInNEL.hide()
			textPosition.position = Vector2(1024/2 - 320, 600/2-100)
			textPosition.scale = Vector2(1.5, 1.5)
			next.set_position(button_position)
		1:
			booksInNEL.show()
			textPosition.position = Vector2(32, 56)
			textPosition.scale = Vector2(1, 1)
			next.set_position(button_position)
			txt.text = text1
		2:
			booksInNEL.hide()
			IAlogo.show()
			textPosition.position = Vector2(560, 56)
			next.set_position(button_position)
			txt.text = "However, the legality of this initiative came into question. Hachette Book Group, along with major publishers like Penguin Random House and HarperCollins, filed a lawsuit against IA, alleging copyright exploitation and lack of compensation. "
		3:
			IAlogo.hide()
			booksInNEL.hide()
			court.show()
			textPosition.position = Vector2(312, 456)
			next.set_position(button_position)
			txt.text = "The case, known as Hachette v. Internet Archive, concluded on August 17, 2023, with the Southern District of New York ruling against IA. The court determined that the NEL's purpose did not grant IA the right to digitally scan and serve copyrighted material for free."
		4:
			court.hide()
			textPosition.position = Vector2(32, 56)
			txt.text = ""
			impacts.show()
			next.set_position(button_position_end)

func _on_Next_pressed():
	textCounter +=1
