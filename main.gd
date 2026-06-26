extends Node2D

@export var level_music: AudioStream 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.getOnReadyReferences($Player, $CanvasLayer/CountDown2)
	
	level_music.loop = true
	AudioController.play_music(level_music)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_area_body_entered(body: Node2D) -> void:
	#stop spinning sound
	AudioController.stop_sfx()
	#set GameState victory state to true
	GameState.victory = true
	#scene change to victory screen that displays score and a little thank you message
	SceneManager.change_scene(SceneManager.VICTORY)

func _on_rotate_body_entered(body: Node2D) -> void:
	
	var tween := create_tween()
	tween.tween_property(
		body,"rotation",deg_to_rad(20), 0.1
	)
	
	#body.rotation = deg_to_rad(20)
