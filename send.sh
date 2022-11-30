#!/bin/bash

BOTNAME="UPS Notification"
MAINTEXT=$(/sbin/apcaccess status | jq -Rsa | gawk '{ gsub(/"/,"") } 1')

while getopts w:c:f: flag
do
    case "${flag}" in
        w) webhook=${OPTARG};;
        c) color=${OPTARG};;
        f) fault=${OPTARG};;
    esac
done

/etc/apcupsd/discord.sh --webhook-url="$webhook" \
--username "$BOTNAME" \
--avatar "image url" \
--title "$fault Notification" \
--description "\`\`\`yaml\n$MAINTEXT\`\`\`" \
--color "$color" \
--url "https://sub.example.dev" \
--footer "discord.sh" \
--footer-icon "image url" \
--timestamp

