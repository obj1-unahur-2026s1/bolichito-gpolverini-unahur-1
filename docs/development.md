# Guía para Desarrolladores

## Introducción

Esta guía está diseñada para ayudar a desarrolladores que quieran contribuir o extender el proyecto "Gustos y Bolichito". Aquí encontrarás información sobre el flujo de trabajo, convenciones de código y mejores prácticas.

## Configuración del Entorno de Desarrollo

### Requisitos
- Visual Studio Code con extensión de Wollok
- Wollok 4.0.0+
- Git

### Configuración Inicial
```bash
# Clonar el repositorio
git clone <url-del-repositorio>
cd bolichito

# Abrir en VS Code
code .
```

Ver [setup.md](setup.md) para instrucciones detalladas.

## Flujo de Trabajo

### 1. Antes de Empezar

1. **Actualiza tu rama local:**
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Crea una nueva rama:**
   ```bash
   git checkout -b feature/nombre-descriptivo
   # o
   git checkout -b fix/nombre-del-bug
   ```

### 2. Durante el Desarrollo

1. **Escribe tests primero (TDD) con formato BDD:**
   ```wollok
   describe "Componente | Funcionalidad" {
       test "Given: estado inicial | When: acción | Then: resultado esperado" {
           // Test que falla
           assert.equals(valorEsperado, objeto.nuevoMetodo())
       }
   }
   ```

2. **Implementa la funcionalidad:**
   ```wollok
   object objeto {
       method nuevoMetodo() {
           // Implementación mínima para pasar el test
       }
   }
   ```

3. **Ejecuta los tests frecuentemente:**
   - Después de cada cambio significativo
   - Antes de hacer commit

4. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde
   - Elimina duplicación
   - Mejora nombres de variables/métodos

### 3. Antes de Hacer Commit

1. **Ejecuta TODOS los tests:**
   - Desde VS Code: Ctrl+Shift+P → "Wollok: Run All Tests"
   - O desde terminal: `wollok test` (si tienes Wollok CLI)

2. **Verifica que no haya errores de compilación:**
   - Revisa el panel "Problems" en VS Code (Ctrl+Shift+M)

3. **Revisa tus cambios:**
   ```bash
   git status
   git diff
   ```

### 4. Hacer Commit

```bash
# Agrega los archivos modificados
git add src/archivo.wlk tests/archivo.wtest

# Commit con mensaje descriptivo
git commit -m "Agrega validación de peso en objetos

- Implementa método validarPeso()
- Agrega tests para casos límite
- Fixes #123"
```

### 5. Push y Pull Request

```bash
# Push a tu rama
git push origin feature/nombre-descriptivo

# Crea un Pull Request en GitHub/GitLab
# Describe los cambios y referencia issues relacionados
```

## Convenciones de Código

### Nomenclatura

#### Objetos
```wollok
// Objetos singleton: camelCase
object bolichito { }
object remera { }
```

#### Clases
```wollok
// Clases: PascalCase
class Persona { }
class ObjetoDecorado { }
```

#### Métodos
```wollok
// Métodos: camelCase
method leGusta(objeto) { }
method brilla() { }
method puedeOfrecerleAlgoA(persona) { }
```

#### Variables
```wollok
// Variables: camelCase
const pesoMaximo = 2000
var objetoActual = remera
```

### Estilo de Código

#### Indentación
- Usa **2 espacios** (no tabs)
- VS Code con la extensión de Wollok lo configura automáticamente

#### Llaves
```wollok
// ✓ Bueno: llave de apertura en la misma línea
method ejemplo() {
    // código
}

// ✗ Malo: llave de apertura en nueva línea
method ejemplo()
{
    // código
}
```

#### Espacios
```wollok
// ✓ Bueno: espacios alrededor de operadores
const resultado = peso + 400

// ✗ Malo: sin espacios
const resultado=peso+400

// ✓ Bueno: espacio después de comas
method metodo(param1, param2, param3)

// ✗ Malo: sin espacios
method metodo(param1,param2,param3)
```

#### Líneas en Blanco
```wollok
object ejemplo {
    // Una línea en blanco entre métodos
    method metodo1() {
        // código
    }
    
    method metodo2() {
        // código
    }
}
```

### Comentarios

#### Cuándo Comentar
```wollok
// ✓ Bueno: comentar lógica compleja
method leGusta(objeto) {
    // Juan tiene gustos combinados: le gustan colores no fuertes
    // O objetos que pesen entre 1200 y 1800 gramos
    return !objeto.color().esFuerte() || 
           objeto.peso().between(1200, 1800)
}

// ✗ Malo: comentar lo obvio
method peso() {
    return 800  // retorna 800
}
```

#### Comentarios TODO
```wollok
// TODO: Implementar validación de peso negativo
// FIXME: Este método no maneja el caso de cajita vacía
// HACK: Solución temporal hasta refactorizar
```

## Mejores Prácticas

### 1. Principio de Responsabilidad Única
Cada objeto/clase debe tener una sola responsabilidad:

```wollok
// ✓ Bueno: cada objeto tiene una responsabilidad clara
object rojo {
    method esFuerte() = true
}

object cobre {
    method brilla() = true
}

// ✗ Malo: objeto con múltiples responsabilidades
object rojoYCobre {
    method esFuerte() = true
    method brilla() = true
}
```

### 2. Encapsulamiento
No expongas detalles de implementación:

```wollok
// ✓ Bueno: encapsula el cálculo
object cajita {
    var contenido = null
    const pesoPropio = 400
    
    method peso() = pesoPropio + contenido.peso()
}

// ✗ Malo: expone detalles internos
object cajita {
    var contenido = null
    var pesoPropio = 400  // público, puede ser modificado
    
    method peso() = pesoPropio + contenido.peso()
}
```

