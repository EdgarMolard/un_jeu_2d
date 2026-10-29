class_name Quetes
extends PanelContainer

const BATON_OBJECTIF := 3

@onready var bain: Label = $Liste/Bain
@onready var baton: Label = $Liste/Baton

var bain_termine := false
var baton_progression := 0

func _ready() -> void:
	add_to_group("gestionnaire_quetes")
	mettre_a_jour_affichage()

func valider_bain() -> void:
	if bain_termine:
		return

	bain_termine = true
	mettre_a_jour_affichage()

func progresser_baton() -> void:
	if not bain_termine or baton_progression >= BATON_OBJECTIF:
		return

	baton_progression += 1
	mettre_a_jour_affichage()

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
