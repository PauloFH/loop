extends CharacterBody2D

@export var speed = 100.0
@export var key_g = 0
@export var key_f = 0
@export var max_health = 100
var current_health
var is_dead = false

@export var ghost_time = 5.0
var is_ghost = false
var ghost_timer = 0.0



@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

var last_direction = "down"
var death_position = Vector2.ZERO
func _ready():
	current_health = max_health
	animation_player.play("idledown")
	collision_mask = 1
	collision_layer = 1

func _physics_process(_delta):
	if is_ghost:
			ghost_timer -= _delta
			if ghost_timer <= 0:
				generate_new_body()
	
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
	if is_dead or is_ghost:
		return
		
	current_health -= damage
	print("Vida atual: ", current_health)
	
	if current_health <= 0:
		die()


func die():
	if is_dead:
		return
	is_dead = true
	current_health = 0

	animation_player.play("dead" + last_direction)
	await animation_player.animation_finished
	create_corpse()
	become_ghost()
	
	print("Player morreu!")




func _input(event):
	if event.is_action_pressed("ui_accept") and not is_ghost:
		take_damage(100)

func become_ghost():
	is_ghost = true
	is_dead = false
	ghost_timer = ghost_time
	sprite.modulate = Color(1, 1, 1, 0.5)
	animation_player.play("idle" + last_direction)
	collision_mask = 2
	
	print("Virou fantasma!")



func create_corpse():
	var corpse = StaticBody2D.new()
	var corpse_sprite = Sprite2D.new()
	corpse_sprite.texture = sprite.texture
	corpse_sprite.hframes = sprite.hframes
	corpse_sprite.vframes = sprite.vframes
	corpse_sprite.frame = sprite.frame
	corpse_sprite.position = sprite.position
	corpse.add_child(corpse_sprite)
	var player_collision = $CollisionShape2D
	var collision = CollisionShape2D.new()
	collision.shape = player_collision.shape.duplicate()
	collision.position = player_collision.position
	corpse.add_child(collision)
	corpse.collision_layer = 1
	corpse.position = position
	
	get_parent().add_child(corpse)
	
	print("Sprite do player em: ", sprite.position)
	print("Colisor do player em: ", player_collision.position)
	print("Sprite do cadáver em: ", corpse_sprite.position)
	print("Colisor do cadáver em: ", collision.position)

func generate_new_body():
	is_ghost = false
	is_dead = false
	current_health = max_health
	sprite.modulate = Color(1, 1, 1, 1.0)
	collision_mask = 1
	
	print("Gerou novo corpo!")



func has_key(key_type: String) -> bool:
	match key_type:
		"gold":
			return key_g > 0
		"iron":
			return key_f > 0
		_:
			return false

func use_key(key_type: String):
	match key_type:
		"gold":
			if key_g > 0:
				key_g -= 1
		"iron":  
			if key_f > 0:
				key_f -= 1
