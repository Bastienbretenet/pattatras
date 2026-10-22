#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"

PORT="${PATTATRAS_PORT:-3000}"
URL="http://localhost:${PORT}"

echo "=== Pattatras ==="

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker n'est pas installé."
  echo "Installez Docker Desktop : https://www.docker.com/products/docker-desktop/"
  read -r -p "Appuyez sur Entrée pour fermer..." _
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Docker est installé mais n'est pas démarré."
  echo "Ouvrez l'application Docker Desktop, attendez qu'elle soit prête, puis relancez ce script."
  read -r -p "Appuyez sur Entrée pour fermer..." _
  exit 1
fi

echo "Préparation de l'application (le premier lancement peut prendre quelques minutes)..."
if ! docker compose up -d --build; then
  echo "Le lancement a échoué. Si le port ${PORT} est déjà utilisé, relancez avec : PATTATRAS_PORT=9000 ./lancer.sh"
  read -r -p "Appuyez sur Entrée pour fermer..." _
  exit 1
fi

echo -n "Démarrage du serveur"
for _ in $(seq 1 150); do
  # Passe par le proxy Vite : répond seulement quand le front et l'API sont prêts
  # grep plutôt que >/dev/null : le curl de certains Git Bash échoue en écrivant dans /dev/null
  if curl -fs "${URL}/api/pattatras/1" 2>/dev/null | grep -q '"number"'; then
    echo ""
    echo "Pattatras est prêt : ${URL}"
    # cmd.exe : Windows (Git Bash ou WSL), open : macOS, xdg-open : Linux.
    # MSYS_NO_PATHCONV : empêche Git Bash de convertir "/c" en chemin "C:/".
    if command -v cmd.exe >/dev/null 2>&1; then MSYS_NO_PATHCONV=1 cmd.exe /c start "" "$URL" >/dev/null 2>&1
    elif command -v open >/dev/null 2>&1; then open "$URL"
    elif command -v xdg-open >/dev/null 2>&1; then xdg-open "$URL" >/dev/null 2>&1
    else echo "Ouvrez ${URL} dans votre navigateur."
    fi
    echo "Pour arrêter l'application : docker compose down"
    exit 0
  fi
  echo -n "."
  sleep 2
done

echo ""
echo "Le serveur ne répond pas après 5 minutes. Détails : docker compose logs"
read -r -p "Appuyez sur Entrée pour fermer..." _
exit 1
