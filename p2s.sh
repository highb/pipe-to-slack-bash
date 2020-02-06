#!/bin/bash

WEBHOOK_URL="$(cat $HOME/.p2s.sh)"
MESSAGE="$(cat /dev/stdin)"
PAYLOAD_FILE="/tmp/pipe-to-slack-bash-payload.json"

if [ -z "${WEBHOOK_URL}" ]; then
  echo "Please provide your webhook URL in ~/.p2s.sh" >&2
  exit 1
fi

if [ -z "${MESSAGE}" ]; then
  echo "Please provide your message via STDIN (cat file | p2s.sh)" >&2
  exit 1
fi

if [ "$1" == "text" ]; then
  cat > $PAYLOAD_FILE <<EOM
  {
    "text": "$MESSAGE"
  }
EOM
else
  cat > $PAYLOAD_FILE <<EOM
  {
    "blocks": [
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "\`\`\`
$MESSAGE
          \`\`\`"
        }
      }
    ]
  }
EOM

fi

if [ -n "$(command -v http)" ] ; then
  http POST "${WEBHOOK_URL}" < $PAYLOAD_FILE
elif [ -n "$(command -v curl)" ] ; then
  curl -X POST -H "Content-Type: application/json" -d @$PAYLOAD_FILE "${WEBHOOK_URL}"
else
  echo "You need HTTPie https://httpie.org/ or CuRL https://curl.haxx.se/ to use this."
fi