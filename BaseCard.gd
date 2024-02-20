extends Sprite

var card_suite_coords = {
	"Hearts": 1,
	"Clubs": 48,
	"Diamonds": 95,
	"Spades": 142
}

var card_name_coords = {
	"2": 36,
	"3": 71,
	"4": 106,
	"5": 141,
	"6": 176,
	"7": 211,
	"8": 246,
	"9": 281,
	"10": 316,
	"Jack": 351,
	"Queen": 386,
	"King": 421,
	"Ace": 456
}

var card_and_suite
var _card_name = "Joker"
var _card_slot_name = "Joker"
var _rank = "Joker"
	
func _set_card(cardName):
	if (cardName == "Joker"):
		region_rect = Rect2(1, 142, 33,45)
		_card_name = "Joker"
		_rank = "Joker"
		return
	
	card_and_suite = _parse_card_name(cardName)
	var x = card_name_coords[card_and_suite[0]]
	var y = card_suite_coords[card_and_suite[1]]
	region_rect = Rect2(x,y,33,45)
	

func _parse_card_name(cardName):
	_card_name = cardName
	
	card_and_suite = []
	card_and_suite = cardName.split(" of ")
	
	_rank = card_and_suite[0]
	
	return card_and_suite
