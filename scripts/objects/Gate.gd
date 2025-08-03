extends StaticBody2D

enum KeyType { GOLD, SILVER }

@export var required_key: KeyType = KeyType.SILVER
@export var animation_name: String = "open_gate"

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var area_2d = $Area2D

var is_open = false

func _ready():
	if sprite:
		sprite.frame = 0
	if area_2d:
		area_2d.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") and not is_open:
		if body.has_key(required_key):
			open_gate(body)

func open_gate(player):
	if is_open:
		return
	is_open = true
	player.use_key(required_key)
	if animation_player and animation_player.has_animation(animation_name):
		animation_player.play(animation_name)
		await animation_player.animation_finished
		animation_player.pause()
	else:
		print("Animação não encontrada: ", animation_name)
	
	print("Portão aberto!")
