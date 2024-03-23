extends CharacterBody2D
@export var type = "placeholder"
@export var speed = 600
@export var onHitFallSpeed = 0.5
@export var onHitFallDuration = 1
@export var onHitFallDeceleration = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		"barrel":
			$AnimatedSprite2D.animation = "barrel"
			$AnimatedSprite2D.speed_scale = 2
			$AnimatedSprite2D.play()
			speed = 400
			$CollisionShape2D.shape = $BarrelCollider.shape
			onHitFallSpeed = 0.4
			onHitFallDuration = 0.5
			onHitFallDeceleration = 0.8
		"crate":
			$AnimatedSprite2D.animation = "crate"
			$AnimatedSprite2D.flip_h = randi_range(0,1)==1
			$AnimatedSprite2D.flip_v = randi_range(0,1)==1
			$AnimatedSprite2D.rotation = randi_range(0,3) * PI / 2
			speed = 600
			$CollisionShape2D.shape = $CrateCollider.shape
			onHitFallSpeed = 0.5
			onHitFallDuration = 0.75
			onHitFallDeceleration = 0.75
		"cannonball":
			$AnimatedSprite2D.animation = "cannonball"
			speed = 800
			$CollisionShape2D.shape = $CannonballCollider.shape
			onHitFallSpeed = 0.6
			onHitFallDuration = 1
			onHitFallDeceleration = 0.6


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
	if position.y > 2700:
		queue_free()

