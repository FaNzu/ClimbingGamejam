extends Node

var climberposition

@onready var players := {
	"1": {
		viewport = $Row/DefenderViewportContainer/SubViewport,
		camera = $Row/DefenderViewportContainer/SubViewport/Camera2D,
		player = $Row/DefenderViewportContainer/SubViewport/Castle/Defender
	},
	"2": {
		viewport = $Row/ClimberViewportContainer/SubViewport,
		camera = $Row/ClimberViewportContainer/SubViewport/Camera2D,
		player = $Row/DefenderViewportContainer/SubViewport/Castle/Climber
	}
}

func _ready() -> void:
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
	if $Music.playing == false:
		$Music.play()

func _process(delta):
	climberposition = players["2"].player.position
	$Row/ColorRect/ProgressGoblin.position.y = ((2664/750) * climberposition.y) / 10
	
	#print(players["2"].player.position)
	if players["2"].player.position.y <= 212:
		print("WON")
		$POPUP.show()

func _on_back_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
