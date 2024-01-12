extends Node2D

@onready var click_ob = preload("res://Scenes/multi_click.tscn")
@onready var click_holder = $ClickObjects
@onready var count_down = $CountDown
@onready var click_display = preload("res://Scenes/popup_panel.tscn")

func _input(InputEvent):
	if Input.is_action_pressed("click"):
		print("click")

func _ready():
	count_down.count_down()

func _on_count_down_completed():
	for i in range(0,2):
		var popup = click_display.instantiate()
		click_holder.add_child(popup)
		popup.position.x = 510.0 * i
		var ob = click_ob.instantiate()
		popup.add_child(ob)
	

func _on_click_ob_click(ob_pop: PopupPanel,ob_name: String):
	pass

func _on_pop_selected():
	pass
