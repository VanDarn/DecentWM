#!/bin/bash


# Add an appointment to Calcurse via .ics import
# Usage: ./add_calcurse_appt.sh
# or:    ./add_calcurse_appt.sh YYYYMMDD HHMM HHMM "Description"

# If arguments are not passed, prompt interactively
#if [ $# -lt 4 ]; then
#  read -p "Enter date (YYYYMMDD): " DATE
#  read -p "Enter start time (HHMM, 24h): " START
#  read -p "Enter end time (HHMM, 24h): " END
#  read -p "Enter description: " SUMMARY
#else
  DATE="$1"
  START="$2"
  END="$3"
  SUMMARY="$4"



#fi

# Validate simple format
#if [[ ! "$DATE" =~ ^[0-9]{8}$ ]] || [[ ! "$START" =~ ^[0-9]{4}$ ]] || [[ ! "$END" =~ ^[0-9]{4}$ ]]; then
#  echo "❌ Invalid date or time format."
#  echo "Example: ./add_calcurse_appt.sh 20251114 0900 1000 'Team meeting'"
#  exit 1
#fi

# Create a temporary .ics file
TMPFILE=$(mktemp)
cat > "$TMPFILE" <<EOF
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
DTSTART:${DATE}T${START}00
DTEND:${DATE}T${END}00
SUMMARY:${SUMMARY}
END:VEVENT
END:VCALENDAR
EOF

# Import into Calcurse
calcurse --import "$TMPFILE"

# Clean up
rm "$TMPFILE"

#echo "✅ Appointment added: $SUMMARY on ${DATE} from ${START} to ${END}"

