extends CanvasLayer

signal completed

@onready var timer =  $Timer
@onready var display = $CountDownDisplay
@onready var label = $CountDownDisplay/Label

var start = false
var started = false

func count_down():
	start = true

func _process(delta):
	if start:
		if not started:
			timer.start()
			started = true
		display.show()
		label.text = "%.1f" % timer.time_left

func _on_timer_timeout():
	start = false
	started = false
	display.hide()
	completed.emit()
