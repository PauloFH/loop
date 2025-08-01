extends Node2D
class_name TrapBase

@export var damage: int = 100
@export var is_active: bool = true
@export var cooldown_time: float = 1.0

var can_trigger: bool = true

func _ready():
	setup_trap()

func setup_trap():
	pass

func trigger_trap(body):
	if not can_trigger or not is_active:
		return
	
	print("Armadilha ativada por: ", body.name)
	activate_trap(body)
	start_cooldown()

func activate_trap(body):
	pass

func start_cooldown():
	can_trigger = false
	await get_tree().create_timer(cooldown_time).timeout
	can_trigger = true
