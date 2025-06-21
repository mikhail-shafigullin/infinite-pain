extends Node

var gameConnector; # html/game-connector.js

func _ready():
	gameConnector = JavaScriptBridge.get_interface("gameConnector")
	gameConnector.loadStrudel();

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("play_button"):
		gameConnector.play();
	
	if event.is_action_pressed("stop_button"):
		gameConnector.stop();
