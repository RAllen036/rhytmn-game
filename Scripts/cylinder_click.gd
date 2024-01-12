extends Node2D

@onready var player_path = $Path/PlayerPath
@onready var player_anchor = $Path/PlayerPath/PlayerAnchor
@onready var player = $Path/PlayerPath/PlayerAnchor/Player

@onready var path = $Path

@onready var goal = $Path/Goal

var player_speed: float = 200
var radius: float = 100

var start: bool = false
var reverse: bool = false
var spinning: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var path_length = path.curve.get_baked_length()
	
	goal.position.x = path_length + radius
	
	player.position.x = -radius
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var angular_speed = player_speed / radius
	
	if is_zero_approx(player_path.progress_ratio):
		spinning = true
		player_anchor.rotate(angular_speed * delta)
		if reverse:
			if player_anchor.rotation_degrees - 360 >= 0:
				player_anchor.rotation_degrees = 0
				reverse = false
		else:
			if player_anchor.rotation_degrees >= 90:
				player_anchor.rotation_degrees = 90
				spinning = false
	
	if is_equal_approx(player_path.progress_ratio, 1):
		spinning = true
		player_anchor.rotate(angular_speed * delta)
		
		if player_anchor.rotation_degrees >= 270:
			player_anchor.rotation_degrees = 270
			spinning = false
			reverse = true
	
	if not spinning:
		if reverse:
			player_path.progress = player_path.progress - player_speed * delta
		else:
			player_path.progress = player_path.progress + player_speed * delta
	
