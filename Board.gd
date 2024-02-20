extends Control

var player_opp
var player_self
var discard

var selected_card = ""
var selected_discard = ""

var card_values = {
	"Ace": 0,
	"2": 1,
	"3": 2,
	"4": 3,
	"5": 4,
	"6": 5,
	"7": 6,
	"8":7,
	"9": 8,
	"10": 9,
	"Jack": 10,
	"Queen": 11,
	"King": 12
}

var changeCount = 0

var player_name
var player_opp_name
var player_no

func _ready():	
	player_opp = get_node("PlayerOpp")
	player_self = get_node("PlayerSelf")
	discard = get_node("Discard")
	
	discard._add_discard_one("8 of Hearts")
	discard._add_discard_two("6 of Clubs")
	
	player_self.connect("selected_slot", self, "_on_card_selected")
	discard.connect("selected_discard_slot", self, "_on_discard_selected")
	
	var player_self_cards = ["9 of Spades", "10 of Clubs", "Jack of Diamonds", "Queen of Hearts", "King of Spades"]
	var player_opp_cards = ["Ace of Spades", "2 of Clubs", "3 of Diamonds", "4 of Hearts", "5 of Spades"]
	
	player_self._setCards(player_self_cards)
	player_opp._setCards(player_opp_cards)


func _set_player_names(player_name, player_opp_name):
	get_node("PlayerSelfName").text = player_name
	get_node("PlayerOppName").text = player_opp_name

func _handle_game_state(gamestate):
	#player1 cards
	#player2 cards
	#discard1 top
	#discard2 top
	var player1cards = gamestate["Player1"]
	var player2cards = gamestate["Player2"]
	var discard1card = gamestate["Discard1"][0]
	var discard2card = gamestate["Discard2"][0]
	
	if (player_no == 1):
		player_self._setCards(player1cards)
		player_opp._setCards(player2cards)
	elif (player_no == 2):
		player_self._setCards(player2cards)
		player_opp._setCards(player1cards)
	
	discard._add_discard_one(discard1card)
	discard._add_discard_two(discard2card)
	
func _send_game_state(card, discard):
	var card_name = get_node("PlayerSelf").self_player_hand[int(card[4])]._card_name
	var discard_name = discard.to_lower()
	
	#{"Move": ["Queen of Hearts", "discard1"]}
	var Move = {"Move": [card_name, discard_name]}
	var moveJson = JSON.print(Move)
	print(JSON.print(Move))
	
	get_node("..")._send_data(moveJson)

func _on_discard_selected(slot):
	if (slot != "None" && selected_card != ""):
		if (_valid_move(selected_card, slot)):
			_send_game_state(selected_card, slot)
			var card = player_self._delete_card(selected_card)
			changeCount = changeCount + 1
			if (slot == "Discard1"):
				discard._add_discard_one(card)
			else:
				discard._add_discard_two(card)
				
			selected_card = ""
			

func _on_card_selected(slot):
	if (slot != "None"):
		selected_card = slot
		
func _valid_move(card, discard):
	var card_node = get_node("PlayerSelf").self_player_hand[int(card[4])]
	var discard_node = get_node("Discard/Discard1") if discard == "Discard1" else get_node("Discard/Discard2")
	
	if (card_node._rank == "Joker" or discard_node._rank == "Joker"):
		return true
	
	var card_rank = card_values[card_node._rank]
	var discard_rank = card_values[discard_node._rank]
	
	# cardValue == discardValue - 1
	if (card_rank == discard_rank - 1):
		return true
		
	# cardValue == discardValue +1
	if (card_rank == discard_rank + 1):
		return true
		
	# K -> A cardValue == 12 and discardValue == 0
	if (card_rank == 12 and discard_rank == 0):
		return true
		
	# A -> K cardValue == 0 and discardValue == 12
	if(card_rank == 0 and discard_rank == 12):
		return true
	

func _clearSelect():
	discard._clear_select()
	
func _reset_board():
	player_opp._reset_cards()
	player_self._reset_cards()
