extends Control

signal selected_slot

var self_player_hand
var self_player_slots
var slots

func _ready():
	self_player_hand = get_tree().get_nodes_in_group("PlayerSelfCards")
	
	var slot1 = get_node("Card1/CardArea")
	var slot2 = get_node("Card2/CardArea")
	var slot3 = get_node("Card3/CardArea")
	var slot4 = get_node("Card4/CardArea")
	var slot5 = get_node("Card5/CardArea")
	
	slots = [slot1, slot2, slot3, slot4, slot5]
	
	for slot in slots:
		slot.connect("selected", self, "_selectCardSlot")

func _setCards(cards):
	var hand_size
	if (cards.size() > 5):
		hand_size = 5
	else:
		hand_size = cards.size()
	
	for i in range(0, hand_size):
		self_player_hand[i]._card_slot_name = "Card"+str(i)
		if(cards[i] == "Joker"):
			self_player_hand[i].visible = false
			slots[i].get_node("CollisionShape2D").disabled = true
		self_player_hand[i]._set_card(cards[i])
		

func _reset_cards():
	for card in self_player_hand:
		card.visible = true
		card.get_node("CardArea").get_node("CollisionShape2D").disabled = false

func _delete_card(slot):
	var card = self_player_hand[int(slot[4])]
	
	var cardName = card._card_name
	
	card._set_card("Joker")
	
	
	
	return cardName

func _selectCardSlot(selected, name = "none"):
	if(selected):
		emit_signal("selected_slot", name)
		

func _disabledCardSlot(slot):
	pass
	
