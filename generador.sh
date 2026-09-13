#!/usr/bin/env bash
# Script generado automáticamente

NOMBRE_PROYECTO="${1:-MinimalApiProject}"
NOMBRE_PRUEBAS="${NOMBRE_PROYECTO}.Tests"
NOMBRE_SOLUCION="${NOMBRE_PROYECTO}.sln"

# Crea un proyecto de minimal api de .net
echo "Creando proyecto de minimal api de .net..."
dotnet new webapi -n "$NOMBRE_PROYECTO"

# Crea un proyecto de pruebas para el proyecto de minimal api de .net
echo "Creando proyecto de pruebas para el proyecto de minimal api de .net..."
dotnet new xunit -n "$NOMBRE_PRUEBAS"

# Asocia los dos proyectos
echo "Asociando los proyectos..."
dotnet add "$NOMBRE_PRUEBAS" reference "$NOMBRE_PROYECTO"

# Crea un archivo de solución 
echo "Creando archivo de solución..."
dotnet new sln -n "$NOMBRE_PROYECTO"

# Agrega ambos proyectos a la solución
echo "Agregando proyectos a la solución..."
dotnet sln "$NOMBRE_SOLUCION" add "$NOMBRE_PROYECTO/$NOMBRE_PROYECTO.csproj"
dotnet sln "$NOMBRE_SOLUCION" add "$NOMBRE_PRUEBAS/$NOMBRE_PRUEBAS.csproj"

# Agrega los paquetes necesarios para el proyecto de test de minimal api de .net
echo "Agregando paquetes necesarios para el proyecto de test..."
dotnet add "$NOMBRE_PRUEBAS" package Microsoft.AspNetCore.Mvc.Testing
dotnet add "$NOMBRE_PRUEBAS" package Minivalidation


# Agrega un archivo de Docker en el proyecto de minimal api de .net
echo "Agregando archivo de Docker en el proyecto de minimal api de .net..."
cat <<EOL > "$NOMBRE_PROYECTO/Dockerfile"
# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Expose the port the application runs on
EXPOSE 80   

# Set the entry point for the application
ENTRYPOINT ["dotnet", "$NOMBRE_PROYECTO.dll"]
EOL

echo "Proyecto de minimal api de .net creado con éxito."
