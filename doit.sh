#!/bin/sh

/usr/bin/yaml2ical -y meetings -o output/irc-meetings.ical -t list.markdown.jinja -w output/calendar.md -f -n "CentOS Meetings" -d "Meeting schedule for the CentOS Project and SIGS"
cp ./output/* ../centos.org/community/


