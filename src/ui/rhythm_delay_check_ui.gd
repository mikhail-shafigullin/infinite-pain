extends Control

@onready var beatsContainer: Control = %beats;
@onready var beatTemplate: Control = %beatTemplate;

func _ready():
	print(Global.bpmController)
	pass;
