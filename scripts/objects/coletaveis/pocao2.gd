extends object_base

func on_collect(_player):
	print("Poção de mana coletada!")
	queue_free()
