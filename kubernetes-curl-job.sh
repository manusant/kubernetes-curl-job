#!/bin/env sh

notifySuccess() {
    curl -X POST -H 'Content-type: application/json'\
    --data "{\"text": "$SUCCESS_MESSAGE" :"\"rocket:\"}" \
    "$WEBHOOK"
}

notifyFail() {
    curl -X POST -H 'Content-type: application/json'\
    --data "{\"text": "$FAIL_MESSAGE": "\"rotating_light:\"}" \
    "$WEBHOOK"
}

# Authenticate with your Auth API using OAuth2 Client credentials flow and get an ACCESS TOKEN
accessToken=$(curl -H "Authorization: Basic $BASIC_CLIENT_CREDENTIALS" \
  -d grant_type=client_credentials \
  --silent "$OAUTH_TOKEN_ENDPOINT" | jq -r .access_token)

# Execute API request using previously requested Access Token
status_code=$(curl -H "Authorization: Bearer ${accessToken}" \
    -X POST --write-out %{http_code} --silent --output /dev/null \
    "$JOB_ENDPOINT")

if [ "$status_code" -ne 202 ]; then
  echo "$FAIL_MESSAGE"
  notifyFail
else
  echo "$SUCCESS_MESSAGE"
  notifySuccess
fi
