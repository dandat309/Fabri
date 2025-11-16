extends Node2D

var steven = Steven.new()
var enemy = Enemy.new()
var StAckcon = 0

func _ready():
	$steven2.value = steven.vida
	$inimigo2.value = enemy.vida
	
func _on_attack_pressed() -> void:
	$HBoxContainer/attack.disabled = true
	steven.atacar(enemy)
	StAckcon += 1
	$inimigo2.value = enemy.vida
	$text.text = steven.nome +" atacou e deixou o " + enemy.nome+ " com " + str(enemy.vida) + " de vida"
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return
	enemy_turn()
	$HBoxContainer/attack.disabled = false

func _on_defend_pressed() -> void:
	steven.defender()
	$text.text = steven.nome +" está defendendo"
	enemy_turn()

func _on_heal_pressed() -> void:
	steven.curar()
	$text.text = steven.nome +" se curou Vida atual: " + str(steven.vida)
	$steven2.value = steven.vida
	enemy_turn()

func _on_ultimate_pressed() -> void:
	steven.ultimate(enemy)
	$inimigo2.value = enemy.vida
	$text.text = steven.nome + " usou seu ultimate \nVida do"  + enemy.nome +  " : " + str(enemy.vida)
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return

func enemy_turn():
	if StAckcon >= 3:
		enemy.ultimate(steven)
		StAckcon = 0
		$text.text += "\n O " + enemy.nome + " usou a Ult"
		$steven2.value = steven.vida
	else:
		enemy.atacar(steven)
		$text.text += "\nO " + enemy.nome + " atacou Steven"
		$steven2.value = steven.vida
	if steven.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/derrota.tscn")
		
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return

func enemy_ult():
	enemy.ultimate(steven)
	$steven2.value = steven.vida
	$text.text = "\nO " +enemy.nome + " inimigo usou seu ultimate Vida do Steven: " + str(steven.vida)
