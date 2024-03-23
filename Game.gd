extends Node

@onready var players := {
	"1": {
		viewport = $Row/LeftViewportContainer/SubViewport,
		camera = $Row/LeftViewportContainer/SubViewport/Camera2D,
		player = $Row/LeftViewportContainer/SubViewport/Level/Player1
	},
	"2": {
		viewport = $Row/RightViewportContainer/SubViewport,
		camera = $Row/RightViewportContainer/SubViewport/Camera2D,
		player = $Row/LeftViewportContainer/SubViewport/Level/Player2
	}
}


func _ready() -> void:
	#print (typeof(world_2d) == typeof(world))
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	
	#
	#for node in players.values():
		#var remote_transform := RemoteTransform2D.new()
		#remote_transform.remote_path = node.camera.get_path()
		#node.player.add_child(remote_transform)
