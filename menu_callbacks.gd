class_name MenuCallbacks
extends HBoxContainer

export var start_scene : PackedScene


func _ready():
	assert(start_scene != null, "Start scene missing. Start button will not work.")


func _on_Start_pressed():
	get_tree().change_scene_to(start_scene)


func _on_Quit_pressed():
	get_tree().quit()
