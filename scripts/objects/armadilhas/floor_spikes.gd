extends TrapBase

## script sendo usado em cima de uma area2D. Abstrações da node2D estão sendo "concretizadas" aqui,
## de modo que esse escript se torna usável apenas em uma area2D, e o trapBase continua extensível
## para qualquer node2D.

@export var spike_duration: float = 2.0
@export var warning_time: float = 0.5

@onready var area_2d = self
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

# Tem como função guardar o estado onde é possível causar dano no jogador ao colidir
var spikes_out:bool = false

func setup_trap():
	area_2d.body_entered.connect(_on_body_entered)
	sprite.modulate = Color.WHITE

## WARNING: caso o jogador entre e fique na trap enquanto ela está em cooldown, é possível que a trap
## não seja ativada novamente depois que o tempo de cooldown seja restituido. Pode ser necessário re
## fatorar o código do player ou desta trap caso essa interação não seja desejada.
func _on_body_entered(body):
	if body.is_in_group("player"):
		if spikes_out:
			body.take_damage(damage)
		else: 
			trigger_trap(body)

func activate_trap(body):
	sprite.frame = 1
	await get_tree().create_timer(warning_time).timeout
	sprite.play("default")
	spikes_out = true
	await get_tree().create_timer(spike_duration).timeout
	spikes_out = false
	sprite.frame = 0
	sprite.play_backwards("default")
