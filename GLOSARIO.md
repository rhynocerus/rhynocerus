# Glosario RHYNUS 🦏
## Lo que voy aprendiendo entre videojuegos, Android, Git y Linux

Apuntes de consulta en lenguaje sencillo. No es una lista de certificaciones ni una afirmación de dominio profesional de todas las herramientas.

**Contexto:** los ejemplos se apoyan en Packet Runner, el laboratorio Nexus-AI y el entorno Linux. Que un término aparezca aquí no significa que se haya implementado en esos proyectos. Parallax y Blender se incluyen como conceptos comentados, no como funciones o herramientas cuya utilización esté verificada.

## Cómo usarlo
Busca una palabra con Ctrl+F. Primero lee la definición y después el ejemplo. No hace falta memorizar todo: reconocer y consultar también es aprender.

## 1. Herramientas, técnicas y organización
| Término | Significado sencillo | Ejemplo o asociación |
|---|---|---|
| Stack tecnológico | Conjunto de tecnologías que utiliza un proyecto. | Motor, lenguaje, bibliotecas y servicios. |
| Glosario | Diccionario de términos de un ámbito. | Este documento. |
| Framework | Estructura de herramientas y convenciones para desarrollar. | Jetpack Compose ayuda a construir interfaces Android. |
| Biblioteca / library | Código reutilizable que incorporamos a un programa. | OkHttp para peticiones HTTP. |
| Dependencia | Componente externo que necesita un proyecto. | Una biblioteca declarada en Gradle. |
| Milestone / hito | Objetivo o etapa que puede agrupar tareas e incidencias. | Primera versión jugable. |
| Roadmap | Plan de evolución del proyecto. | Qué abordar ahora y después. |
| Portfolio | Selección de trabajos que muestra capacidades. | Proyectos documentados y demostraciones. |
| MVP | Producto mínimo viable para comprobar una propuesta con usuarios. | No necesariamente una aplicación completa. |
| SaaS | Software ofrecido como servicio, normalmente mediante una red. | Una solución alojada y mantenida para clientes. |

## 2. Videojuegos y creación visual
| Término | Significado sencillo | Ejemplo o asociación |
|---|---|---|
| Godot | Motor para crear videojuegos. | Motor de Packet Runner. |
| GDScript | Lenguaje de programación utilizado en Godot. | Instrucciones del jugador y de la partida. |
| Escena / scene | Estructura reutilizable de elementos de Godot. | Un jugador o una pantalla. |
| Nodo / node | Elemento básico que aporta una función en Godot. | Imagen, sonido, cámara o cuerpo físico. |
| Señal / signal | Notificación de un evento entre objetos. | Un botón comunica que fue pulsado. |
| Sprite | Representación gráfica 2D de un personaje u objeto. | El rinoceronte del juego. |
| Spritesheet | Imagen que reúne varios fotogramas o elementos. | Diferentes poses en una misma hoja. |
| Fotograma / frame | Una imagen o paso de una secuencia animada. | Una pose durante la carrera. |
| Parallax | Capas visuales que se desplazan a distintas velocidades para sugerir profundidad. | Un fondo lejano avanza más despacio; concepto comentado. |
| HUD | Información visible durante la partida. | Puntuación y estado del escudo. |
| Colisión | Interacción detectada entre formas físicas o áreas. | Contacto del jugador con un obstáculo. |
| Hitbox | Región utilizada para detectar determinados impactos o contactos. | No tiene por qué coincidir exactamente con el dibujo. |
| Game Over | Estado o pantalla que indica el final de una partida. | Mostrar puntuación y permitir reintentar. |
| SFX | Efectos de sonido. | Salto, impacto o recogida de un objeto. |
| Loop / bucle | Repetición de una acción o recurso. | Música que vuelve al inicio al terminar. |
| Asset / recurso | Material utilizado en un proyecto. | Imagen, audio, fuente o modelo. |
| Blender | Herramienta de creación 3D, animación y otras tareas visuales. | Concepto comentado; no implica que Packet Runner la utilice. |
| Modelo 3D | Representación tridimensional de un objeto. | Una figura formada por geometría. |
| Textura | Imagen o datos aplicados a una superficie. | Apariencia visual de un objeto 3D. |
| Shader | Programa que participa en el cálculo de la apariencia gráfica. | Efectos de color o iluminación; ejemplo conceptual. |

