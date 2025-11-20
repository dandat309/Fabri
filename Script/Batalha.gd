extends Node2D

var steven = Steven.new()
var enemy = Enemy.new()
var StAckcon = 0
var cura = false
var ult = false
func _ready():
	$text.text = ""

func trocaTXT():
	$text.text = ""

func _on_attack_pressed() -> void:
	trocaTXT()
	$HBoxContainer/attack.disabled = true
	steven.atacar(enemy)
	StAckcon += 1
	$text.text = steven.nome + " atacou!\n" + enemy.nome + " agora está com " + str(enemy.vida) + " de vida."
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return
	$HBoxContainer/attack.disabled = false
	enemy_turn()

func _on_defend_pressed() -> void:
	trocaTXT()
	$HBoxContainer/attack.disabled = true
	steven.defender()
	$text.text = steven.nome + " está defendendo."
	$HBoxContainer/attack.disabled = false

func _on_heal_pressed() -> void:
	trocaTXT()
	if cura:
		return
	cura = true
	steven.curar()
	$text.text = steven.nome + " se curou\nVida atual: " + str(steven.vida)
	await get_tree().create_timer(3).timeout
	cura = false

func _on_ultimate_pressed() -> void:
	trocaTXT()
	if ult:
		return
	ult = true
	steven.ultimate(enemy)
	$text.text = steven.nome + " usou a ULT\n" + enemy.nome + " ficou com " + str(enemy.vida) + " de vida"
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return
	await get_tree().create_timer(7).timeout
	ult = false
	enemy_turn()

func enemy_turn():
	trocaTXT()
	if StAckcon >= 3:
		enemy.ultimate(steven)
		StAckcon = 0
		$text.text = enemy.nome + " usou a ULT\nSteven agora está com " + str(steven.vida) + " de vida."
	else:
		enemy.atacar(steven)
		$text.text = enemy.nome + " atacou!\nSteven agora está com " + str(steven.vida) + " de vida."
	if steven.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/derrota.tscn")
		return
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return
