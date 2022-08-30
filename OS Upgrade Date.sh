#!/bin/bash

# Evaluate the status in shell output
eval $(/usr/bin/stat -s /)
# Convert st_birthtime from epoch to a formatted time
result=$(/bin/date -jf %s "$st_birthtime" "+%F %T")
# Print the results
echo "<result>$result</result>"

exit 0
