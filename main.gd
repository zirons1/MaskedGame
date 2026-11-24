extends Control

const LEADERBOARD_NAME : String = "leaderboard"

const ALPHABET : String = "abcdefghijklmnopqrstuvwxyz"

@onready var secret_box: SecretBox = %SecretBox
@onready var input_box: InputBox = %InputBox
@onready var timer_guy: TimerGuy = $Timer
@onready var game_over_screen: Control = %GameOverScreen
@onready var tutorial: Control = %Tutorial

@onready var warning_label: WarningLabel = %WarningLabel

var seconds : int = 60

var source_words : Array[String]

var previous : Array[String]

var score : int = 0
var stopped : bool = false

func _ready() -> void:
	if Global.tutorial:
		tutorial.show()
	else:
		timer_guy.game_over.connect(game_over)
		timer_guy.start(seconds)
	
	var file : FileAccess = FileAccess.open("res://words/source.txt", FileAccess.READ)
	while not file.eof_reached():
		var line : String = file.get_line()
		if line.length() <= 12:
			source_words.push_back(line)
	
	pick_new_word()

func pick_new_word() -> void:
	var new_word : String = source_words.pick_random()
	source_words.erase(new_word)
	secret_box.new_word(new_word)

func _input(event):
	if Global.tutorial:
		if event.is_action_pressed("left_click") or event.is_action_pressed("space") or event.is_action_pressed("enter"):
			tutorial.hide()
			Global.tutorial = false
			
			timer_guy.game_over.connect(game_over)
			timer_guy.start(seconds)
		
		return
	
	if stopped:
		return
	
	if event.is_action_pressed("enter"):
		var typed_word : String = input_box.get_typed_word()
		var revealed_letters : String = secret_box.get_revealed_letters()
		var secret_word : String = secret_box.secret_word
		
		if typed_word.is_empty():
			warning_label.warn("Bruh, thats not a word.")
			return
		
		if typed_word.length() < revealed_letters.length() or !typed_word.begins_with(revealed_letters):
			warning_label.warn("The word must start with the revealed letters.")
			return
		
		if typed_word in previous:
			warning_label.warn("You tried that already. Hurry up!")
			return
		
		# From this point on, the word is valid
		input_box.clear()
		previous.append(typed_word)
		
		if typed_word == secret_word or typed_word.begins_with(secret_word) or revealed_letters.length() + 1 >= secret_word.length():
			secret_box.reveal_all()
			score += 1
			timer_guy.word(secret_word.length())
			get_tree().create_timer(1.0).timeout.connect(pick_new_word)
		else:
			secret_box.reveal_next_letter()
			
		return
	
	elif event.is_action_pressed("backspace"):
		input_box.backspace()

	elif event is InputEventKey and event.is_pressed():
		var key_event := event as InputEventKey
		var letter : String = String.chr(key_event.unicode).to_lower()
		if letter not in ALPHABET:
			return
		
		input_box.add_letter(letter)

func game_over() -> void:
	game_over_screen.score(score)
	game_over_screen.show()
	secret_box.reveal_all()
	stopped = true

func _on_play_again_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		get_tree().reload_current_scene()

func _on_menu_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		get_tree().change_scene_to_file("res://title.tscn")
