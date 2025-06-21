class_name JSController
extends Node

var gameConnector; # html/game-connector.js

var is_initialized = false;

signal js_connected;

func _ready():
	Global.jsController = self;
	gameConnector = JavaScriptBridge.get_interface("gameConnector");
	if(gameConnector):
		gameConnector.loadStrudel();
		is_initialized = true;
		js_connected.emit();
	else:
		print("jsConnector is not initialized. It is normal for debug inside of godot. If game is started through the web, it must be an error between godot and js. Check console log.");
		is_initialized = false;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("play_button") && is_initialized:
		gameConnector.play();
	
	if event.is_action_pressed("stop_button") && is_initialized:
		gameConnector.stop();
