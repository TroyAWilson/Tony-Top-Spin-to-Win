extends Node

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

const VICTORYSCREEN = "DavidKBD - 03 - Coastal Groove Party - Skank the Summer.ogg"
var spinSound := preload("res://spin.mp3")

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	sfx_player = AudioStreamPlayer.new()
	
	add_child(music_player)
	add_child(sfx_player)
	
func play_music(stream: AudioStream) -> void:
	if music_player.stream == stream and music_player.playing:
		return
		
	music_player.stream = stream
	music_player.volume_db = -25.0
	music_player.play()
	
func stop_music() -> void:
	music_player.stop()
	
func play_sfx(stream: AudioStream) -> void:
	stream.loop = true
	
	sfx_player.stream = stream
	sfx_player.volume_db = -10.0
	sfx_player.play()
	
func playTopSfx() -> void:
	spinSound.loop = true
	
	sfx_player.stream = spinSound
	sfx_player.volume_db = -10.0
	sfx_player.play()
	
func stop_sfx()->void:
	sfx_player.stop()
