extends Area2D

signal selected

var border
var card
var cardNode
var clicked
var selected

func _ready():
	border = get_node("CollisionShape2D/ReferenceRect")
	card = get_tree().current_scene

func _on_CardArea_input_event(viewport, event, shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		if !selected:
			selected = true
			clicked = true
			emit_signal("selected", true, get_node("..")._card_slot_name)
			_select()
		
func _input(event):
	if event.is_pressed():
		clicked = false
		emit_signal("selected", false)
		_deselect()
		selected = false

func _select():
	border.set_editor_only(false)

func _deselect():
	border.set_editor_only(true)
	

func _on_CardArea_mouse_entered():
	if (!clicked):
		_select()

func _on_CardArea_mouse_exited():
	if(!clicked):
		_deselect()
