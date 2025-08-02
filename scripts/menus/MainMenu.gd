extends Control

@onready var start_button = $MarginContainer/VBoxContainer/ButtonContainer/StartButton
@onready var quit_button = $MarginContainer/VBoxContainer/ButtonContainer/QuitButton

func _ready():
	if start_button == null:
		print("ERRO: start_button é null!")
		return
		
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	start_button.grab_focus()

func _on_start_pressed():
	print("Iniciando jogo...")
	SceneManager.go_to_level_1()

func _on_quit_pressed():
	print("Saindo do jogo...")
	get_tree().quit()
