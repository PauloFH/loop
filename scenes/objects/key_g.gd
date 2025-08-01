extends "res://scripts/objects/object.gd"

func on_collect(_player):
	print("Chave dourada coletada!")
	_player.key_g += 1
	print(_player.key_g)
	queue_free()
