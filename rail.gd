extends Area2D

@onready var path: Path2D = $Path2D
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path_follow.loop = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("enter_grind_zone"):
		body.enter_grind_zone(self)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("exit_grind_zone"):
		body.exit_grind_zone(self)

func get_path_position(progress: float) -> Vector2:
	path_follow.progress = progress
	return path_follow.global_position

func get_path_length() -> float:
	return path.curve.get_baked_length()
