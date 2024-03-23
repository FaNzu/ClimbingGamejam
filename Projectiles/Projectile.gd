extends Area2D
@export var type = "placeholder"
@export var speed = 600
@export var onHitFallSpeed = 0.5
@export var onHitFallDuration = 1
@export var onHitFallDeceleration = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
