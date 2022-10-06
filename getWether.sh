#!/bin/bash
echo "This script will fetch wether details of a city"
echo "Enter the details with first letter in caps & rest in small case"
echo


# First fetch the loction ID"
#read -p "Enter City name: " city
#read -p "Enter State: " state
echo

front="http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=KgiMkd9HQ8IaIiLmQIt5gA5ADAXhRUKL&q="
city="hyderabad"
url="${front}${city}"

state="Telangana"
locID=$(curl -X GET $url | ./jq.exe --arg state "$state" '[.[] select(.AdministrativeArea.LocalizedName==$state) | .Key][0]')
echo "Location ID: " $locID
echo


# Let's use the Location ID to fetch the wether of that place.
frontUrl="http://dataservice.accuweather.com/currentconditions/v1/"
backUrl="?apikey=KgiMkd9HQ8IaIiLmQIt5gA5ADAXhRUKL&details=true"
url2="${front}${locID}${back}"
echo $url2
echo

currTemp=$(curl -X GET $url2 | ./jq.exe | '.[] | .Temperature.Metric.Value')
windSpeed=$(curl -X GET $url2 | ./jq.exe | '.[] | .Wind.Speed.Metric.Value')

echo $currTemp $windSpeed



