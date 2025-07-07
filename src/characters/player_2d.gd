extends CharacterBody2D

@export var speed: float = 200.0
@export var gravity: float = 500.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var current_item: Node2D = null

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = 0
		animated_sprite.play("idle")

	# Handle item interaction
	if Input.is_action_just_pressed("jump") and current_item:
		use_item()

	move_and_slide()

func use_item() -> void:
	if current_item and current_item.has_method("use"):
		current_item.use(self)

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		current_item = body

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body == current_item:
		current_item = null
