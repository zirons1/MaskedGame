class_name TimerGuy
extends Control

signal game_over

@onready var letter_scene := preload("res://scenes/letter.tscn")

@onready var timer: Timer = %Timer
@onready var timer_box: HBoxContainer = %TimerBox

var queue : Array[int] = []

var total_time : int

func start(time : int) -> void:
	total_time = time
	on_timeout()
	timer.start()

func word(length : int) -> void:
	queue.append(total_time + length)

func on_timeout() -> void:
	if !queue.is_empty():
		update_time(queue.pop_front())
	else:
		var minus : int = total_time - 1
		if minus < 0:
			timer.stop()
			game_over.emit()
			return
		
		update_time(total_time - 1)

func update_time(new_time : int) -> void:
	var prev : int = total_time
	
	var prev_ten : int = (prev / 10) % 10
	var new_ten : int = (new_time / 10) % 10
	
	if prev_ten != new_ten:
		update_ten(new_ten)
	
	update_one(new_time % 10)
	total_time = new_time

func update_ten(num : int) -> void:
	if timer_box.get_child_count() >= 1:
		var ten := timer_box.get_child(0)
		ten.queue_free()
	
	var letter_rect := letter_scene.instantiate()
	letter_rect.letter = str(num)
	timer_box.add_child(letter_rect, false, 0)

func update_one(num : int) -> void:
	if timer_box.get_child_count() >= 2:
		var ten := timer_box.get_child(1)
		ten.queue_free()
	
	var letter_rect := letter_scene.instantiate()
	letter_rect.letter = str(num)
	timer_box.add_child(letter_rect)
