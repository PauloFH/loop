extends object_base

func on_collect(_player):
	print("Chave coletada!")
	_player.key_f += 1
	print(_player.key_g)
	queue_free()
