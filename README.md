# Pattatras

Application web qui applique les règles suivantes aux nombres de 1 à 6457 :

| Si le nombre est…          | Affichage          |
| -------------------------- | ------------------ |
| multiple de 3              | **Patte**          |
| multiple de 5              | **Tatras**         |
| multiple de 3 **et** de 5  | **Pattatras**      |
| autre                      | le nombre lui-même |

## Prérequis

[Docker Desktop](https://www.docker.com/products/docker-desktop/), installé et démarré.

## Lancement

1. Téléchargez le projet et décompressez-le.
2. Lancez le script correspondant à votre système :
   - Windows : double-cliquez sur `lancer.bat`
   - Mac / Linux : `./lancer.sh`
3. L'application s'ouvre dans le navigateur sur <http://localhost:3000>.

Le premier lancement peut prendre quelques minutes.

Pour utiliser un autre port : `PATTATRAS_PORT=9000 ./lancer.sh` (Mac / Linux) ou `set PATTATRAS_PORT=9000` puis `lancer.bat` (Windows).

## Utilisation

- **Nombre aléatoire** : tire un nombre au hasard et affiche son résultat.
- **Tableau Pattatras** : affiche la suite complète de 1 à 6457.

## Arrêt

```bash
docker compose down
```

## API

| Route | Réponse |
| --- | --- |
| `GET /api/pattatras` | `[{"number":1,"value":"1","type":"nombre"}, ...]` |
| `GET /api/pattatras/{nombre}` | `{"number":15,"value":"Pattatras","type":"pattatras"}` |

`type` vaut `patte`, `tatras`, `pattatras` ou `nombre`. Un nombre hors de 1–6457 renvoie une erreur `422`.

## Développement

- Back : PHP 8.4, Symfony 8.1 (`backend/`)
- Front : VueJS 3, Vite (`frontend/`)

Les modifications du code sont prises en compte sans redémarrage.

Tests :

```bash
docker compose exec app vendor/bin/phpunit
```
