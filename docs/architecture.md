# Arquitectura del Sistema

## Visión General

El proyecto "Gustos y Bolichito" es un sistema orientado a objetos que modela un bolichito con objetos exhibidos y personas con diferentes gustos. El sistema está diseñado siguiendo principios de programación orientada a objetos y el paradigma de Wollok.

## Diagrama de Componentes

```
┌──────────────────────────────────────────────────┐
│                    BOLICHITO                     │
│  ┌──────────────┐              ┌──────────────┐  │
│  │   Vidriera   │              │  Mostrador   │  │
│  │   (Objeto)   │              │   (Objeto)   │  │
│  └──────────────┘              └──────────────┘  │
└──────────────────────────────────────────────────┘
                         │
                         │ exhibe
                         ▼
┌──────────────────────────────────────────────────┐
│                     OBJETOS                      │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐        │
│  │  Remera  │  │  Pelota  │  │Biblioteca│  ...   │
│  └──────────┘  └──────────┘  └──────────┘        │
│       │              │              │            │
│       ├─ color       ├─ color       ├─ color     │
│       ├─ material    ├─ material    ├─ material  │
│       └─ peso        └─ peso        └─ peso      │
└──────────────────────────────────────────────────┘
        │                    │
        ▼                    ▼
┌──────────────┐      ┌──────────────┐
│   COLORES    │      │  MATERIALES  │
│              │      │              │
│ - rojo       │      │ - cobre      │
│ - verde      │      │ - vidrio     │
│ - celeste    │      │ - lino       │
│ - pardo      │      │ - madera     │
│ - naranja    │      │ - cuero      │
└──────────────┘      └──────────────┘
         │                    │
         └────────┬───────────┘
                  │
                  ▼
         ┌─────────────────┐
         │    PERSONAS     │
         │                 │
         │ - Rosa          │
         │ - Estefanía     │
         │ - Luisa         │
         │ - Juan          │
         └─────────────────┘
```

## Módulos del Sistema

### 1. Colores (`colores.wlk`)

**Responsabilidad:** Definir los colores disponibles y sus propiedades.

**Objetos:**
- `rojo` - Color fuerte
- `verde` - Color fuerte
- `celeste` - Color no fuerte
- `pardo` - Color no fuerte
- `naranja` - Color fuerte

**Métodos:**
- `esFuerte()` - Retorna si el color es fuerte o no

### 2. Materiales (`materiales.wlk`)

**Responsabilidad:** Definir los materiales disponibles y sus propiedades.

**Objetos:**
- `cobre` - Material brillante
- `vidrio` - Material brillante
- `lino` - Material no brillante
- `madera` - Material no brillante
- `cuero` - Material no brillante

**Métodos:**
- `brilla()` - Retorna si el material brilla o no

### 3. Objetos (`objetos.wlk`)

**Responsabilidad:** Definir los objetos que pueden ser exhibidos en el bolichito.

**Clases/Objetos:**

#### Objetos Simples
- `remera` - roja, lino, 800g
- `pelota` - parda, cuero, 1300g
- `biblioteca` - verde, madera, 8000g

#### Objetos con Estado Variable
- `muneco` - celeste, vidrio, peso variable
- `placa` - color y peso variables, cobre
- `arito` - celeste, cobre, 180g
- `banquito` - color variable (inicial: naranja), madera, 1700g
- `cajita` - roja, cobre, contiene otro objeto, peso = 400g + contenido

**Métodos comunes:**
- `color()` - Retorna el color del objeto
- `material()` - Retorna el material del objeto
- `peso()` - Retorna el peso en gramos
- `brilla()` - Retorna si el material brilla

### 4. Personas (`personas.wlk`)

**Responsabilidad:** Modelar personas con diferentes criterios de gusto.

**Objetos:**

- **Rosa:** Le gustan objetos de 2kg o menos
  - `leGusta(objeto)` - Verifica si `objeto.peso() <= 2000`

- **Estefanía:** Le gustan objetos de colores fuertes
  - `leGusta(objeto)` - Verifica si `objeto.color().esFuerte()`

- **Luisa:** Le gustan objetos de materiales brillantes
  - `leGusta(objeto)` - Verifica si `objeto.brilla()`

