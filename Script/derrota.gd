extends Node2D

func _on_volte_pressed() -> void:
	get_tree().change_scene_to_file("res://Cena/Batalha.tscn")

func _on_feche_o_jogo_pressed() -> void:
	get_tree().quit()
