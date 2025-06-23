extends Control

@onready var beatsContainer: Control = %beats;
@onready var beatTemplate: Control = %beatTemplate;

@onready var bpmTimer: Timer = %bpmTimer;
@onready var delayTimer: Timer = %delayTimer;

@onready var delayText: RichTextLabel = %delayText;

@onready var audioStreamPlayer: AudioStreamPlayer = %AudioStreamPlayer;

var beat_delay_array = [];
var last_10_beats_expected = [];
var last_10_beats_actual = [];
var approximate_delay;

var bpmTimerWaitTimeMs = 1000;

func _ready():
	print(Global.bpmController)
	if(!Global.bpmController):
		Global.bpmController = BpmController.new();
	
	beatTemplate.visible = false;
	bpmTimer.start();
	delayTimer.start();
	
	bpmTimerWaitTimeMs = bpmTimer.wait_time * 1000
	pass;


func _input(event):
	if(event.is_action_pressed("beat")):
		detect_beat();
	if(event.is_action_released("beat")):
		clear_beat();


func detect_beat():
	last_10_beats_actual.push_back(Time.get_ticks_msec());
	if(last_10_beats_actual.size() > 10):
		last_10_beats_actual.pop_front();
	beatTemplate.visible = true;


func clear_beat():
	beatTemplate.visible = false;

func evaluate_delay():
	beat_delay_array.clear();
	var approximate_delay = 0;
	if(last_10_beats_expected.size() >= 10 and last_10_beats_actual.size() >= 10):
		for i in 10:
			beat_delay_array.push_back(last_10_beats_expected[i] - last_10_beats_actual[i]);
		approximate_delay = beat_delay_array.reduce(func(accum, number): return accum + number, 0)/10;
	
	approximate_delay = approximate_delay % int(bpmTimerWaitTimeMs);
	if approximate_delay > int(bpmTimerWaitTimeMs)/2:
		approximate_delay = bpmTimerWaitTimeMs - approximate_delay
	return approximate_delay;
	

func _on_bpm_timer_timeout():
	last_10_beats_expected.push_back(Time.get_ticks_msec());
	if(last_10_beats_expected.size() > 10):
		last_10_beats_expected.pop_front();
	audioStreamPlayer.play();


func _on_delay_timer_timeout():
	var delay = evaluate_delay();
	delayText.text = "[center]Current delay: " + str(delay);
	pass # Replace with function body.
