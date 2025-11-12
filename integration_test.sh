# Shell script used in setup/deployment of the application.
#!/usr/bin/env bash
set -euo pipefail
docker compose up -d --build proxy app_blue
sleep 5
curl -sf http://localhost:8080 | grep "Chuck Norris"
echo "Integration OK."
