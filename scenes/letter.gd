class_name Letter
extends TextureRect

const LETTER_RAND := {
	"a" : 4, 
	"b" : 3, 
	"c" : 2, 
	"d" : 4, 
	"e" : 3, 
	"f" : 4, 
	"g" : 4, 
	"h" : 3, 
	"i" : 4, 
	"j" : 4, 
	"k" : 3, 
	"l" : 4, 
	"m" : 3, 
	"n" : 3, 
	"o" : 4, 
	"p" : 4, 
	"q" : 4, 
	"r" : 4, 
	"s" : 4, 
	"t" : 4, 
	"u" : 4, 
	"v" : 5, 
	"w" : 4, 
	"x" : 4, 
	"y" : 4, 
	"z" : 4,
	"0" : 2,
	"1" : 2,
	"2" : 4,
	"3" : 3,
	"4" : 3,
	"5" : 3,
	"6" : 4,
	"7" : 4,
	"8" : 3,
	"9" : 3}

@onready var greyscale_shader_material = preload("res://shaders/greyscale.tres")
@onready var white_shader_material = preload("res://shaders/white.tres")
@export var delta : float = 1.5

var starting_degrees : float
var starting_scale : Vector2

var letter : String :
	set(value):
		var rand : int = randi_range(1, LETTER_RAND[value])
		var file_path : String = "res://letters/" + value.to_upper() + " (" + str(rand) + ").png"
		texture = load(file_path)

func _ready() -> void:
	stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	
	var rect_size : Vector2 = size
	pivot_offset = Vector2(rect_size.x / 2, rect_size.y / 2)
	
	starting_degrees = rotation_degrees
	starting_scale = scale
	
	if randi() % 2:
		delta *= -1
	
	swap()

func swap() -> void:
	delta *= -1
	rotation_degrees = starting_degrees + delta
	
	var timer := get_tree().create_timer(0.8)
	timer.timeout.connect(swap)
