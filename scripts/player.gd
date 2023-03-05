extends Area2D

signal hit

@export var speed: int = 400
var screen_size

var input_movement: Vector2
var current_velocity: Vector2

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	Handle_Input()
	Movement(delta)
	DoAnimation()

func Start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func Handle_Input() -> void:
	input_movement = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_movement.x = 1
	if Input.is_action_pressed("move_left"):
		input_movement.x = -1
	if Input.is_action_pressed("move_down"):
		input_movement.y = 1
	if Input.is_action_pressed("move_up"):
		input_movement.y = -1

func Movement(delta) -> void:
	current_velocity = Vector2.ZERO
	if HasMovement_Input():
		current_velocity = input_movement.normalized() * speed
	
	position += current_velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func DoAnimation() -> void:
	$AnimatedSprite2D.flip_h = current_velocity.x < 0
	if current_velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
	elif current_velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = current_velocity.y > 0
	
	if HasMovement_Input():
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
func HasMovement_Input() -> bool:
	return not input_movement == Vector2.ZERO

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
