extends Node2D

@onready var next_level = preload("res://Scenes/elipse_click.tscn")

@onready var player = $Central/Player
@onready var goal = $Goal
@onready var central = $Central
@onready var count_down = $CountDown

@export var radius = 100
@export var player_speed = 500

var collision = false

@export var player_start = Vector2(0, 1)
@export var goal_start = Vector2(1, 0)

var start = false
var reverse = false

var wins: int = 0
var req: int = 10

func _ready():
	# Set the player on the radius of center dependant on 
	
	player_start.normalized()
	goal_start.normalized()
	player.position = Vector2(player_start.x * radius, player_start.y * radius)
	goal.position = Vector2(central.position.x + goal_start.x * radius, central.position.y + goal_start.y * radius)
	count_down.count_down()

func _process(delta):
	if not start:
		return
	# Creates a circular path
	var angular_speed: float
	angular_speed = player_speed / radius
	if reverse:
		central.rotate(-angular_speed * delta)
	else:
		central.rotate(angular_speed * delta)

func _on_player_body_entered(body):
	if body.is_in_group("goal"):
		collision = true

func _on_player_body_exited(body):
	if body.is_in_group("goal"):
		collision = false

func _input(event):
	if Input.is_action_just_pressed("click"):
		if collision:
			wins += 1
			reverse = not reverse
			if wins >= req:
				var next = next_level.instantiate()
				get_tree().root.add_child(next)
				get_tree().current_scene = next
				queue_free()
		else:
			print("Shit")

func _on_count_down_completed():
	start = true