## 3. Git y GitHub
Git es el sistema de control de versiones. GitHub es una plataforma que aloja repositorios y añade colaboración.

| Término | Significado sencillo | Ejemplo o asociación |
|---|---|---|
| Repositorio / repo | Proyecto con archivos e historial de versiones. | packet-runner. |
| Commit | Registro de una serie de cambios en el historial. | Incorporar una mejora con un mensaje descriptivo. |
| Rama / branch | Línea de desarrollo separada. | Trabajar una función sin modificar directamente main. |
| main | Nombre habitual de la rama principal. | Su significado depende de las reglas del proyecto. |
| Fork | Copia de un repositorio vinculada al original en la plataforma. | El fork RHYNUS de Nexus-AI. |
| Clone / clonar | Crear una copia local del repositorio y su historial. | Descargar el proyecto al ordenador. |
| Remote / remoto | Referencia a otro repositorio. | origin y upstream. |
| origin | Nombre convencional del remoto principal de una copia local. | En Nexus apunta al fork de RHYNUS. |
| upstream | Nombre habitual del remoto del proyecto original. | En Nexus apunta a Llucs/Nexus-AI. |
| Fetch | Descargar referencias y objetos del remoto sin integrar automáticamente sus cambios en la rama actual. | Revisar novedades antes de fusionar. |
| Pull | Obtener cambios e integrarlos según la configuración. | Puede usar merge o rebase. |
| Push | Enviar commits y referencias al remoto. | Publicar una rama propia. |
| Pull request / PR | Propuesta de integración de cambios entre ramas o repositorios. | Pedir que se incorpore una mejora. |
| Merge / fusionar | Integrar líneas de desarrollo. | Incorporar una rama a main. |
| Issue | Registro de un problema, tarea o propuesta. | Documentar un error reproducible. |
| Tag / etiqueta | Nombre asociado a un punto del historial. | Marcar una versión. |
| Release | Publicación de una versión en la plataforma, con notas y posibles archivos. | Distribuir un APK. |
| GitHub Actions | Automatización mediante workflows. | Compilar o ejecutar pruebas. |
| CI | Integración continua: automatizar comprobaciones frecuentes de cambios. | Detectar fallos antes de integrar. |
| Artefacto / artifact | Archivo producido por una ejecución o compilación. | APK generado en un workflow. |
| .gitignore | Reglas para ignorar ciertos archivos no versionados. | Cachés y resultados de compilación. |

## 4. Android e inteligencia artificial
| Término | Significado sencillo | Ejemplo o asociación |
|---|---|---|
| Android Studio | Entorno de desarrollo para Android. | Preparar herramientas y desarrollar apps. |
| SDK | Herramientas y componentes para desarrollar para una plataforma. | Android SDK Platform 34. |
| API level | Número que identifica una versión de las APIs de Android. | API 24 corresponde a Android 7.0. |
| Kotlin | Lenguaje de programación. | Lenguaje de Nexus-AI. |
| Jetpack Compose | Herramientas para construir interfaces Android mediante código declarativo. | Pantallas de Nexus-AI. |
| Gradle | Sistema de automatización de compilación y dependencias. | assembleDebug. |
| JDK | Herramientas Java necesarias para tareas de desarrollo. | JDK 17 en la compilación realizada. |
| APK | Paquete instalable de una aplicación Android. | Archivo instalado en el OPPO. |
| Debug build | Compilación orientada a desarrollo y diagnóstico. | No equivale a una versión de producción. |
| Firma del APK | Mecanismo criptográfico para verificar integridad e identidad de firma. | Firma Android Debug de una prueba local. |
| ADB | Herramienta para comunicarse con dispositivos o emuladores Android. | Instalar y abrir Nexus por USB. |
| Emulador | Software que simula un dispositivo. | No se utilizó en la prueba física del OPPO. |
| API | Interfaz mediante la que programas interactúan. | Consultar un servicio de IA. |
| Endpoint | Dirección concreta de un servicio o API. | /v1/models. |
| Modelo de IA | Sistema que procesa entradas y genera resultados. | Distinto de la app que muestra el chat. |
| Prompt | Entrada o instrucciones dadas a un modelo. | Pedir un ejemplo de Python. |
| Token | Unidad utilizada por un modelo para representar texto u otros datos. | No es siempre una palabra completa. |
| Contexto | Información que recibe el modelo para responder. | Mensajes anteriores incluidos en una petición. |
| API key | Credencial para acceder a un servicio. | No debe publicarse en Git. |
| Dictado | Conversión de voz en texto. | Prueba realizada en Nexus. |
| DataStore | Componente Android para persistir determinados datos. | Preferencias e historial en Nexus. |

