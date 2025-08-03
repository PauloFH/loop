extends object_base

@export var key_type: int = 1  # 0 = GOLD, 1 = SILVER

func on_collect(_player):
	match key_type:
		0: 
			print("Chave dourada coletada!")
			_player.add_key(0) 
		1:
			print("Chave prateada coletada!")
			_player.add_key(1)
	
	print("Chaves do player: ", _player.collected_keys)
	queue_free()
