class_name SecretBox
extends Control

@onready var star_scene := preload("res://scenes/star.tscn")

@onready var label: Label = %Label
@onready var star_box: HBoxContainer = %StarBox

var secret_word : String
var revealed_letters : int = 0

func new_word(word : String) -> void:
	secret_word = word
	revealed_letters = 0
	label.text = word
	for x in range(word.length()):
		var star := star_scene.instantiate()
		star_box.add_child(star)
	star_box.show()
	
	reveal_next_letter()

func get_revealed_letters() -> String:
	var word : String
	for x in range(revealed_letters):
		word += secret_word[x]
	return word

func reveal_next_letter() -> void:
	star_box.get_child(revealed_letters).invis()
	revealed_letters += 1

func reveal_all() -> void:
	star_box.hide()
	for child in star_box.get_children():
		child.queue_free()
