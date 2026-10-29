class_name Quetes
extends PanelContainer

const BATON_OBJECTIF := 3

@onready var bain: Label = $Liste/Bain
@onready var baton: Label = $Liste/Baton
@onready var transition: ColorRect = $"../Transition"
@onready var AudioPlayerQuete: AudioStreamPlayer2D = $AudioQuete

var bain_termine := false
var baton_progression := 0
var quete_terminee := false

func _ready() -> void:
	add_to_group("gestionnaire_quetes")
	mettre_a_jour_affichage()

func valider_bain() -> void:
	if bain_termine:
		return

	bain_termine = true
	mettre_a_jour_affichage()

func progresser_baton() -> void:
	if not bain_termine or quete_terminee or baton_progression >= BATON_OBJECTIF:
		return

	baton_progression += 1
	mettre_a_jour_affichage()
	if baton_progression == BATON_OBJECTIF:
		quete_terminee = true
		lancer_fin_de_quete()

func lancer_fin_de_quete() -> void:
	var player := get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player == null:
		return

	AudioPlayerQuete.stream = preload("res://Assets/SoundFX/accident.mp3")
	AudioPlayerQuete.play()
	
	player.set_physics_process(false)
	var fondu := create_tween()
	fondu.tween_property(transition, "color:a", 1.0, 0.8)
	await fondu.finished
	await get_tree().create_timer(0.5).timeout


	var retour := create_tween()
	retour.tween_property(transition, "color:a", 0.0, 1.0)
	await retour.finished

	player.parler("OH MON DIEU !!! MON PREPUCE... IL A DIPSARU \n - hurla Glandalf")
	await get_tree().create_timer(6.0).timeout
	player.tagueule()
	player.set_physics_process(true)

func mettre_a_jour_affichage() -> void:
	if bain_termine:
		bain.text = "[x] Prendre un bain"
	else:
		bain.text = "[ ] Prendre un bain"

	if not bain_termine:
		baton.text = "[-] Se détruire le bâton magique (bain requis)"
	elif baton_progression >= BATON_OBJECTIF:
		baton.text = "[x] Se détruire le bâton magique"
	else:
		baton.text = "[ ] Se détruire le bâton magique (%d/%d)" % [
			baton_progression,
			BATON_OBJECTIF
		]
