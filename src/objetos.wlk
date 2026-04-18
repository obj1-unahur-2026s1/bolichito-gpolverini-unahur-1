import src.colores.*
import src.materiales.*

object pelota {
    method peso() = 1300
    method color() = pardo
    method material() = cuero
    method brilla() = self.material().brilla()
}

object remera {
    method peso() = 800
    method color() = rojo
    method material() = lino
    method brilla() = self.material().brilla()
}

object biblioteca {
    method peso() = 8000
    method color() = verde
    method material() = madera
    method brilla() = self.material().brilla()
}

object muñeco {
    var peso = 200
    method peso() = peso
    method peso(unPeso) {
        peso = unPeso
    } 
    method color() = celeste
    method material() = vidrio
    method brilla() = self.material().brilla()
}

object placa {
    var peso = 200
    method peso() = peso
    method peso(unPeso) {
        peso = unPeso
    }
    var color = rojo
    method color() = color
    method color(unColor) {
        color = unColor
    }
    method material() = cobre
    method brilla() = self.material().brilla()
}

object arito {
    method peso() = 180
    method color() = celeste
    method material() = cobre
    method brilla() = self.material().brilla()
}

object banquito {
    method peso() = 1700
    var color = naranja
    method color() = color
    method color(unColor) {
        color = unColor
    }
    method material() = madera
    method brilla() = self.material().brilla()
}

object cajita {
    method peso() = 400 + contenido.peso()
    method color() = rojo
    method material() = cobre
    var contenido = arito
    method contenido() = contenido
    method contenido(unObjeto) {
        contenido = unObjeto
    }
    method brilla() = self.material().brilla()
}