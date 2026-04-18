import src.objetos.*
import src.personas.*

object bolichito {
    var objetoEnVidriera = pelota
    method objetoEnVidriera() = objetoEnVidriera
    method objetoEnVidriera(unObjeto) {
        objetoEnVidriera = unObjeto
    } 
    var objetoEnMostrador = muñeco
    method objetoEnMostrador() = objetoEnMostrador
    method objetoEnMostrador(unObjeto) {
        objetoEnMostrador = unObjeto
    } 

    method brilla() = objetoEnMostrador.brilla() && objetoEnVidriera.brilla()
    method esMonocromatico() = objetoEnMostrador.color() == objetoEnVidriera.color()
    method estaEquilibrado() = objetoEnMostrador.peso() > objetoEnVidriera.peso()
    method tieneObjetoDeColor(unColor) = objetoEnMostrador.color() == unColor || objetoEnVidriera.color() == unColor
    method puedeMejorar() = self.esMonocromatico() || !self.estaEquilibrado()
    method puedeOfrecerleAlgoA(unaPersona) = unaPersona.leGusta(objetoEnMostrador) || unaPersona.leGusta(objetoEnVidriera)
}