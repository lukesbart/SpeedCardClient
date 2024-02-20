extends Control

var opp_player_hand

func _ready():
	opp_player_hand = get_tree().get_nodes_in_group("PlayerOppCards")
	var cards = ["7 of Clubs", "8 of Clubs", "9 of Clubs", "10 of Clubs", "Jack of Clubs"]
	_setCards(cards)

func _setCards(cards):
	var hand_size
	
	if (cards.size() > 5):
		hand_size = 5
	else:
		hand_size = cards.size()
	
	for i in range(0, hand_size):
		opp_player_hand[i]._set_card(cards[i])
		if(opp_player_hand[i]._card_name == "Joker"):
			opp_player_hand[i].visible = false

func _reset_cards():
	for card in opp_player_hand:
		card.visible = true
