#!/usr/bin/env bash
# Sends a Vapi-shaped tool call to your n8n webhook and prints the response.
# Usage: N8N_WEBHOOK_URL=https://your-n8n/webhook/vapi-tools ./examples/test-webhook.sh
set -euo pipefail
: "${N8N_WEBHOOK_URL:?Set N8N_WEBHOOK_URL to your n8n webhook URL}"
curl -sS -X POST "$N8N_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  --data @"$(dirname "$0")/tool-call-request.json"
echo
