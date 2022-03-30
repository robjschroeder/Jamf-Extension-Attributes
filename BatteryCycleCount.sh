#!/bin/sh

# Returns the cycle count on the battery

# Created: 3.30.2022 @robjschroeder

echo "<result>$(system_profiler SPPowerDataType | grep "Condition" | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')</result>"
