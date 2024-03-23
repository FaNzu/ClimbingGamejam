extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var stopped
var fallDuration
var fallSpeed
var fallDeceleration

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	stopped = true
	fallDuration = 0
	fallSpeed = 0
	fallDeceleration = 0
	$AnimatedSprite2D.animation = "up"
	#uncomment to hide character on start
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("simulate_fall"):
		fall(1, 0.25, 0.5)
	
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if fallDuration > 0:
		velocity.y = fallSpeed * speed
		fallDuration -= delta
	elif fallSpeed > 0:
		fallSpeed -= fallDeceleration * delta
		if fallSpeed < 0:
			fallSpeed = 0
		velocity.y = fallSpeed * speed
	else:
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
			#if $AnimatedSprite2D.animation != "up":
			$AnimatedSprite2D.animation = "up"
			if stopped:
				stopped = false
				$AnimatedSprite2D.frame = ($AnimatedSprite2D.frame + 1) % 2
				$AnimatedSprite2D.play()
		else:
			stopped = true
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

func fall(initialSpeed, duration, deceleration):
	fallSpeed = initialSpeed
	fallDuration = duration
	fallDeceleration = deceleration
	$AnimatedSprite2D.animation = "fall"
