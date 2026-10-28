
extends Area2D

var player_nearby := false
var a_interagi := false

@onready var bruit_caca: AudioStreamPlayer2D = $BruitCaca

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	print("Zone prête")

func _process(_delta: float) -> void:
	if not player_nearby:
		return

	var player = get_tree().get_first_node_in_group("player")

	if player == null:
		return

	if not a_interagi:
		player.parler("Et si je prenais un bain ?\n- réfléchit Glandalf ( E )")

		if Input.is_action_just_pressed("interact"):
			a_interagi = true
			player.parler("Je vais bien chier dans mon bain\n- s'exclama Glandalf")
			bruit_caca.play()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = true
		a_interagi = false

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
		a_interagi = false

		var player = get_tree().get_first_node_in_group("player")
		if player != null:
			player.tagueule()