- **Juan:** Le gustan objetos de colores no fuertes O que pesen entre 1200-1800g
  - `leGusta(objeto)` - Verifica condición compuesta

### 5. Bolichito (`bolichito.wlk`)

**Responsabilidad:** Gestionar la exhibición de objetos y responder consultas sobre el estado del bolichito.

**Estado:**
- `vidriera` - Objeto exhibido en la vidriera
- `mostrador` - Objeto exhibido en el mostrador

**Métodos:**

#### Consultas de Estado
- `brilla()` - Ambos objetos brillan
- `esMonocromatico()` - Ambos objetos del mismo color
- `estaEquilibrado()` - Mostrador pesa más que vidriera
- `tieneObjetoDeColor(color)` - Algún objeto es del color especificado
- `puedeMejorar()` - Está desequilibrado o es monocromático
- `puedeOfrecerleAlgoA(persona)` - Algún objeto le gusta a la persona

#### Modificadores
- `objetoEnVidriera(objeto)` - Cambia el objeto de la vidriera
- `objetoEnMostrador(objeto)` - Cambia el objeto del mostrador

## Patrones de Diseño

### 1. Strategy Pattern (Implícito)
Cada persona implementa su propia estrategia de gusto a través del método `leGusta(objeto)`.

### 2. Composition
- El bolichito compone objetos (vidriera y mostrador)
- La cajita compone otro objeto en su interior
- Los objetos componen color y material

### 3. Polymorphism
Todos los objetos responden a la misma interfaz:
- `color()`
- `material()`
- `peso()`
- `brilla()`

## Decisiones de Diseño

### ¿Por qué separar colores y materiales en archivos distintos?

**Razón:** Separación de responsabilidades. Los colores y materiales son conceptos independientes con sus propias propiedades (esFuerte vs brilla).

### ¿Por qué algunos objetos tienen estado mutable?

**Razón:** Modelar la realidad del ejercicio. Algunos objetos como el muñeco, la placa, el banquito y la cajita pueden cambiar sus propiedades con el tiempo.

### ¿Por qué el bolichito no es una clase?

**Razón:** En el contexto del ejercicio, solo existe un bolichito. Usar un objeto singleton es más simple y directo.

### ¿Por qué las personas son objetos y no clases?

**Razón:** Cada persona tiene un criterio de gusto único y fijo. No necesitamos crear múltiples instancias de "Rosa" o "Juan".

## Extensibilidad

El sistema está diseñado para ser fácilmente extensible:

### Agregar nuevos colores
```wollok
object azul {
    method esFuerte() = true
}
```

### Agregar nuevos materiales
```wollok
object plastico {
    method brilla() = false
}
```

### Agregar nuevos objetos
```wollok
object silla {
    method color() = rojo
    method material() = madera
    method peso() = 5000
    method brilla() = self.material().brilla()
}
```

### Agregar nuevas personas
```wollok
object maria {
    method leGusta(objeto) = objeto.peso() > 5000
}
```

## Flujo de Interacción Típico

1. **Configuración inicial:**
   ```wollok
   bolichito.objetoEnVidriera(remera)
   bolichito.objetoEnMostrador(pelota)
   ```

2. **Consultas sobre el bolichito:**
   ```wollok
   bolichito.brilla()             // false
   bolichito.esMonocromatico()    // false
   bolichito.estaEquilibrado()    // true (pelota > remera)
   ```

3. **Consultas sobre personas:**
   ```wollok
   bolichito.puedeOfrecerleAlgoA(rosa)      // true (ambos < 2kg)
   bolichito.puedeOfrecerleAlgoA(estefania) // true (remera es roja)
   ```

## Consideraciones de Testing

Cada módulo tiene su propia suite de tests:
- `colores.wtest` - Tests de propiedades de colores
- `materiales.wtest` - Tests de propiedades de materiales
- `objetos.wtest` - Tests de objetos individuales
- `personas.wtest` - Tests de criterios de gusto
- `bolichito.wtest` - Tests de integración del bolichito

Ver [testing.md](testing.md) para más detalles sobre estrategias de testing.
