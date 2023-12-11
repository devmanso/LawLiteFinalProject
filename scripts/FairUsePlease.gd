extends Node2D

onready var yesbutton = $ButtonScaleYes/Yes
onready var nobutton = $ButtonScaleNo/No
onready var bookspawn = $BookSpawn
onready var titlelabel = $Title
onready var authorlabel = $Author
onready var desc = $Description
onready var publisherlabel = $Publisher

var book = preload("res://Assets/Book.tscn")
var new_book
var bookscale : Vector2 = Vector2(2, 2)
var yesCounter : int = 0
var noCounter : int = 0
var bookCounter : int = 0
var bookDestroyed : bool = false
var title : String
var author : String
var description : String
var publisher : String
var currentBook : String
var currentChoice # false for yes, true for no
var correctChoices : int = 0
var incorrectChoices : int = 0

# how this game works (like papers please)
# the user is presented with a book, one by one, the user clicks a checkmark if
# they think the book archived is under fair use, this will work like the game papers, please.
# the user is presented with a book, to the left of them is a guideline of fair use,
# and to the right of them is the info about the book, they must deicde
# wether or not the book falls under fair use, if it does they press the checkmark, 
# if it isn't they click the x mark and discard the book.

# this handles the title, author and description for all books
func generateBook():
	match bookCounter:
		1:
			title = "Frankenstein or, The modern Prometheus"
			currentBook = "frank"
			author = "Mary Wollstonecraft Shelley"
			publisher = "(Public Domain) 1818"
			description = "A classic Gothic tale delving into ambition, ethics, and the repercussions of playing god."
			new_book.cover.texture = load("res://Assets/frank.jpg")
		2:
			currentBook = ""
			title = "Charlotte's Web"
			author = "E. B. White"
			publisher = "Harper & Brothers 1952"
			description = "In a heartfelt narrative, a pig named Wilbur forms an unlikely friendship with a spider, exploring themes of loyalty and life's lessons."
			new_book.cover.texture = load("res://Assets/char_web.jpg")
		3:
			title = "The Great Gatsby"
			author = "F. Scott Fitzgerald"
			publisher = "Charles Scribner's Sons, entered Public Domain 2021"
			description = "In the Roaring Twenties, Jay Gatsby's extravagant parties mask a tale of unrequited love and societal disillusionment."
			new_book.cover.texture = load("res://Assets/thegreatgatsby.jpg")
		4:
			title = "The picture of Dorian Gray"
			author = "Oscar Wilde"
			publisher = "Public Domain"
			description = "A corrupt young man somehow keeps his youthful beauty eternally, but a special painting gradually reveals his inner ugliness to all."
			new_book.cover.texture = load("res://Assets/dorian_gray.jpg")
		5:
			title = "1984"
			author = "George Orwell"
			publisher = "Secker & Warburg 1949"
			description = "dystopian social science fiction novel"
			new_book.cover.texture = load("res://Assets/go_1984.jpg")
		6:
			title = "A Brave New world"
			author = "Aldous Huxley"
			publisher = "Harper Collins"
			description = "Huxley's 'Brave New World' explores a future of conformity, technology, and moral questions, offering a cautionary tale on societal control."
			new_book.cover.texture = load("res://Assets/bnw.jpg")
			new_book.scale = Vector2(.70, .70)


# spawns a book with appropriate scaling
func spawnBook(title : String, author : String):
	new_book = book.instance()
	new_book.title = title
	new_book.author = author
	new_book.scale = Vector2(2, 1.3) #scale * bookscale
	add_child(new_book)

# needs to be called after spawnBook to set bookspawn at a position
# use bookspawn.position
func setBookPos(position : Vector2):
	new_book.position = position

# destroys the current book to spawn another one
func destroyBook():
	if new_book:
		new_book.queue_free()

# spawn a book upon init of scene (frankenstein)
func _ready():
	currentChoice = "none"
	bookCounter +=1
	spawnBook(title, author)
	generateBook()
	setBookPos(bookspawn.position)
	bookDestroyed = false

func _process(delta):
	# ensure correct author, title and description is shown
	authorlabel.text = author
	titlelabel.text = title
	publisherlabel.text = publisher
	desc.text = str(correctChoices) + " correct guesses so far"
	#desc.text = description
	# handle book destruction/respawn
	if bookDestroyed:
		spawnBook(title, author)
		generateBook()
		setBookPos(bookspawn.global_position)
		print("Book spawned")
		bookDestroyed = false
		handleChoices(bookCounter)
		currentChoice = "none" # reset current choice
	
	#print(currentChoice)
	
	if bookCounter == 7:
		get_tree().change_scene("res://Levels/FairUsePleaseEND.tscn")

func handleChoices(counter: int):
	var isCorrect: bool = currentChoice == "true"
	
	match counter:
		1:
			if isCorrect:
				correctChoices += 1
			else:
				incorrectChoices += 1
		2:
			if isCorrect:
				incorrectChoices += 1
			else:
				correctChoices += 1
		3:
			if isCorrect:
				correctChoices += 1
			else:
				incorrectChoices += 1
		4:
			if isCorrect:
				incorrectChoices += 1
			else:
				correctChoices += 1
		5:
			if isCorrect:
				incorrectChoices +=1
			else:
				correctChoices +=1
		6:
			# 1984
			if isCorrect:
				correctChoices +=1
			else:
				incorrectChoices +=1
		7:
			# Brave new world
			if isCorrect:
				correctChoices +=1
			else:
				incorrectChoices +=1
		


# this is awful code
#func handleChoices(counter : int):
#	if counter == 1 and currentChoice == "true":
#		correctChoices +=1
#	elif counter == 1 and currentChoice == "false":
#		incorrectChoices +=1
#	elif counter == 2 and currentChoice == "false":
#		correctChoices +=1
#	elif counter == 2 and currentChoice == "true":
#		incorrectChoices +=1
#	elif counter == 3 and currentChoice == "true":
#		correctChoices +=1
#	elif counter == 3 and currentChoice == "false":
#		incorrectChoices +=1
#	elif counter == 4 and currentChoice == "true":
#		correctChoices +=1
#	elif counter == 4 and currentChoice == "false":
#		incorrectChoices +=1

## INPUT HANDLING

func _on_Yes_pressed():
	currentChoice = "false"
	destroyBook()
	print("Book destroyed")
	yesCounter +=1
	bookCounter +=1
	bookDestroyed = true

func _on_No_pressed():
	currentChoice = "true"
	destroyBook()
	print("Book destroyed")
	noCounter +=1
	bookCounter +=1
	bookDestroyed = true
