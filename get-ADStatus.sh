#!/bin/bash

# Reports AD Status
#
# Updated: 2.23.2022 @ Robjschroeder
#

ad_domain_name=$(dsconfigad -show | grep "Active Directory Domain" | cut -d= -f2 | awk '{print $1}')

echo "<result>${ad_domain_name}</result>"

exit 0
