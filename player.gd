extends CharacterBody2D

const MAX_SPEED = 300.0
const ACCELERATION = 600.0
const DECELERATION = 150.0
const JUMP_VELOCITY = -300.0
const GRIND_SPEED = 300.0
const RAIL_OFFSET = Vector2(0, -13) #Sets player above the rail, just an offset value
const BASE_SPEED := 250.0
const scoreStyles = "[font_size=20]"

var can_grind := false
var grinding := false
var grind_direction := 1
var current_rail: Area2D = null
var grind_progress := 0.0
var doing_trick := false
var snapping_to_rail := false
var snap_tween: Tween = null
var controls_enabled := false
var slowing_to_stop := false

@onready var MainLabel := $"../CanvasLayer/Score2"
@onready var AnimPlayer := $AnimationPlayer
@onready var AnimSprite := $AnimatedSprite2D

func _onready() -> void:
	MainLabel.text = str(GameState.player_score)
	floor_snap_length = 12.0
	floor_max_angle = deg_to_rad(60)
	floor_stop_on_slope = false

func _physics_process(delta: float) -> void:
	if not controls_enabled:
		AnimSprite.play("no_spin")
		return
		
	
	if MainLabel.text == "":
		MainLabel.text = scoreStyles+str(GameState.player_score)
	
	if can_grind and not grinding and Input.is_action_just_pressed("ui_up"):
		start_grind()
	
	if grinding:
		GameState.player_score += 1
		MainLabel.text = scoreStyles + str(GameState.player_score)
	
		if snapping_to_rail:
			return
			
		var rail_length = current_rail.get_path_length()

		grind_progress += GRIND_SPEED * grind_direction * delta
		grind_progress = clamp(grind_progress, 0.0, rail_length)

		global_position = current_rail.get_path_position(grind_progress) + RAIL_OFFSET
		
		if grind_progress <= 0.0 or grind_progress >= rail_length:
			end_grind()
			return
			
		if Input.is_action_just_pressed("ui_accept"):
			end_grind()
			velocity.y = JUMP_VELOCITY + 75
			return
		
		return
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		AudioController.stop_sfx()
	else:
		velocity.y = 100
		if !AudioController.sfx_player.playing:
			AudioController.playTopSfx()


	if not is_on_floor() and not doing_trick and Input.is_action_just_pressed("trick"):
		do_trick()

	if is_on_floor():
		AnimSprite.play("default")

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	#var direction := Input.get_axis("ui_left", "ui_right")

	var speed = BASE_SPEED
	speed  = max(speed, BASE_SPEED)
		
	speed = move_toward(
		speed, MAX_SPEED, ACCELERATION * delta
	)
	
	velocity.x = speed
	move_and_slide()

func enter_grind_zone(rail: Area2D) -> void:
	can_grind = true
	current_rail = rail
	
func exit_grind_zone(rail: Area2D) -> void:
	if current_rail == rail and not grinding:
		can_grind = false
		current_rail = null

func start_grind() -> void:
	if doing_trick:
		doing_trick = false
	
	if current_rail == null:
		return

	grinding = true
	snapping_to_rail = true
	AnimSprite.play("grind")

	if velocity.x < 0:
		grind_direction = -1
		AnimSprite.flip_h = 1
	else:
		grind_direction = 1
		AnimSprite.flip_h = 0

	grind_progress = current_rail.path.curve.get_closest_offset(
		current_rail.path.to_local(global_position)
	)
	
	var target_position : Vector2 = current_rail.get_path_position(grind_progress) + RAIL_OFFSET

	velocity = Vector2.ZERO
	
	if snap_tween:
		snap_tween.kill()
	
	snap_tween = create_tween()
	snap_tween.tween_property(
		self, "global_position", target_position, 0.04
	)
	await snap_tween.finished
	snapping_to_rail = false
	
	#global_position = current_rail.get_path_position(grind_progress) + RAIL_OFFSET
	
func end_grind() -> void:
	var exit_speed := GRIND_SPEED * grind_direction
	AnimSprite.play("default")

	grinding = false
	can_grind = false
	current_rail = null
	
	velocity.x = exit_speed
	
func do_trick() -> void:
	if doing_trick:
		return
	#currently removing the animation check?
	#I don't think I have the time to fix this, so people can just spam trick
	#doing_trick = true
	AnimSprite.play("trick")
	
	#update score
	GameState.player_score += 50
	MainLabel.text = scoreStyles + str(GameState.player_score)
	await $AnimatedSprite2D.animation_finished

	print("after await")

	doing_trick = false
	AnimSprite.play("default")

func launch() -> void:
	#This needs to be workshopped a little bit more but we're almost there
	velocity.x = move_toward(
			velocity.x  + 500,
			1 * MAX_SPEED,
			ACCELERATION
		)
