# Syft: análisis y pruebas reproducibles

**RHYNUS Interactive Works (RIW) · 21 de octubre de 2026**

**Informe de pruebas Syft – v1.1 – RIW**

Syft ofrece una infraestructura amplia de pruebas. En esta evaluación, la selección unitaria pasó completa tras preparar sus archivos de prueba: **355 tests principales en 33 paquetes**, con **2.732 eventos aprobados contando tests y subtests**. Estos dos recuentos se solapan; no deben sumarse. La compilación y la generación de tres formatos SBOM también funcionaron. Una prueba CLI quedó bloqueada por ausencia de Docker en el entorno local. **La validación posterior en GitHub Actions ya supera los cinco tests CLI, incluido el caso Docker; véase la actualización v1.1.**

Es una evaluación parcial y reproducible, no una certificación de seguridad ni una ejecución completa de la CI de Anchore. No se modificó el código de Syft ni se enviaron incidencias a su repositorio.

## Qué ofrece el proyecto

Syft es una herramienta CLI y biblioteca Go que inventaría componentes de software y genera SBOMs desde directorios, archivos e imágenes de contenedor. Para detectar vulnerabilidades puede combinarse con un analizador como Grype. Un SBOM por sí solo no demuestra que un sistema esté libre de vulnerabilidades.

