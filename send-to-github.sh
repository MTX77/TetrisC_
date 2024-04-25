#!/bin/bash

GITHUB_TOKEN="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"
REPO_OWNER="MTX77"
REPO_NAME="TetrisC_"
BRANCH="master"
FILE_PATH="./log/*"

API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/artifacts"

git add ./log
git commit
git push origin
