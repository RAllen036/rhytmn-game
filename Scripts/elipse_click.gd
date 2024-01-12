extends Node2D

@onready var count_down = $CountDown

@onready var player = $Path2D/PlayerPath/Anchor/Player
@onready var player_anchor = $Path2D/PlayerPath/Anchor
@onready var player_path = $Path2D/PlayerPath
@onready var path = $Path2D
@onready var goal_path = $Path2D/GoalPath
@onready var goal = $Path2D/GoalPath/GoalBody

@onready var next_level = preload("res://Scenes/cylinder_click.tscn")

var player_speed: float = 300
var radius: float = 200

var reverse: bool = false
var start: bool = false
var entered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	player.position = Vector2(-radius, 0)
	goal.position = Vector2(radius, 0)
	
	count_down.count_down()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start:
		
		if is_equal_approx(player_path.progress_ratio, 1) or is_zero_approx(player_path.progress_ratio):
			reverse = not reverse
		
		var progress: float
		
		if reverse:
			progress = player_path.progress - player_speed * delta
		else:
			progress = player_path.progress + player_speed * delta
		
		player_path.progress = progress
		
		if reverse:
			player_anchor.rotation_degrees = player_anchor.rotation - (180 * player_path.progress_ratio)
		else:
			player_anchor.rotation_degrees = player_anchor.rotation + (180 * player_path.progress_ratio)
		

func _input(event):
	if Input.is_action_just_pressed("click"):
		if entered:
			
			var next = next_level.instantiate()
			get_tree().root.add_child(next)
			get_tree().current_scene = next
			queue_free()
			
		else:
			print("Shit")

func _on_count_down_completed():
	start = true

func _on_player_body_entered(body):
	if body.is_in_group("goal"):
		entered = true

func _on_player_body_exited(body):
	if body.is_in_group("goal"):
		entered = false
