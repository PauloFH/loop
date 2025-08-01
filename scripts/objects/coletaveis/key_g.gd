extends object_base

func on_collect(_player):
	print("Chave dourada coletada!")
	_player.key_g += 1
	print(_player.key_g)
	queue_free()
