extends CharacterBody2D

@export var ACCELERATION = 12000.0
@export var FRICTION = 0.9
@export var SPEED = 600

@export var ROW_SWITCH_SPEED = 8

@export var ROWS = 1
@export var GRID_SIZE = 64
@export var INITIAL_Y = 0

var bounds = Vector2(0, 0)
var current_row = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func handle_horizontal_movement(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity *= FRICTION

	var mouse = get_local_mouse_position()
	var angle = mouse.angle()

	var horizontal_direction = Input.get_axis("left", "right")
	var vertical_direction = 0

	var mouse_delta = mouse.normalized()

	var direction = Vector2(horizontal_direction, vertical_direction).normalized()
	var strafe_accel = ACCELERATION
	var speed_limit = SPEED

	var current_speed = direction.dot(velocity)
	var accel = strafe_accel * delta

	accel = max(0, min(accel, speed_limit - current_speed))
	velocity += direction * accel

func handle_vertical_movement():
	if Input.is_action_just_pressed("up"):
		current_row = clamp(current_row - 1, -ROWS, ROWS)
	if Input.is_action_just_pressed("down"):
		current_row = clamp(current_row + 1, -ROWS, ROWS)
	
	position.y = move_toward(position.y, INITIAL_Y + GRID_SIZE * current_row, ROW_SWITCH_SPEED)

func _physics_process(delta):
	handle_vertical_movement()
	handle_horizontal_movement(delta)		
	move_and_slide()
	if position.x < 0:
		position.x = 0
	if position.x > bounds.x:
		position.x = bounds.x
	

