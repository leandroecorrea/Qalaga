import wollok.game.*
object barra {
	var property position = game.at(400, 1)
	
	method image(){
		return "barra.png"
	}
	
	method mover(direccion) {
		const proxima = direccion.siguiente(self.position(), 50)
		//if(tablero.pertenece(proxima)) {
			
			self.position(proxima)		
		//}
		//Por ahora no es un problema
	}
}

object nave1 {
	var property position = game.at(400, 350)
	var property direccion = derecha
	method image(){
		return "nave1.png"
	}
	
	method actualizar() {		
		self.mover(12)
	}
	
	method mover(velocidad) {
		if(self.debeGirar()){
			direccion = direccion.opuesto()
		}	
		const proxima = direccion.siguiente(self.position(), velocidad)
		self.position(proxima)		
	}
	
	method colision(otro) {
		game.removeVisual(otro)
	}
	method debeGirar() = self.position().x() >= game.width() - 200 ||
						 self.position().x() <= 200
}


object derecha {

	method siguiente(position, velocidad) {
		return position.right(velocidad)
	}
	
	method opuesto() = izquierda
}

object izquierda {

	method siguiente(position, velocidad) {
		return position.left(velocidad)
	}
	method opuesto() = derecha

}

object arriba {

	method siguiente(position, velocidad) {
		return position.up(10)
	}

}

object abajo {

	method siguiente(position) {
		return position.down(1)
	}

}

object tablero {

	method pertenece(position) {
		return position.x().between(0, game.width() - 1) and 
			position.y().between(0, game.height() - 1)
	}
}

object bala {
	var property position
	
	method image() = "bala.png"
	
	method actualizar() {
		self.mover(150)
		if(self.position().y() >= game.height() -50){
			game.removeVisual(self)
			game.removeTickEvent("Bala")
		}
	}
	
	method disparar(elQueDispara) {
		self.position(elQueDispara.position())
	}
	
	method mover(velocidad) {
		const proxima = arriba.siguiente(self.position(), velocidad)
		self.position(proxima)
	}
	
	
}
