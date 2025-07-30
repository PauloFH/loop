extends CharacterBody2D

@export var speed = 100.0

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

var last_direction = "down"

func _ready():
	animation_player.play("idledown")

func _physics_process(_delta):
	
	var input_vector = Vector2.ZERO
	var new_direction = ""
	
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
		new_direction = "up"
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
		new_direction = "down"
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
		new_direction = "left"
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
		new_direction = "right"
	
	if input_vector.length() > 0:
		last_direction = new_direction
	
	input_vector = input_vector.normalized()
	
	velocity = input_vector * speed
	move_and_slide()
	
	if velocity.length() > 0:
		animation_player.play("walk" + last_direction)
	else:
		animation_player.play("idle" + last_direction)
