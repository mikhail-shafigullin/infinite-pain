extends Node

static var jsController: JSController;
static var bpmController: BpmController;
static var screenController: ScreenController;

static func is_everything_loaded():
	return jsController && bpmController && screenController;
