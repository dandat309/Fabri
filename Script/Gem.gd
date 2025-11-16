extends Node
class_name Gem

var nome
var vida
var dano
var defesaON = true

func _init(i_nome: String, i_vida: int, i_dano: int):
	nome = i_nome
	vida = i_vida
	dano = i_dano

func atacar(alvo: Gem):
	print(nome + " atacou " + alvo.nome)
	if alvo.defesaON:
		print(alvo.nome + " defendeu o ataque")
		alvo.defesaON = false
		return
	alvo.vida -= dano