## 5. Linux, red y automatización
| Término | Significado sencillo | Ejemplo o asociación |
|---|---|---|
| Bash | Intérprete de comandos y lenguaje de scripting. | Automatizar tareas de terminal. |
| Script | Archivo con instrucciones ejecutables por un intérprete. | Tareas de mantenimiento. |
| Pipe / tubería | Conecta la salida de un comando con la entrada de otro. | curl ... \| jq. |
| curl | Herramienta para transferir datos mediante protocolos como HTTP. | Consultar una API. |
| JSON | Formato estructurado de intercambio de datos. | Respuesta del catálogo de modelos. |
| jq | Herramienta de consulta y transformación de JSON. | Extraer .data[].id. |
| HTTP | Protocolo de comunicación utilizado en la web y muchas APIs. | Peticiones y respuestas. |
| HTTP 200 | Respuesta HTTP satisfactoria. | Consultar el catálogo correctamente. |
| HTTP 400 | Respuesta de solicitud no aceptada como válida por el servidor. | Hay que leer el cuerpo para conocer el motivo específico. |
| SHA-256 | Función que produce una huella de datos. | Identificar un APK; no demuestra por sí sola que sea seguro. |
| Permiso de ejecución | Permiso que permite ejecutar un archivo, sujeto a otras restricciones del sistema. | chmod u+x en el ejecutable de Gradle. |
| Daemon / servicio | Proceso que realiza tareas en segundo plano. | Servicios del sistema. |
| Log / registro | Información sobre eventos o funcionamiento. | Investigar errores. |
| USBGuard | Control de autorización de dispositivos USB en Linux. | Revisar la política antes de activar restricciones. |
| Grafana | Plataforma de visualización y consulta de datos. | Paneles de monitorización. |
| Prometheus | Sistema de monitorización basado en métricas. | Recoger y consultar indicadores. |
| Node Exporter | Exporta métricas del sistema para Prometheus. | CPU, memoria y otros indicadores. |
| Blue Team | Funciones defensivas de seguridad. | Monitorizar, detectar y responder. |
| SOC | Centro o equipo de operaciones de seguridad. | Analizar alertas e incidentes. |
| OSINT | Obtención y análisis de información de fuentes abiertas. | Investigación con fuentes accesibles y límites legales. |

## 6. Publicar sin confundir derechos
| Término | Significado sencillo | Recordatorio |
|---|---|---|
| Open source | Software distribuido bajo una licencia que permite derechos de uso, estudio, modificación y redistribución. | Código visible no significa automáticamente código abierto. |
| Licencia | Condiciones bajo las que se autoriza utilizar una obra. | Revisar código, dependencias y recursos. |
| MIT | Licencia permisiva utilizada por Nexus-AI. | Conservar los avisos requeridos; permite usos comerciales. |
| Atribución | Reconocimiento de los autores y procedencia. | Un fork no convierte el original en una creación propia. |
| Prueba funcional | Comprobar un comportamiento concreto. | Dictado o borrado de un chat. |
| Auditoría de seguridad | Evaluación con alcance y metodología de seguridad definidos. | Verificar un APK no equivale a una auditoría completa. |

## Proyectos de referencia
- [Packet Runner](https://github.com/rhynocerus/packet-runner)
- [Fork de Nexus-AI](https://github.com/rhynocerus/Nexus-AI)
- [Nexus-AI original, de Llucs](https://github.com/Llucs/Nexus-AI)

## Fuentes para ampliar
- [Documentación de Godot](https://docs.godotengine.org/es/stable/)
- [Manual de Blender](https://docs.blender.org/manual/en/latest/)
- [Libro de Git en español](https://git-scm.com/book/es/v2)
- [Documentación de GitHub](https://docs.github.com/es)
- [Documentación Android](https://developer.android.com/docs)
- [Manual de jq](https://jqlang.org/manual/)
- [Licencia MIT](https://choosealicense.com/licenses/mit/)

---
Documento vivo de aprendizaje. Las versiones, servicios y requisitos pueden cambiar.
