#!/bin/bash
XCODE_XIP_FILE="~/Downloads/Xcode_13.1.xip" \
GITLAB_URL="https://gitlab.com/" \
GITLAB_REGISTRATION_TOKEN="DzyAn6VnpySjQmzp7zZ5" \
GITLAB_RUNNER_NAME="mac01" \
GITLAB_RUNNER_TAGS="macos,xcode13" \
RAM_SIZE=8192 \
CPU_COUNT=4 \
vagrant up