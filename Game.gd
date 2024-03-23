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

func _process(delta):
	climberposition = players["2"].player.position
	$Row/ColorRect/ProgressRect.position.y = 2664 / climberposition.y

func _ready() -> void:
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
