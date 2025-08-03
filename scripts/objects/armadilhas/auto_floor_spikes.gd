extends TrapBase

## script sendo usado em cima de uma area2D. Abstrações da node2D estão sendo "concretizadas" aqui,
## de modo que esse escript se torna usável apenas em uma area2D, e o trapBase continua extensível
## para qualquer node2D.

@export var auto_start_cooldown:float = 1
@export var spike_duration: float = 2.0
@export var warning_time: float = 0.5

@onready var area_2d = self
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var timer = $auto_activation

func setup_trap():
	timer.start(auto_start_cooldown)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)

func _on_auto_activation_timeout() -> void:
	sprite.frame = 1
	await get_tree().create_timer(warning_time).timeout
	collision.disabled = false
	sprite.play("default")
	await get_tree().create_timer(spike_duration).timeout
	collision.disabled = true
	sprite.play_backwards("default")
	await sprite.animation_finished
	timer.start(auto_start_cooldown)
