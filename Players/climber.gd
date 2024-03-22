extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#uncomment to hide character on start
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("climber_move_right"):
		velocity.x += 1
	if Input.is_action_pressed("climber_move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("climber_move_down"):
		velocity.y += 1
	if Input.is_action_pressed("climber_move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.pause()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false