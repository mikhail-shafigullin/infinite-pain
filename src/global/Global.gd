extends Node

var jsController: JSController;
var screenController: ScreenController;
var player: PlayerController;

func is_everything_loaded():
	return jsController && screenController;
