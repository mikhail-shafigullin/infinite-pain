extends Node

var jsController: JSController;
var bpmController: BpmController;
var screenController: ScreenController;

func is_everything_loaded():
	return jsController && bpmController && screenController;
