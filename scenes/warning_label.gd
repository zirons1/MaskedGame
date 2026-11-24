class_name WarningLabel
extends Label

var invis : Color = Color(0, 0, 0, 0)
var black : Color = Color(0, 0, 0, 255)

var tween : Tween

func _ready() -> void:
	modulate.a = 0

func warn(message : String) -> void:
	if tween and tween.is_running():
		tween.pause()
		tween.custom_step(10.0)
	
	text = message
	
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 1.0).from(0).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 0, 1.0).from(1).set_ease(Tween.EASE_OUT)
	tween.finished.connect(tween.kill)
