# Guía de Testing

## Estrategia de Testing

El proyecto utiliza el framework de testing de Wollok para garantizar la correctitud del código. Los tests están organizados por módulo y cubren tanto casos normales como casos límite.

## Estructura de Tests

```
tests/
├── bolichito.wtest    # Tests de integración del bolichito
├── colores.wtest      # Tests unitarios de colores
├── materiales.wtest   # Tests unitarios de materiales
├── objetos.wtest      # Tests unitarios de objetos
└── personas.wtest     # Tests unitarios de personas
```

## Ejecutar Tests

### Todos los tests
```bash
# Desde VS Code: Abre la paleta de comandos
# Ctrl+Shift+P (Windows/Linux) o Cmd+Shift+P (Mac)
# Busca: "Wollok: Run All Tests"

# O desde la terminal con Wollok CLI (si está instalado):
wollok test
```

### Test individual
```bash
# Desde VS Code: 
# - Abre el archivo .wtest
# - Click en el ícono "Run Test" que aparece sobre cada test
# - O click derecho en el archivo → "Run Wollok File"

# Desde la terminal:
wollok test tests/personas.wtest
```

## Cobertura de Tests

### 1. Tests de Colores (`colores.wtest`)

**Objetivo:** Verificar que los colores tienen las propiedades correctas.

**Casos de prueba:**
- ✓ Colores fuertes (rojo, verde, naranja)
- ✓ Colores no fuertes (celeste, pardo)

**Ejemplo (Formato BDD Gherkin-like):**
```wollok
describe "Color | Verificar si un color es fuerte" {
    test "Given: rojo | When: consultamos esFuerte() | Then: debería retornar true" {
        assert.that(rojo.esFuerte())
    }
    
    test "Given: celeste | When: consultamos esFuerte() | Then: debería retornar false" {
        assert.notThat(celeste.esFuerte())
    }
}
```

### 2. Tests de Materiales (`materiales.wtest`)

**Objetivo:** Verificar que los materiales tienen las propiedades correctas.

**Casos de prueba:**
- ✓ Materiales brillantes (cobre, vidrio)
- ✓ Materiales no brillantes (lino, madera, cuero)

**Ejemplo (Formato BDD Gherkin-like):**
```wollok
describe "Material | Verificar si un material brilla" {
    test "Given: cobre | When: consultamos brilla() | Then: debería retornar true" {
        assert.that(cobre.brilla())
    }
    
    test "Given: madera | When: consultamos brilla() | Then: debería retornar false" {
        assert.notThat(madera.brilla())
    }
}
```

### 3. Tests de Objetos (`objetos.wtest`)

**Objetivo:** Verificar que los objetos tienen las propiedades correctas y responden correctamente a los mensajes.

**Casos de prueba:**
- ✓ Propiedades de objetos simples (remera, pelota, biblioteca)
- ✓ Objetos con peso variable (muñeco)
- ✓ Objetos con color y peso variables (placa)
- ✓ Objetos con color variable (banquito)
- ✓ Objetos compuestos (cajita con contenido)
- ✓ Método `brilla()` delegando al material

**Ejemplo (Formato BDD Gherkin-like):**
```wollok
describe "Objeto | Verificar propiedades de remera" {
    test "Given: remera | When: consultamos material, color y peso | Then: debería ser lino, roja y 800g" {
        assert.equals(lino, remera.material())
        assert.equals(rojo, remera.color())
        assert.equals(800, remera.peso())
    }
    
    test "Given: remera | When: consultamos brilla() | Then: debería retornar false porque es de lino" {
        assert.notThat(remera.brilla())
    }
}

describe "Objeto | Verificar cambios de estado mutable" {
    test "Given: cajita | When: cambiamos contenido a remera | Then: peso debería ser 1200g" {
        cajita.contenido(remera)
        assert.equals(1200, cajita.peso())
    }
}
```

### 4. Tests de Personas (`personas.wtest`)

**Objetivo:** Verificar que cada persona aplica correctamente su criterio de gusto.

**Casos de prueba:**

#### Rosa (le gustan objetos ≤ 2000g)
- ✓ Le gusta la remera (800g)
- ✓ Le gusta la pelota (1300g)
- ✗ No le gusta la biblioteca (8000g)

#### Estefanía (le gustan colores fuertes)
- ✓ Le gusta la remera (roja)
- ✓ Le gusta la biblioteca (verde)
- ✗ No le gusta la pelota (parda)
- ✗ No le gusta el muñeco (celeste)

#### Luisa (le gustan materiales brillantes)
- ✓ Le gusta el muñeco (vidrio)
- ✓ Le gusta la placa (cobre)
- ✗ No le gusta la remera (lino)
- ✗ No le gusta la pelota (cuero)

