extends TrapBase

@export var arrow_speed:float = 100
@export var detect_area_size:float = 70
@export var teste:Color
const ARROW = preload("res://scenes/objects/traps/arrow_traps/arrow.tscn")

func _ready():
	$activate_box/CollisionShape2D.shape.size.x = detect_area_size
	$activate_box/CollisionShape2D.position.x = (detect_area_size / 2)

func _on_activate_box_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		trigger_trap(body)

func activate_trap(body:Node2D) -> void:
	# queria a animação mas fica mto feio aq...
	$sprite2D.play("default")
	var new_arrow = ARROW.instantiate()
	print(rotation)
	new_arrow.setup(damage, rotation, arrow_speed)
	new_arrow.position = position + Vector2.from_angle(rotation) * 6
	
	Callable(func(): get_parent().add_child(new_arrow)).call_deferred()
