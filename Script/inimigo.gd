extends Gem
class_name Enemy

func _init():
	super._init("Inimigo Corrompido", 150, 20)
	
func ultimate(alvo: Gem):
	alvo.vida -= 30
	print(nome + " lançou um ataque sombrio!")
