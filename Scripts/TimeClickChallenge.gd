extends Node2D

signal hit

@onready var path_follow = $Path/PathFollow2D
@export var speed = 100

var coll_in = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow.progress = path_follow.progress + speed * delta
	

func _on_visual_timer_body_entered(body):
	coll_in = true
func _on_visual_timer_body_exited(body):
	coll_in = false

func _input(event):
	if Input.is_action_just_pressed("click"):
		print("Click:", name)
		if coll_in:
			hit.emit()

