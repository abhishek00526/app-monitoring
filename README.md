# Simple App Monitoring Project

A beginner-friendly project showing how to monitor a Flask app with Docker, Prometheus, and Grafana.

## Quick start

```bash
# 1. Clone or extract this folder
cd simple-app

# 2. Start everything
docker compose up -d --build

# 3. Wait 10 seconds for databases to start
sleep 10

# 4. Open in browser
# App: http://localhost:5000
# Prometheus: http://localhost:9090
# Grafana: http://localhost:3000 (user: admin, pass: admin)
```

## Test the app

```bash
# Health check (should return 200)
curl http://localhost:5000/health

# Slow response (takes 5 seconds)
curl http://localhost:5000/slow

# Error (returns 500)
curl http://localhost:5000/error

# Check container health
docker ps
```

## Grafana setup

1. Open http://localhost:3000
2. Login: admin / admin
3. Add Prometheus data source: http://prometheus:9090
4. Create a simple graph:
   - Metric: up
   - It shows 1 = up, 0 = down

## Incident drills

Read each file in `incidents/` folder and recreate it:

```bash
# 1. Stop the app container
docker stop simple-app

# Check Grafana - it shows app is down
# Check Prometheus - uptime metric goes to 0

# Start it again
docker start simple-app
```

See `incidents/` folder for 4 complete examples.

## Cleanup

```bash
docker compose down
docker volume prune
```

## Files explained

| File | What it does |
|---|---|
| `app.py` | Flask app with /health, /slow, /error endpoints |
| `Dockerfile` | Packages app into a Docker image |
| `docker-compose.yml` | Starts app, database, Prometheus, Grafana |
| `prometheus.yml` | Tells Prometheus what to monitor |
| `healthcheck.sh` | Script to check if app is healthy |
| `backup_db.sh` | Script to backup the database |
| `incidents/` | Examples of how to break and fix the app |

## What you'll learn

- ✅ How to run apps in Docker
- ✅ How to monitor with Prometheus
- ✅ How to visualize with Grafana
- ✅ How to diagnose problems with Linux commands
- ✅ How to document incidents
