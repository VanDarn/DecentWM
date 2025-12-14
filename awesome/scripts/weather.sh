#!/bin/bash

  KEY="e1bfc01fb8fdb15ee85744484d1c35eb"
  CITY="2778067"
  UNITS="metric"
  weather=$(curl -s "http://api.openweathermap.org/data/2.5/forecast?id=$CITY&units=$UNITS&APPID=$KEY")
      
  weather_temp=$(echo "$weather" \
  | jq -r '.list[] 
  | select(.dt_txt | test("06:00:00|15:00:00|21:00:00"))
  | [.dt_txt, .main.temp, .weather[0].icon, .pop]
  | @tsv')


echo "${weather_temp}"
  
 
