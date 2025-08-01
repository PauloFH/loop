# object.gd - deve ser assim
extends Area2D  # NÃO StaticBody2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("default")
	body_entered.connect(_on_body_entered)
	print("Objeto criado e sinal conectado!")

func _on_body_entered(body):
	print("Algo entrou na área: ", body.name)
	if body.name == "Player":
		on_collect(body)

func on_collect(_player):
	pass  # Sobrescrito pelos filhos
