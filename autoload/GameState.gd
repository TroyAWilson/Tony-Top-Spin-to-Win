extends Node

var player : CharacterBody2D
var countdown_label : RichTextLabel
var player_score := 0
var victory := false

const spinSound := preload("res://spin.mp3")

func getOnReadyReferences(p: CharacterBody2D, l: RichTextLabel) -> void:
	player = p
	countdown_label = l
	
	start_countdown()

func start_countdown() -> void:
	print('starting countdown')
	
	const textStyles = "[wave][font_size=40]"
	
	const wordsArr := ['Get [color=#e63946]serious!', "You have to [color=d4a000]WIN", 'NOW [color=#1a73e8]SPIN!']
	
	for word in wordsArr:
		countdown_label.text = textStyles + ' ' + word
		await get_tree().create_timer(2.0).timeout
		
	countdown_label.queue_free()
	
	player.launch()
	AudioController.play_sfx(spinSound)
	player.controls_enabled = true

func changeScene() -> void:
	pass
