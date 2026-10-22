@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Pattatras

if "%PATTATRAS_PORT%"=="" set PATTATRAS_PORT=3000
set URL=http://localhost:%PATTATRAS_PORT%

echo === Pattatras ===

where docker >nul 2>&1
if errorlevel 1 (
  echo Docker n'est pas installé.
  echo Installez Docker Desktop : https://www.docker.com/products/docker-desktop/
  pause
  exit /b 1
)

docker info >nul 2>&1
if errorlevel 1 (
  echo Docker est installé mais n'est pas démarré.
  echo Ouvrez l'application Docker Desktop, attendez qu'elle soit prête, puis relancez ce fichier.
  pause
  exit /b 1
)

echo Préparation de l'application (le premier lancement peut prendre quelques minutes)...
docker compose up -d --build
if errorlevel 1 (
  echo Le lancement a échoué. Si le port %PATTATRAS_PORT% est déjà utilisé, fermez l'autre application ou modifiez PATTATRAS_PORT.
  pause
  exit /b 1
)

echo Démarrage du serveur...
for /l %%i in (1,1,150) do (
  curl -fs %URL%/api/pattatras/1 >nul 2>&1 && goto ready
  ping -n 3 127.0.0.1 >nul
)
echo Le serveur ne répond pas après 5 minutes. Détails : docker compose logs
pause
exit /b 1

:ready
echo Pattatras est prêt : %URL%
start "" %URL%
echo Pour arrêter l'application : docker compose down (ou bouton Stop dans Docker Desktop)
ping -n 6 127.0.0.1 >nul
exit /b 0
