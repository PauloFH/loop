extends Control

@onready var start_button = $VBoxContainer/ButtonContainer/StartButton
@onready var settings_button = $VBoxContainer/ButtonContainer/SettingsButton  
@onready var quit_button = $VBoxContainer/ButtonContainer/QuitButton

func _ready():
	# Conecta os botões
	start_button.pressed.connect(_on_start_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Foca no primeiro botão
	start_button.grab_focus()

func _on_start_pressed():
	print("Iniciando jogo...")
	SceneManager.go_to_level_1()

func _on_settings_pressed():
	print("Abrindo configurações...")
	SceneManager.go_to_settings()

func _on_quit_pressed():
	print("Saindo do jogo...")
	get_tree().quit()
