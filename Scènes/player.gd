
extends CharacterBody2D

const SPEED = 250.0

@onready var anim = $AnimatedSprite2D
@onready var bulle: PanelContainer = $"../CanvasLayer/Bulle"
@onready var texte: Label = $"../CanvasLayer/Bulle/Label"
@onready var pointe: Polygon2D = $"../CanvasLayer/Pointe"

var hauteur_bulle := 60.0

func _ready() -> void:
	bulle.hide()
	pointe.hide()

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
        "move_down"
	)

	velocity = direction * SPEED
	move_and_slide()

	if direction == Vector2.ZERO:
		anim.play("idle")
	else:
		anim.play("run")

	if direction.x != 0:
		anim.flip_h = direction.x < 0

func _process(_delta: float) -> void:
	placer_bulle()

func placer_bulle() -> void:
	# Position du joueur en coordonnées d'écran
	var position_ecran = get_viewport().get_canvas_transform() * global_position

	# Centre la bulle au-dessus du joueur
	bulle.position = Vector2(
		position_ecran.x + 40,
		position_ecran.y - 70
	)

	# Place la pointe au centre du bord inférieur de la bulle
	pointe.position = bulle.position + Vector2(
		30,
		bulle.size.y +8
	)

func parler(message: String) -> void:
	texte.text = message
	bulle.show()
	pointe.show()

	# Laisse Godot recalculer la taille du texte et de la bulle
	await get_tree().process_frame
	placer_bulle()

func tagueule() -> void:
	bulle.hide()
	pointe.hide()
