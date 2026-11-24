extends Control

func score(score : int) -> void:
	$Label.text = "[center]You unmasked\n[b]" + str(score) + "[/b]\nwords![/center]"
