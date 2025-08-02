extends Area2D

var damage:float = 0
var direction:Vector2 = Vector2(0,0)
var speed:float = 0

func setup(damage:float, direction:Vector2, speed:float) -> void:
	self.damage = damage
	self.direction = direction
	self.speed = speed
	rotation = direction.angle()


func _process(delta: float) -> void:
	position += Vector2(0, speed)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
	queue_free()
