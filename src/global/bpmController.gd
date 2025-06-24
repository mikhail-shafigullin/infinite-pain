extends Node

var bpm = 120:
	set(val):
		bpm = val;
		bpm_changed.emit(bpm);

var delay = 0:
	set(val):
		delay = val;
		delay_changed.emit(delay)

signal bpm_changed(new_bpm);
signal delay_changed(new_delay);
