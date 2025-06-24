class_name PlayerController
extends CharacterBody3D

# Movement settings
@export var speed: float = 10.0
@export var jump_velocity: float = 10;
@export var jump_gravity_reduction = 0.2;
@export var mouse_sensitivity: float = 0.005

# Camera settings
@onready var camera: Camera3D = %Camera3D
@export var max_look_up: float = 1.2
@export var max_look_down: float = -1.2

var mouseInput = Vector2(0, 0);

@export var coyote_time: float = 0.5;
var time_in_air = 0
var is_jumped = false;

# Physics
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	velocity = Vector3.ZERO;
	Global.player = self;

func _process(delta):
	handle_mouse_look()

func _physics_process(delta):
	handle_movement(delta)

func handle_movement(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta;
		time_in_air+= delta;
		if !Input.is_action_pressed("jump"):
			velocity.y -= jump_gravity_reduction;
	
	if is_on_floor():
		is_jumped = false
		time_in_air = 0;

	if (
		Input.is_action_just_pressed("jump") 
		and (
			CheatController.isInfiniteJumps or
			(!is_jumped 
			and ( is_on_floor() or time_in_air < coyote_time ) )
		)
	):
		is_jumped = true
		velocity.y = jump_velocity;

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func handle_mouse_look():
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	var mouse_delta = mouseInput * mouse_sensitivity
	
	# Horizontal rotation
	rotate_y(-mouse_delta.x)
	
	# Vertical rotation
	if camera:
		camera.rotate_x(-mouse_delta.y)
		camera.rotation.x = clamp(camera.rotation.x, max_look_down, max_look_up)
		
	mouseInput = Vector2(0, 0)

func _input(event):
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouseInput.x += event.relative.x
		mouseInput.y += event.relative.y
		
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
