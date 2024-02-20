extends Control

var discard_one_pile
var discard_two_pile

var slot1
var slot2

var discard_area

signal selected_discard_slot

# Called when the node enters the scene tree for the first time.
func _ready():
	
	slot1 = get_node("Discard1/CardArea")
	slot1.connect("selected", self, "_on_slot_selected")
	
	slot2 = get_node("Discard2/CardArea")
	slot2.connect("selected", self, "_on_slot_selected")
	
	discard_one_pile = get_node("Discard1")
	discard_one_pile._card_slot_name = "Discard1"
	
	discard_two_pile = get_node("Discard2")
	discard_two_pile._card_slot_name = "Discard2"
	
func _add_discard_one(card):
	discard_one_pile._set_card(card)
	
func _add_discard_two(card):
	discard_two_pile._set_card(card)
	
func _on_slot_selected(is_selected, slot_name="None"):
	if(is_selected):
		emit_signal("selected_discard_slot", slot_name)
	
func _clear_select():
	slot1._deselect()
	slot2._deselect()
