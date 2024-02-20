extends Control

var ip_address
var ip_address_input
var ip_submit

func _ready():
	ip_address_input = get_node("ConnectPanel/ServerIp")
	ip_submit = get_node("ConnectPanel/submitIp")


func _on_Button_pressed():
	ip_address = ip_address_input.text
	ip_address_input.editable = false
	ip_submit.disabled = true
	print(ip_address)
