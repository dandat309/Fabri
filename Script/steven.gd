extends Gem
class_name Steven

func _init():
	super._init("Steven", 120, 15)  

func curar():
	vida += 25
	print(nome + " se curou!")

func defender():
	defesaON = true

func ultimate(alvo: Gem):    
	alvo.vida -= 40 
