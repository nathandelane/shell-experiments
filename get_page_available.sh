#!/bin/bash

URL=$1
NOT_AVAILABLE=True

while [ $NOT_AVAILABLE ]
do

  CURRENT_DATE_TIME=$(date -v+6H "+%Y-%m-%dT%TZ")

  echo "${CURRENT_DATE_TIME} Getting response from ${URL}..."

  RESPONSE_CODE=$(curl -s -o /dev/null -I -w "%{http_code}" "${URL}")

  if [ $RESPONSE_CODE -eq "200" ]
  then
    NOT_AVAILABLE=False
  fi

  echo "Response code was ${RESPONSE_CODE}."

  sleep 10s

done

# MacOS Darwin message dialog
/usr/bin/osascript <<-EOF

    tell application "System Events"
        activate
        display dialog "${URL} Is Available"
    end tell

EOF
