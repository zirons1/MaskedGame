extends Control

@onready var title_text: Control = %TitleText
@onready var play: Control = $Play

@export var delta : float = 3.5

func _ready() -> void:
	swap()

func swap() -> void:
	delta *= -1
	for i in range(title_text.get_child_count()):
		var child := title_text.get_child(i)
		if i % 2:
			child.rotation_degrees = child.rotation_degrees + delta
		else:
			child.rotation_degrees = child.rotation_degrees - delta
			
	for i in range(play.get_child_count()):
		var child := play.get_child(i)
		if i % 2:
			child.rotation_degrees = child.rotation_degrees + delta
		else:
			child.rotation_degrees = child.rotation_degrees - delta
		
	var timer := get_tree().create_timer(0.6)
	timer.timeout.connect(swap)


func _on_panel_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		get_tree().change_scene_to_file("res://main.tscn")
