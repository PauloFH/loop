extends Node

var master_volume: float = 1.0
var sfx_volume: float = 1.0
var music_volume: float = 1.0
var fullscreen: bool = false
var vsync: bool = true

const SETTINGS_FILE = "user://settings.cfg"
var config = ConfigFile.new()

func _ready():
	load_settings()
	apply_settings()

func save_settings():
	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("video", "fullscreen", fullscreen)
	config.set_value("video", "vsync", vsync)
	
	config.save(SETTINGS_FILE)
	print("Configurações salvas!")

func load_settings():
	if config.load(SETTINGS_FILE) != OK:
		print("Arquivo de configurações não encontrado, usando padrões")
		return
	
	master_volume = config.get_value("audio", "master_volume", 1.0)
	sfx_volume = config.get_value("audio", "sfx_volume", 1.0)
	music_volume = config.get_value("audio", "music_volume", 1.0)
	fullscreen = config.get_value("video", "fullscreen", false)
	vsync = config.get_value("video", "vsync", true)

func apply_settings():
	AudioServer.set_bus_volume_db(0, linear_to_db(master_volume))
	
	# Aplica vídeo
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
