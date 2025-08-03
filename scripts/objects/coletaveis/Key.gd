extends Area2D

enum KeyType { GOLD, SILVER }

@export var key_type: KeyType = KeyType.GOLD

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.add_key(key_type)
		queue_free()
