class_name Star
extends Control

func _ready() -> void:
	var file_path : String = "res://art/star" + str(randi_range(1, 2)) + ".png"
	$Sprite2D.texture = load(file_path)

func invis() -> void:
	$Sprite2D.texture = load("res://art/blank.png")
