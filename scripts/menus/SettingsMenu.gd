extends Control

@onready var master_slider = $VBoxContainer/SettingsContainer/AudioSection/MasterVolumeContainer/MasterSlider
@onready var sfx_slider = $VBoxContainer/SettingsContainer/AudioSection/SFXVolumeContainer/SFXSlider
@onready var music_slider = $VBoxContainer/SettingsContainer/AudioSection/MusicVolumeContainer/MusicSlider
@onready var fullscreen_check = $VBoxContainer/SettingsContainer/VideoSection/FullscreenCheck
@onready var vsync_check = $VBoxContainer/SettingsContainer/VideoSection/VsyncCheck

@onready var back_button = $VBoxContainer/ButtonContainer/BackButton
@onready var apply_button = $VBoxContainer/ButtonContainer/ApplyButton

func _ready():
	# Conecta botões
	back_button.pressed.connect(_on_back_pressed)
	apply_button.pressed.connect(_on_apply_pressed)
	
	# Conecta sliders para preview em tempo real
	master_slider.value_changed.connect(_on_master_volume_changed)
	
	# Carrega valores atuais
	load_current_settings()
	
	back_button.grab_focus()

func load_current_settings():
	master_slider.value = SettingsManager.master_volume
	sfx_slider.value = SettingsManager.sfx_volume
	music_slider.value = SettingsManager.music_volume
	fullscreen_check.button_pressed = SettingsManager.fullscreen
	vsync_check.button_pressed = SettingsManager.vsync

func _on_master_volume_changed(value: float):
	# Preview em tempo real
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_apply_pressed():
	# Salva as configurações
	SettingsManager.master_volume = master_slider.value
	SettingsManager.sfx_volume = sfx_slider.value
	SettingsManager.music_volume = music_slider.value
	SettingsManager.fullscreen = fullscreen_check.button_pressed
	SettingsManager.vsync = vsync_check.button_pressed
	
	SettingsManager.apply_settings()
	SettingsManager.save_settings()
	
	print("Configurações aplicadas!")

func _on_back_pressed():
	SceneManager.go_to_main_menu()
