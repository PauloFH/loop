extends TrapBase

@onready var sprite = $sprite2D
@onready var activate_collision = $activate_box/CollisionShape2D
@onready var damage_collision = $damage_box/CollisionShape2D

@onready var warning_time:float = 0.2
@onready var flame_time: float = 0.5

var flames_out:bool = false



## WARNING: caso o jogador entre e fique na trap enquanto ela está em cooldown, é possível que a trap
## não seja ativada novamente depois que o tempo de cooldown seja restituido. Pode ser necessário re
## fatorar o código do player ou desta trap caso essa interação não seja desejada.
func _on_activate_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		trigger_trap(body)

func _on_damage_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)

func activate_trap(body:Node2D) -> void:
	sprite.frame = 1
	await get_tree().create_timer(warning_time).timeout
	activate_collision.disabled = true
	damage_collision.disabled = false
	flames_out = true
	sprite.play("default")
	await get_tree().create_timer(flame_time).timeout
	sprite.frame = 0
	flames_out = false
	activate_collision.disabled = false
	damage_collision.disabled = true
