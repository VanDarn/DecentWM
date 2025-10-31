#!/bin/bash

# Fetch  weather data from wttr.in
response=$(curl -s "https://wttr.in/berlin?format=j1")

current_cdt=$(echo "$response" | jq -r '.current_condition[0]')

current_weather=$(echo "$current_cdt" | jq -r '.weatherDesc[0].value')
current_temp=$(echo "$current_cdt" | jq -r '.temp_C')
current_precip=$(echo "$current_cdt" | jq -r '.precipMM')

current="$current_weather $current_temp°C ${current_precip}mm"

#forecast=$(echo "$response" | jq -r '
#.weather[].hourly[]
#| select(.time == "900" or .time == "1200" or .time == "1800" or .time == "2100")
#| "\((.time | tonumber / 100 | floor | tostring | if length == 1 then "0" + . else . end)):00 \(.tempC)°C \(.chanceofrain)% \(.weatherDesc[0].value)"
#')

#echo "$forecast"




times=("900" "1200" "1800" "2100")

for t in "${times[@]}"; do
    forecast=$(echo "$response" | jq -r \
        --arg time "$t" '
        .weather[].hourly[]
        | select(.time == $time)
        | {time, tempC, chanceofrain, desc: .weatherDesc[0].value}')

    time=$(echo "$forecast" | jq -r '.time')
    temp=$(echo "$forecast" | jq -r '.tempC')
    rain=$(echo "$forecast" | jq -r '.chanceofrain')
    wthr=$(echo "$forecast" | jq -r '.desc')


#printf "%s %s°C %s%% %s\n" "$time" "$temp" "$rain" "$wthr"

echo "$wthr" #Echo time temp, rain and weather in one line
done
