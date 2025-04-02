#Script that runs ipaddr and applies pipes and filters to display only your IP address

#Create variable to hold the value

#i=$(ip addr | grep inet | grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")

i=$(ip addr | awk 'NR < 11 && NR > 9 {print $2}' )
echo "$i"

