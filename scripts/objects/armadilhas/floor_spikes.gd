
extends TrapBase

@export var spike_duration: float = 2.0
@export var warning_time: float = 0.5

@onready var area_2d = $Area2D
@onready var sprite = $Sprite2D
@onready var collision = $Area2D/CollisionShape2D

func setup_trap():
	area_2d.body_entered.connect(_on_body_entered)
	sprite.modulate = Color.WHITE

func _on_body_entered(body):
	if body.is_in_group("player"):
		trigger_trap(body)


# pra visualizar eu pintei
func activate_trap(body):
	sprite.modulate = Color.YELLOW
	await get_tree().create_timer(warning_time).timeout
	sprite.modulate = Color.RED
	var bodies = area_2d.get_overlapping_bodies()
	for overlapping_body in bodies:
		if overlapping_body.is_in_group("player"):
			overlapping_body.take_damage(damage)	
	await get_tree().create_timer(spike_duration).timeout
	sprite.modulate = Color.WHITE
