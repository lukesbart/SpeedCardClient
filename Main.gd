extends Node

var lobby
var client
var board
var win_panel

var playerNo
var player_name
var player_opp_name
var server_ip
var player_names = {"player1": "", "player2" : ""}

func _ready():
	lobby = get_node("Lobby")
	client = get_node("ClientStream")
	board = get_node("Board")
	win_panel = get_node("Win")
	
	
func _connectText(name, ip = "127.0.0.1", port = "88"):
	server_ip = ip
	player_name = name
	client._connect(ip)

func _send_data(data):
	client._send(data)

func _on_ClientStream_serverData(data):
	process_data(data)

func _restart_game():
	client._close()
	win_panel.visible = false
	lobby.visible = true
	lobby._reset()
	board.visible = false
	board._reset_board()

func process_data(data):
	var jsonData = data
	var jsonParse = JSON.parse(data)
	
	var message = jsonParse.result
	
	if (typeof(message) != TYPE_NIL):
		if ("playerNumber" in message):
			playerNo = message["playerNumber"]
		if (message["Status"] == "Setup"):
			print(JSON.print(message["message"]))
			var server_message = message["message"]
			lobby.get_node("ServerResponse").text = server_message
		elif (message["Status"] == "Full"):
			var server_message = message["message"]
			lobby.get_node("ServerResponse").text = server_message
			client._close()
			lobby._reset_form()
		elif(message["Status"] == "Starting"):
			if (playerNo == 1):
				player_opp_name = message["Player2Name"]
			elif (playerNo == 2):
				player_opp_name = message["Player1Name"]
				
			player_names["player1"] = message["Player1Name"]
			player_names["player2"] = message["Player2Name"]
			
			board.player_no = playerNo
			board._set_player_names(player_name, player_opp_name)
			board.visible = true
			lobby.visible = false
			
		elif (message["Status"] == "Playing"):
			board._handle_game_state(message)
			
		elif (message["Status"] == "Won"):
			board._clearSelect()
			var winner = message["Winner"]
			var winner_name = player_names[winner]

			get_node("Win/WinnerPanel/WinnerMessage").text = winner_name + " won the game!"
			win_panel.visible = true
		
