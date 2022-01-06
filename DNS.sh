#!/bin/sh

# Get DNS entries from SCUTIL
dns=$(/usr/sbin/scutil --dns | awk '/scoped queries/,/END/{print}' | awk '/nameserver/{print $NF}' )
# Echo result to EA output
echo "<result>$dns</result>"
