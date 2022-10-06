#!/bin/bash
read -p "Enter City: " city
read -p "Enter State: " state

#city="hyderabad"
#state="Telangana"

front="http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=KgiMkd9HQ8IaIiLmQIt5gA5ADAXhRUKL&q="
url="${front}${city}"

locID=$(curl -X GET $url | ./jq.exe --arg state "$state" '[.[] | select(.AdministrativeArea.LocalizedName==$state) | .Key][0]')
echo "Location ID: " $locID

