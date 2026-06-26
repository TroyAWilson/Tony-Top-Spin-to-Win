extends Node
#@onready var fade_rect: ColorRect = $FadeRect
#@onready var anim: AnimationPlayer = $AnimationPlayer

const VICTORY := "res://victory_screen.tscn"

var current_level := ""
var transitioning := false

func change_scene(path):
	if transitioning:
		return

	transitioning = true
	#fade_rect.visible = true
	
	#anim.play("fade_out")
	#await anim.animation_finished	
	
	get_tree().change_scene_to_file(path)

	#anim.play("fade_in")
	#await anim.animation_finished
	
	transitioning = false
	#fade_rect.visible = false
