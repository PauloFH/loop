extends Node2D

@export var initial_scene:PackedScene

func _ready() -> void:
	add_child(initial_scene.instantiate())
	SceneManager.current_scene = get_child(1)
