extends CharacterBody2D

@export var speed = 100.0
@export var max_health = 100
var current_health
var is_dead = false

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

var last_direction = "down"

func _ready():
	current_health = max_health
	animation_player.play("idledown")

func _physics_process(_delta):
	if is_dead:
		return
	
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

func take_damage(damage):
	if is_dead:
		return
		
	current_health -= damage
	print("Vida atual: ", current_health)
	
	if current_health <= 0:
		die()

func die():
	is_dead = true
	current_health = 0
	
	# Usa a animação específica de morte na direção correta
	animation_player.play("dead" + last_direction)
	
	print("Player morreu!")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		take_damage(50)
