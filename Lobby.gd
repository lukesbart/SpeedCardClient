extends Node

var name_input
var submit
var server_response
var ip_input
var main

var submitted = false

func _ready():
	main = get_node("..")
	
	name_input = get_node("NameInput")
	submit = get_node("Submit")
	server_response = get_node("ServerResponse")
	ip_input = get_node("IPInput")

func _reset():
	server_response.text = ""
	_reset_form()
	
func _reset_form():
	submitted = false
	submit.disabled = false
	ip_input.editable = true
	name_input.editable = true

func _validate_ip(address):
	var regex = RegEx.new()
	regex.compile("\\b(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\b")
	
	var result = regex.search(address)
	if result:
		return true
	else:
		return false
	

func _on_Submit_pressed():
	if (_validate_ip(ip_input.text) and name_input.text != ""):
		main._connectText(name_input.text, ip_input.text)
		submitted = true
		submit.disabled = true
		ip_input.editable = false
		name_input.editable = false
		
	else:
		server_response.text = "Enter a valid ip address"
		submitted = false
	
	
