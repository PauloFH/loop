extends TrapBase

@export var arrow_speed:float = 5
const ARROW = preload("res://scenes/objects/traps/arrow_traps/arrow.tscn")

func _ready() -> void:
	$sprite2D.speed_scale

func _on_activate_box_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		trigger_trap(body)

func activate_trap(body:Node2D) -> void:
	$sprite2D.play("default")
	var new_arrow = ARROW.instantiate()
	new_arrow.setup(damage, Vector2.ZERO, 1)
	
	Callable(func(): add_child(new_arrow)).call_deferred()
