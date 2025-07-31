extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("default")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		on_collect(body)


func on_collect(_player):
	pass