### 3. Polimorfismo
Aprovecha el polimorfismo de Wollok:

```wollok
// ✓ Bueno: todos los objetos responden a la misma interfaz
remera.peso()
pelota.peso()
biblioteca.peso()

// ✗ Malo: usar condicionales para tipos
method calcularPeso(objeto) {
    if (objeto == remera) return 800
    else if (objeto == pelota) return 1300
    // ...
}
```

### 4. Inmutabilidad Cuando Sea Posible
```wollok
// ✓ Bueno: usa const para valores que no cambian
object remera {
    method color() = rojo
    method material() = lino
    method peso() = 800
}

// ✗ Malo: usar var innecesariamente
object remera {
    var color = rojo  // ¿realmente necesita cambiar?
    method color() = color
    method color(unColor) {
        color = unColor
    }
}
```

### 5. Nombres Descriptivos
```wollok
// ✓ Bueno: nombres que expresan intención
method puedeOfrecerleAlgoA(persona) {
    return persona.leGusta(vidriera) || persona.leGusta(mostrador)
}

// ✗ Malo: nombres crípticos
method check(p) {
    return p.lg(v) || p.lg(m)
}
```

## Patrones Comunes

### Pattern: Strategy (Criterios de Gusto)
```wollok
// Cada persona implementa su propia estrategia
object rosa {
    method leGusta(objeto) = objeto.peso() <= 2000
}

object estefania {
    method leGusta(objeto) = objeto.color().esFuerte()
}
```

### Pattern: Delegation (Delegar a Componentes)
```wollok
object remera {
    method color() = rojo
    method material() = lino
    
    // Delega al material
    method brilla() = self.material().brilla()
}
```

### Pattern: Composite (Objetos Compuestos)
```wollok
object cajita {
    var contenido = null
    
    method peso() = 400 + contenido.peso()
    method guardar(objeto) { contenido = objeto }
}
```

## Testing

### Test-Driven Development (TDD)

1. **Red:** Escribe un test que falle
2. **Green:** Implementa lo mínimo para que pase
3. **Refactor:** Mejora el código

**Formato BDD Gherkin-like:**
```wollok
// 1. RED: Test que falla
describe "Componente | Nueva funcionalidad" {
    test "Given: estado inicial | When: acción | Then: resultado esperado" {
        assert.equals(cobre, arito.material())
    }
}

// 2. GREEN: Implementación mínima
object arito {
    method material() = cobre
}

// 3. REFACTOR: (si es necesario)
```

Ver [testing.md](testing.md) para más detalles.

## Debugging

### Técnicas de Debugging

#### 1. Console.println()
```wollok
method leGusta(objeto) {
    console.println("Peso: " + objeto.peso())
    console.println("Color fuerte: " + objeto.color().esFuerte())
    return objeto.peso() <= 2000
}
```

#### 2. Breakpoints
- Click en el margen izquierdo del editor en VS Code
- Ejecuta en modo Debug (F5)
- Inspecciona variables en el panel de Debug

#### 3. Tests Específicos
```wollok
test "debug: verificar peso de cajita" {
    cajita.guardar(remera)
    console.println("Peso cajita: " + cajita.peso())
    console.println("Peso remera: " + remera.peso())
    assert.equals(1200, cajita.peso())
}
```

## Errores Comunes

### 1. Olvidar el `self`
```wollok
// ✗ Malo
object ejemplo {
    var peso = 100
    method duplicarPeso() {
        peso = peso * 2  // Error: peso no está definido
    }
}

// ✓ Bueno
object ejemplo {
    var peso = 100
    method duplicarPeso() {
        peso = self.peso() * 2
    }
}
```

### 2. Comparar Objetos con `==` en lugar de `equals`
```wollok
// ✗ Malo (puede no funcionar como esperas)
if (objeto.color() == rojo) { }

// ✓ Bueno
if (objeto.color().equals(rojo)) { }

// ✓ Mejor (en tests)
assert.equals(rojo, objeto.color())
```

### 3. No Inicializar Variables
```wollok
// ✗ Malo
object cajita {
    var contenido  // Error: no inicializada
}

// ✓ Bueno
object cajita {
    var contenido = null
}
```

## Recursos Adicionales

### Documentación
- [Arquitectura del Sistema](architecture.md)
- [Guía de Testing](testing.md)
- [Guía de Setup](setup.md)

### Enlaces Externos
- [Documentación oficial de Wollok](https://www.wollok.org/)
- [Tour de Wollok](https://www.wollok.org/tour/)
- [Guía de Contribución](../CONTRIBUTING.md)

## Preguntas Frecuentes

### ¿Cómo agrego un nuevo objeto?

1. Agrega el objeto en `src/objetos.wlk`
2. Implementa los métodos requeridos: `color()`, `material()`, `peso()`, `brilla()`
3. Agrega tests en `tests/objetos.wtest`

### ¿Cómo agrego una nueva persona?

1. Agrega el objeto en `src/personas.wlk`
2. Implementa el método `leGusta(objeto)`
3. Agrega tests en `tests/personas.wtest`

### ¿Puedo modificar el README.md?

No, el README.md contiene la especificación del ejercicio y no debe modificarse.

### ¿Dónde reporto bugs?

Crea un issue en el repositorio con:
- Descripción del bug
- Pasos para reproducir
- Comportamiento esperado vs actual
- Versión de Wollok

## Contacto

Si tienes preguntas o necesitas ayuda:
- Crea un issue con la etiqueta "question"
- Revisa la [Guía de Contribución](../CONTRIBUTING.md)
- Consulta el [Código de Conducta](../CODE_OF_CONDUCT.md)
