#!/bin/bash

GITHUB_TOKEN="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"
REPO_OWNER="MTX77"
REPO_NAME="TetrisC_"
BRANCH="master"
FILE_PATH="./artifacts"

API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/artifacts"

chown -R jenkins:jenkins ./artifacts
chmod -R 775 ./artifacts

curl -X POST -H "Authorization: token ${GITHUB_TOKEN}" \
     -H "Content-Type: application/json" \
     -d "{\"message\": \"Dodano APK\", \"content\": \"$(base64 -w 0 ${FILE_PATH})\"}" \
     ${API_URL}
