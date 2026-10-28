extends Control

@onready var bouton_jouer: Button = $VBoxContainer/Lancer
@onready var bouton_quitter: Button = $VBoxContainer/Quitter

func _ready() -> void:
	bouton_jouer.pressed.connect(_on_jouer_pressed)
	bouton_quitter.pressed.connect(_on_quitter_pressed)

func _on_jouer_pressed() -> void:
	get_tree().change_scene_to_file("res://Scènes/scène_2d_principale.tscn")

func _on_quitter_pressed() -> void:
	get_tree().quit()
