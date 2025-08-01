extends object_base

func on_collect(_player):
	print("Poção de cura coletada!")
	queue_free()
