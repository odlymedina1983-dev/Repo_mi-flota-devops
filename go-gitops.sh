#!/bin/bash

# Capturar el mensaje del commit; si no se introduce uno, usa el por defecto
MENSAJE=${1:-"wip: actualizacion automatica de infraestructura"}

echo "📦 1. Añadiendo cambios al Git local..."
git add .

echo "📝 2. Creando el commit..."
git commit -m "$MENSAJE"

echo "🚀 3. Empujando cambios a GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo "⚡ 4. ¡Éxito en GitHub! Forzando a Flux a despertar..."
    flux reconcile source git flux-system
    flux reconcile kustomization mi-flota-infra
    echo "🎯 ¡Sincronización completada! Tu clúster está actualizado."
else
    echo "❌ Error: El push a GitHub falló. Revisa tu conexión o llaves SSH."
fi