#### Juan (le gustan colores no fuertes O peso entre 1200-1800g)
- ✓ Le gusta la pelota (parda Y 1300g)
- ✓ Le gusta el muñeco (celeste)
- ✓ Le gusta una placa de 1500g
- ✗ No le gusta la biblioteca (verde Y 8000g)
- ✗ No le gusta la remera (roja Y 800g)

**Ejemplo (Formato BDD Gherkin-like):**
```wollok
describe "Rosa | Preferencias: objetos de 2kg o menos" {
    test "Given: pelota (1300g) | When: consultamos leGusta() | Then: debería retornar true" {
        assert.that(rosa.leGusta(pelota))
    }
    
    test "Given: biblioteca (8000g) | When: consultamos leGusta() | Then: debería retornar false" {
        assert.notThat(rosa.leGusta(biblioteca))
    }
}

describe "Juan | Preferencias: colores no fuertes O peso entre 1200-1800g" {
    test "Given: objeto con peso exacto 1200g y color fuerte | When: consultamos leGusta() | Then: debería retornar true" {
        placa.peso(1200)
        placa.color(rojo)
        assert.that(juan.leGusta(placa))
    }
    
    test "Given: objeto con peso 1199g y color fuerte | When: consultamos leGusta() | Then: debería retornar false" {
        placa.peso(1199)
        placa.color(rojo)
        assert.notThat(juan.leGusta(placa))
    }
}
```

### 5. Tests del Bolichito (`bolichito.wtest`)

**Objetivo:** Verificar el comportamiento del bolichito con diferentes combinaciones de objetos.

**Casos de prueba:**

#### `brilla()`
- ✓ Brilla si ambos objetos brillan
- ✗ No brilla si solo uno brilla
- ✗ No brilla si ninguno brilla

#### `esMonocromatico()`
- ✓ Es monocromático si ambos son del mismo color
- ✗ No es monocromático si son de colores diferentes

#### `estaEquilibrado()`
- ✓ Está equilibrado si mostrador pesa más que vidriera
- ✗ No está equilibrado si vidriera pesa más o igual

#### `tieneObjetoDeColor(color)`
- ✓ Tiene objeto del color si está en vidriera
- ✓ Tiene objeto del color si está en mostrador
- ✗ No tiene objeto del color si ninguno coincide

#### `puedeMejorar()`
- ✓ Puede mejorar si está desequilibrado
- ✓ Puede mejorar si es monocromático
- ✗ No puede mejorar si está equilibrado y no es monocromático

#### `puedeOfrecerleAlgoA(persona)`
- ✓ Puede ofrecer si el objeto de vidriera le gusta
- ✓ Puede ofrecer si el objeto de mostrador le gusta
- ✗ No puede ofrecer si ninguno le gusta

**Ejemplo (Formato BDD Gherkin-like):**
```wollok
describe "Bolichito | Setup: remera en vidriera y pelota en mostrador" {
    test "Given: remera en vidriera, pelota en mostrador | When: consultamos brilla() | Then: debería retornar false" {
        bolichito.objetoEnVidriera(remera)
        bolichito.objetoEnMostrador(pelota)
        assert.notThat(bolichito.brilla())
    }
    
    test "Given: remera en vidriera, pelota en mostrador | When: consultamos estaEquilibrado() | Then: debería retornar true" {
        bolichito.objetoEnVidriera(remera)
        bolichito.objetoEnMostrador(pelota)
        assert.that(bolichito.estaEquilibrado())
    }
    
    test "Given: remera en vidriera, pelota en mostrador | When: consultamos puedeOfrecerleAlgoA(estefania) | Then: debería retornar true" {
        bolichito.objetoEnVidriera(remera)
        bolichito.objetoEnMostrador(pelota)
        assert.that(bolichito.puedeOfrecerleAlgoA(estefania))
    }
}
```

## Buenas Prácticas de Testing

### 1. Formato BDD Gherkin-like
Los tests deben seguir la estructura Given-When-Then para mayor claridad:

```wollok
describe "Componente | Contexto o funcionalidad" {
    test "Given: estado inicial | When: acción | Then: resultado esperado" {
        // Arrange (preparar estado)
        // Act (realizar acción)
        // Assert (verificar resultado)
        assert.that(condicion)
    }
}
```

**Ventajas:**
- Legible como especificación
- Comunica claramente qué se prueba
- Sirve como documentación viva
- Estándar en la industria

### 2. Nombres Descriptivos
Los nombres de los tests deben describir claramente qué se está probando:

✓ **Bueno:**
```wollok
test "Given: pelota (1300g) | When: consultamos leGusta() | Then: debería retornar true" {
    assert.that(rosa.leGusta(pelota))
}
```

