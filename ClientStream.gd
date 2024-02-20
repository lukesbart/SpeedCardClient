extends Node

var _serverStream = StreamPeerTCP.new()
var _status = 0
var _initSent = false

signal serverData

func _ready():
	_status = _serverStream.get_status()
	_initSent = false

func _connect(ip):
	_serverStream.connect_to_host(ip, 88)

func _process(delta):
	if(_serverStream.get_status() == 2):
		if (_initSent == false):
			_send(get_node("..").player_name)
			_initSent = true
		else:
			_readStream()
			
	# Handle disconnect or server error
	elif((_serverStream.get_status() == 0 or _serverStream.get_status() == 3) and _initSent):
		get_node("../")._restart_game()
		
func _send(data):
	var msg = data.to_ascii();
	_serverStream.put_data(msg)
	
func _readStream():
	var bytes = _serverStream.get_available_bytes()
	if bytes > 0:
		var res = _serverStream.get_partial_data(bytes)
		emit_signal("serverData", res[1].get_string_from_ascii())
	

func _close():
	_serverStream.disconnect_from_host()
	_initSent = false
