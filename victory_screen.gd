extends Node2D

@onready var userScore := $userScore
@export var end_music: AudioStream 

const scoreStyles = "[center][wave][font_size=40]"

func _ready() -> void:
	userScore.text = scoreStyles + "Score: " + str(GameState.player_score)
	end_music.loop = true
	AudioController.play_music(end_music)


func _on_button_pressed() -> void:
	pass # Replace with function body.
