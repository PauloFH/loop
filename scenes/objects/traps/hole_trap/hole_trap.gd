extends TrapBase

# move o corpo imediatamente após pisar na trap
func activate_trap(body: Node2D) -> void:
	if body.is_ghost:
		return
	body.global_position = global_position + Vector2(0, -5)
	body.take_damage(100)
	can_trigger = false
	$fall_collision/CollisionShape2D.disabled = true
	await body.get_node("AnimationPlayer").current_animation_changed
	$pull_body_collision/CollisionShape2D.disabled = false

# Desabilita o segundo nó filho do corpo que for detectada a colisão aqui...
# da forma mais troncha que eu consigo imaginar
func _on_fall_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("activate_trap", body)
