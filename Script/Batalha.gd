extends Node2D

var steven = Steven.new()
var enemy = Enemy.new()
var StAckcon = 0

func _ready():
	$steven2.value = steven.vida
	$inimigo2.value = enemy.vida
	await get_tree().create_timer(2.5).timeout
	$text.text = "" 
	
func _on_attack_pressed() -> void:
	$HBoxContainer/attack.disabled = true
	steven.atacar(enemy)
	StAckcon += 1
	$inimigo2.value = enemy.vida
	$text.text = steven.nome +" atacou e deixou o " + enemy.nome+ " com " + str(enemy.vida) + " de vida"
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return
	await get_tree().create_timer(1.0).timeout
	$HBoxContainer/attack.disabled = false
	await get_tree().create_timer(1.3).timeout
	$text.text = "" 
	enemy_turn()
func _on_defend_pressed() -> void:
	$HBoxContainer/attack.disabled = true
	steven.defender()
	$text.text = steven.nome +" está defendendo"
	await get_tree().create_timer(2.0).timeout
	$HBoxContainer/attack.disabled = false
	await get_tree().create_timer(1.3).timeout
	$text.text = "" 
	enemy_turn()

func _on_heal_pressed() -> void:
	steven.curar()
	$text.text = steven.nome +" se curou Vida atual: " + str(steven.vida)
	$steven2.value = steven.vida
	await get_tree().create_timer(2.0).timeout
	$HBoxContainer/attack.disabled = false
	await get_tree().create_timer(1.3).timeout
	$text.text = "" 
	enemy_turn()

func _on_ultimate_pressed() -> void:
	$HBoxContainer/attack.disabled = false
	steven.ultimate(enemy)
	$inimigo2.value = enemy.vida
	$text.text = steven.nome + " usou seu ultimate \nVida do"  + enemy.nome +  " : " + str(enemy.vida)
	await get_tree().create_timer(3.0).timeout
	$HBoxContainer/attack.disabled = true 
	await get_tree().create_timer(1.3).timeout
	$text.text = "" 
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return

func enemy_turn():
	if StAckcon >= 3:
		enemy.ultimate(steven)
		StAckcon = 0
		$text.text += "\n O " + enemy.nome + " usou a Ult" + str(steven.vida)
		$steven2.value = steven.vida
		await get_tree().create_timer(1.3).timeout
		$text.text = "" 
	else:
		enemy.atacar(steven)
		$text.text += "\nO " + enemy.nome + " atacou Steven \n Steven ficou com " + str(steven.vida)
		$steven2.value = steven.vida
		await get_tree().create_timer(1.3).timeout
		$text.text = ""
	if steven.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/derrota.tscn")
		
	if enemy.vida <= 0:
		get_tree().change_scene_to_file("res://Cena/vitoria.tscn")
		return

func enemy_ult():
	enemy.ultimate(steven)
	$steven2.value = steven.vida
	$text.text = "\nO " +enemy.nome + " inimigo usou seu ultimate Vida do Steven: " + str(steven.vida)
	await get_tree().create_timer(1.5).timeout
	$text.text = "" 
	
	