✗ **Malo:**
```wollok
test "test1" {
    assert.that(rosa.leGusta(pelota))
}
```

### 3. Arrange-Act-Assert (AAA)
Organiza tus tests en tres secciones:

```wollok
test "Given: cajita | When: cambiamos contenido a remera | Then: peso debería ser 1200g" {
    // Arrange (preparar)
    cajita.contenido(remera)
    
    // Act (actuar) - implícito en la consulta
    const pesoTotal = cajita.peso()
    
    // Assert (verificar)
    assert.equals(1200, pesoTotal)
}
```

### 4. Tests Independientes
Cada test debe ser independiente y no depender del orden de ejecución:

✓ **Bueno:** Cada test configura su propio estado
✗ **Malo:** Un test depende del estado dejado por otro test

### 5. Casos Límite
Siempre prueba casos límite:

```wollok
test "Given: objeto con peso exacto 1200g y color fuerte | When: consultamos leGusta() | Then: debería retornar true" {
    placa.peso(1200)
    assert.that(juan.leGusta(placa))
}

test "Given: objeto con peso 1199g y color fuerte | When: consultamos leGusta() | Then: debería retornar false" {
    placa.peso(1199)
    placa.color(rojo)
    assert.notThat(juan.leGusta(placa))
}
```

## Cobertura de Código

### Nota sobre Herramientas de Cobertura
**VS Code con la extensión de Wollok actualmente no incluye una herramienta automática de análisis de cobertura de código.** La cobertura debe evaluarse manualmente revisando:
- Qué métodos son llamados por los tests
- Qué ramas condicionales se ejecutan
- Qué casos límite están cubiertos

### Análisis Manual de Cobertura

Para este proyecto, la cobertura puede verificarse revisando:

1. **Colores** (`colores.wlk`):
   - ✓ Todos los colores tienen tests de `esFuerte()`
   - ✓ Cobertura: 100%

2. **Materiales** (`materiales.wlk`):
   - ✓ Todos los materiales tienen tests de `brilla()`
   - ✓ Cobertura: 100%

3. **Objetos** (`objetos.wlk`):
   - ✓ Todos los objetos tienen tests de propiedades
   - ✓ Objetos con estado variable están testeados
   - ✓ Cobertura: 100%

4. **Personas** (`personas.wlk`):
   - ✓ Cada persona tiene tests con objetos que le gustan
   - ✓ Cada persona tiene tests con objetos que NO le gustan
   - ✓ Casos límite de Juan (between) están cubiertos
   - ✓ Cobertura: 100%

5. **Bolichito** (`bolichito.wlk`):
   - ✓ Todos los métodos tienen tests
   - ✓ Diferentes combinaciones de objetos están testeadas
   - ✓ Cobertura: 100%

### Objetivo de Cobertura
- **Mínimo aceptable:** 80% de cobertura
- **Objetivo:** 90%+ de cobertura
- **Ideal:** 100% de cobertura en lógica de negocio
- **Estado actual del proyecto:** ~100% de cobertura

### Áreas Críticas
Asegúrate de tener cobertura completa en:
- ✓ Todos los métodos públicos
- ✓ Todas las ramas condicionales
- ✓ Casos límite y edge cases
- ✓ Casos de error (si aplica)

## Debugging de Tests

### Test Falla Inesperadamente

1. **Lee el mensaje de error:**
   ```
   Expected: true
   But was: false
   ```

2. **Verifica el estado:**
   ```wollok
   test "debug ejemplo" {
       console.println(objeto.peso())  // Imprime para debug
       assert.equals(800, objeto.peso())
   }
   ```

3. **Simplifica el test:**
   - Reduce el test al mínimo necesario
   - Verifica una cosa a la vez

### Test Pasa Pero No Debería

- Verifica que estás usando `assert.that()` y no `assert.notThat()`
- Asegúrate de que el test realmente ejecuta la lógica esperada
- Revisa que no haya typos en los nombres de métodos

## Agregar Nuevos Tests

Cuando agregues nueva funcionalidad, sigue estos pasos:

1. **Escribe el test primero (TDD):**
   ```wollok
   test "nueva funcionalidad" {
       // Test que falla porque la funcionalidad no existe
   }
   ```

2. **Implementa la funcionalidad mínima:**
   - Haz que el test pase

3. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde

4. **Agrega más tests:**
   - Casos límite
   - Casos de error
   - Diferentes escenarios

## Recursos Adicionales

- [Documentación oficial de Wollok Testing](https://www.wollok.org/documentacion/testing/)
- [Guía de TDD](https://www.wollok.org/documentacion/tdd/)
- Ver [architecture.md](architecture.md) para entender la estructura del código
