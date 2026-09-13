# Generador de proyectos Minimal API .NET

Este proyecto contiene un script Bash que automatiza la creación de una solución .NET con una Minimal API, un proyecto de pruebas y un `Dockerfile`.

## Qué genera

Al ejecutar `generador.sh`, se crean los siguientes elementos:

- Un proyecto web basado en `Microsoft.NET.Sdk.Web`.
- Un proyecto de pruebas basado en xUnit.
- Una referencia del proyecto de pruebas hacia la API.
- Una solución que incluye ambos proyectos.
- Los paquetes `Microsoft.AspNetCore.Mvc.Testing` y `MiniValidation` para facilitar las pruebas y la validación.
- Un `Dockerfile` para compilar y ejecutar la API en un contenedor.

La API generada incluye el endpoint de ejemplo `GET /weatherforecast` y expone OpenAPI cuando se ejecuta en el entorno de desarrollo.

## Requisitos

- Bash.
- SDK de .NET instalado.
- Docker, solo si se desea construir y ejecutar la imagen.

## Uso

Desde esta carpeta, asigna permisos de ejecución al script si es necesario:

```bash
chmod +x generador.sh
```

Para crear un proyecto con un nombre personalizado:

```bash
./generador.sh ProyectoCopilot
```

El nombre se utiliza como base para todos los proyectos y archivos principales:

- `ProyectoCopilot/`
- `ProyectoCopilot.Tests/`
- `ProyectoCopilot.sln` o `ProyectoCopilot.slnx`, según la versión del SDK de .NET.

Si no se proporciona un nombre, se utiliza `MinimalApiProject`:

```bash
./generador.sh
```

> Ejecuta el script en una carpeta nueva o vacía para evitar conflictos con archivos y proyectos existentes.

## Estructura

Después de ejecutar el script, la estructura principal es similar a esta:

```text
.
├── generador.sh
├── README.md
├── ProyectoCopilot.slnx
├── ProyectoCopilot/
│   ├── Dockerfile
│   ├── Program.cs
│   ├── ProyectoCopilot.csproj
│   ├── ProyectoCopilot.http
│   ├── appsettings.json
│   └── appsettings.Development.json
└── ProyectoCopilot.Tests/
    ├── ProyectoCopilot.Tests.csproj
    └── UnitTest1.cs
```

El nombre `ProyectoCopilot` es un ejemplo; será reemplazado por el valor que pases como primer argumento.

## Ejecutar la API

Entra en la carpeta del proyecto generado y ejecuta:

```bash
cd ProyectoCopilot
dotnet run
```

La consola mostrará la URL local de la aplicación. El endpoint de ejemplo puede consultarse en:

```text
GET /weatherforecast
```

Durante el desarrollo, OpenAPI está disponible en la ruta configurada por la plantilla de .NET.

## Ejecutar las pruebas

Desde la carpeta raíz de la solución:

```bash
dotnet test ProyectoCopilot.Tests/ProyectoCopilot.Tests.csproj
```

También puedes ejecutar todas las pruebas de la solución con:

```bash
dotnet test
```

## Ejecutar con Docker

Desde la carpeta del proyecto de la API:

```bash
cd ProyectoCopilot
docker build -t proyectocopilot .
docker run --rm -p 8080:80 proyectocopilot
```

Después, consulta la API en `http://localhost:8080/weatherforecast`.

El `Dockerfile` utiliza imágenes de .NET 7.0. Si el proyecto generado utiliza otra versión del SDK o del runtime, conviene mantener ambas versiones alineadas antes de construir la imagen.

## Archivos principales

- `generador.sh`: crea y configura la solución completa.
- `Program.cs`: configura la aplicación y define el endpoint de ejemplo.
- `*.csproj`: contienen el framework objetivo y las dependencias de cada proyecto.
- `UnitTest1.cs`: punto de partida para agregar pruebas.
- `Dockerfile`: define las etapas de compilación y ejecución en Docker.
