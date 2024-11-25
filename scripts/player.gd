extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980

@onready var animated_sprite = $AnimatedSprite2D
@export var maxHealth = 30
@onready var currentHealth: int = maxHealth
var double_jump_available = true
var current_animation = "idling"

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		double_jump_available = true
		
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif double_jump_available:
			velocity.y = JUMP_VELOCITY * 0.999999
			double_jump_available = false
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		if animated_sprite != null:
			animated_sprite.flip_h = direction < 0
		play_animation("running")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		play_animation("idling")
		
	if velocity.y < 0:
		play_animation("jumping1")
	elif velocity.y > 0:
		play_animation("jumping2")
	
	move_and_slide()

func play_animation(anim_name: String) -> void:
	if current_animation != anim_name:
		current_animation = anim_name
		if animated_sprite != null:
			animated_sprite.play(anim_name)
