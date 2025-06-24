class_name ScreenController
extends Node

const baseLevel = preload("res://levels/BaseLevel.tscn")
const rhythmDelayCheckUI = preload("res://levels/ui/rhythmDelayCheckUI.tscn")

@onready var loadedLevelContainer = %LoadedLevel;
@onready var canvasLayer = %CanvasLayer;

var currentLevel: String = "";
var currentUI: String = "";

var loadedLevel;
var loadedUIs = [];

func _ready():
	Global.screenController = self;

func _process(delta):
	if(Global.is_everything_loaded() && loadedLevelContainer):
		change_level();

func change_level():
	var setLevel = baseLevel.to_string(); 
	var setUI = rhythmDelayCheckUI.to_string(); 
	if(setLevel != currentLevel || setUI != currentUI):
		print('start base level');
		currentLevel = setLevel;
		currentUI = setUI;
		loadedLevel = baseLevel.instantiate();
		for child in loadedLevelContainer.get_children():
			loadedLevelContainer.remove_child(child);
		loadedLevelContainer.add_child(loadedLevel);
		
		var ui = rhythmDelayCheckUI.instantiate();
		loadedUIs.push_back(ui);
		canvasLayer.add_child(ui);
	
	
