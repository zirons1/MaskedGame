class_name InputBox
extends Control

@onready var letter_scene := preload("res://scenes/letter.tscn")

@onready var text_box: HBoxContainer = %TextBox
@onready var check: AnimatedSprite2D = %Check

var en_dictionary : PackedStringArray

var curr_word : String

func _ready() -> void:
	# init English dictionary
	var file : FileAccess = FileAccess.open("res://words/dictionary.txt", FileAccess.READ)
	while not file.eof_reached():
		en_dictionary.push_back(file.get_line().to_lower())
		
	check.play()
	update_check()

func add_letter(letter : String) -> void:
	if curr_word.length() > 12:
		# TODO
		print("too long")
		return
	
	var letter_rect := letter_scene.instantiate()
	letter_rect.letter = letter
	text_box.add_child(letter_rect)
	
	curr_word += letter
	update_check()

func backspace() -> void:
	var letter_count : int = text_box.get_child_count()
	if letter_count == 0:
		return
	
	var last : int = letter_count - 1
	
	curr_word = curr_word.substr(0, last)
	update_check()
	
	text_box.get_child(last).queue_free()

func clear() -> void:
	curr_word = ""
	update_check()
	
	for child in text_box.get_children():
		child.queue_free()

func in_dictionary(word : String) -> bool:
	var lower_word = word.to_lower()
	return lower_word in en_dictionary

func update_check() -> void:
	if curr_word.is_empty():
		check.hide()
		return
	
	if in_dictionary(curr_word):
		check.show()
	else:
		check.hide()

func get_typed_word() -> String:
	if in_dictionary(curr_word):
		return curr_word
	else:
		return ""
