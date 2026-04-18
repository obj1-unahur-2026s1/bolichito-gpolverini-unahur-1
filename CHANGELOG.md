# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [1.0.0] - 2026-04-13

### Agregado

#### Personas
- Implementación de Rosa: le gustan objetos de 2kg o menos
- Implementación de Estefanía: le gustan objetos de colores fuertes
- Implementación de Luisa: le gustan objetos de materiales brillantes
- Implementación de Juan: le gustan objetos de colores no fuertes o que pesen entre 1200-1800g

#### Colores
- Sistema de colores: rojo, verde, celeste, pardo
- Clasificación de colores fuertes (rojo, verde) y no fuertes (celeste, pardo)
- Soporte para color naranja (fuerte)

#### Materiales
- Materiales brillantes: cobre y vidrio
- Materiales no brillantes: lino, madera y cuero

#### Objetos
- Remera: roja, lino, 800g
- Pelota: parda, cuero, 1300g
- Biblioteca: verde, madera, 8000g
- Muñeco: celeste, vidrio, peso variable
- Placa: cobre, color y peso variables
- Arito: celeste, cobre, 180g
- Banquito: madera, 1700g, color variable (inicialmente naranja)
- Cajita: roja, cobre, contiene objetos, peso = 400g + contenido

#### Bolichito
- Sistema de exhibición con vidriera y mostrador
- Método `brilla()`: verifica si ambos objetos brillan
- Método `esMonocromatico()`: verifica si ambos objetos son del mismo color
- Método `estaEquilibrado()`: verifica si el mostrador pesa más que la vidriera
- Método `tieneObjetoDeColor(color)`: verifica si exhibe algún objeto del color especificado
- Método `puedeMejorar()`: verifica si está desequilibrado o es monocromático
- Método `puedeOfrecerleAlgoA(persona)`: verifica si puede ofrecer algo a una persona

#### Tests
- Suite completa de tests para personas
- Suite completa de tests para objetos
- Suite completa de tests para bolichito
- Suite completa de tests para colores
- Suite completa de tests para materiales

#### Documentación
- README.md con especificación completa del ejercicio
- LICENSE (ISC)
- CODE_OF_CONDUCT.md
- CONTRIBUTING.md
- CHANGELOG.md

### Configuración
- Proyecto configurado para Wollok 4.0.0
- Estructura de carpetas src/ y tests/
- Configuración de .gitignore para archivos de log

[1.0.0]: https://github.com/obj1-unahur-2026s1/bolichito-gpolverini-unahur-1/releases/tag/v1.0.0