Se examinó `main` en la revisión inmutable [`f15c3343e29dfb20cf6d82c820e7090b49808c96`](https://github.com/anchore/syft/tree/f15c3343e29dfb20cf6d82c820e7090b49808c96), cuyo mensaje es «Pin Gguff lib to prevent dropping packages (#5447)». Se localizaron 509 archivos Go con sufijo `_test.go`; un archivo puede contener varios tests y subtests.

| Área | Entrada oficial | Características observadas |
|---|---|---|
| Unitarias | `make unit` | Excluye directorios `test/`, prepara fixtures y configura un umbral de cobertura del 62 %. |
| Integración | `make integration` | Ejercita la aplicación sobre imágenes de prueba; admite detector de carreras. |
| CLI | `make cli` | Usa un binario snapshot y pruebas sobre argumentos, formatos y escaneos. |
| Herramientas internas | `make test-utils` | Pruebas Python de etiquetado y pruebas Go de `.make`. |
| Validaciones adicionales | `make static-analysis`, `make validate-cyclonedx-schema` | Análisis estático, coherencia y validación de formatos. |
| Aceptación y contenedores | `make install-test`, `make compare-linux`, `make containers-storage-test` | Instalador, comparación de resultados y almacenes Podman/Buildah. |

El workflow oficial distribuye estas tareas entre Linux, Windows y macOS. Su entorno de CI incluye recursos y herramientas que esta evaluación local no reproduce por completo.

## Entorno preparado

- Ubuntu 24.04.3 LTS, Linux x86_64; cuota de 8 CPU y límite de 8 GiB de RAM.
- Go **1.26.8**, requerido por `go.mod`, instalado dentro del espacio de trabajo. Descarga contrastada con el SHA-256 del catálogo oficial de Go.
- `GOTOOLCHAIN=local`, `GOMAXPROCS=4`, compilación/pruebas con `-p 2` y tags `containers_image_openpgp,exclude_graphdriver_btrfs`.
- Dependencias descargadas y verificadas con `go mod verify`: **all modules verified**.
- ORAS 1.3.4 verificado por SHA-256 para recuperar los fixtures oficiales.
- Caché de fixtures fijada por digest: `sha256:647e0205eadc1bcf516ce517cfa039d3738129dd3e41bba690df1f1cacc99143`.
- Docker no está instalado. No se ejecutaron el detector de carreras ni la medición de cobertura.

El bootstrap oficial anuncia Go 1.26.2 por defecto, mientras `go.mod` requiere 1.26.8. Se preparó directamente 1.26.8 para evitar depender de una actualización automática del toolchain. Esta diferencia de configuración no se considera por sí sola un defecto del proyecto.

## Resultados locales originales

| Comprobación | Resultado | Evidencia |
|---|---|---|
| Etiquetador Python | 8 tests aprobados | [labeler.log](evidence/labeler.log) |
| Herramientas Go de `.make` | 1 test principal y sus 5 subtests aprobados | [go-make.jsonl.gz](evidence/go-make.jsonl.gz) |
| Tamaño de snippets binarios | Aprobado: archivos de hasta 1.000 bytes | [binary-fixture-size.log](evidence/binary-fixture-size.log) |
| Selección unitaria con fixtures | 355 tests principales aprobados, 33 paquetes aprobados; 3 paquetes sin tests | [unit-with-fixtures.jsonl.gz](evidence/unit-with-fixtures.jsonl.gz) |
| Compilación de la CLI | Aprobada, código de salida 0 | [build.exit](evidence/build.exit) |
| CLI: versión, GGUF, enlaces simbólicos y entradas malformadas | 4 tests principales aprobados; 16 eventos aprobados contando subtests | [cli-selected.jsonl.gz](evidence/cli-selected.jsonl.gz) |
| CLI: `TestDirectoryScanCompletesWithinTimeout` | Bloqueado por Docker; Go lo registra como fallo y el comando termina con código 1 | [cli-selected.jsonl.gz](evidence/cli-selected.jsonl.gz) |
| Prueba funcional RIW | 5 comprobaciones aprobadas sobre tres SBOMs | [checks.json](evidence/smoke/checks.json) |

La selección unitaria cubrió archivos y sus catalogadores, sistema Linux, licencias, CPE, modelo de paquetes, catalogadores JavaScript/Python y formatos de salida. El comando exacto está en [run.sh](scripts/run.sh). No equivale a `make unit` completo ni comprueba su umbral de cobertura.

La prueba funcional RIW escaneó únicamente un `requirements.txt` sintético con `requests==2.32.3` y `flask==3.0.3`. Comprobó su presencia y versión en Syft JSON, CycloneDX JSON y SPDX JSON, además de los identificadores de formato. Se comprobó la lectura del JSON; no se validaron los documentos contra sus esquemas completos.

### Incidencias del entorno y resolución

La primera ejecución unitaria tuvo 9 paquetes fallidos y 18 tests principales fallidos por fixtures ausentes o intentos de construirlos con Docker. Se conserva el [registro inicial](evidence/unit-selected.jsonl.gz). Tras recuperar los archivos oficiales, la misma selección terminó sin fallos. Esto respalda que los fallos iniciales se debían a la preparación del entorno.

La selección CLI terminó con código 1 porque `TestDirectoryScanCompletesWithinTimeout` invoca `docker pull` y después ejecuta Syft dentro de un contenedor. Ese caso sigue pendiente en un entorno con Docker. No se presenta como aprobado ni como un defecto confirmado de Syft.

## Repetir las pruebas

Desde una copia de este repositorio, en Linux x86_64, con Git, curl, tar, Python 3 y GCC disponibles:

```bash
bash qa/syft/2026-10-21/scripts/prepare.sh
bash qa/syft/2026-10-21/scripts/run.sh
```

La preparación descarga Go, la revisión fijada de Syft, sus dependencias y los fixtures. Usa `.work/`, sin instalar herramientas en directorios del sistema. Los resultados de cada repetición van a `results/<fecha>/`. Docker con un daemon operativo es necesario para completar el caso CLI de contenedores; sin él, el script conservará el fallo y devolverá un estado no satisfactorio.

También se incluye el workflow manual [Syft QA · RIW](https://github.com/rhynocerus/rhynocerus/actions/workflows/syft-qa.yml). Al ejecutarlo en GitHub Actions prepara el entorno, repite la selección y conserva registros/SBOMs como artefacto durante 30 días. Los resultados locales originales se conservan como historial. Las ejecuciones posteriores en Actions se documentan a continuación.

Para ampliar después al conjunto oficial, en una máquina con Docker y las herramientas del bootstrap, pueden ejecutarse `make unit`, `make integration` y `make cli`. Quedan fuera de esta evaluación esas suites completas, la aceptación multiplataforma, el instalador, Podman/Buildah, análisis estático completo, cobertura y detector de carreras.

## Actualización v1.1: validación en GitHub Actions

La [primera ejecución en Actions](https://github.com/rhynocerus/rhynocerus/actions/runs/39625354079) aprobó las 355 pruebas unitarias principales, las herramientas internas, la compilación y el smoke test. El único fallo fue `TestDirectoryScanCompletesWithinTimeout`, que terminó con código 126.

La causa estaba en el script RIW: compilaba Syft en `results/` y configuraba `SYFT_BINARY_LOCATION`, pero el helper de upstream para Docker ignora esa variable y monta el ejecutable desde `snapshot/linux-build_linux_amd64_v1/syft`. El ejecutable no estaba en esa ruta. El estado rojo correspondía a un error de preparación de nuestro entorno; no confirmó un defecto de Syft.

Se corrigió el script para compilar con `CGO_ENABLED=0` —compatible con Alpine— y copiar el ejecutable al directorio snapshot esperado. Se añadió `-show-output` para conservar el diagnóstico completo cuando una prueba CLI falla. No se omitieron ni alteraron tests de Syft.

La [segunda ejecución en Actions](https://github.com/rhynocerus/rhynocerus/actions/runs/39626601905), sobre la corrección `fd2700e79687f0b48f8f47cf5556b816ee06c949`, terminó **success** en Ubuntu 24.04.5 LTS:

| Comprobación | Resultado |
|---|---|
| Selección unitaria | 355 tests principales aprobados en 33 paquetes; 2.732 eventos aprobados contando subtests |
| Selección CLI | 5 tests principales aprobados, incluido Docker; 17 eventos aprobados contando subtests |
| Etiquetador Python | 8 tests aprobados |
| Herramientas Go `.make` | 1 test principal y 5 subtests aprobados |
| Snippets, compilación y smoke test RIW | Aprobados; las cinco comprobaciones de los SBOMs fueron satisfactorias |

Todos los comandos registrados terminaron con código 0. Esto valida la selección descrita, no la suite oficial completa ni la seguridad global del proyecto.

Se conservan los artefactos originales para comparar ambos resultados: [primera ejecución fallida](evidence/actions-39625354079.zip) y [segunda ejecución satisfactoria](evidence/actions-39626601905.zip). Sus SHA-256 se incluyen en `SHA256SUMS` y en `summary.json`. La activación automática usada para validar la rama de corrección se retiró; el workflow publicado sigue siendo manual.

## Fuentes y trazabilidad

- [README de Syft](https://github.com/anchore/syft/blob/f15c3343e29dfb20cf6d82c820e7090b49808c96/README.md).
- [Versión de Go y dependencias](https://github.com/anchore/syft/blob/f15c3343e29dfb20cf6d82c820e7090b49808c96/go.mod).
- [Definición de tareas y pruebas](https://github.com/anchore/syft/blob/f15c3343e29dfb20cf6d82c820e7090b49808c96/.make/main.go) y [Taskfile](https://github.com/anchore/syft/blob/f15c3343e29dfb20cf6d82c820e7090b49808c96/Taskfile.yaml).
- [Workflow oficial de validaciones](https://github.com/anchore/syft/blob/f15c3343e29dfb20cf6d82c820e7090b49808c96/.github/workflows/validations.yaml) y [bootstrap](https://github.com/anchore/syft/blob/f15c3343e29dfb20cf6d82c820e7090b49808c96/.github/actions/bootstrap/action.yaml).
- [Resumen estructurado](summary.json), [entorno](evidence/environment.txt) y [huellas SHA-256 de los archivos publicados](SHA256SUMS).

Los registros Go completos se guardan comprimidos; pueden leerse con `gzip -dc archivo.jsonl.gz`. Los resultados corresponden solo a la revisión y al entorno descritos.

Syft mantiene su licencia Apache-2.0 y su autoría de Anchore y colaboradores. Los scripts originales RIW de este informe se identifican como GPL-3.0-or-later. Este informe no implica afiliación ni aprobación de Anchore.
