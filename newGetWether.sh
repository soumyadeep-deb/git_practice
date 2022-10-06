#!/bin/bash
# First part
read -p "Enter City: " city
read -p "Enter State: " state

#city="hyderabad"
#state="Telangana"

front="http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=KgiMkd9HQ8IaIiLmQIt5gA5ADAXhRUKL&q="
url="${front}${city}"

tempID=$(curl -X GET $url | ./jq.exe --arg state "$state" '[.[] | select(.AdministrativeArea.LocalizedName==$state) | .Key][0]')

locID=$(echo $tempID | sed "s/\"//g")

#locID="202190"
echo "Location ID for ${city} is: " $locID

# Second part
# Make the url
frontUrl="http://dataservice.accuweather.com/currentconditions/v1/"
backUrl="?apikey=KgiMkd9HQ8IaIiLmQIt5gA5ADAXhRUKL&details=true"
newUrl="${frontUrl}${locID}${backUrl}"

echo $newUrl
echo

currTemp=$(curl -X GET $newUrl | ./jq.exe '.[] | .Temperature.Metric.Value')
windSpeed=$(curl -X GET $newUrl | ./jq.exe '.[] | .Wind.Speed.Metric.Value')

echo
echo "The current Temperature in ${city} is: " $currTemp
echo

echo "The Wind Speed is: " $windSpeed
echo
