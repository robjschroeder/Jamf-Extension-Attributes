#!/bin/bash

# Reports the current DNS server
# on the macOS computer. 
#
# Updated: 2.23.2022 @ Robjschroeder
#

# Get DNS entries from SCUTIL
dns=$(/usr/sbin/scutil --dns | awk '/scoped queries/,/END/{print}' | awk '/nameserver/{print $NF}' )
# Echo result to EA output
echo "<result>${dns}</result>"

exit 0
