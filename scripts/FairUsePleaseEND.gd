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
onready var cdl = $CDL
onready var senators = $Senators
onready var nel = $Nel
onready var southnycourt = $NYCourt
onready var money = $money
onready var done = $Done

var textCounter : int = 0

var rng = RandomNumberGenerator.new()

func _ready():
	impacts.hide()
	southnycourt.hide()
	money.hide()
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

var text2 = """
The Internet Archive also hosts a free digital library, calle the Open Library,
the archive boasts more than 1.4 million books, both public domain, and licensed,
popular or obscure.

IA does this through a model called Controlled-Digital-Learning (CDL).
CDL is a digital library lending practice, that mimics the lending practices of
physical libraries, while adiding by copyright law*. Physical boks are digitally
scanned into digital copies, which lended based on the number of physical copies
the library owns. So if a library owns 10 physical copies of a book, they can lend
out 10 digital copies. These digital copies come with DRM software (Digital Rights
Management) to prevent illegal copies, and limit content only on the loan period.
"""

var text3 = """
The IA had been using the CDL system since 2011 to great success, the methodology
had raised some legal concerns, but has never been seriously challenged up until
recently.

This would change when, during the pandemic, starting on March 23, 2020. The IA
announced the National-Emergency-Library, their website blog stated "
To address our unprecedented global and immediate need for access to reading and research materials, as of today, March 24, 2020, the Internet Archive will suspend waitlists for the 1.4 million (and growing) books in our lending library by creating a National Emergency Library to serve the nation’s displaced learners. This suspension will run through June 30, 2020, or the end of the US national emergency, whichever is later."
"""

var text4 = """
The NEL was met with acclaim from the public, universities and libraries viewed it
as an indespensible service, especially during the COVID-19 lockdown. However, it
was despised by authors and their publishers. The Author's Guild stated:
"IA has no rights whatsoever to these books, much less to give them away indiscriminitly,
... the Internet Archive would use the COVID-19 epidemic as an excuse to push copyright
law further out to the edges, and in doing so, harm authors"

Despite the general public's support, the book publishers had bi-partisan support
from both sides, Senators Thom Tills, and Tom Udall shared their support.
"""

var text5 = """
This all came to a head on June 16, 2020. When 4 of the largest book publishers
in the world, filed a lawsuit against Internet Archive for mass copyright infringment
under the false guise of fair use. IA immediately ended the NEL, but the Open Library
still functioned under the previous CDL model.

The case concluded on August 17 of this year, with the Southern District Court of
New York ruling against IA. The court determined that the NEl's purpose did not
grant IA the copyrights to lend an unlimited amount of copyrighted books.

The court demanded that IA repay the publishers for 125 books lended on the NEL.
"""

var text6 = """

"""

func _process(delta):
	button_position = Vector2(textPosition.position.x, textPosition.position.y+100)
	match textCounter:
		0:
			nel.hide()
			booksInNEL.hide()
			textPosition.position = Vector2(1024/2 - 320, 600/2-100)
			textPosition.scale = Vector2(1.5, 1.5)
			next.set_position(button_position)
		1:
			booksInNEL.show()
			textPosition.position = Vector2(32, 56)
			textPosition.scale = Vector2(1, 1)
			next.set_position(Vector2(button_position.x, button_position.y+100))
			txt.text = text1
		2:
			booksInNEL.hide()
			#IAlogo.show()
			cdl.show()
			cdl.position = Vector2(100, 50)
			textPosition.position = Vector2(480, 56)
			next.set_position(Vector2(button_position.x, button_position.y+220))
			txt.text = text2
		3:
			IAlogo.hide()
			cdl.position = Vector2(590,70)
			booksInNEL.hide()
			#court.show()
			nel.show()
			textPosition.position = Vector2(80, 330)
			next.set_position(Vector2(button_position.x, button_position.y + 95))
			txt.text = text3
		4:
			nel.hide()
			court.hide()
			cdl.hide()
			textPosition.position = Vector2(32, 56)
			txt.text = text4
			senators.position = Vector2(580, 50)
			senators.show()
			#impacts.show()
			next.set_position(button_position)
		5:
			IAlogo.show()
			senators.hide()
			textPosition.position = Vector2(60, 5)
			txt.text = text5
			southnycourt.show()
			money.show()
			next.set_position(Vector2(700, 100))
		6:
			impacts.show()
			southnycourt.hide()
			money.hide()
			txt.text = ""
			IAlogo.hide()
			done.set_position(Vector2(100, 400))
		
		
func _on_Next_pressed():
	textCounter +=1


func _on_Done_pressed():
	get_tree().change_scene("res://Levels/Desktop.tscn")
