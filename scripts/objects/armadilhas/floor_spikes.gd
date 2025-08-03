extends TrapBase

## script sendo usado em cima de uma area2D. Abstrações da node2D estão sendo "concretizadas" aqui,
## de modo que esse escript se torna usável apenas em uma area2D, e o trapBase continua extensível
## para qualquer node2D.

@export var spike_duration: float = 2.0
@export var warning_time: float = 0.5

@onready var sprite = $Sprite2D
@onready var activate_collision = $activate_box/CollisionShape2D
@onready var damage_collision = $damage_box/CollisionShape2D



func _on_activate_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		trigger_trap(body)

func _on_damage_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)


func activate_trap(body):
	sprite.frame = 1
	await get_tree().create_timer(warning_time).timeout
	sprite.play("default")
	activate_collision.disabled = true
	damage_collision.disabled = false
	await get_tree().create_timer(spike_duration).timeout
	sprite.play_backwards("default")
	activate_collision.disabled = false
	damage_collision.disabled = true
